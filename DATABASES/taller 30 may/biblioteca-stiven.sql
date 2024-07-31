drop database biblioteca;
create database biblioteca4 character set utf8mb4;
use biblioteca4;

create table Autor (
idAutor int primary key auto_increment,
nombres varchar (100) not null,
apellidos varchar (100) not null,
nacionalidad varchar (100)
);

create table Editorial (
idEditorial int primary key auto_increment,
nombre  varchar(255) not null unique
);

create  table Libro (
idLibro int primary key auto_increment,
titulo varchar (255) not null,
categoria varchar (50) not null,
fechaPublicacion date not null,
idioma varchar (50) not null,
idAutor int not null,
idEditorial int not null,
foreign key (idAutor) references Autor(idAutor),
foreign key (idEditorial) references Editorial(idEditorial)
);


1
SELECT * FROM Editorial;
2
INSERT INTO Autor (nombres, apellidos, nacionalidad)
VALUES
('Gabriel', 'García Márquez', 'Colombiano'),
('Álvaro', 'Mutis', 'Colombiano');

3
INSERT INTO Autor (nombres, apellidos, nacionalidad)
VALUES
('Mario', 'Vargas Llosa', 'Peruano'),
('Julio Ramón', 'Ribeyro', 'Peruano');


4
INSERT INTO Autor (nombres, apellidos, nacionalidad)
VALUES
('Octavio', 'Paz', 'Mexicano');


5
SELECT * FROM Autor;





6

INSERT INTO Editorial (nombre)
VALUES
('Sudamericana'),
('Alfaguara'),
('Seix Barral'),
('Mosca Azul Editores'),
('Fondo de Cultura Económica');

7
SELECT Libro.*, Autor.nombres, Autor.apellidos
FROM Libro
JOIN Autor ON Libro.idAutor = Autor.idAutor;
