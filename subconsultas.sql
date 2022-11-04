-- ------------------------------------------------------
-- DDL: Lenguaje de definición de datos
-- ------------------------------------------------------
-- ------------------------------------------------------
drop database if exists libro;
create database libro;
use libro;

create table libros(
  id int auto_increment primary key,
  titulo varchar(255),
  autor varchar(30),
  precio float,
  cantidad int,
  id_editoriales int
);

create table editoriales(
	id int auto_increment primary key, 
    nombre varchar (255)
);

alter table libros 
add foreign key (id_editoriales)
references editoriales (id);
-- ------------------------------------------------------
-- ------------------------------------------------------
-- DML: Lenguaje de manipulación de datos
-- ------------------------------------------------------

delete from editoriales where id = 1;
delete from editoriales where id = 2;
delete from editoriales where id = 3;

INSERT INTO editoriales (id, nombre) VALUES (1, 'Planeta');
INSERT INTO editoriales (id, nombre) VALUES (2, 'Emece');
INSERT INTO editoriales (id, nombre) VALUES (3, 'Paidos');

insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('El aleph','Borges',2000.00,600, 1);
  insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('El aleph','Paenza',600.00,400, 1);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Martin Fierro','Jose Hernandez',1202.20,200, 1);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Antologia poetica','J.L. Borges',800.00,150, 3);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Aprenda PHP','Mario Molina',1800.00,200, 2);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges',580.40,100,2);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Manual de PHP', 'J.C. Paez',450.00,120,2);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Harry Potter y la piedra filosofal','J.K. Rowling',750.00,50,3);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Harry Potter y la camara secreta','J.K. Rowling',850.00,100,3);
insert into libros (titulo,autor,precio,cantidad,id_editoriales)
  values('Alicia en el pais de las maravillas','Lewis Carroll',null,200,3);
-- ------------------------------------------------------
-- ------------------------------------------------------
-- DQL: Lenguaje de consulta de datos
-- ------------------------------------------------------
-- ------------------------------------------------------
/* Consultas relacionales */

-- Ordenar el libro alfabeticamente por titulo
select * from libros order by titulo;

-- Traeme los libros con precio mayores a 500
select * from libros where precio > 500;

-- Traeme los libros con precios entre 400 y 1800
select * from libros where precio > 400 and precio < 1800;
select * from libros where precio between 400 and 1800;

-- Traeme el promedio de precios de todos los libros de "borges"
select round(avg(precio)) from libros where autor like "%borges%";

-- traeme el precio más caro
select max(precio) from libros;

/* Consultas anidadas o subconsultas */
/* 
1) hacemos la subconsulta de funcion: select max(precio) from libros
2) encerramos la subconsulta dentro de la consulta principal/padre


*/
-- traeme el libro con el precio más caro
select titulo, precio from libros where precio = (
	select max(precio) from libros
);

-- Traeme los libros con precios que no sean ni baratos ni caros
select titulo,precio from libros where precio != (select min(precio) from libros) 
and precio != (select max(precio) from libros) order by precio;

-- Traeme el promedio de la editorial planeta
select editoriales.nombre, round(avg(libros.precio)) from editoriales 
join libros on editoriales.id = libros.id_editoriales where editoriales.nombre = "Planeta";

-- Traeme el libro mas caro de la editorial emece 
select editoriales.nombre, max(libros.precio) from libros join editoriales on editoriales.id = libros.id_editoriales
group by editoriales.nombre having editoriales.nombre like "emece";

-- Traeme las editoriales donde haya publicado el autor "rowling"
select nombre from editoriales where id in (select id_editoriales from libros where autor like "%rowling%");

select distinct libros.titulo,editoriales.nombre from editoriales 
join libros on editoriales.id = libros.id_editoriales where autor like "%rowling%";