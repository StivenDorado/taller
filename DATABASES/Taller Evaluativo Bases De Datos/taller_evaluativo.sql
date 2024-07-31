CREATE DATABASE Pizzeria 
WITH ENCODING = 'UTF8';

CREATE TABLE Pizzas (
    idPizza SERIAL PRIMARY KEY,
    pizNombre VARCHAR(50) NOT NULL,
    pizIngredientes VARCHAR(255) NOT NULL,
    pizValor INTEGER NOT NULL
);

CREATE TABLE Clientes (
    idCliente SERIAL PRIMARY KEY,
    cliNombre VARCHAR(50) NOT NULL,
    cliCorreo VARCHAR(100) NOT NULL
);

CREATE TABLE Pedidos (
    idPedido SERIAL PRIMARY KEY,
    idPizza INTEGER NOT NULL REFERENCES Pizzas(idPizza),
    idCliente INTEGER NOT NULL REFERENCES Clientes(idCliente),
    pedCantidad INTEGER NOT NULL,
    pedDireccion VARCHAR(255) NOT NULL,
    pedFechaHora TIMESTAMP NOT NULL
);

CREATE TABLE Facturas (
    idFactura SERIAL PRIMARY KEY,
    idPedido INTEGER NOT NULL REFERENCES Pedidos(idPedido),
    facValor INTEGER NOT NULL
);



/*a. Consultar el comercial con mayor valor de comisión:*/
SELECT c.comNombre, SUM(p.pedValor * c.comComision) AS comTotal
FROM Clientes c
JOIN Pedidos p ON c.cliId = p.cliId
JOIN Comisiones co ON c.comId = co.comId
GROUP BY c.comNombre
ORDER BY comTotal DESC
LIMIT 1;


/*b. Listado de clientes con pedidos entre 300€ y 600€ en 2019:*/
SELECT cliNombre, cliApellido, pedFechaHora, pedValor
FROM Clientes c
JOIN Pedidos p ON c.cliId = p.cliId
WHERE pedFechaHora BETWEEN '2019-01-01' AND '2019-12-31'
AND pedValor BETWEEN 300 AND 600;


/*c. Listado de pedidos superiores a 1000€ con detalles de clientes y comerciales:*/
SELECT p.pedCantidad, p.pedFechaHora, c.cliNombre, c.cliApellido, comNombre, comApellido
FROM Pedidos p
JOIN Clientes c ON c.cliId = p.cliId
JOIN Comisiones co ON p.comId = co.comId
WHERE p.pedCantidad > 1000
ORDER BY p.pedFechaHora DESC;
























