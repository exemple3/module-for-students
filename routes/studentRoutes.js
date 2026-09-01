const express = require('express');
const router = express.Router();
const db = require('../db');

// получаем список профессий с поиском
router.get('/professions', async (req, res) => {
    try {
        let search = req.query.search;
        let query = "SELECT p.id, p.title, p.description, p.average_salary, GROUP_CONCAT(DISTINCT c.name SEPARATOR ', ') AS required_competencies, COUNT(DISTINCT v.id) AS vacancies_count FROM professions p LEFT JOIN profession_competencies pc ON p.id = pc.profession_id LEFT JOIN competencies c ON pc.competency_id = c.id LEFT JOIN vacancies v ON p.id = v.profession_id";
        let params = [];

        // если ввели текст в поиск, добавляем условие
        if (search != undefined && search != '') {
            query = query + " WHERE p.title LIKE ? OR c.name LIKE ?";
            params.push('%' + search + '%');
            params.push('%' + search + '%');
        }

        query = query + " GROUP BY p.id ORDER BY p.average_salary DESC";

        let result = await db.query(query, params);
        let professions = result[0];

        res.json(professions);
    } catch (error) {
        res.status(500).json({ error: 'ошибка загрузки профессий' });
    }
});

// получаем детали одной профессии
router.get('/professions/:id', async (req, res) => {
    try {
        let id = req.params.id;

        // ищем саму профессию
        let profResult = await db.query('SELECT * FROM professions WHERE id = ?', [id]);
        let professions = profResult[0];

        if (professions.length == 0) {
            return res.status(404).json({ error: 'не найдено' });
        }

        // достаем навыки
        let compResult = await db.query("SELECT c.name FROM competencies c JOIN profession_competencies pc ON c.id = pc.competency_id WHERE pc.profession_id = ?", [id]);
        let competencies = compResult[0];

        // достаем вакансии
        let vacResult = await db.query("SELECT v.id, v.title, v.salary_offered, e.name AS employer_name, e.industry FROM vacancies v JOIN employers e ON v.employer_id = e.id WHERE v.profession_id = ?", [id]);
        let vacancies = vacResult[0];

        // достаем вузы
        let progResult = await db.query("SELECT ep.id, ep.title, ep.ege_requirements, ep.passing_score, u.name AS university_name, u.city, pp.is_primary FROM educational_programs ep JOIN program_professions pp ON ep.id = pp.program_id JOIN universities u ON ep.university_id = u.id WHERE pp.profession_id = ? ORDER BY pp.is_primary DESC, ep.passing_score DESC", [id]);
        let programs = progResult[0];

        // собираем все в один ответ
        let answer = {
            id: professions[0].id,
            title: professions[0].title,
            description: professions[0].description,
            average_salary: professions[0].average_salary,
            competencies: [],
            vacancies: vacancies,
            educational_programs: programs
        };

        for (let i = 0; i < competencies.length; i++) {
            answer.competencies.push(competencies[i].name);
        }

        res.json(answer);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// список всех вузов и программ
router.get('/universities', async (req, res) => {
    try {
        let query = "SELECT u.id AS university_id, u.name AS university_name, u.city, ep.id AS program_id, ep.title AS program_title, ep.ege_requirements, ep.passing_score, p.id AS profession_id, p.title AS profession_title, pp.is_primary FROM universities u JOIN educational_programs ep ON u.id = ep.university_id LEFT JOIN program_professions pp ON ep.id = pp.program_id LEFT JOIN professions p ON pp.profession_id = p.id ORDER BY u.name, ep.title, pp.is_primary DESC";
        let result = await db.query(query);
        let rows = result[0];

        let universitiesMap = {};

        // группируем плоские данные из базы в объекты
        for (let i = 0; i < rows.length; i++) {
            let row = rows[i];

            if (!universitiesMap[row.university_id]) {
                universitiesMap[row.university_id] = {
                    id: row.university_id,
                    name: row.university_name,
                    city: row.city,
                    programs: {}
                };
            }

            let uni = universitiesMap[row.university_id];

            if (!uni.programs[row.program_id]) {
                uni.programs[row.program_id] = {
                    id: row.program_id,
                    title: row.program_title,
                    ege_requirements: row.ege_requirements,
                    passing_score: row.passing_score,
                    professions: []
                };
            }

            if (row.profession_id) {
                uni.programs[row.program_id].professions.push({
                    id: row.profession_id,
                    title: row.profession_title,
                    is_primary: row.is_primary == 1 ? true : false
                });
            }
        }

        // переделываем объекты в массив для фронтенда
        let finalResult = [];
        let keys = Object.keys(universitiesMap);
        for (let i = 0; i < keys.length; i++) {
            let uni = universitiesMap[keys[i]];
            let progKeys = Object.keys(uni.programs);
            let progArr = [];
            for (let j = 0; j < progKeys.length; j++) {
                progArr.push(uni.programs[progKeys[j]]);
            }
            uni.programs = progArr;
            finalResult.push(uni);
        }

        res.json(finalResult);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// получаем вопросы теста
router.get('/test-questions', async (req, res) => {
    try {
        let qRes = await db.query('SELECT * FROM test_questions');
        let questions = qRes[0];

        let optRes = await db.query('SELECT * FROM test_options');
        let options = optRes[0];

        let fullQuestions = [];

        for (let i = 0; i < questions.length; i++) {
            let q = questions[i];
            let qOptions = [];

            for (let j = 0; j < options.length; j++) {
                if (options[j].question_id == q.id) {
                    qOptions.push({
                        id: options[j].id,
                        text: options[j].option_text,
                        profession_id: options[j].linked_profession_id
                    });
                }
            }

            fullQuestions.push({
                id: q.id,
                question: q.question_text,
                hint: q.hint,
                options: qOptions
            });
        }

        res.json(fullQuestions);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// считаем результаты теста
router.post('/career-trajectory', async (req, res) => {
    try {
        let selectedOptionIds = req.body.selectedOptionIds;
        let totalEgeScore = req.body.totalEgeScore;

        if (!selectedOptionIds || selectedOptionIds.length == 0) {
            return res.status(400).json({ error: 'надо выбрать ответы' });
        }

        let optRes = await db.query('SELECT linked_profession_id FROM test_options WHERE id IN (?)', [selectedOptionIds]);
        let options = optRes[0];

        if (options.length == 0) {
            return res.status(400).json({ error: 'ответы не найдены' });
        }

        // считаем голоса
        let scoreMap = {};
        for (let i = 0; i < options.length; i++) {
            let profId = options[i].linked_profession_id;
            if (!scoreMap[profId]) {
                scoreMap[profId] = 0;
            }
            scoreMap[profId] = scoreMap[profId] + 1;
        }

        let totalVotes = options.length;

        let allProfRes = await db.query('SELECT id, title, description, average_salary FROM professions');
        let allProfessions = allProfRes[0];

        let profileScores = [];
        for (let i = 0; i < allProfessions.length; i++) {
            let p = allProfessions[i];
            let votes = scoreMap[p.id] || 0;
            let percentage = Math.round((votes / totalVotes) * 100);

            profileScores.push({
                profession_id: p.id,
                title: p.title,
                description: p.description,
                average_salary: p.average_salary,
                votes: votes,
                percentage: percentage
            });
        }

        // сортируем чтобы победитель был первым
        profileScores.sort(function(a, b) {
            return b.votes - a.votes;
        });

        let primaryProfession = profileScores[0];
        let secondaryProfession = null;
        if (profileScores.length > 1 && profileScores[1].votes > 0) {
            secondaryProfession = profileScores[1];
        }

        // тянем навыки победителя
        let compRes = await db.query("SELECT c.name FROM competencies c JOIN profession_competencies pc ON c.id = pc.competency_id WHERE pc.profession_id = ?", [primaryProfession.profession_id]);
        let competencies = compRes[0];
        let compArr = [];
        for (let i = 0; i < competencies.length; i++) {
            compArr.push(competencies[i].name);
        }

        // тянем вузы
        let progRes = await db.query("SELECT ep.id, ep.title, ep.ege_requirements, ep.passing_score, u.name AS university_name, u.city, pp.is_primary FROM educational_programs ep JOIN program_professions pp ON ep.id = pp.program_id JOIN universities u ON ep.university_id = u.id WHERE pp.profession_id = ? ORDER BY pp.is_primary DESC, ep.passing_score DESC", [primaryProfession.profession_id]);
        let programs = progRes[0];

        let userScore = null;
        if (totalEgeScore != null && totalEgeScore != '') {
            userScore = parseInt(totalEgeScore);
        }

        let evaluatedPrograms = [];
        for (let i = 0; i < programs.length; i++) {
            let prog = programs[i];
            let passed = null;
            if (userScore != null) {
                if (userScore >= prog.passing_score) {
                    passed = true;
                } else {
                    passed = false;
                }
            }

            evaluatedPrograms.push({
                id: prog.id,
                university: prog.university_name,
                city: prog.city,
                program_title: prog.title,
                ege_requirements: prog.ege_requirements,
                passing_score: prog.passing_score,
                is_primary_qualification: prog.is_primary == 1 ? true : false,
                passesByScore: passed
            });
        }

        let vacRes = await db.query("SELECT v.title, v.salary_offered, e.name AS employer_name FROM vacancies v JOIN employers e ON v.employer_id = e.id WHERE v.profession_id = ?", [primaryProfession.profession_id]);
        let vacancies = vacRes[0];

        let matchScores = [];
        for (let i = 0; i < profileScores.length; i++) {
            if (profileScores[i].votes > 0) {
                matchScores.push(profileScores[i]);
            }
        }

        res.json({
            trajectory: {
                recommendedProfession: {
                    id: primaryProfession.profession_id,
                    title: primaryProfession.title,
                    description: primaryProfession.description,
                    average_salary: primaryProfession.average_salary,
                    key_competencies: compArr
                },
                secondaryProfession: secondaryProfession,
                profileMatchScores: matchScores,
                marketDemand: {
                    activeVacanciesCount: vacancies.length,
                    sampleVacancies: vacancies
                },
                userEgeScore: userScore,
                suitableEducationalPrograms: evaluatedPrograms,
                actionPlan: [
                    'Готовиться к нужным предметам ЕГЭ',
                    'Подать заявления в эти университеты',
                    'Учить нужные навыки (компетенции)',
                    'Найти стажировку во время учебы',
                    'Устроиться на работу'
                ]
            }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// добавить программу в избранное
router.post('/favorite-programs', async (req, res) => {
    try {
        let userId = req.body.userId;
        let programId = req.body.programId;
        await db.query('INSERT IGNORE INTO favorite_programs (user_id, program_id) VALUES (?, ?)', [userId, programId]);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// удалить программу из избранного
router.post('/favorite-programs/remove', async (req, res) => {
    try {
        let userId = req.body.userId;
        let programId = req.body.programId;
        await db.query('DELETE FROM favorite_programs WHERE user_id = ? AND program_id = ?', [userId, programId]);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// получить избранные программы юзера
router.get('/favorite-programs/:userId', async (req, res) => {
    try {
        let userId = req.params.userId;
        let query = "SELECT ep.id, ep.title, ep.ege_requirements, ep.passing_score, u.name AS university_name, u.city FROM favorite_programs fp JOIN educational_programs ep ON fp.program_id = ep.id JOIN universities u ON ep.university_id = u.id WHERE fp.user_id = ?";
        let result = await db.query(query, [userId]);
        res.json(result[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// добавить профессию в избранное
router.post('/favorite-professions', async (req, res) => {
    try {
        let userId = req.body.userId;
        let professionId = req.body.professionId;
        await db.query('INSERT IGNORE INTO favorite_professions (user_id, profession_id) VALUES (?, ?)', [userId, professionId]);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// удалить профессию из избранного
router.post('/favorite-professions/remove', async (req, res) => {
    try {
        let userId = req.body.userId;
        let professionId = req.body.professionId;
        await db.query('DELETE FROM favorite_professions WHERE user_id = ? AND profession_id = ?', [userId, professionId]);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// получить избранные профессии юзера
router.get('/favorite-professions/:userId', async (req, res) => {
    try {
        let userId = req.params.userId;
        let query = "SELECT p.id, p.title, p.average_salary FROM favorite_professions fp JOIN professions p ON fp.profession_id = p.id WHERE fp.user_id = ?";
        let result = await db.query(query, [userId]);
        res.json(result[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;