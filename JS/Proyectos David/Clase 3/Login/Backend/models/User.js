// models/User.js
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

// Esquema de Usuario
const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        match: [/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, 'Por favor ingresa un email válido']
    },
    name: {
        type: String,
        required: true,
        trim: true,
        minlength: 2,
        maxlength: 50
    },
    password: {
        type: String,
        required: true,
        minlength: 6
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
}, {
    timestamps: true
});

// Método de validación estático
userSchema.statics.validate = function(username, password, name, email) {
    return !!(
        username && 
        password && 
        name && 
        email &&
        username.length >= 3 && 
        username.length <= 20 &&
        password.length >= 6 &&
        name.length >= 2 &&
        name.length <= 50 &&
        /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)
    );
};

// Middleware para hashear contraseña antes de guardar
userSchema.pre('save', async function(next) {
    // Solo hashear la contraseña si ha sido modificada
    if (!this.isModified('password')) return next();

    try {
        // Generar salt y hashear contraseña
        const salt = await bcrypt.genSalt(10);
        this.password = await bcrypt.hash(this.password, salt);
        next();
    } catch (error) {
        next(error);
    }
});

// Método para comparar contraseñas
userSchema.methods.comparePassword = async function(candidatePassword) {
    return bcrypt.compare(candidatePassword, this.password);
};

// Modelo de Usuario
const User = mongoose.model('User', userSchema);

module.exports = User;