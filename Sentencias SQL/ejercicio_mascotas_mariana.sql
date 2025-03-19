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

describe mascota;
/*Inserción: creacion de registros - crear filas en tablas*/
insert into mascota (idMascota,nombreMascota, generoMascota, razaMascota, cantidad)
values (1, 'Rush', 'Macho', 'criollo', 1);

insert into mascota values (2, 'alma', 'hembra', 'criolla', 1);

/*CONSULTAR; unicamente permite ver
Select * from "tabla"
*/

select * from mascota;

/*insercion multiple*/

insert into mascota values (3, 'tom', 'M', 'criollo', 1), (4, 'kyara', 'H', 'criollo', 1);
insert into mascota values (5, 'tobias', 'H', 'criollo', 1),(6, 'drako', 'H', 'Criollo', 1);
/*Consulta*/
select * from mascota;

/*INSERCIONES VACUNA*/
describe vacuna;
insert into vacuna values (1, 'rabia', 1, 'rabia'), (2, 'malaria', 10, 'malaria');
insert into vacuna values (3, 'varicela', 2, 'varicela'), (4, 'fiebre amarilla', 5, 'fiebre amarilla'),(5, 'viruela', 6, 'viruela');
select * from vacuna;


describe producto;
describe cliente;

/*INSERCIONES CLIENTE*/
insert into cliente values (5436, 'mariana', 'alvarez', 'NQS', '7647', 1);
insert into cliente values (3325, 'gabriel', 'jeronimo', 'Calle', '4563', 2),(3749, 'tatiana', 'carvajal', 'avenida 68', '2839', 4),
(8384, 'felipe', 'cardona', 'carrera 37', '2749', 2) ;
insert into cliente values (8347, 'daniel', 'herrera', 'calle 19 sur', '7372', 3);
select * from cliente;
