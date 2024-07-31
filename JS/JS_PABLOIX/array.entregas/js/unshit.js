//primer ejemplo
let frutas = ['Manzana', 'Però', 'Uva'];
    console.log (Frutas.unshift ('banano'));

//segundo ejemplo
const notas = [10, 20, 30];
    console.log (notas. Unshift (40, 50));



    function sumarNumeros() {
        // Solicitar al usuario el primer número
        let primerNumero = Number(prompt('Ingrese el primer número: '));
      
        // Solicitar al usuario el segundo número
        let segundoNumero = Number(prompt('Ingrese el segundo número: '));
      
        // Sumar los números
        const suma = primerNumero + segundoNumero;
      
        // Mostrar el resultado de la suma
        alert(`La suma de los números es: ${suma}`);
      }
      
      // Ejecutar la función para pedir al usuario los números y sumar
      sumarNumeros();
      