/* Personaje de tv */
let nombre = "tamjori";
let anime = "demonn slayer";
let edad = 16;

/* se le asignan las propiedades (variables) al objeto */
let personaje = {
    /* Propiedades o llaves de valor */
    nombre:"tanjiro",
    anime:"demon slayer",
    edad: 16,
};

console.log(personaje);
console.log(personaje.nombre);
console.log(personaje["anime"]);

personaje.edad = 13;

let llave = "edad";
personaje ["llave"] = 16;

//elimina propiedades de un objeto
delete personaje.anime;

console.log(personaje);