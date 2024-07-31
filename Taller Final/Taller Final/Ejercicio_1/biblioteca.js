class BibliotecaMusica{
    #duracion;
    constructor(titulo, artista, duracion) {
        this.titulo = titulo;
        this.artista = artista;
        this.#duracion = duracion;
        
    }
    
    // al ser un atributo Privado
    get duracion() {
        return this.#duracion;
    }
}


class Coleccion{
    constructor(){
        this.coleccion = [] // Array
    }

    agregarCancion(cancion) {
        this.coleccion.push(cancion);
    }

    // Recorre el array usando un For 
    eliminarCancion(titulo) { 
        for (let i = 0; i < this.coleccion.length; i++) {
            if (this.coleccion[i].titulo === titulo){
                this.coleccion.splice(i, 1);
                break; // acaba de recorrer el array
            }
        }
    }

    mostrarDetalles() {
        for (let i = 0; i < this.coleccion.length; i++) {
            console.log(`Titulo ${this.coleccion[i].titulo}`)
        }
    }
  
}

// Instancias 
let coleccion = new Coleccion();

let cancion1 = new BibliotecaMusica('Snap Out', 'Artick', '3:66');
let cancion2 = new BibliotecaMusica('Cracker Island', 'Gorillaz', '3:63');

// Agregar canciones
coleccion.agregarCancion(cancion1);
coleccion.agregarCancion(cancion2);

// Eliminar cancion
coleccion.eliminarCancion('Snap Out')

coleccion.mostrarDetalles();