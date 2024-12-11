const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const authController = {
    // Registro de usuario
    async register(req, res) {
        try {
            const { name, email, password } = req.body;

            // Validar campos requeridos
            if (!name || !email || !password) {
                return res.status(400).json({ error: 'Todos los campos son obligatorios' });
            }

            // Validar longitud y formato de campos
            if (name.length < 2 || name.length > 50) {
                return res.status(400).json({ error: 'El nombre debe tener entre 2 y 50 caracteres' });
            }
            if (password.length < 6) {
                return res.status(400).json({ error: 'La contraseña debe tener al menos 6 caracteres' });
            }
            const emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (!emailRegex.test(email)) {
                return res.status(400).json({ error: 'Correo electrónico inválido' });
            }

            // Verificar si el usuario ya existe
            const existingUser = await User.findOne({ email });
            if (existingUser) {
                return res.status(409).json({ error: 'El correo ya está registrado' });
            }

            // Hash de la contraseña
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);

            // Crear nuevo usuario
            const newUser = new User({ 
                name, 
                email, 
                password: hashedPassword 
            });

            // Guardar usuario
            await newUser.save();

            res.status(201).json({ message: 'Usuario registrado exitosamente' });
        } catch (error) {
            console.error('Error en registro:', error);
            res.status(500).json({ error: 'Error en el registro', details: error.message });
        }
    },

    // Inicio de sesión
    async login(req, res) {
        try {
            const { email, password } = req.body;

            // Buscar usuario por correo
            const user = await User.findOne({ email });
            if (!user) {
                return res.status(401).json({ error: 'Credenciales incorrectas' });
            }

            // Verificar contraseña
            const isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch) {
                return res.status(401).json({ error: 'Credenciales incorrectas' });
            }

            // Generar token JWT
            const token = jwt.sign(
                { 
                    id: user._id, 
                    email: user.email,
                    name: user.name 
                },
                process.env.JWT_SECRET,
                { expiresIn: '1h' }
            );

            res.json({
                message: 'Inicio de sesión exitoso',
                token,
                user: {
                    id: user._id,
                    name: user.name,
                    email: user.email
                }
            });
        } catch (error) {
            console.error('Error en login:', error);
            res.status(500).json({ error: 'Error en el inicio de sesión', details: error.message });
        }
    },

    // Middleware para verificar token
    async verifyToken(req, res, next) {
        const token = req.header('Authorization')?.replace('Bearer ', '');

        if (!token) {
            return res.status(401).json({ error: 'No se proporcionó token de autenticación' });
        }

        try {
            const decoded = jwt.verify(token, process.env.JWT_SECRET);
            req.user = decoded;
            next();
        } catch (error) {
            res.status(401).json({ error: 'Token inválido o expirado' });
        }
    },

    // Ruta protegida
    getProtectedData(req, res) {
        res.json({
            message: 'Acceso autorizado',
            user: req.user,
        });
    },

    // Obtener lista de usuarios
    async getUsers(req, res) {
        try {
            const users = await User.find().select('-password'); // Excluir contraseñas
            res.json(users);
        } catch (error) {
            console.error('Error al obtener usuarios:', error);
            res.status(500).json({ error: 'Error al obtener usuarios', details: error.message });
        }
    },
};

module.exports = authController;