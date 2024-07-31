DROP DATABASE IF EXISTS inmobiliaria;
CREATE DATABASE inmobiliaria CHARACTER SET utf8mb4;
USE inmobiliaria;

CREATE TABLE Propietarios(
idPropietario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombreCompleto VARCHAR (100) NOT NULL,
direccion VARCHAR (50) UNIQUE,
telefono VARCHAR (30) UNIQUE
);

CREATE TABLE Arrendatarios (
idArrendatario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombreCompleto VARCHAR(100) NOT NULL,
correo VARCHAR (100) UNIQUE,
telefono VARCHAR (30)UNIQUE
);

CREATE TABLE Casas (
idCasa INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
direccion VARCHAR (50) UNIQUE,
estrato VARCHAR (20) NOT NULL,
numeroHabitaciones VARCHAR (200) NOT NULL,
numeroBaños VARCHAR (100) NOT NULL,
area VARCHAR (100) NOT NULL,
valorArriendo DECIMAL (10,2) NOT NULL,
idPropietario INT UNSIGNED,
FOREIGN KEY (idPropietario) REFERENCES Propietarios(idPropietario)
);

CREATE TABLE Arriendos (
idArriendo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
idCasa INT UNSIGNED,
idArrendatario int UNSIGNED,
fechaInicial_de_arriendo DATE
);




1
INSERT INTO Propietarios (nombreCompleto, direccion, telefono)
VALUES
('Juan Pérez', 'Calle 123', '1234567890'),
('Ana Gómez', 'Calle 456', '0987654321'),
('Carlos López', 'Calle 789', '1122334455');

2
SELECT * FROM Propietarios;

3
SELECT * FROM Propietarios;


4
INSERT INTO Casas (direccion, estrato, numeroHabitaciones, numeroBaños, area, valorArriendo, idPropietario)
VALUES
('Calle 123', '1', '3', '2', '120', 1000.00, 1),
('Calle 456', '2', '4', '3', '150', 1500.00, 2),
('Calle 789', '3', '5', '4', '200', 2000.00, 3);

5
SELECT * FROM Casas;

6
INSERT INTO Arrendatarios (nombreCompleto, correo, telefono)
VALUES
('Luis Fernández', 'luis@example.com', '3344556677'),
('María Torres', 'maria@example.com', '4455667788'),
('Pedro Martínez', 'pedro@example.com', '5566778899');

7
SELECT * FROM ArrendatariosSELECT * FROM Arrendatarios;

8
INSERT INTO Arriendos (idCasa, idArrendatario, fechaInicial_de_arriendo)
VALUES (1, 1, '2024-04-01');

9
INSERT INTO Arriendos (idCasa, idArrendatario, fechaInicial_de_arriendo)
VALUES (2, 2, '2024-02-15');


10
SELECT * FROM Arriendos;

11
UPDATE Propietarios
SET nombreCompleto = 'Marcos Cepeda Rico'
WHERE idPropietario = 1;

12
SELECT * FROM Propietarios
WHERE nombreCompleto = 'Marcos Cepeda Rico';

13
UPDATE Casas
SET estrato = '3';

14
SELECT * FROM Casas;

15
UPDATE Casas
SET valorArriendo = valorArriendo * 1.10;

16
SELECT direccion, estrato, valorArriendo
FROM Casas;

17
UPDATE Arriendos
SET fechaInicial_de_arriendo = '2024-05-15'
WHERE fechaInicial_de_arriendo = '2024-02-15';

18
SELECT * FROM Arriendos
WHERE fechaInicial_de_arriendo >= '2024-05-01';

19
DELETE FROM Arriendos
WHERE fechaInicial_de_arriendo = '2024-04-01';

20
SELECT * FROM Arriendos;









































