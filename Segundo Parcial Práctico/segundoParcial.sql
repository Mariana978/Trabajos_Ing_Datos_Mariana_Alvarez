/*Parcial Práctico 2 Mariana Álvarez Carvajal*/

/*1. Crear la base de datos de DataVerse para almacenar datos de sensores IoT, transporte, 
consumo energético y seguridad, el nombre es BDDataVerse */
CREATE DATABASE BDDataVerse;
USE BDDataVerse;

/*2. Crea las siguientes tablas y sus respectivas relaciones según el modelamiento:
timestamp es una restricción para la fecha actual*/
-- Tabla de sensores IoT
CREATE TABLE Sensores (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) null,  
    ubicacion VARCHAR(100) not null,
    fechaInstalacion date not null
);
-- Tabla de registro de sensores IoT
CREATE TABLE RegistroSensores (
    idRegistro INT AUTO_INCREMENT PRIMARY KEY,
    idSensorFK INT not null,
    valor double not null,
    fechaRegistro timestamp not null,
    FOREIGN KEY (idSensorFK) REFERENCES Sensores(idSensor) on delete cascade on update cascade    
);
-- Tabla de transporte
CREATE TABLE Transporte (
    idTransporte INT AUTO_INCREMENT PRIMARY KEY,
    tipoTrans enum('aéreo', 'terrestre','acuático') not null,
    capacidad VARCHAR(50)  not null
);
-- Tabla de Usuarios
create table Usuarios(
  idUsuario int AUTO_INCREMENT primary key,
  nombreUsuario varchar(50) not null,
  emailUsuario varchar(50) null,
  idTransporteFK int not null,
  idSensorFK int not null,
  idEventoFK int not null,
  FOREIGN key (idTransporteFK) references Transporte(idTransporte) on delete cascade on update cascade,
FOREIGN key (idSensorFK) references Sensores(idSensor) on delete cascade on update cascade,
  FOREIGN key (idEventoFK) references Seguridad(idEvento) on delete cascade on update cascade  
);

-- Consumo energético
CREATE TABLE ConsumoEnergetico (
    idConsumo INT AUTO_INCREMENT PRIMARY KEY,
    idRegistroFK INT NOT NULL, 
    consumoKW bool not null,
    fechaConsumo DATE not null,
    zona VARCHAR(20) not null,
    FOREIGN key (idRegistroFK) references RegistroSensores(idRegistro) on delete cascade on update cascade 
);
-- Seguridad
CREATE TABLE Seguridad (
    idEvento INT AUTO_INCREMENT PRIMARY KEY,
    tipoEvento VARCHAR(100) not null,  
    descripcion TEXT not null,
    ubicacion VARCHAR(20) not null,
    fechaHora DATETIME not null
);

/*Modifique la tabla Usuario y cree un campo teléfono.*/
ALTER TABLE Usuarios ADD telefono varchar(20);


/*Inserta al menos 5 registros en cada tabla*/
select*from sensores;
INSERT INTO Sensores VALUES(' ','temperatura', 'Plaza Cívica', '2025-04-05');
INSERT INTO Sensores VALUES(' ','ruido', 'Zona Escolar Norte', '2022-04-05'), (' ','humedad', 'Plaza Principal', '2023-04-05'), (' ','calidad de aire', 'Avenida Marítima', '2024-04-05'),
(' ','agua', 'Avenida nqs', '2020-04-05');

select*from RegistroSensores;
insert into RegistroSensores values (' ',1,5645,' ');
insert into RegistroSensores values (' ',2,8653,' '), (' ',3,674687,' '), (' ',4,79854,' '), (' ',5,9775,' ');


select*from Transporte;
insert into Transporte values (' ',2,'87987'), (' ',1,'86456'), (' ',3,'8786'), (' ',2,'87987'), (' ',3,'87895');

select*from ConsumoEnergetico;
insert into ConsumoEnergetico values (' ',2,98576, '2022-04-05', 'avenida' ), (' ',1,54645, '2020-04-05', 'nqs' ), (' ',3,69456, '2021-04-05', 'calle' ), (' ',4,7845, '2027-04-05', 'varrera' ), 
(' ',5,789324, '2020-04-05', 'barrio' );


select*from Seguridad;
insert into Seguridad values (' ','robo','hjashdhf', 'avenida', '2022-04-05' );
insert into Seguridad values (' ','accidente','assdtrr', 'carrera', '2025-04-05'), (' ','homicidio','wrgasd', 'nqs', '2021-04-05' ), (' ','robo','asres', 'carrera', '2021-04-05' ),
(' ','acsesinato','asdfs', 'carrera', '2019-04-05' );


select*from Usuarios;
insert into Usuarios values (' ', 'Mariana', 'jasjjas', 1, 2, 3), (' ', 'Carla', 'asre', 5, 3, 2), (' ', 'Mario', 'jashhdrhas', 4, 5, 1), (' ', 'Santia', 'adtrasf', 4, 2, 5), (' ', 'Sergii', 'sadfds', 2, 4, 5);

desc RegistroSensores;
/*Crea un procedimiento Insertar_Registro_Sensor que reciba como parámetros el ID del sensor,
valor y timestamp, y lo inserte en la tabla Registros_Sensores.
*/

DELIMITER //
Create procedure Insertar_Registro_Sensor(in idSensor int, in valor double, in fechaRegistro timestamp)
begin
-- instrucciones de SQL
insert into RegistroSensores values (idSensor, valor, ' ');
END // 
DELIMITER ;
call Insertar_Registro_Sensor (' ', 78987, ' ');
