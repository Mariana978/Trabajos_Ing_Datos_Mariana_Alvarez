CREATE DATAbase BDmental;
use BDmental;
create table Usuarios(
	idUsu int auto_increment primary key,
    nombreUsu varchar(20) not null,
    correoUsu varchar(50) not null,
    contraseñaUsu varchar(50) not null,
    fNacimiento date not null,
    genero varchar (20) not null,
    carreraUsu varchar (20) not null,
    fRegistro date not null
);
create table Sesiones(
	idSesion int auto_increment primary key,
    tituloSesion varchar(20) not null,
    idUsuFK int not null,
    duracion varchar(50) not null,
    dificultadSesion enum('básico','intermedio','avanzado') not null,
    descripcionSesion text not null,
    estadoSesiones bool not null,
    fecha date not null,
    foreign key (idUsuFK) references Usuarios(idUsu) 
    on delete cascade on update cascade
);

create table Bita_animo(
	idBita int auto_increment primary key,
    idUsuFK int not null,
    fecha date not null,
    estadoEm varchar(50) not null,
    notaPersonal text not null,
    recomendaciones text not null,
    foreign key (idUsuFK) references Usuarios(idUsu) 
    on delete cascade on update cascade
);
create table Recordatorios(
	idRecordatorio int auto_increment primary key,
    idUsuFK int not null,
    recordatorio varchar(50) not null,
    fecha datetime not null,
    foreign key (idUsuFK) references Usuarios(idUsu) 
    on delete cascade on update cascade
);
create table Tareas(
	IdTarea int auto_increment primary key,
    idUsuFK int not null,
    fEntrega date not null,
    descripcion text not null,
    prioridad varchar(20) not null,
    estado enum('pendiente','en progreso','completada'),
    foreign key (idUsuFK) references Usuarios(idUsu) 
    on delete cascade on update cascade
);
create table comunidad(
	Idcomunidad int auto_increment primary key,
    tematica varchar(50)
);
create table asociacion(
	IdcomunidadFK int not null,
    idUsuFK int not null,
    foreign key (idUsuFK) references Usuarios(idUsu) 
    on delete cascade on update cascade,
    foreign key (IdcomunidadFK) references comunidad(Idcomunidad) 
    on delete cascade on update cascade
);
select*from bita_animo;
desc tareas;
insert into usuarios values (' ', 'Mariana', 'mariana@outlook', '1234', '2008-03-08','femenino','MACC', '2025-03-09'), 
(' ', 'lina', 'lina@outlook', '7927', '2009-06-07','femenino','Artes', '2020-07-04'), (' ', 'Tata', 'tata@outlook', '79247', '2000-09-08','femenino','ISE', '2016-09-09');
insert into sesiones values (' ', 'Dia 1', 1,'2 horas' ,1,'Sesion dia 1',0,'2025-03-09'), 
(' ', 'Dia 2', 2, '2 horas',2,'Sesion Dia 2',0, '2022-07-04'), (' ', 'Dia 3', 3, '2 horas',3,'Sesion Dia 3',1,'2020-09-09');
insert into bita_animo values (' ', 1, '2020-06-03', 'triste','no me siento bien' ,'reposo diario'),(' ', 1, '2020-07-03', 'feliz','me siento bien' ,'cosas que me gustan');
insert into tareas values (' ',1,'2022-06-03','tarea biologia','urgente',1),(' ',2,'2022-08-03','tarea matematicas','urgente',2);
insert into recordatorios values (' ',1, 'tomar agua', '2022-01-09');
insert into recordatorios values (' ',2, 'ejercicio', '2022-01-09');
insert into comunidad values (' ', 'musica'), (' ', 'grupo de chistes');
insert into asociacion values (1,2),(1,3),(1,1),(2,1),(2,2),(2,3);


/*consultas básicas*/
select * from usuarios inner join bita_animo on usuarios.idUsu = bita_animo.idUsuFK group by idUsu;
select*from sesiones where idUsuFK=1 and estadoSesiones =1;


select nombreUsu, tematica from asociacion inner join usuarios on usuarios.idUsu = asociacion.idUsuFK 
inner join comunidad on asociacion.idComunidadFK = comunidad.idComunidad;
select estadoSesiones, fecha from sesiones inner join usuarios  where usuarios.idUsu = sesiones.idUsuFK and estadoSesiones=1;


create view vista_actividades_usuario as select nombreUsu, correoUsu from Usuarios inner join tareas on usuarios.idUsu = tareas.idUsuFK where estado='pendiente';
select*from vista_actividades_usuario;
desc asociacion;
Select * from asociacion Where (Select count(idUsuFK) from asociacion order by idUsuFK limit 1);
select*from sesiones where (select * from UsuarioS where Usuarios.idUsuario=sesiones.idUsuarioFK);



desc bita_animo;
DELIMITER //
Create procedure agregar_bitacora(in idUsu int, in estadoEm varchar(50), in nota text)
begin
insert into bita_animo (idUsuFK,estadoEm, notaPersonal) values (idUsu, estadoEm, nota);
END // 
DELIMITER ;
call agregar_bitacora (1,'triste','estoy triste');
select*from bita_Animo;

desc tareas;
DELIMITER //
Create procedure marcar_tarea_completada(in tarea_ID int)
begin
UPDATE tareas set tareas.estado= 'pendiente';
END // 
DELIMITER ;
call marcar_tarea_completada (1,'triste','estoy triste');
select*from tareas;