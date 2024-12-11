// server.js
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const authRoutes = require('./router/authRoutes');
require('./config/db');

const app = express();

// Middlewares
app.use(express.json());
app.use(cors());

// Rutas
app.use(authRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor en funcionamiento en http://localhost:${PORT}`);
});