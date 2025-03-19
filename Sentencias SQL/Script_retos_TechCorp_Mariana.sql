/*La Gran Empresa de Datos: Mariana Álvarez Carvajal*/
create database TechCorp;
use TechCorp;
CREATE TABLE empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreEmpleado VARCHAR(100) not null,
    edadEmpleado INT not null,
    ingresosEmpleado DECIMAL(10,2)not null, /*Serían 10 números antes de la coma, y dos decimales*/
    fContratacion DATE not null,
    departamento varchar(20) not null
);
CREATE TABLE departamento (
    idDepartamento INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreDepartamento VARCHAR(100) not null
);

/*Insertar empleados: Inserté 10 empleados*/
insert into empleados values (' ','Mariana Álvarez', 20, 3500.50, '2024-03-17', 'Analítica'),
(' ', 'Gabriel Álvarez', 35, 4200.00, '2018-03-22', 'Programación'),
(' ', 'Paola Rodríguez', 24, 5000.75, '2024-11-10', 'Ventas'),
(' ','Lina Peña', 23, 3800.00, '2022-09-05', 'RRHH'),
(' ','Tatiana Carvajal', 33, 3100.25, '2020-01-20', 'Finanzas'),
(' ','David Moreno', 45, 6000.00, '2010-07-01', 'Marketing'),
(' ','Paula Garzón', 26, 2700.00, '2023-02-12', 'Analítica'),
(' ','Beatriz Pinzón', 40, 4800.50, '2023-05-30', 'Finanzas'),
(' ','Patricia Fernández', 33, 4100.00, '2017-08-25', 'Ventas'),
(' ','Hugo Lombardi', 42, 5500.00, '2014-04-18', 'Ventas');
select * from empleados;

/*Insertar departamentos*/
insert into departamento values (' ', 'Programación'),(' ', 'Ventas'),(' ','RRHH'),(' ', 'Finanzas'),(' ','Marketing'),
(' ', 'Analítica');
select * from departamento;

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
