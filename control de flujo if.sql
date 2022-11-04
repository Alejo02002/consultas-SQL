drop database if exists libro;
create database libro;
use libro;

 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(30),
  precio decimal(5,2) unsigned,
  primary key (codigo)
 );
 
-- Ingresamos algunos registros:
 insert into libros (titulo, autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',50.5);
 insert into libros (titulo, autor,editorial,precio)
  values('Alicia a traves del espejo','Lewis Carroll','Emece',25);
 insert into libros (titulo, autor,editorial,precio) 
  values('El aleph','Borges','Paidos',15);
 insert into libros (titulo, autor,editorial,precio)
  values('Matemática estas ahi','Paenza','Paidos',10);
 insert into libros (titulo, autor,editorial)
  values('Antologia','Borges','Paidos');
 insert into libros (titulo, editorial)
  values('El gato con botas','Paidos');
 insert into libros (titulo, autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Emece',90);
  
-- Queremos traer solo los precios de libros mayor y menor a 50 alter
select * from libros where precio > 50;

select * from libros where precio < 50;

-- Si el precio de los libros es mayor a 50 entonces es caro, sino es barato
select titulo, precio, if (precio>50,"Es Caro","Es Barato") from libros;
