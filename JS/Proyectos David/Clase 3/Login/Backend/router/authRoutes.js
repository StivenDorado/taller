// routes/authRoutes.js
const express = require('express');
const authController = require('../controllers/authController');
const authenticateToken = require('../middleware/authenticateToken');

const router = express.Router();

// Ruta de registro
router.post('/register', authController.register);

// Ruta de login
router.post('/login', authController.login);

// Ruta protegida
router.get('/protected', authenticateToken, authController.getProtectedData);

module.exports = router;