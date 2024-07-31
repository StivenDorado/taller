class Contacto {
    constructor(nombre, apellido, telefono, correoElectronico) {
      this.nombre = nombre;
      this.apellido = apellido;
      this.telefono = telefono;
      this.correoElectronico = correoElectronico;
    }
  }
  
  class Agenda {
    constructor() {
      contactos = []; // Array privada para almacenar los contactos

    }
  
    agregarContacto(contactos) {
      this.contactos.push(contactos);
    }
    
    editarContacto(nombre, nuevoNombre, nuevoApellido, nuevoTelefono, nuevoCorreoElectronico) {
      for (let i = 0; i < this.contactos.length; i++) {
          if (this.contactos[i].nombre === nombre) {
              this.contactos[i].nombre = nuevoNombre;
              this.contactos[i].apellido = nuevoApellido;
              this.contactos[i].telefono = nuevoTelefono;
              this.contactos[i].correoElectronico = nuevoCorreoElectronico;  
              break;
          }
      }
  }
    // elimina el contacto por el nombre 
    eliminarContacto(nombre) {
      for (let i = 0; i < this.contactos.length; i++) {
          if (this.contactos[i].nombre === nombre) {
              this.contactos.splice(i, 1);
              break;
          }
      }
  }
  
    mostrarContacto() {
      for (let i = 0; i < this.contactos.length; i++) {
          console.log(`Nombre: ${this.contactos[i].nombre},
              Apellido: ${this.contactos[i].apellido},
              Teléfono: ${this.contactos[i].telefono},
              Correo: ${this.contactos[i].correoElectronico}`);
      }
  }
  }
  
  // Instancias
  const miAgenda = new Agenda();
  
  miAgenda.agregarContacto("Juan", "Pérez", "123456789", "juan.perez@example.com");
  miAgenda.agregarContacto("Ana", "Gómez", "987654321", "ana.gomez@example.com");
  
  console.log("Contactos en la agenda:");
  miAgenda.mostrarContacto();
  
  miAgenda.editarContacto(0, "Juan", "Pérez", "111111111", "juan.perez@nuevoemail.com");
  
  console.log("Contactos después de editar:");
  miAgenda.mostrarContacto();
  
  miAgenda.eliminarContacto(1);
  
  console.log("Contactos después de eliminar:");
  miAgenda.mostrarContacto();
  