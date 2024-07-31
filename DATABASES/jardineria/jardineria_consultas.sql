DROP DATABASE IF EXISTS jardineria;
CREATE DATABASE jardineria CHARACTER SET utf8mb4;
USE jardineria;

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) DEFAULT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe INTEGER DEFAULT NULL,
  puesto VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE gama_producto (
  gama VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256),
  PRIMARY KEY (gama)
);

CREATE TABLE cliente (
  codigo_cliente INTEGER NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) DEFAULT NULL,
  apellido_contacto VARCHAR(30) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  pais VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) DEFAULT NULL,
  codigo_empleado_rep_ventas INTEGER DEFAULT NULL,
  limite_credito NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_cliente),
  FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE pedido (
  codigo_pedido INTEGER NOT NULL,
  fecha_pedido date NOT NULL,
  fecha_esperada date NOT NULL,
  fecha_entrega date DEFAULT NULL,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  codigo_cliente INTEGER NOT NULL,
  PRIMARY KEY (codigo_pedido),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE producto (
  codigo_producto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  gama VARCHAR(50) NOT NULL,
  dimensiones VARCHAR(25) NULL,
  proveedor VARCHAR(50) DEFAULT NULL,
  descripcion text NULL,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_producto),
  FOREIGN KEY (gama) REFERENCES gama_producto (gama)
);

CREATE TABLE detalle_pedido (
  codigo_pedido INTEGER NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (codigo_pedido, codigo_producto),
  FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido),
  FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

CREATE TABLE pago (
  codigo_cliente INTEGER NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago date NOT NULL,
  total NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (codigo_cliente, id_transaccion),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);




/**Consultas multitabla (Composición interna)*/

/*Devuelve un listado con el código de oficina y la ciudad donde hay ofi*/

SELECT codigo_oficina, ciudad
FROM oficina;

/*Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/

SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

/*Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.*/

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

/*Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/

SELECT e.puesto AS nombre_puesto, e.nombre AS nombre_jefe, e.apellido1, e.apellido2, e.email
FROM empleado e
WHERE e.codigo_empleado = (SELECT codigo_empleado FROM empleado WHERE codigo_jefe IS NULL);

/*Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.*/

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);

/*Devuelve un listado con el nombre de los todos los clientes españoles.*/

SELECT nombre_cliente
FROM cliente
WHERE pais = 'España';

/**/
SELECT DISTINCT estado
FROM pedido;

/*Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/

SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

/*Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

Utilizando la función YEAR de MySQL.
Utilizando la función DATE_FORMAT de MySQL.
Sin utilizar ninguna de las funciones anteriores.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

/*Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.*/

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_esperada - INTERVAL 2 DAY >= fecha_entrega;

/*Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

Utilizando la función ADDDATE de MySQL.
Utilizando la función DATEDIFF de MySQL.
¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
*/
SELECT *
FROM pedido
WHERE estado = 'rechazado' AND YEAR(fecha_pedido) = 2009;

/*Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/
SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;

/*Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/
SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal'
ORDER BY total DESC;

/*Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/
SELECT DISTINCT forma_pago
FROM pago;

/*Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.*/

SELECT *
FROM producto
WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

/*Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.*/
SELECT *
FROM cliente
WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);



/* Consultas multitabla (composición interna)*/

/*Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE p.codigo_cliente IS NULL;

/*Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

/*Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

/*Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
SELECT DISTINCT linea_direccion1, ciudad, pais
FROM cliente c
JOIN oficina o ON c.ciudad = o.ciudad AND c.pais = o.pais
WHERE c.ciudad = 'Fuenlabrada';

/*Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.ciudad = o.ciudad AND e.pais = o.pais;

/*Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT e1.nombre AS nombre_empleado, e2.nombre AS nombre_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

/*Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/
SELECT e1.nombre AS nombre_empleado, e2.nombre AS nombre_jefe, e3.nombre AS nombre_jefe_de_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

/*Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.*/
SELECT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

/*Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
SELECT DISTINCT c.nombre_cliente, gp.gama
FROM cliente c
JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
JOIN detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
JOIN producto p ON dp.codigo_producto = p.codigo_producto
JOIN gama_producto gp ON p.gama = gp.gama;

/*Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/
SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL;  


/*Consultas multitabla (Composición externa)/

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.*/
SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.codigo_pedido IS NULL;

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.*/
SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pago.codigo_cliente IS NULL AND pedido.codigo_pedido IS NULL;

/*Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.*/
SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina IS NULL;

/*Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.*/
SELECT empleado.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

/*Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.*/
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.codigo_oficina, 
o.ciudad, o.pais, o.region, o.codigo_postal, o.telefono, o.linea_direccion1, o.linea_direccion2
FROM empleado e JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT DISTINCT codigo_empleado_rep_ventas FROM cliente);

/*Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.*/
SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE oficina.codigo_oficina IS NULL OR cliente.codigo_empleado_rep_ventas IS NULL;

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT producto.*
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

/*Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.*/
SELECT p.nombre, p.descripcion, pe.comentarios
FROM producto p 
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
LEFT JOIN pedido pe ON dp.codigo_pedido = pe.codigo_pedido
WHERE dp.codigo_producto IS NULL;

/*Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.*/
SELECT DISTINCT oficina.*
FROM oficina
LEFT JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
LEFT JOIN gama_producto ON producto.gama = gama_producto.gama
WHERE gama_producto.gama = 'Frutales' AND empleado.codigo_empleado IS NULL;

/*Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.*/
SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
GROUP BY cliente.codigo_cliente
HAVING COUNT(pedido.codigo_pedido) > 0 AND COUNT(pago.codigo_cliente) = 0;

/*Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.*/
SELECT e1.*, e2.nombre AS nombre_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN cliente ON e1.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;


/*Consultas resumen*/

/*¿Cuántos empleados hay en la compañía?*/
SELECT COUNT(*) AS total_empleados
FROM empleado;

/*¿Cuántos clientes tiene cada país?*/
SELECT pais, COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais;

/*¿Cuál fue el pago medio en 2009?*/
SELECT AVG(total) AS pago_medio
FROM (SELECT YEAR(fecha_pago) AS año, SUM(total) AS total
FROM pago
GROUP BY año) AS pagos_por_año
WHERE año = 2009;

/*¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.*/
SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado
ORDER BY total_pedidos DESC;

/*Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
SELECT MAX(precio_venta) AS precio_mas_caro, MIN(precio_venta) AS precio_mas_barato
FROM producto;

/*Calcula el número de clientes que tiene la empresa.*/
SELECT COUNT(*) AS total_clientes
FROM cliente;

/*¿Cuántos clientes existen con domicilio en la ciudad de Madrid?*/
SELECT COUNT(*) AS total_clientes_madrid
FROM cliente
WHERE ciudad = 'Madrid';

/*¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT ciudad, COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY ciudad;

/*Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS total_clientes
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.nombre, e.apellido1;

/*Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT COUNT(*) AS total_clientes_sin_representante
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

/*Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, MIN(fecha_pago) AS primer_pago, MAX(fecha_pago) AS ultimo_pago
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente, c.nombre_contacto, c.apellido_contacto;

/*Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT codigo_pedido, COUNT(*) AS total_productos_diferentes
FROM detalle_pedido
GROUP BY codigo_pedido;

/*Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/
SELECT codigo_pedido, SUM(cantidad) AS cantidad_total
FROM detalle_pedido
GROUP BY codigo_pedido;

/*Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.*/
SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre
ORDER BY total_unidades_vendidas DESC
LIMIT 20;

/*La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.*/
SELECT SUM(base_imponible) AS total_base_imponible, SUM(IVA) AS total_IVA, SUM(base_imponible) + SUM(IVA) AS total_facturado
FROM (SELECT SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto) AS facturacion;

/*La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT dp.codigo_producto, SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA, SUM(precio_venta * cantidad) + SUM(precio_venta * cantidad) * 0.21 AS total_facturado
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY dp.codigo_producto;

/*La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.*/
SELECT dp.codigo_producto, SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA, SUM(precio_venta * cantidad) + SUM(precio_venta * cantidad) * 0.21 AS total_facturado
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;

/*Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/
SELECT p.nombre,
SUM(dp.cantidad) AS unidades_vendidas,
SUM(dp.cantidad * dp.precio_unidad) AS total_facturado,
SUM(dp.cantidad * dp.precio_unidad) * 1.21 AS total_facturado_con_iva
FROM detalle_pedido dp JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre HAVING total_facturado > 3000;
    
/*Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.*/
SELECT YEAR(fecha_pago) AS anio,
SUM(total) AS suma_pagos
FROM pago GROUP BY 
YEAR(fecha_pago);


/*Subconsultas Con operadores básicos de comparación */

/*Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

/*Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;

/*Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)*/
SELECT p.nombre
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

/*Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
SELECT nombre
FROM producto
ORDER BY cantidad_en_stock DESC
LIMIT 1;

/*Devuelve el producto que más unidades tiene en stock.*/
SELECT nombre
FROM producto
ORDER BY cantidad_en_stock DESC
LIMIT 1;

/*Devuelve el producto que menos unidades tiene en stock.*/
SELECT nombre
FROM producto
ORDER BY cantidad_en_stock
LIMIT 1;

/*Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/
SELECT e.nombre, e.apellido1, e.apellido2, e.email
FROM empleado e
JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE j.nombre = 'Alberto' AND j.apellido1 = 'Soria';


/*Subconsultas con ALL y ANY*/

/*Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

/*Devuelve el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;

/*Devuelve el producto que menos unidades tiene en stock.*/
SELECT nombre
FROM producto
ORDER BY cantidad_en_stock
LIMIT 1;


/* Subconsultas con IN y NOT IN*/

/*Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.*/
SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.*/
SELECT DISTINCT nombre_cliente
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente;

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.*/
SELECT DISTINCT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
WHERE pr.gama <> 'Frutales' OR pr.gama IS NULL;

/*Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.*/
SELECT DISTINCT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pa.codigo_cliente IS NULL AND p.codigo_pedido IS NOT NULL;

/*Subconsultas con EXISTS y NOT EXISTS*/

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

/*Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.*/
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

/*Devuelve un listado de los productos que han aparecido en un pedido alguna vez.*/
SELECT DISTINCT nombre
FROM producto
WHERE codigo_producto IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

/*Consultas variadas*/

/*Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS num_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente;

/*Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.*/
SELECT c.nombre_cliente, COALESCE(SUM(pa.total), 0) AS total_pagado
FROM cliente c
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
GROUP BY c.nombre_cliente;

/*Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.*/
SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente;

/*Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.telefono
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE pa.codigo_cliente IS NULL;

/*Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.*/
SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.*/
SELECT o.ciudad, COUNT(e.codigo_empleado) AS num_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;