/*Sentencias de DDL*/
/*Creacion de base de datos*/
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

insert into mascota values (1, 'perro', 'hembra', 'pitbull',2);
insert into mascota values (2, 'bassed', 'hembra', 'bassed',2);

insert into cliente values (1, 'mariana', 'alvarez', 'avenida 68',2342, 2);
insert into cliente values (2, 'tatiana', 'carvajal', 'carrera 5',34923,1);

insert into producto values (1, 'vacuna', 'perro', 7686, 1 );
insert into producto values (2, 'correa', 'perro', 7686, 2);

insert into vacuna values (1, 'rabia', 1, 'rabia'), (2, 'malaria', 10, 'malaria');
insert into vacuna values (3, 'varicela', 2, 'varicela'), (4, 'fiebre amarilla', 5, 'fiebre amarilla'),(5, 'viruela', 6, 'viruela');

insert into mascota_vacuna values (1, 1, 'rabia');
insert into producto values (2, 2, 'viruela');

select m.*, c.nombreCliente, p.nombreProducto from mascota m join cliente c on m.idMascota=c.idMascotaFK join producto 
p on p.cedulaClienteFK=c.cedulaCliente;

/*Eliminación*/
delete from producto where codigoProducto=1;
describe producto;
select*from producto;

/*Procedimientos almacenaos: Stored Procedure - Conjunto de instrudcciones de SQL que se almacenan en la base de datos
y estos se pueden ejecutar muchas veces

SINTAXIS DEL PROCEDIMIENTO:

DELIMITER //
Create procedure InsertarMascota(parametros entrada in salida out)
begin
---instrucciones de SQL
END
// DEMILITER

*/

/*Creación de Procedimiento almacenado*/
DELIMITER //
Create procedure InsertarMascota(in idMascota int, nombreMascota varchar(15), generoMascota varchar(15), razaMascota varchar(15),cantidad int)
begin
-- instrucciones de SQL
	insert into mascota values (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);
END // 
DELIMITER ;

select*from mascota;

-- Ejecutar el procedimiento
-- Sintaxis es call nombreProcedimiento (valores)
call InsertarMascota ('3', 'Firulais', 'Macho', 'pitbull', 3);

select*from producto;
DELIMITER //
Create procedure ConsultarPrecio(out total float)
begin
-- instrucciones de SQL
	select count(*)into precio from producto;
END // 
DELIMITER ;

call ConsultarPrecio (@resultado);
select @resultado;

/*Crear un procedimiento para insertar registros en tabla débil*/
DELIMITER //
Create procedure InsertarMascotaVacuna(in codigoVacunaFK int, idMascota int, enfermedad varchar(15))
begin
-- instrucciones de SQL
	insert into mascota_vacuna values (codigoVacunaFK, idMascota, enfermedad);
END // 
DELIMITER ;
call InsertarMascotaVacuna (2, 3, 'varicela');
/*Procedimiento consultar las vacunas que se le ha aplicado a una mascota*/
/*Y qué enfermedad está atacando*/

DELIMITER //
Create procedure ConsultarVacunas(out nombreMascota varchar(15), nombreVacuna varchar(15), enfermedad varchar(15))
begin
-- instrucciones de SQL
	select nombreMascota, nombreVacuna, enfermedad
	from mascota inner join mascota_vacuna on mascota_vacuna.idMascotaFK = mascota.idMascota inner join 
vacuna on vacuna.codigoVacuna = mascota_vacuna.codigoVacunaFK;
END // 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ConsultarVacunas2(IN mascotaNombre VARCHAR(15))
BEGIN
    SELECT M.nombreMascota, V.nombreVacuna, V.enfermedad
    FROM Mascota M
    INNER JOIN Mascota_Vacuna MV ON MV.idMascotaFK = M.idMascota
    INNER JOIN Vacuna V ON V.codigoVacuna = MV.codigoVacunaFK
    WHERE M.nombreMascota = mascotaNombre;
END //
DELIMITER ;

CALL ConsultarVacunas2('Firulais');
select*from cliente;

/*Vistas - Views: Es una consulta que genera una tabla virtual pero que no queda almacenada dentro de la base de datos

SINTAXIS:
create view nombreVista as 
select valoresaConsultar from nombreTabla where condiciones
*/
create view vistaCliente as select*from cliente where telefono=2342;
select*from vistaCliente;

/*Crear una vista que contenga el 4,6 y 7*/
create view vistaTel as select*from cliente where telefono='%4%' or telefono ='%6%' or telefono ='%7%';
select*from vistaTel;
alter view vistaTel as select*from cliente where telefono like '%4%' and telefono like '%6%' and telefono like '%7%';
select*from cliente;

/**Modificar una vista
alter view nombreVista as
select valoresaConsultar from nombreTabla where condiciones

Eliminar una vista:
drop view nombreVista**/

/*DISPARADORES - TRIGGERS - DESENCADENADORES
tipos:

BEFORE
1. before insert
2. before update
3. before delete

AFTER
1. after insert
2. after update
3. after delete

Sintaxis:
DELIMITER //
create trigger nombreTrigger
after insert on nombreTabla for each row begin
-- Instrucciones que quiero que se ejecuten
*/

/*Registrar en consolidado cada vez que inserte una mascota*/
create table consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);


DELIMITER //
create trigger registrarConsilidadoMascotas 
after insert on mascota
for each row begin
	insert into consolidado values (new.idMascota,new.nombreMascota, new.generoMascota, new.razaMascota, 
    new.cantidad);
-- Instrucciones que quiero que se ejecuten
end //
DELIMITER ;

insert into Mascota values (4 , 'nebuña', 'F', 'criollo', 2);
insert into Mascota values (10 , 'jesus', 'm', 'criollo', 2);
select*from consolidado;

create table eliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);

DELIMITER //
create trigger eliminarCliente 
BEFORE delete on cliente
for each row begin
	insert into eliminados values (old.cedulaCliente,old.nombreCliente, old.apellidoCliente, old.direccionCliente, 
    old.telefono, old.idMascotaFK);
-- Instrucciones que quiero que se ejecuten
end //
DELIMITER ;

insert into Cliente values (4,'Luna','Pino','Calle 33', 305799, 1);
delete from cliente where cedulaCliente = 4;
select * from eliminados;



