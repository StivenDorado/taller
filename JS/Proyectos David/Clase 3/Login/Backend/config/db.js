const mongoose = require('mongoose');

const db = async () => {
    try {
        await mongoose.connect(process.env.MONGODB_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('Conexión a MongoDB exitosa');
    } catch (error) {
        console.error('Error de conexión a MongoDB:', error.message);
        process.exit(1); // Finaliza la aplicación si falla la conexión
    }
};

module.exports = db;
