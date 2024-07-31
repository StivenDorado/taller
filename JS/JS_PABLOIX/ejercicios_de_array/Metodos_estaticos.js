
//El método Array.from() crea una nueva instancia de Array a partir de un objeto iterable o similar a un array.

//Ejemplo 1: Convertir un string en un array de caracteres

const str = "Hola";
const arrayOfChars = Array.from(str);
console.log(arrayOfChars);
// Resultado: ['H', 'o', 'l', 'a']

//Ejemplo 2: Crear un array a partir de un objeto con propiedades de longitud

const obj = { length: 3, 0: 'a', 1: 'b', 2: 'c' };
const arrayFromObj = Array.from(obj);
console.log(arrayFromObj);
// Resultado: ['a', 'b', 'c']



//El método Array.isArray() determina si el valor pasado es un Array.

//Ejemplo 1: Verificar si una variable es un array

const arr = [1, 2, 3];
const result = Array.isArray(arr);
console.log(result);
// Resultado: true


//Ejemplo 2: Verificar si una variable que no es un array

const notAnArray = "Hola";
const result1 = Array.isArray(notAnArray);
console.log(result1);
// Resultado: false