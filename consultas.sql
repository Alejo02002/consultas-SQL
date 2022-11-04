drop database if exists libro;
create database libro;
use libro;

create table libros(
  id int auto_increment primary key,
  titulo varchar(150),
  autor varchar(30),
  editorial varchar(15),
  precio float,
  cantidad int
);

insert into libros (titulo,autor,editorial,precio,cantidad)
  values('El aleph','Borges','Planeta',15,100);
  insert into libros (titulo,autor,editorial,precio,cantidad)
  values('El aleph','Paenza','Planeta',15,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Antologia poetica','J.L. Borges','Planeta',40,150);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Aprenda PHP','Mario Molina','Emece',18.20,200);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',36.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Manual de PHP', 'J.C. Paez', 'Paidos',30.80,120);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Paidos',45.00,50);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Harry Potter y la camara secreta','J.K. Rowling','Paidos',46.00,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',null,200);
  
/* 
-- ------------- operadores relacionales
*/

select titulo, autor,editorial,precio from libros;

-- distinto= <> != 
select titulo, autor,editorial,precio from libros where autor != 'Borges' and autor != 'J.L. Borges';

-- mayor > o menor <
select titulo, autor,editorial,precio from libros where precio>20;

-- menor o igual <= mayor o igual >=
select titulo,autor,editorial,precio from libros where precio<=30;

/* 
-- ------------- order by
*/

-- desc: decendiente y asc: asendiente
select titulo,autor,editorial,precio from libros order by precio;


/* 
-- ------------- count
*/

select count(*) from libros;

select count(*) from libros where editorial='Planeta';

select titulo,autor,editorial,precio from libros where autor like '%Borges%';

select count(precio) from libros;

/* 
----------- like, not like 
*/
-- Like filtra la palabra y te trae un registro
select titulo,autor,editorial,precio from libros where autor like '%A%';
select titulo,autor,editorial,precio from libros where autor not like '%J%';

/* 
-- ------------- sum - min - max - avg
*/

select sum(cantidad) from libros where autor like '%borges';

select min(precio) from libros;

-- round() redondea un decimal a un numero entero
select round(avg(precio)) from libros where autor like '%borges%';

/* 
-- ------------- between, and, or, xor, in
*/

-- El precio del libro sea mayor o igual a 20 y menor o igual a 40
select * from libros where precio >= 20 and precio <= 40;
-- El precio del libro este entre 20 y 40
select * from libros where precio between 20 and 40;

select * from libros where autor = 'Borges' or autor='Paenza';
select * from libros where autor in('borges','paenza');

-- quiero todos los libros menos de tal autor.
select * from libros where autor != 'Borges' and autor != 'Paenza';
select * from libros where autor not in('borges','paenza');
select * from libros where autor not like '%Borges%' and autor not like 'Paenza';

/* 
-- --------------- having, group by
*/

-- Queremos averiguar la cantidad de libros agrupados por editorial:
 select editorial, count(*) from libros group by editorial;
  
-- Queremos conocer la cantidad de libros agrupados por editorial pero considerando sólo los que devuelvan un valor mayor a 2, tipeamos:
 select editorial, count(*) from libros group by editorial having count(*)>2;
  
-- Necesitamos el promedio de los precios de los libros agrupados por editorial:
select editorial,round(avg(precio)) as "promedio_precio" from libros group by editorial;

select editorial,autor,round(avg(precio)) 
as "promedio_precio" 
from libros 
group by editorial 
having autor 
like "%borge%";

select titulo,autor,round(avg(precio)) as "precio_mayor" from libros having max(precio);

-- Consultas anidadas
select titulo, precio from libros where precio = (
	select max(precio) from libros
);

-- Ahora, sólo queremos aquellos cuyo promedio supere los 25 pesos:
 select editorial, round(avg(precio)) from libros group by editorial having avg(precio)>25;
 

-- Queremos contar los registros agrupados por editorial sin tener en cuenta a la editorial "Planeta". Tipeamos y analicemos las siguientes sentencias:
 select editorial, count(*) from libros
  where editorial<>'Planeta'
  group by editorial;
  
select editorial, count(*) from libros
group by editorial
having editorial != 'Planeta';

/* 
Probamos combinar condiciones "where" y "having". Queremos la cantidad de libros, sin tener en cuenta los que tienen precio nulo, 
agrupados por editorial, rechazando los de editorial "Planeta": 
*/

 select editorial, count(*) from libros
  where precio is not null
  group by editorial
  having editorial != 'Planeta';
  
-- Para obtener el promedio de los precios agrupados por editorial, de aquellas editoriales que tienen más de 2 libros tipeamos:
 select editorial, avg(precio) from libros
  group by editorial
  having count(*) > 2; 
  
/* Para encontrar el mayor valor de los libros agrupados por editorial y luego seleccionar las filas que 
tengan un valor mayor o igual a 30 usamos:*/

 select editorial, max(precio)
  from libros
  group by editorial
  having max(precio)>=30;
  
-- Para esta misma sentencia podemos utilizar un "alias" para hacer referencia a la columna de la expresión:
 select titulo, max(precio) as 'mayor_precio' from libros group by titulo;
 