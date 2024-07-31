create database inmobiliaria6;
use inmobiliaria6;

create table propietarios(
id_propietario int unsigned auto_increment primary key,
nombre_completo varchar (100) not null,
direccion varchar (50) unique,
telefono varchar (30) unique
);

create table arrendatarios (
id_arrendatario int unsigned auto_increment primary key,
nombre_completo varchar(100) not null,
correo varchar (100) unique ,
telefono varchar (30)unique
);

create table casas (
id_casa int unsigned auto_increment primary key,
direccion varchar (50) unique,
estrato varchar (10) not null,
numero_de_habitaciones varchar (200) not null,
numero_de_baños varchar (100) not null,
area varchar (100) not null,
valor_arriendo decimal (10,2) not null,
id_propietario int unsigned,
foreign key (id_propietario) references propietarios(id_propietario)
);

create table arriendos (
id_arriendo int unsigned auto_increment primary key,
id_casa int unsigned,
id_arrendatario int unsigned,
fecha_inicial_de_arriendo date
);


insert into propietarios
values (null,"joshua orozco tobar","calle 10 no.9-78 centro","314 879 4785");

insert into propietarios
values (null,"Luigi Esteban Daza","carrera 56A no.51-81","321 890 4775");

insert into propietarios
values (null,"roger daniel escobar", "carrera 8 no.20-59","312 789 9475");

select*from propietarios;


insert into casas
values (null,"calle 10 no.9-78 centro","seis","diez","5","120 metros cuadrados", "700.000","1");
insert into casas 
values (null,"carrera 50A no.11-41","cuatro","doce","8","200 metros cuadrados","650.000","2");
insert into casas 
values (null,"carrera 10A no.19-70","cinco","ocho","3","100 metros cuadrados","550.000","3");

select*from casas;

insert into arrendatarios
values (null,"Juan Jose Sanchez","juanjo@gmail.com","321 584 8190");
insert into arrendatarios
values (null,"maria fernanda anaya","mafe@gmail.com","321 481 4570");
insert into arrendatarios
values (null,"henry alejandro castillo","henryc@gmail.com","312 890 7590");

select*from arrendatarios;

insert into arriendos
values (null,1,3,"2024-04-01");

insert into arriendos
values (null,2,1,"2024-02-15");

select*from arriendos;


update propietarios  set nombre_completo="Marcos Cepeda Rico" where id_propietario=1;

select*from propietarios;

update casas set estrato="tres" where id_casa = 1 ;
update casas set estrato="tres" where id_casa = 2 ;
update casas set estrato="tres" where id_casa = 3 ;

select*from casas;


update casas set valor_arriendo="770.000" where id_casa =1;
update casas set valor_arriendo="715.000" where id_casa =2;
update casas set valor_arriendo="605.000" where id_casa =3;

select*from casas;

select direccion,estrato,valor_arriendo 
from casas;

update arriendos set fecha_inicial_de_arriendo="2024-05-15" where id_arriendo= 2; 


select*from arriendos where fecha_inicial_de_arriendo >="2024-05-1";

delete from arriendos where id_arriendo=1;


select*from arriendos