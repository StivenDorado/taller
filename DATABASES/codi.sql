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

/** Consultas sobre una tabla **/
SELECT codigo_oficina, ciudad
FROM oficina;

SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

SELECT e.puesto AS nombre_puesto, e.nombre AS nombre_jefe, e.apellido1, e.apellido2, e.email
FROM empleado e
WHERE e.codigo_empleado = (SELECT codigo_jefe FROM empleado WHERE codigo_jefe IS NULL);

SELECT e.puesto AS nombre_puesto, e.nombre AS nombre_jefe, e.apellido1, e.apellido2, e.email
FROM empleado e
WHERE e.codigo_empleado = (SELECT codigo_empleado FROM empleado WHERE codigo_jefe IS NULL);

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);

SELECT nombre_cliente
FROM cliente
WHERE pais = 'España';

SELECT DISTINCT estado
FROM pedido;

SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_esperada - INTERVAL 2 DAY >= fecha_entrega;

SELECT *
FROM pedido
WHERE estado = 'rechazado' AND YEAR(fecha_pedido) = 2009;

SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;

SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal'
ORDER BY total DESC;

SELECT DISTINCT forma_pago
FROM pago;


SELECT *
FROM cliente
WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);




/**Consultas multitabla (Composición interna)*/

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE p.codigo_cliente IS NULL;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

SELECT DISTINCT linea_direccion1, ciudad, pais
FROM cliente c
JOIN oficina o ON c.ciudad = o.ciudad AND c.pais = o.pais
WHERE c.ciudad = 'Fuenlabrada';

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

SELECT e.nombre AS nombre_empleado, j.nombre AS nombre_jefe
FROM empleado e
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

SELECT e1.nombre AS nombre_empleado, e2.nombre AS nombre_jefe, e3.nombre AS nombre_jefe_de_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

SELECT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

SELECT DISTINCT c.nombre_cliente, gp.gama
FROM cliente c
JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
JOIN detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
JOIN producto p ON dp.codigo_producto = p.codigo_producto
JOIN gama_producto gp ON p.gama = gp.gama;


/*Consultas multitabla (Composición externa)*/
SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL;

SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.codigo_pedido IS NULL;

SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pago.codigo_cliente IS NULL AND pedido.codigo_pedido IS NULL;

SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina IS NULL;

SELECT empleado.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

SELECT empleado.*, oficina.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE oficina.codigo_oficina IS NULL OR cliente.codigo_empleado_rep_ventas IS NULL;

SELECT producto.*
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

SELECT producto.nombre, producto.descripcion, producto.imagen
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

SELECT DISTINCT oficina.*
FROM oficina
LEFT JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
LEFT JOIN gama_producto ON producto.gama = gama_producto.gama
WHERE gama_producto.gama = 'Frutales' AND empleado.codigo_empleado IS NULL;

SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
GROUP BY cliente.codigo_cliente
HAVING COUNT(pedido.codigo_pedido) > 0 AND COUNT(pago.codigo_cliente) = 0;

SELECT e1.*, e2.nombre AS nombre_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN cliente ON e1.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

/*Consultas resumen*/

SELECT COUNT(*) AS total_empleados
FROM empleado;

SELECT pais, COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais;

SELECT AVG(total) AS pago_medio
FROM (
    SELECT YEAR(fecha_pago) AS año, SUM(total) AS total
    FROM pago
    GROUP BY año
) AS pagos_por_año
WHERE año = 2009;

SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado
ORDER BY total_pedidos DESC;

SELECT MAX(precio_venta) AS precio_mas_caro, MIN(precio_venta) AS precio_mas_barato
FROM producto;

SELECT COUNT(*) AS total_clientes
FROM cliente;

SELECT COUNT(*) AS total_clientes_madrid
FROM cliente
WHERE ciudad = 'Madrid';

SELECT ciudad, COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY ciudad;

SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS total_clientes
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.nombre, e.apellido1;

SELECT COUNT(*) AS total_clientes_sin_representante
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, MIN(fecha_pago) AS primer_pago, MAX(fecha_pago) AS ultimo_pago
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente, c.nombre_contacto, c.apellido_contacto;

SELECT codigo_pedido, COUNT(*) AS total_productos_diferentes
FROM detalle_pedido
GROUP BY codigo_pedido;

SELECT codigo_pedido, SUM(cantidad) AS cantidad_total
FROM detalle_pedido
GROUP BY codigo_pedido;

SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.nombre
ORDER BY total_unidades_vendidas DESC
LIMIT 20;

SELECT SUM(base_imponible) AS total_base_imponible, SUM(IVA) AS total_IVA, SUM(base_imponible) + SUM(IVA) AS total_facturado
FROM (
    SELECT SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA
    FROM detalle_pedido dp
    JOIN producto p ON dp.codigo_producto = p.codigo_producto
) AS facturacion;

SELECT dp.codigo_producto, SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA, SUM(precio_venta * cantidad) + SUM(precio_venta * cantidad) * 0.21 AS total_facturado
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY dp.codigo_producto;

SELECT dp.codigo_producto, SUM(precio_venta * cantidad) AS base_imponible, SUM(precio_venta * cantidad) * 0.21 AS IVA, SUM(precio_venta * cantidad) + SUM(precio_venta * cantidad) * 0.21 AS total_facturado
FROM detalle_pedido dp
JOIN producto p ON dp.codigo_producto = p.codigo_producto
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;

SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas, SUM(precio_venta * dp.cantidad) AS total_facturado, SUM(precio_venta * dp.cantidad) * 0.21 AS total_facturado_con_IVA
FROM detalle_pedido dp
JOIN

/*Subconsultas Con operadores básicos de comparación */

SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;

SELECT p.nombre
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY cantidad_en_stock DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY cantidad_en_stock DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY cantidad_en_stock
LIMIT 1;

SELECT e.nombre, e.apellido1, e.apellido2, e.email
FROM empleado e
JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE j.nombre = 'Alberto' AND j.apellido1 = 'Soria';


/*Subconsultas con ALL y ANY*/

SELECT nombre_cliente
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;

SELECT nombre
FROM producto
ORDER BY cantidad_en_stock
LIMIT 1;

/* Subconsultas con IN y NOT IN*/

SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

SELECT DISTINCT nombre_cliente
FROM cliente
INNER JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente;

SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

SELECT DISTINCT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
WHERE pr.gama <> 'Frutales' OR pr.gama IS NULL;

SELECT DISTINCT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pa.codigo_cliente IS NULL AND p.codigo_pedido IS NOT NULL;



/*Subconsultas con EXISTS y NOT EXISTS*/

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);

SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

SELECT DISTINCT nombre
FROM producto
WHERE codigo_producto IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);



/*Consultas variadas*/

SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS num_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente;

SELECT c.nombre_cliente, COALESCE(SUM(pa.total), 0) AS total_pagado
FROM cliente c
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
GROUP BY c.nombre_cliente;

SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.telefono
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE pa.codigo_cliente IS NULL;

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

SELECT o.ciudad, COUNT(e.codigo_empleado) AS num_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;


/**/
/**/
/**/
/**/
/**/
/**/
/**/






SELECT 
    e.nombre, 
    e.apellido1, 
    e.apellido2, 
    e.puesto, 
    o.codigo_oficina, 
    o.ciudad, 
    o.pais, 
    o.region, 
    o.codigo_postal, 
    o.telefono, 
    o.linea_direccion1, 
    o.linea_direccion2
FROM 
    empleado e
JOIN 
    oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE 
    e.codigo_empleado NOT IN (SELECT DISTINCT codigo_empleado_rep_ventas FROM cliente);





SELECT DISTINCT o.linea_direccion1, o.ciudad, o.pais
FROM cliente c
JOIN oficina o ON c.ciudad = o.ciudad AND c.pais = o.pais
WHERE c.ciudad = 'Fuenlabrada';


SELECT p.nombre, p.descripcion, pe.comentarios
FROM producto p 
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
LEFT JOIN pedido pe ON dp.codigo_pedido = pe.codigo_pedido
WHERE dp.codigo_producto IS NULL;

































