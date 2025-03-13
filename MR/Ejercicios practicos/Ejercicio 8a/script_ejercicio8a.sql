create database empresaEncomiendas;


/*HABILITAR BASE DE DATOS*/
use empresaEncomiendas;


/*Crear tabla*/
create table Camionero(
idCamionero int AUTO_INCREMENT PRIMARY KEY,
nombreCamionero VARCHAR(20) NOT NULL,
telefonoCamionero VARCHAR(20) NOT NULL,
direccionCamionero varchar(30) NOT NULL 
);


create table Camion(
placa int AUTO_INCREMENT PRIMARY KEY,
modelo VARCHAR(20) NOT NULL,
potencia VARCHAR(20) NOT NULL,
tipoCamion varchar(30) not null not null
);

create table Ciudad(
codigoCiudad varchar(20) PRIMARY KEY,
nombreCiudad VARCHAR(20) NOT NULL
);

create table DetalleConduce(
idDetalle int AUTO_INCREMENT PRIMARY KEY,
placaFK int not null,
idCamioneroFK int not null,
foreign key (placaFK) references Camion(placa) on delete cascade on update cascade,
foreign key (idCamioneroFK) references Camionero(idCamionero) on delete cascade on update cascade

);


create table Paquete(
codigoPaquete varchar(20) PRIMARY KEY,
descripcionPaquete VARCHAR(20) NOT NULL,
destinatarioPaquete VARCHAR(20) NOT NULL,
codigoCiudadFK varchar(20) not null,
idCamioneroFK int not null,
foreign key (codigoCiudadFK) references Ciudad(codigoCiudad) on delete cascade on update cascade,
foreign key (idCamioneroFK) references Camionero(idCamionero) on delete cascade on update cascade

);



/*Consultar la estructura de las tablas*/
describe Clientes;

