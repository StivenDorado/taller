class Contacto {
    constructor() {
        this.contactos = new Map(); // Se aplica un Map para almacenar contactos
    }

    agregarContacto(id, nombre, apellido, telefono, correoElectronico) {
        const contacto = {
            id, 
            nombre, 
            apellido, 
            telefono, 
            correoElectronico
        };
        this.contactos.set(id, contacto); // Se aplica el id como clave en el Map
    }

    editarContacto(id, nuevoNombre, nuevoApellido, nuevoTelefono, nuevoCorreoElectronico) {
        if (this.contactos.has(id)) {
            let contacto = this.contactos.get(id);
            contacto.nombre = nuevoNombre;
            contacto.apellido = nuevoApellido;
            contacto.telefono = nuevoTelefono;
            contacto.correoElectronico = nuevoCorreoElectronico;
            this.contactos.set(id, contacto); // Se actualiza el contacto en el Map
        } else {
            console.log("Contacto no encontrado.");
        }
    }

    eliminarContacto(id) {
        if (this.contactos.has(id)) {
            this.contactos.delete(id); // Se limina el contacto del Map
        } else {
            console.log("Contacto no encontrado.");
        }
    }

    mostrarContacto() {
        this.contactos.forEach(contacto => {
            console.log(`Nombre: ${contacto.nombre} ${contacto.apellido},
Teléfono: ${contacto.telefono},
Correo: ${contacto.correoElectronico}`);
        });
    }
}

// Instancias
let misContactos = new Contacto();

misContactos.agregarContacto(1, "Harry", "Potter", "123456789", "harry.potter@hogwarts.com");
misContactos.agregarContacto(2, "Hermione", "Granger", "987654321", "hermione.granger@hogwarts.com");
misContactos.agregarContacto(3, "Ron", "Weasley", "456789123", "ron.weasley@hogwarts.com");
misContactos.agregarContacto(4, "Albus", "Dumbledore", "654321987", "albus.dumbledore@hogwarts.com");
misContactos.agregarContacto(5, "Severus", "Snape", "321654987", "severus.snape@hogwarts.com");

misContactos.mostrarContacto();

misContactos.eliminarContacto(4);


misContactos.mostrarContacto();

misContactos.editarContacto(3, "Ronald", "Weasley", "654789321", "ronald.weasley@hogwarts.com");

misContactos.mostrarContacto();
