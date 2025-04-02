create database votaciones2503816;
use votaciones2503816;


CREATE TABLE Genero(
  idGenero int primary key,
  nomGenero varchar(50) not null,
  estadoG bool not null
);
create table Jornada(
  idJornada int primary key,
  nomJornada varchar(50) not null,
  estadoJ bool not null
);
create table TipoDocumento(
  idTipoDoc int primary key,
  nomTipoDoc varchar(100) not null,
  estadoTD bool not null
);
create table TipoMiembro(
  idTipoMiembro int primary key,
  nomTipoMiembro varchar(50) not null,
  estadoTM bool not null
);
create table Curso(
  idCurso int primary key,
  nomCurso varchar(50) not null,
  estadoCu bool not null
);
create table Concejo(
  idConcejo int primary key,
  nomConcejo varchar(100) not null,
  estadoCO bool not null
);
create table Cargo(
  idCargo int primary key,
  nomCargo varchar(50) not null,
  idConcejoFK int not null,
  estadoC bool not null,
  FOREIGN KEY (idConcejoFK) REFERENCES Concejo(idConcejo) on delete cascade on update cascade
);
create table Eleccion(
  idEleccion int primary key,
  fechaEleccion date not null,
  anioEleccion year not null,
  estadoEl bool not null
);
create table Usuario(
  idUsuario int primary key,
  noDocUsuario int not null,
  idTipoDocFK int not null,
  nombreUsuario varchar(50) not null,
  apellidoUsuario varchar(50) not null,
  idGeneroFK int not null,
  fechaNacUsuario varchar(50) null,
  emailUsuario varchar(50) null,
  passwordUsuario varchar(30) null,
  fotoUsuario blob null,
  idJornadaFK int not null,
  idTipoMiembroFK int not null,
  idCursoFK int not null,
  estadoU bool not null,
  FOREIGN key (idTipoDocFK) references TipoDocumento(idTipoDoc),
  FOREIGN key (idGeneroFK) references Genero(idGenero),
  FOREIGN key (idJornadaFK) references Jornada(idJornada),
  FOREIGN key (idTipoMiembroFK) references TipoMiembro(idTipoMiembro),
  FOREIGN key (idCursoFK) references Curso(idCurso)
);
Create table Postulacion_Candidato(
  idPostCandidato int primary key,
  idUsuarioFK int not null,
  idEleccionFK int not null,
  idCargoFK int not null,
  propuestas varchar(100),
  totalVotos int not null,
  estadoCan bool not null,
  FOREIGN key (idUsuarioFK) REFERENCES Usuario(idUsuario),
  FOREIGN key (idEleccionFK) REFERENCES Eleccion(idEleccion),
  FOREIGN key (idCargoFK) REFERENCES Cargo(idCargo)
);
create table Votacion(
  idVotacion int primary key,
  horaVotacion time not null,
  idUsuarioVotanteFK int not null,
  idPostCandidatoFK int not null,
  estadoV bool not null,
  FOREIGN key (idUsuarioVotanteFK) references Usuario(idUsuario) on delete cascade on update cascade,
  FOREIGN key (idPostCandidatoFK) references Postulacion_Candidato(idPostCandidato) on delete cascade on update cascade
);


insert into Genero values (1,'Femenino',true), (2,'Masculino',true);
Insert into Jornada Values (1,'Mañana',true),(2,'Tarde',true),(3,'Noche',true);
Insert into TipoDocumento values (1,'Tarjeta de Identidad',true),(2,'Cédula Ciudadanía',true),
(3,'Cédula Extranjeria',true),(4,'Pasaporte',true),(5,'NUIP',false);
insert into TipoMiembro values (1,'Estudiante',true), (2,'Profesor',true), (3,'Acudiente',true);
insert into Curso VALUES (1,'901',true), (2,'902',true), (3,'1001',true), (4,'1002',true), (5,'1003',false),
(6,'1101',true), (7,'1102',true), (8,'1103',false);
insert into Concejo values (1,'Concejo Académico',true), (2,'Concejo Directivo',true),(3,'Concejo Convivencia',true);
INSERT into Cargo VALUES (1,'Personero',1,true), (2,'Contralor',1,true), (3,'Cabildante',1,true);
insert into Eleccion values (1,'2020-04-20',2020,true), (2,'2019-04-15',2019,true), (3,'2019-04-12',2019,false), 
(4,'2018-04-14',2018,true), (5,'2017-04-12',2017,true);
desc Postulacion_Candidato;
insert into Usuario values (1,1,1,'Voto','Blanco',2,' ', ' ',' ', ' ' ,1,1,3,true);
insert into Usuario values (2,1010123456,1,'DAVID SANTIAGO','LÓPEZ MORA',2,'11-10-2004','davidLopez456@hotmail.com','David2004', 
' ' ,1,1,1,true), (3,1010123789,1,'LAURA MILENA','GOMEZ BONILLA',1,'17/03/2004','lauragomez@gmail.com','Gomez2004', 
' ' ,1,1,1,true),(4,1010123741,1,'DIEGO FERNANDO','CAÑON VARGAS',2,'20/05/2003','diegocanon@hotmail.com','Diego2003', 
' ' ,1,1,1,true),(5,1010123852,1,'TATIANA','VARGAS CABRERA',1,'28/11/2003','tatacabrera@gmail.com','Cabrera2003', 
' ' ,1,1,3,true),(6,1010123963,1,'LEYDY KATHERINE','FERNANDEZ RODRIGUEZ',1,'28/06/2004','leydy2004@gmail.com','Leydy2004', 
' ' ,1,1,4,true),(7,1010123654,2,'MAURICIO','BERMUDEZ AMAYA',2,'26/01/2002','maobermudez@gmail.com','Amaya2002', 
' ' ,1,1,4,true),(8,1010741258,1,'ANDRES FELIPE','RODRIGUEZ PEREZ',2,'23/03/2004','andyrodriguez@gmail.com','Arodriguez2004', 
' ' ,1,1,3,true),(9,1010236859,1,'MARIA ANGÉLICA','TRIVIÑO LATORRE',1,'04/02/2002','angelicatri@gmail.com','Trivino2002', 
' ' ,1,1,3,true),(10,1010236963,1,'GENARO','VASQUEZ RODRIGUEZ',2,'14/11/2002','gevasquez@gmail.com','Vasquez123', 
' ' ,1,1,3,true);

insert into Postulacion_Candidato values (1,1,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true),
(2,5,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true),
(3,7,1,1,'Mejorar sala de informática, Construir piscina',0,true);
insert into Votacion values (1,'12:08:15',1,1,true), (2,'12:12:35',2,3,true), (3,'12:14:18',3,2,true),
(4,'12:15:58',4,2,true), (5,'12:18:02',5,3,true),(6,'12:24:22',6,3,true), (7,'12:28:02',7,3,true), 
(8,'12:30:14',8,2,true), (9,'12:40:20',9,2,true), (10,'12:45:20',10,2,true);

/*ConsuItas*/
/*1, Realice una consulta que muestre el nombre de cada concejo, que tenga asignado un cargo, con 
el nombre del cargo, al que pertenece y el estado actual del mismo."*/
SELECT nomConcejo, nomCargo, estadoC FROM Concejo JOIN Cargo ON Concejo.idConcejo = Cargo.idConcejoFK;

/*2, Realice una consulta que muestre el nombre de cada concejo, el nombre del cargo 
al que pertenece y el estado actual del mismo. Tenga o no cargo asignado.*/
SELECT nomConcejo, nomCargo,estadoC FROM Concejo LEFT JOIN Cargo ON Concejo.idConcejo = Cargo.idConcejoFK;

/*3, Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso */
SELECT nombreUsuario,nomJornada, nomTipoMiembro, nomCurso FROM Usuario JOIN Jornada 
ON Usuario.idJornadaFK = Jornada.idJornada JOIN TipoMiembro ON Usuario.idTipoMiembroFK = TipoMiembro.idTipoMiembro
JOIN Curso ON Usuario.idCursoFK = Curso.idCurso;

/*4, Agregue el campo a la tabla estudiante llamada profesión. */
ALTER TABLE Usuario ADD COLUMN profesion VARCHAR(100) NULL;

/* 0TRA 0PCI0N, C0N N0T NUII
ALTER TABLE Usuario ADD COLUMN profesion VARCHAR(100) N0T NULL;
UPDATE Usuario SET profesion = 'Estudiante' WHERE idTipoMiembroFK = 1;
UPDATE Usuario SET profesion = 'Profesor' WHERE idTipoMiembroFK = 2;
UPDATE Usuario SET profesion = 'Acudiente' WHERE idTipoMiembroFK = 3;
*/

/*5, Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas.*/
	SELECT nombreUsuario, apellidoUsuario, COUNT(Votacion.idVotacion) AS 'Total_Votos' FROM Postulacion_Candidato
	JOIN Usuario ON Postulacion_Candidato.idUsuarioFK = Usuario.idUsuario LEFT JOIN Votacion ON Postulacion_Candidato.idPostCandidato = Votacion.idPostCandidatoFK
	GROUP BY Usuario.idUsuario, Usuario.nombreUsuario, Usuario.apellidoUsuario
	ORDER BY Total_Votos DESC;

/*Implemente tres procedimientos almacenados, tres vistas y dos subconsultas */
/*PR0CEDIMIENT0S*/
	/*1, REGISTRAR NUEVA EIECCI0N*/
	DELIMITER //
CREATE PROCEDURE RegistrarEleccion(in p_idEleccion int, p_fechaEleccion DATE,IN p_anioEleccion YEAR)
BEGIN
    INSERT INTO Eleccion (idEleccion, fechaEleccion, anioEleccion, estadoEl)
    VALUES (p_idEleccion, p_fechaEleccion, p_anioEleccion, TRUE);
END //
DELIMITER ;
drop procedure RegistrarEleccion;
CALL RegistrarEleccion('10','2025-04-10', 2025);

	/*2, ACTUAIIZAR J0RNADA DE UN USUARI0*/
		DELIMITER //
CREATE PROCEDURE ActualizarJornadaUsuario(IN p_idUsuario INT,IN p_nuevaJornada INT)
BEGIN
	UPDATE Usuario 
    SET idJornadaFK = p_nuevaJornada
    WHERE idUsuario = p_idUsuario;
END //
DELIMITER ;
CALL ActualizarJornadaUsuario(5, 2);
DESC Jornada;
select*from Usuario;

	/*3, EIMINAR USUARI0 P0R SU ID*/
DELIMITER //
CREATE PROCEDURE EliminarUsuario(IN NidUsuario INT)
BEGIN
    DELETE FROM Usuario WHERE idUsuario = NidUsuario;
END //
DELIMITER ;
call EliminarUsuario(2);
select*from Usuario;

/*VISTAS*/
	/*Vista de Usuari0s c0n su tip0 de d0cument0*/
CREATE VIEW VistaDocumento As SELECT idUsuario, nombreUsuario, apellidoUsuario, 
    nomTipoDoc AS 'Tipo_Documento' FROM Usuario
JOIN TipoDocumento ON Usuario.idTipoDocFK = TipoDocumento.idTipoDoc;
select*from VistaDocumento;

	/*V0t0s p0r Carg0*/
CREATE VIEW Vista_Cargo As SELECT nomCargo AS Cargo, 
    COUNT(Votacion.idVotacion) AS 'Total_Votos' FROM Postulacion_Candidato
JOIN Cargo ON Postulacion_Candidato.idCargoFK = Cargo.idCargo
LEFT JOIN Votacion ON Postulacion_Candidato.idPostCandidato = Votacion.idPostCandidatoFK
GROUP BY Cargo.nomCargo;
select*from Vista_Cargo;

	/*EIeccines Activas*/
CREATE VIEW Elecciones_Activas AS SELECT idEleccion, fechaEleccion, anioEleccion 
FROM Eleccion WHERE estadoEl = TRUE;
SELECT * FROM Elecciones_Activas;

/*SUBC0NSUITAS*/
	/*Usuarios que NO se han Postulado a Ningún Cargo*/
SELECT nombreUsuario, apellidoUsuario FROM Usuario
WHERE Usuario.idUsuario NOT IN (
    SELECT Postulacion_Candidato.idUsuarioFK FROM Postulacion_Candidato
);

/*Mostrar los Usuarios con su Tipo de Miembro y Jornada*/
SELECT nombreUsuario, apellidoUsuario, 
       (SELECT nomTipoMiembro FROM TipoMiembro WHERE TipoMiembro.idTipoMiembro = Usuario.idTipoMiembroFK )as 'Tip0',
       (SELECT nomJornada FROM Jornada WHERE Jornada .idJornada = Usuario.idJornadaFK) AS 'Jornada'
FROM Usuario;

