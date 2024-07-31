import Libro from "./biblioteca.js";
import LibroSistema from "./libroSistema.js";

// Instancia de Libro
const libro1 = new Libro("Cien años de soledad", "Gabriel García Márquez");
console.log(libro1.mostrarEstado()); 
console.log(libro1.prestarLibro());  
console.log(libro1.mostrarEstado()); 
console.log(libro1.devolverLibro()); 
console.log(libro1.mostrarEstado()); 

// Instancia de LibroDigital
const libroDigital1 = new LibroSistema("1984", "George Orwell", "ePub");
console.log(libroDigital1.mostrarEstado());
console.log(libroDigital1.prestarLibro()); 
console.log(libroDigital1.mostrarEstado()); 
console.log(libroDigital1.devolverLibro()); 
console.log(libroDigital1.mostrarEstado()); 

