/*La Gran Empresa de Datos: Mariana Álvarez Carvajal*/
create database TechCorp;
use TechCorp;
CREATE TABLE empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreEmpleado VARCHAR(100) not null,
    edadEmpleado INT not null,
    ingresosEmpleado DECIMAL(10,2)not null, /*Serían 10 números antes de la coma, y dos decimales*/
    fContratacion DATE not null,
    departamento varchar(20) not null,
    idDepartamentoFk int not null,
    idCargoFK varchar(30) not null,
	foreign key(idDepartamentoFk) references departamento (idDepartamento) on delete cascade on update cascade,
	foreign key(idCargoFK) references cargo (idCargo) on delete cascade on update cascade
);

CREATE TABLE departamento (
    idDepartamento INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreDepartamento VARCHAR(100) not null
);
create table cargo(
	idCargo varchar(30) primary key not null,
    nombreCargo varchar (50) not null,
    rangoCargo varchar (100) not null,
    descCargo varchar(100) not null
);

/*Insertar empleados: Inserté 10 empleados*/
insert into empleados values (' ','Mariana Álvarez', 20, 3500.50, '2024-03-17', 'Analítica',1,2),
(' ', 'Gabriel Álvarez', 35, 4200.00, '2018-03-22', 'Programación',3,4),
(' ', 'Paola Rodríguez', 24, 5000.75, '2024-11-10', 'Ventas',3,2),
(' ','Lina Peña', 23, 3800.00, '2022-09-05', 'RRHH',4,5),
(' ','Tatiana Carvajal', 33, 3100.25, '2020-01-20', 'Finanzas',6,5),
(' ','David Moreno', 45, 6000.00, '2010-07-01', 'Marketing',5,3),
(' ','Paula Garzón', 26, 2700.00, '2023-02-12', 'Analítica',2,5),
(' ','Beatriz Pinzón', 40, 4800.50, '2023-05-30', 'Finanzas',1,5),
(' ','Patricia Fernández', 33, 4100.00, '2017-08-25', 'Ventas',1,2),
(' ','Hugo Lombardi', 42, 5500.00, '2014-04-18', 'Ventas',4,2);
select * from empleados;

/*Insertar departamentos*/
insert into departamento values (' ', 'Programación'),(' ', 'Ventas'),(' ','RRHH'),(' ', 'Finanzas'),(' ','Marketing'),
(' ', 'Analítica');
select * from departamento;

insert into cargo values (1, 'analista de datos', 3, 'analista de datos'),
(2, 'vendedor', 2, 'Vendedor'),(3,'director RRHH', 6, 'director de RRHH'),(4, 'Innovador',1, 'innovador'),
(5,'Gerente',5,'gerente'),(6, 'Director Financiero', 6,'director financiero');

/*RETO 1: Lista de empleados: Obtén los nombres, edades y salarios de todos los empleados de TechCorp.*/
select nombreEmpleado as 'nombres', edadEmpleado as 'edades', ingresosEmpleado as 'salarios' from empleados;

/*RETO 2: Altos ingresos: ¿Quiénes son los empleados que ganan más de $4,000?*/
select idEmpleado, nombreEmpleado as 'nombres', ingresosEmpleado as 'salarios' from empleados where ingresosEmpleado >4000.00;

/*RETO 3: Fuerza de ventas: Extrae la lista de empleados que trabajan en el departamento de Ventas.*/
select*from empleados where departamento='Ventas';

/*RETO 4: Rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años.*/
select*from empleados where edadEmpleado>=30 and edadEmpleado<=40;

/*RETO 5: Nuevas contrataciones: ¿Quiénes han sido contratados después del año 2020?*/
select * from empleados where year(fContratacion) > 2020;

/*RETO 6: Distribución de empleados: ¿Cuántos empleados hay en cada departamento?*/
/* Para unsar Count: Agrupa los datos por la columna especificada y cuenta los elementos en cada grupo.*/
select departamento, COUNT(*) as tOTAL from empleados group by departamento;

/*RETO 7: Análisis salarial: ¿Cuál es el salario promedio en la empresa?
Devuelve la media (promedio) de todos los registros según el campo indicado.*/
select Avg(ingresosEmpleado) AS promedioSalario  FROM empleados;

/*RETO 8: Nombres selectivos: Muestra los empleados cuyos nombres comienzan con "A" o "C".*/
/*Insertaré otros dos clientes porque antes no tenía nombres que tuvieran esas condiciones*/
insert into empleados values (' ','Camila Hernández', 20, 3500.50, '2024-03-17', 'Analítica'),
(' ','Ana Gómez', 20, 3500.50, '2024-03-17', 'Programación');
select*from empleados where nombreEmpleado like 'A%' or nombreEmpleado like 'C%' ; 

/*RETO 9: Departamentos específicos: Encuentra a los empleados que no pertenecen al departamento de IT.
Asumiré IT como Programación:*/
select * from empleados where departamento<>'Programación';

/*RETO 10: El mejor pagado: ¿Quién es el empleado con el salario más alto?*/
select nombreEmpleado as 'El Más pagado', ingresosEmpleado as 'salario' from empleados where ingresosEmpleado = (select MAX(ingresosEmpleado) from empleados);

/*Funciones agregadas: Permiten hacer procesos sin tener que modificiarlos*/
 /*consultar rangos between*/
 select*from empleados where idEmpleado  between 1 and 4;
 
 /*Consultar un valor que esté dentro de una lista de valores: in*/
 select*from empleados where idEmpleado in (1,6);
 
 /*Si un campo es nulo is null*/
 select*from empleados where nombreEmpleado is null;


select*from empleados where departamento is null;
select*from empleados order by ingresosEmpleado desc;
select*, (2025-year(fContratacion)) as 'Años trabajados' from empleados;
select*from empleados order by ingresosEmpleado desc limit 3;

/*Having: Se pone cuadno ya hice un group by*/

/*Modificiación: Update*/
update empleados set nombreEmpleado = 'Gabriel' where idEmpleado=1;

/*delete: eliminar. SIEMPRE DEBE LLEVAR UNA CLAUSULA WHERE*/

/*Tipos de Join: 
select campos_que_quiero_consultar from tabla 1 inner join tabla 2 on tabla1.nombreCampoTabla1 = tabla2.nombre columna tabla2
inner join tabla3 on tabla1.nombreColumnaTabla1 = tabla3.nombrecolumna

1. Inner: Devuelve solo las filas (Registros) que coincidan en ambas tablas (intersección)
2. Left: Devuelve todas las filas de la izquierda + la que coincidan con la de la derecha 
3. Right: Devuelve todas las filas de la derecha + la que coincidan con la de la izquierda 
4. Full: Devuelve todas las filas
*/
/*Mostrar los nomres de los empleados y los nombres de los departamentos a los que pertencen*/
select nombreEmpleado, departamento from empleados inner join departamento 
on empleados.idDepartamentoFK = departamento.idDepartamento;

select nombreEmpleado, departamento from empleados left join departamento 
on empleados.idDepartamentoFK = departamento.idDepartamento;

select nombreEmpleado, departamento from empleados right join departamento 
on departamento.idDepartamento = empleados.idDepartamentoFK;

/*Consulta todos los empleados con un rango especigico: Los que el id son menores o iguales a 3*/
select * from empleados left join cargo on cargo.rangoCargo=3;

/*Cargos con un rango específico*/
select*from cargo where rangoCargo = 2;

/*Empleados con un cargo específico*/
select nombreEmpleado, idCargoFK, nombreCargo from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo where idCargo=3;

/*Mostrar todos los empleados que llevan más de tres años, mostrando departamento, salario, cargo*/
select nombreEmpleado, nombreDepartamento, ingresosEmpleado, nombreCargo
from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo inner join 
departamento on empleados.idDepartamentoFK = departamento.idDepartamento where
(2025-year(fContratacion)) >3;

/*Mostrar toda la información de los mepleado. Nombre, frecha contra, dto, años de antiguedad, cargo, rango del cargo*/
select nombreEmpleado, fContratacion, nombreDepartamento, nombreCargo, rangoCargo, 
(2025-year(fContratacion)) as 'Años trabajados'
from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo inner join 
departamento on empleados.idDepartamentoFK = departamento.idDepartamento;

/*Mostrar los departamentos que no tengan empleados asignados*/
select nombreEmpleado, nombreDepartamento from departamento inner join empleados on empleados.idDepartamentoFK = departamento.idDepartamento
where idDepartamentoFK is null;

/*Mostrar todos los cargos que no tengan empleados asignados*/
select * from cargo inner join empleados on empleados.idCargoFK = cargo.idCargo
where idCargoFK is null;


