/*Base de datos*/
/*Consultas: De acuerdo a los RQF*/
create database EjercicioClase;
use EjercicioClase;

create table cliente(
	codigo int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(20) not null,
	domicilio varchar (50) not null,
    ciudad varchar(20) not null,
    provincia varchar(20) not null,
    telefono varchar(50) not null
);

insert into cliente values (' ', 'mariana', 'calle 57', 'bogotá', 'usme', '3053497498'),
(' ', 'lina', 'calle 40 sur', 'bogotá', 'rafael uribe uribe', '310283829'),
(' ', 'daniel', 'carrera 68', 'bogotá', 'fontibon', '3256971928'),
(' ', 'sergio', 'avenida NQS', 'bogotá', 'Kennedy', '316253846'),
(' ', 'tatiana', 'carrera 56', 'bogotá', 'tunjuelito', '2364728'),
(' ', 'santiago', 'avenida 34', 'bogotá', 'tunjuelito', '33789239'),
(' ', 'felipe', 'carrera 32', 'bogotá', 'chapinero', '23748293'),
(' ', 'cata', 'carrera 59 norte', 'bogotá', 'bosa', '3848394'),
(' ', 'laura', 'avenida 75', 'bogotá', 'puente aranda', '34628384'),
(' ', 'camargo', 'avenida 32', 'bogotá', 'quiroga', '31362847');
insert into cliente values (' ', 'tatiana', 'avenida 32', 'bogotá', 'quiroga', '31362847');

/*Consulta general Select*/
select * from cliente; /*El asterisco indica que voy a traer todos los campos*/

/*Consultas específicas*/
select nombre from cliente;

/*Clausula where: permite generar operadores lógicos (OR, AND, NOT), aritméticos (suma,resta, division,
multiplicacion y módulo) y de comparación (==  =  <>  <=  >=*/
select * from cliente where nombre ='tatiana';
select nombre from cliente where nombre ='tatiana';
select domicilio from cliente where nombre ='tatiana' and codigo=2;/*No muestra nada porque tienen que cumplirse los dos requisitos*/
select * from cliente where nombre ='tatiana' or codigo=2;
select * from cliente where nombre <> 'mariana'; /*<> significa diferente*/
select*from cliente where codigo<=3;
select*from cliente where not nombre = 'tatiana';

/*Alias: Hay nombres de campos que son muy largos, estos alias permiten cambiar los nombres dentro de las consultas,
pero el nomhre se mantiene en la tabla. PUEDEN IR EN MAYÚSCULA Y SEPARADO*/
select nombre as 'nombreCliente', domicilio as 'Dirección', ciudad,provincia as 'Localidad', telefono from cliente;
describe cliente;/*Aquí se ven los nombres originales de los campos*/

/*ordenar*/
select*from cliente order by telefono asc;/*ordenar el telefono de forma ascendente*/
select*from cliente order by codigo desc;/*ordenar el telefono de forma ascendente*/

select nombre as 'nombre cliente', domicilio, ciudad, telefono from cliente 
where nombre = 'tatiana' order by telefono asc; /*Muestra los datos que tiene tatiana y luego organiza los numeros de forma ascendente*/

/*Consultas agrupando*/
select nombre as 'nombre cliente', domicilio, ciudad, telefono from cliente 
where nombre = 'tatiana' group by telefono asc; 

/*like not like, permiten verificar si se contiene o no contiene los caracteres que estoy buscando*/
select*from cliente where domicilio like '%5%';/*que tenga el 5*/
select*from cliente where nombre like 'm%';/*Nombres que empiezan en m*/
select*from cliente where nombre like '%a';/*Nombres que terminan en a*/
