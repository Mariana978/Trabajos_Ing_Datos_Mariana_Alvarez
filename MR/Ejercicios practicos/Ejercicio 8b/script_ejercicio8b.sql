create database aseguradora;


/*HABILITAR BASE DE DATOS*/
use aseguradora;


/*Crear tabla*/
create table Compania(
idCompania int PRIMARY KEY,
nombreCompania VARCHAR(50) NOT NULL,
fechaFundacion date NULL,
repreLegal varchar(50) NULL 
);

create table Accidente(
idAccidente int PRIMARY KEY,
fechaAccidente date not NULL,
lugarAccidente varchar(50) NOT NULL,
tipoHeridos varchar(50) not null,
numeroMuertos int not null
);


create table Seguro(
idSeguro int PRIMARY KEY,
idCompaniaFK int not null,
estadoSeguro varchar(10) not null,
fechaInicio date not null,
costoSeguro double not null,
fechaExpiracion date not null,
valorAsegurado double not null,
foreign key (idCompaniaFK) references Compania(idCompania) on delete cascade on update cascade
);

create table DescripcionAccidente(
idDescAccidente varchar(50) PRIMARY KEY,
idAccidenteFK int not NULL,
cantidadVehiculos int NOT NULL,
responsabilidad varchar(50) not null,
foreign key (idAccidenteFK) references Accidente(idAccidente) on delete cascade on update cascade
);

create table Automovil(
placa varchar(6) PRIMARY KEY,
serialChasis VARCHAR(50) NULL,
marca VARCHAR(20) NOT NULL,
modelo varchar(20) not null,
tipoAutomovil varchar(50) not null,
anioFabri int not null,
cilindraje int null,
idSeguroFK int not null,
idDescAccidenteFK varchar(50) not null,
foreign key (idSeguroFK) references Seguro(idSeguro) on delete cascade on update cascade,
foreign key (idDescAccidenteFK) references DescripcionAccidente(idDescAccidente) on delete cascade on update cascade
);


/*Consultar la estructura de las tablas*/
describe accidente;
