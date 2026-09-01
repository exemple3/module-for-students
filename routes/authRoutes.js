const express = require('express');
const router = express.Router();
const db = require('../db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// регистрация пользователя
router.post('/register', async (req, res) => {
    try {
        let name = req.body.name;
        let email = req.body.email;
        let password = req.body.password;

        if (!name || !email || !password) {
            return res.status(400).json({ error: 'заполните все поля' });
        }

        // шифруем пароль чтобы не хранить в открытом виде
        let salt = await bcrypt.genSalt(10);
        let hashPassword = await bcrypt.hash(password, salt);

        await db.query('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', [name, email, hashPassword]);

        res.json({ message: 'успешная регистрация' });
    } catch (error) {
        res.status(400).json({ error: 'ошибка (возможно такой email уже есть)' });
    }
});

// вход в систему
router.post('/login', async (req, res) => {
    try {
        let email = req.body.email;
        let password = req.body.password;

        let result = await db.query('SELECT * FROM users WHERE email = ?', [email]);
        let users = result[0];

        if (users.length == 0) {
            return res.status(400).json({ error: 'пользователь не найден' });
        }

        let user = users[0];

        // проверяем пароль
        let isMatch = await bcrypt.compare(password, user.password);
        if (isMatch == false) {
            return res.status(400).json({ error: 'неверный пароль' });
        }

        // создаем токен (ключ пишем простой для учебного проекта)
        let token = jwt.sign({ id: user.id }, 'secret_key_123', { expiresIn: '24h' });

        res.json({
            token: token,
            user: { id: user.id, name: user.name, email: user.email }
        });
    } catch (error) {
        res.status(500).json({ error: 'ошибка сервера' });
    }
});

module.exports = router;