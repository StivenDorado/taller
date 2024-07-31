drop database biblioteca;
create database biblioteca4 character set utf8mb4;
use biblioteca4;

create table autor(
idAutor int auto_increment primary key,
nombres varchar(50) not null,
apellidos varchar(50) not null,
nacionalidad varchar(30) not null
);

describe autor;

create table editorial(
idEditorial int auto_increment primary key,
nombre varchar(50) not null
);

describe editorial;

create table libro(
idLibro int auto_increment primary key,
titulo varchar(100) not null,
categoria varchar(50) not null,
fechaPublicacion date not null,
idioma varchar(30),
idAutor int not null,
idEditorial int not null,
foreign key (idAutor) references autor (idAutor),
foreign key (idEditorial) references editorial (idEditorial)
);

1
insert into editorial
values
(null, "Norma"),
(null, "Aguilar"),
(null, "Alfaguairaonsu");
2
select * from editorial;



3
INSERT INTO Autor (nombres, apellidos, nacionalidad) VALUES
('Gabriel', 'García Márquez', 'Colombiano'),
('Laura', 'Restrepo', 'Colombiano');
4
INSERT INTO Autor (nombres, apellidos, nacionalidad) VALUES
('Mario', 'Vargas Llosa', 'Peruano'),
('Julio', 'Ramón Ribeyro', 'Peruano');
5
INSERT INTO Autor (nombres, apellidos, nacionalidad) VALUES
('Carlos', 'Fuentes', 'Mexicano');
6
SELECT * FROM Autor;


7
insert into libro
values
(null, "Satanás", "Novela", "2002-02-22", "Español", 1, 1),
(null, "100 Años de Soledad", "Novela", "1967-06-05", "Español", 2, 2),
(null, "Las Desventuras de Don Toliver", "Comedia", "1999-10-25", "Español", 3, 3),
(null, "Klanxpa manchakuna", "Terror", "1982-07-20", "Quechua", 4, 3),
(null, "Song of Heart", "Romance", "2012-09-13", "Inglés", 5, 2);


8
select libro.titulo, libro.categoria, libro.fechaPublicacion, libro.idioma, 
autor.nombres, autor.apellidos
from libro
inner join autor on libro.idAutor = autor.idAutor;



9 
update editorial set nombre = "Alfaguara"
where idEditorial = "3";
10 
select * from editorial where nombre = "Alfaguara";

11
update autor set nombres = "Vicente"
where idAutor = "5";
update autor set apellidos = "Fernández"
where idAutor = "5";
12
select * from autor 
where nacionalidad = 'mexicano';
13
select libro.titulo, libro.categoria, libro.fechaPublicacion, libro.idioma, 
autor.nombres, autor.apellidos
from libro
inner join autor on libro.idAutor = autor.idAutor
where autor.nacionalidad = 'mexicano';


14
delete from libro where idAutor = 2;

15
select * from libro;


16
update libro set idioma = "mandarín"
where idAutor = "5";

17
DELETE FROM libro WHERE idioma = 'mandarín';


18
select * from libro;











































