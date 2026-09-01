const express = require('express');
const cors = require('cors');
require('dotenv').config();

const db = require('./db');
const studentRoutes = require('./routes/studentRoutes');
const authRoutes = require('./routes/authRoutes');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Раздача клиентского интерфейса
app.use(express.static('public'));

// Маршруты API
app.use('/api/student', studentRoutes);
app.use('/api/auth', authRoutes);

app.get('/api/test-db', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT 1 + 1 AS solution');
        res.json({ message: 'База данных успешно подключена!', solution: rows[0].solution });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.listen(PORT, () => {
    console.log(`Сервер запущен на http://localhost:${PORT}`);
});