-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: career_navigator
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `competencies`
--

DROP TABLE IF EXISTS `competencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competencies`
--

LOCK TABLES `competencies` WRITE;
/*!40000 ALTER TABLE `competencies` DISABLE KEYS */;
INSERT INTO `competencies` VALUES (17,'C++ / Системное программирование'),(18,'Data Engineering (Apache Spark, Kafka, ETL-процессы)'),(9,'HTML5, CSS3, SCSS, адаптивная верстка'),(1,'JavaScript / TypeScript'),(2,'Node.js / Express'),(4,'Python'),(20,'REST API & GraphQL архитектура'),(8,'UI/UX дизайн, Figma, CJM и юзабилити-тестирование'),(11,'Автоматизация тестирования (Selenium / Playwright / Postman)'),(7,'Администрирование Linux, Docker, CI/CD (DevOps)'),(6,'Информационная безопасность, криптография и аудит'),(16,'Компьютерные сети (TCP/IP, маршрутизация, сетевые экраны)'),(5,'Машинное обучение, нейросети и математическая статистика'),(19,'Облачные сервисы (Yandex Cloud, AWS, Kubernetes)'),(13,'Разработка под Android (Kotlin / Jetpack Compose)'),(12,'Разработка под iOS (Swift / SwiftUI)'),(3,'Реляционные базы данных (SQL / PostgreSQL / MySQL)'),(15,'Системный и бизнес-анализ (UML, BPMN, написание ТЗ)'),(10,'Тестирование ПО (QA), написание тест-кейсов и баг-репортов'),(14,'Управление IT-продуктом (Agile / Scrum, юнит-экономика, метрики)');
/*!40000 ALTER TABLE `competencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `educational_programs`
--

DROP TABLE IF EXISTS `educational_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `educational_programs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `university_id` int NOT NULL,
  `profession_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `ege_requirements` varchar(255) NOT NULL,
  `passing_score` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `university_id` (`university_id`),
  KEY `profession_id` (`profession_id`),
  CONSTRAINT `educational_programs_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `educational_programs_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `educational_programs`
--

LOCK TABLES `educational_programs` WRITE;
/*!40000 ALTER TABLE `educational_programs` DISABLE KEYS */;
INSERT INTO `educational_programs` VALUES (1,1,1,'Программная инженерия','Информатика: 80, Проф. Математика: 80, Русский язык: 75',278),(2,1,2,'Прикладная математика и информатика','Информатика: 85, Проф. Математика: 85, Русский язык: 80',292),(3,1,8,'Бизнес-информатика','Проф. Математика: 80, Обществознание/Информатика: 80, Русский язык: 75',270),(4,2,1,'Информатика и вычислительная техника','Информатика: 75, Проф. Математика: 75, Русский язык: 70',255),(5,2,3,'Информационная безопасность автоматизированных систем','Информатика: 80, Проф. Математика: 75, Русский язык: 70',268),(6,3,2,'Фундаментальная информатика и ИТ','Информатика: 85, Проф. Математика: 85, Русский язык: 80',290),(7,4,6,'Системный анализ и управление','Информатика/Физика: 88, Проф. Математика: 88, Русский язык: 82',295),(8,4,7,'Компьютерные технологии и мобильные платформы','Информатика: 85, Проф. Математика: 85, Русский язык: 80',288),(9,5,2,'Анализ данных и искусственный интеллект','Информатика: 85, Проф. Математика: 85, Русский язык: 80',286),(10,5,4,'Компьютерные технологии в дизайне','Информатика: 70, Проф. Математика: 75, Русский язык: 75',248),(11,5,5,'Технологии разработки и тестирования ПО','Информатика: 75, Проф. Математика: 75, Русский язык: 70',258),(12,6,1,'Программирование и информационные технологии','Информатика: 80, Проф. Математика: 80, Русский язык: 75',272),(13,7,1,'Информационные системы и технологии','Информатика: 65, Проф. Математика: 65, Русский язык: 65',230),(14,7,5,'Управление качеством в программных системах','Информатика: 60, Проф. Математика: 60, Русский язык: 60',215),(15,8,2,'Математика и компьютерные науки','Информатика: 75, Проф. Математика: 80, Русский язык: 70',262),(16,8,3,'Безопасность компьютерных систем','Информатика: 70, Проф. Математика: 70, Русский язык: 70',242),(17,9,7,'Разработка мобильных и кроссплатформенных приложений','Информатика: 70, Проф. Математика: 70, Русский язык: 70',240),(18,9,8,'Прикладная информатика в экономике','Проф. Математика: 68, Информатика: 68, Русский язык: 65',232),(19,10,1,'Computer Science and Software Engineering','Информатика: 85, Проф. Математика: 85, Английский/Русский: 80',280),(20,10,6,'Инженерия облачных сервисов и DevOps','Информатика: 80, Проф. Математика: 80, Русский язык: 75',275);
/*!40000 ALTER TABLE `educational_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employers`
--

DROP TABLE IF EXISTS `employers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `industry` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employers`
--

LOCK TABLES `employers` WRITE;
/*!40000 ALTER TABLE `employers` DISABLE KEYS */;
INSERT INTO `employers` VALUES (1,'Яндекс','Поисковые сервисы, такси, e-commerce, облака'),(2,'Сбер','Финтех, цифровые экосистемы и ИИ'),(3,'Лаборатория Касперского','Кибербезопасность и антивирусные решения'),(4,'VK (ВКонтакте)','Социальные сети, игры, коммуникационные платформы'),(5,'Ozon Tech','Электронная коммерция и логистические системы'),(6,'Тинькофф (Т-Банк)','Финтех и мобильный банкинг'),(7,'Positive Technologies','Информационная безопасность и анализ уязвимостей'),(8,'Wildberries','Онлайн-ритейл и распределенные системы');
/*!40000 ALTER TABLE `employers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_professions`
--

DROP TABLE IF EXISTS `favorite_professions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_professions` (
  `user_id` int NOT NULL,
  `profession_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`profession_id`),
  KEY `profession_id` (`profession_id`),
  CONSTRAINT `favorite_professions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorite_professions_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_professions`
--

LOCK TABLES `favorite_professions` WRITE;
/*!40000 ALTER TABLE `favorite_professions` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite_professions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_programs`
--

DROP TABLE IF EXISTS `favorite_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_programs` (
  `user_id` int NOT NULL,
  `program_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`program_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `favorite_programs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorite_programs_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `educational_programs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_programs`
--

LOCK TABLES `favorite_programs` WRITE;
/*!40000 ALTER TABLE `favorite_programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profession_competencies`
--

DROP TABLE IF EXISTS `profession_competencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profession_competencies` (
  `profession_id` int NOT NULL,
  `competency_id` int NOT NULL,
  PRIMARY KEY (`profession_id`,`competency_id`),
  KEY `competency_id` (`competency_id`),
  CONSTRAINT `profession_competencies_ibfk_1` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `profession_competencies_ibfk_2` FOREIGN KEY (`competency_id`) REFERENCES `competencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profession_competencies`
--

LOCK TABLES `profession_competencies` WRITE;
/*!40000 ALTER TABLE `profession_competencies` DISABLE KEYS */;
INSERT INTO `profession_competencies` VALUES (1,1),(4,1),(5,1),(7,1),(1,2),(1,3),(2,3),(3,3),(5,3),(8,3),(2,4),(6,4),(2,5),(3,6),(3,7),(6,7),(4,8),(4,9),(5,10),(5,11),(7,12),(7,13),(8,14),(8,15),(3,16),(6,16),(2,18),(6,19),(1,20),(7,20),(8,20);
/*!40000 ALTER TABLE `profession_competencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professions`
--

DROP TABLE IF EXISTS `professions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `average_salary` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professions`
--

LOCK TABLES `professions` WRITE;
/*!40000 ALTER TABLE `professions` DISABLE KEYS */;
INSERT INTO `professions` VALUES (1,'Backend / Fullstack Разработчик','Создание масштабируемой серверной логики, проектирование API и архитектуры баз данных.',145000),(2,'Data Scientist / ML Engineer','Обработка больших данных, статистическое моделирование и обучение нейросетевых моделей.',175000),(3,'Специалист по информационной безопасности','Защита цифровых платформ, мониторинг инцидентов и аудит сетевых уязвимостей.',155000),(4,'UI/UX Дизайнер интерфейсов','Проектирование логики пользовательского опыта, дизайн веб и мобильных интерфейсов.',115000),(5,'QA Engineer (Инженер по контролю качества)','Функциональное и автоматизированное тестирование сервисов перед выпуском на рынок.',110000),(6,'DevOps Инженер / Архитектор инфраструктуры','Автоматизация сборки и доставки кода (CI/CD), поддержка отказоустойчивости серверов.',180000),(7,'Mobile Developer (iOS / Android)','Создание нативных мобильных приложений для смартфонов и планшетов.',150000),(8,'Системный / Бизнес-аналитик в IT','Формализация требований заказчиков, перевод бизнес-задач в технические задания разработчикам.',135000);
/*!40000 ALTER TABLE `professions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_professions`
--

DROP TABLE IF EXISTS `program_professions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_professions` (
  `program_id` int NOT NULL,
  `profession_id` int NOT NULL,
  `is_primary` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`program_id`,`profession_id`),
  KEY `profession_id` (`profession_id`),
  CONSTRAINT `program_professions_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `educational_programs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `program_professions_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_professions`
--

LOCK TABLES `program_professions` WRITE;
/*!40000 ALTER TABLE `program_professions` DISABLE KEYS */;
INSERT INTO `program_professions` VALUES (1,1,1),(1,5,0),(1,6,0),(1,7,0),(2,1,0),(2,2,1),(2,8,0),(3,1,0),(3,8,1),(4,1,1),(4,5,0),(4,7,0),(5,3,1),(5,6,0),(6,1,0),(6,2,1),(7,1,0),(7,6,1),(7,8,0),(8,1,0),(8,7,1),(9,1,0),(9,2,1),(10,4,1),(10,7,0),(11,1,0),(11,5,1),(12,1,1),(12,6,0),(12,7,0),(13,1,1),(13,5,0),(13,7,0),(14,5,1),(14,8,0),(15,2,1),(15,8,0),(16,3,1),(16,6,0),(17,4,0),(17,7,1),(18,5,0),(18,8,1),(19,1,1),(19,6,0),(19,7,0),(20,1,0),(20,6,1);
/*!40000 ALTER TABLE `program_professions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_options`
--

DROP TABLE IF EXISTS `test_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `option_text` text NOT NULL,
  `linked_profession_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  KEY `linked_profession_id` (`linked_profession_id`),
  CONSTRAINT `test_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `test_questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `test_options_ibfk_2` FOREIGN KEY (`linked_profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_options`
--

LOCK TABLES `test_options` WRITE;
/*!40000 ALTER TABLE `test_options` DISABLE KEYS */;
INSERT INTO `test_options` VALUES (1,1,'Алгебра, информатика (написание алгоритмов и решение задач на логику)',1),(2,1,'Высшая математика, теория вероятностей, статистика и графики функций',2),(3,1,'Физика (электричество, сигналы), право, основы безопасности и криптографии',3),(4,1,'Геометрия, рисование, черчение, визуальные презентации и медиа',4),(5,1,'Русский язык (грамматика, пунктуация), логика, кропотливый разбор текстов',5),(6,1,'Информатика (устройство ПК, операционные системы, компьютерные сети)',6),(7,1,'Информатика (разработка инди-игр, мини-приложений под смартфон)',7),(8,1,'Обществознание, экономика, проектная деятельность и презентации',8),(9,2,'Написать программный код, связать таблицы и настроить работу сервера',1),(10,2,'Собрать статистику, проанализировать данные и сделать прогноз результатов',2),(11,2,'Проверить защиту проекта от взлома, настроить безопасный доступ и пароли',3),(12,2,'Нарисовать красивую презентацию, макет сайта и подобрать цветовую гамму',4),(13,2,'Протестировать весь проект от и до, найти все нестыковки и ошибки команды',5),(14,2,'Настроить компьютеры, хостинг, программы для работы всей команды',6),(15,2,'Сделать так, чтобы проектом было удобно пользоваться с мобильного телефона',7),(16,2,'Пообщаться с преподавателем/заказчиком, составить план и распределить задачи',8),(17,3,'Понять, как устроена сложная система изнутри и написать для нее понятную инструкцию-код',1),(18,3,'Найти скрытую закономерность среди миллионов чисел или фактов',2),(19,3,'Разобраться в чужом закрытом коде, найти уязвимость или обойти ограничение',3),(20,3,'Оценивать удобство сайтов: почему одна кнопка бесит, а другая нажимается сама собой',4),(21,3,'Нажимать на все кнопки подряд, пытаясь сломать программу или сайт ради интереса',5),(22,3,'Настраивать домашний роутер, переустанавливать операционки, собирать ПК',6),(23,3,'Изучать фишки мобильных операционных систем и интерфейсы популярных приложений',7),(24,3,'Анализировать, почему один бизнес успешен, а другой теряет клиентов',8),(25,4,'Люблю создавать логичные конструкции, где каждая строчка на своем месте',1),(26,4,'Могу часами сидеть над графиками и формулами, если ищу точный ответ',2),(27,4,'Всегда обращаю внимание на безопасность данных (двухфакторка, сложные пароли)',3),(28,4,'Раздражает, когда на сайте съехал текст, кривой шрифт или неприятные цвета',4),(29,4,'Сразу замечаю опечатки в книгах, баги в играх и нелогичное поведение программ',5),(30,4,'Люблю, когда всё автоматизировано и работает как швейцарские часы без сбоев',6),(31,4,'Важно, чтобы интерфейс на экране пальцем нажимался мгновенно и без зависаний',7),(32,4,'Важно, чтобы требования были четко записаны и никто ничего не перепутал',8),(33,5,'Инженерные задачи: строить надежные программные механизмы',1),(34,5,'Исследовательские задачи: проверять научные и математические гипотезы',2),(35,5,'Задачи по защите и расследованию: быть цифровым детективом и защитником',3),(36,5,'Творческо-технические задачи: создавать визуальный продукт для людей',4),(37,5,'Задачи контроля: быть строгим аудитором и гарантом качества',5),(38,5,'Инфраструктурные задачи: управлять мощными серверами и облаками',6),(39,5,'Продуктовые мобильные задачи: создавать то, что всегда в кармане у людей',7),(40,5,'Организационные задачи: объединять бизнес и программистов в единое целое',8),(41,6,'Чтобы сервер выдерживал миллион пользователей одновременно',1),(42,6,'Чтобы приложение подбирало умные персонализированные рекомендации',2),(43,6,'Чтобы данные пользователей и переписки были на 100% зашифрованы',3),(44,6,'Чтобы внешний вид вызывал восторг и был интуитивно понятен за 2 секунды',4),(45,6,'Чтобы в релизе не было ни единого бага или вылета',5),(46,6,'Чтобы обновления выкатывались за минуту без остановки работы сервиса',6),(47,6,'Чтобы приложение идеально плавно работало даже на старых смартфонах',7),(48,6,'Чтобы приложение решало реальную проблему людей и приносило прибыль',8),(49,7,'Писать скрипты и программы, управляющие передачей данных',1),(50,7,'Использовать вычислительные мощности для обработки массивов данных',2),(51,7,'Изучать протоколы передачи данных и системы шифрования',3),(52,7,'Настраивать экранные сетки, типографику, визуальные темы оформления',4),(53,7,'Искать границы возможностей техники и нестандартные сценарии использования',5),(54,7,'Работать через терминал/командную строку и настраивать серверные службы',6),(55,7,'Тестировать программы на разных смартфонах, планшетах и часах',7),(56,7,'Использовать таблицы, диаграммы связей и ментальные карты',8),(57,8,'Создавать сложный, высоконагруженный и надежный программный код',1),(58,8,'Работать на острие искусственного интеллекта и прогнозирования',2),(59,8,'Обеспечивать кибербезопасность и защищать цифровой мир от угроз',3),(60,8,'Делать цифровой мир красивым, доступным и понятным для каждого',4),(61,8,'Быть уверенным в безупречном качестве продукта перед его выходом',5),(62,8,'Управлять масштабными облачными системами и автоматизировать процессы',6),(63,8,'Видеть свое приложение на смартфонах миллионов пользователей по всему миру',7),(64,8,'Быть связующим звеном и управлять развитием IT-продукта',8);
/*!40000 ALTER TABLE `test_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_questions`
--

DROP TABLE IF EXISTS `test_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_text` text NOT NULL,
  `hint` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_questions`
--

LOCK TABLES `test_questions` WRITE;
/*!40000 ALTER TABLE `test_questions` DISABLE KEYS */;
INSERT INTO `test_questions` VALUES (1,'Какие школьные предметы или темы даются вам легче и приносят больше удовольствия?','Выберите одно или несколько направлений'),(2,'Представьте, что вы делаете проект для школы или олимпиады. Какую часть работы вы бы взяли на себя?','Можно выбрать несколько ролей'),(3,'С какими типами задач вам интереснее разбираться в свободное время?','Ориентируйтесь на то, от чего вы меньше устаете'),(4,'Как вы относитесь к поиску ошибок и проверке деталей?','Отношение к внимательности и аккуратности'),(5,'Какая рабочая атмосфера и тип задач кажутся вам наиболее комфортными?','Формат взаимодействия и цели'),(6,'Если бы вы создавали собственную игру или приложение, что волновало бы вас в первую очередь?','Приоритет в разработке продукта'),(7,'Как вы предпочитаете работать с техническими устройствами и компьютером?','Уровень взаимодействия с техникой'),(8,'Что для вас важнее всего в будущей профессии?','Ваша главная внутренняя мотивация');
/*!40000 ALTER TABLE `test_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'НИУ ВШЭ (Высшая школа экономики)','Москва'),(2,'МГТУ им. Н.Э. Баумана','Москва'),(3,'МГУ им. М.В. Ломоносова','Москва'),(4,'МФТИ (Физтех)','Долгопрудный / Москва'),(5,'Университет ИТМО','Санкт-Петербург'),(6,'СПбГУ','Санкт-Петербург'),(7,'УрФУ им. Б.Н. Ельцина','Екатеринбург'),(8,'НГУ (Новосибирский госуниверситет)','Новосибирск'),(9,'КФУ (Казанский федеральный университет)','Казань'),(10,'Университет Иннополис','Иннополис');
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'илья','123@mail.ru','$2b$10$yBajYXSOc9WtaXHBuz8cyed.hBpbPItVwGcCIbhOgqdYZXj22kaMi','2026-09-01 15:05:46');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacancies`
--

DROP TABLE IF EXISTS `vacancies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacancies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employer_id` int NOT NULL,
  `profession_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `salary_offered` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employer_id` (`employer_id`),
  KEY `profession_id` (`profession_id`),
  CONSTRAINT `vacancies_ibfk_1` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vacancies_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacancies`
--

LOCK TABLES `vacancies` WRITE;
/*!40000 ALTER TABLE `vacancies` DISABLE KEYS */;
INSERT INTO `vacancies` VALUES (1,1,1,'Junior/Middle Backend Developer (Node.js/Go)',130000),(2,1,4,'Продуктовый дизайнер веб-сервисов',125000),(3,1,6,'DevOps-инженер облачной платформы',170000),(4,2,2,'Data Analyst / ML Researcher',140000),(5,2,7,'Android Developer (Сбербанк Онлайн)',160000),(6,2,8,'Системный аналитик финансовых сервисов',130000),(7,3,3,'Специалист центра мониторинга кибератак (SOC)',120000),(8,3,3,'Пентестер / Аналитик защищенности ПО',165000),(9,4,1,'Fullstack-разработчик медиаплатформы',140000),(10,4,5,'Инженер по автоматизации тестирования (QA)',115000),(11,5,5,'QA Engineer склада и логистики',105000),(12,5,6,'SRE / DevOps Engineer',185000),(13,6,7,'iOS Developer в команду платежей',170000),(14,6,8,'Бизнес-аналитик инвестиционных продуктов',145000),(15,7,3,'Инженер по кибербезопасности инфраструктуры',155000),(16,8,2,'Data Scientist прогнозирования спроса',160000);
/*!40000 ALTER TABLE `vacancies` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-02  0:14:29
