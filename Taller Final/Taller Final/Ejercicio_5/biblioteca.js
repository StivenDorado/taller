
class Libro {
    #disponible;

    constructor(titulo, autor) {
        this.titulo = titulo; 
        this.autor = autor;  
        this.#disponible = true; 
    }

    // Metodos
    prestarLibro() {
        if (this.#disponible) {
            this.#disponible = false; 
            return `${this.titulo} ha sido prestado.`;
        } else {
            return `${this.titulo} no está disponible para préstamo.`;
        }
    }

    devolverLibro() {
        if (!this.#disponible) {
            this.#disponible = true; 
            return `${this.titulo} ha sido devuelto.`;
        } else {
            return `${this.titulo} ya está disponible.`;
        }
    }

    mostrarEstado() {
        return `Título: ${this.titulo}
Autor: ${this.autor}
Disponible: ${this.#disponible ? 'Sí' : 'No'}`;
    }
}

export default Libro;