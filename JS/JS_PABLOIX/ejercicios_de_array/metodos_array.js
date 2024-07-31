//1. Array.prototype.map()

//Ejemplo 1: Duplicar elementos de un arreglo
const numeros = [1, 2, 3, 4, 5];

const numerosDuplicados = numeros.map(numero => numero * 2);

console.log(numerosDuplicados); // [2, 4, 6, 8, 10]


//Ejemplo 2: Convertir nombres a mayúsculas
const nombres = ["juan", "maría", "pedro"];

const nombresMayusculas = nombres.map(nombre => nombre.toUpperCase());

console.log(nombresMayusculas); // ["JUAN", "MARÍA", "PEDRO"]



//2. Array.prototype.pop()

//Ejemplo 1: Eliminar el último elemento de un arreglo
const colores = ["rojo", "verde", "azul", "amarillo"];

const colorEliminado = colores.pop();

console.log(colores); // ["rojo", "verde", "azul"]
console.log(colorEliminado); // "amarillo"

//Ejemplo 2: Obtener el último elemento sin eliminarlo
const frutas = ["manzana", "pera", "mango"];

const ultimaFruta = frutas[frutas.length - 1];

console.log(ultimaFruta); // "mango"
console.log(frutas); // ["manzana", "pera", "mango"] (sin modificaciones)



//3. Array.prototype.push() - Agregar elementos al final

// Ejemplo 1: Creamos un arreglo de frutas
let frutas1 = ["manzana", "pera"];

// Agregamos dos elementos más usando push
frutas1.push("banana", "uvas");

console.log(frutas); // ["manzana", "pera", "banana", "uvas"]



// Ejemplo 2: Creamos un arreglo de números
let numeros1 = [1, 2, 3];

// Agregamos un elemento al final usando push
numeros1.push(4);

console.log(numeros); // [1, 2, 3, 4]



//4. Array.prototype.reduce() (Reducir)

//Ejemplo 1: Calcular la suma de los elementos de un array
const numeros2 = [10, 5, 20, 15, 7];

const sumaTotal = numeros2.reduce((acumulador, valorActual) => acumulador + valorActual, 0);

console.log("Suma total:", sumaTotal); // Resultado: 57


//Ejemplo 2: Contar la cantidad de elementos que son mayores que 10 en un array

const numeros3 = [15, 8, 12, 3, 18, 5];

const cantidadMayores10 = numeros3.reduce((contador, valorActual) => {
  if (valorActual > 10) {
    contador++;
  }
  return contador;
}, 0);

console.log("Cantidad de elementos mayores que 10:", cantidadMayores10); // Resultado: 3



//5. Array.prototype.reduceRight() - Reducir un arreglo a un solo valor (comenzando desde el final)
// Creamos un arreglo de números
let letras = ["a", "b", "c", "d"];

//Ejemplo 1: Invertimos el orden y obtenemos la última letra usando reduceRight
let ultimaLetra = letras.reduceRight((acumulador, letraActual) => letraActual, "");

console.log(ultimaLetra); // d

// Creamos un arreglo de objetos con productos
let productos = [
    { id: 1, nombre: "Camisa", precio: 25 },
    { id: 2, nombre: "Pantalón", precio: 30 },
    { id: 3, nombre: "Zapatos", precio: 40 }
  ];
  
//Ejemplo 2: Obtenemos el producto más caro usando reduceRight
  let productoMasCaro = productos.reduceRight((productoCaro, productoActual) => 
    (productoCaro.precio > productoActual.precio) ? productoCaro : productoActual, productos[0]);
  
  console.log(productoMasCaro); // { id: 3, nombre: "Zapatos", precio: 40 }
  

//6. Array.prototype.reverse() (Invertir)

//Ejemplo 1: Invertir el orden de los elementos de un array de cadenas de texto

const palabras = ["hola", "mundo", "cómo", "estás"];

palabras.reverse();

console.log("Array invertido:", palabras); // Resultado: ["estás", "cómo", "mundo", "hola"]

//Ejemplo 2: Invertir el orden de los elementos de un array de números

const numeros4 = [5, 2, 4, 1, 3];

numeros4.reverse();

console.log("Array invertido:", numeros); // Resultado: [3, 1, 4, 2, 5]

//7. Array.prototype.shift() (Extraer primer elemento)

//Ejemplo 1: Extraer y eliminar el primer elemento de un array de cadenas de texto

const colores1 = ["rojo", "azul", "verde", "amarillo"];

const primerColor = colores1.shift();

console.log("Primer color extraído:", primerColor); // Resultado: "rojo"
console.log("Array restante:", colores); // Resultado: ["azul", "verde", "amarillo"]


//Ejemplo 2: Extraer y eliminar el primer elemento de un array de números

const numeros5 = [10, 5, 20, 15, 7];

const primerNumero = numeros5.shift();

console.log("Primer número extraído:", primerNumero); // Resultado: 10
console.log("Array restante:", numeros5); // Resultado: [5, 20, 15, 7]


//8. Array.prototype.slice()

//Ejemplo 1: Obtener un subarray de los primeros 3 elementos:
const numeros6 = [1, 2, 3, 4, 5];
const subArray1 = numeros6.slice(0, 3); // subArray = [1, 2, 3]

//Ejemplo 2: Obtener un subarray desde el índice 2 hasta el final:
const colores2 = ["rojo", "verde", "azul", "amarillo"];
const subArray2 = colores.slice(2); // subArray = ["azul", "amarillo"]


//9. Array.prototype.some()

//Ejemplo 1: Verificar si hay números pares en un array:

const numeros7 = [1, 2, 3, 4, 5];
const hayPares = numeros7.some(numero => numero % 2 === 0); // hayPares = true

//Ejemplo 2: Comprobar si algún estudiante tiene una calificación mayor a 90:
const estudiantes = [
    { nombre: "Juan", calificacion: 85 },
    { nombre: "María", calificacion: 92 },
    { nombre: "Pedro", calificacion: 78 }
  ];
  
  const hayCalificacionAlta = estudiantes.some(estudiante => estudiante.calificacion > 90); // hayCalificacionAlta = true
  

//10. Array.prototype.sort()

//Ejemplo 1: Ordenar un array de números en orden ascendente:
const numeros8 = [5, 2, 4, 1, 3];
numeros8.sort(); // numeros = [1, 2, 3, 4, 5]

//Ejemplo 2: Ordenar un array de objetos por nombre en orden descendente:

const productos1 = [
    { nombre: "Laptop", precio: 1000 },
    { nombre: "Celular", precio: 500 },
    { nombre: "Tablet", precio: 750 }
  ];
  
  productos1.sort((a, b) => b.nombre.localeCompare(a.nombre)); // productos1 = [{ nombre: "Tablet", precio: 750 }, { nombre: "Celular", precio: 500 }, { nombre: "Laptop", precio: 1000 }]
  