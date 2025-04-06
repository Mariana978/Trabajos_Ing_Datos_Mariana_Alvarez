/*APUNTES PARCIAI 2 

Esta consulta devuelve todos los campos de una tabla 
			SELECT * FROM nombre_tabla 

--------------------------------------------------------------------------------------

 2- Para consultar campos específicos de la tabla utilizamos la sentencia
			SELECT campo1, campo2, campo3 FROM nombre_tabla 
--------------------------------------------------------------------------------------
  
 3- alias
			SELECT campo1 AS ‘Nombre a mostrar' FROM nombretabla; 
--------------------------------------------------------------------------------------

C0nsuIta 0rganizada de dat0s 
4- Devuelve campo1 y campo2 de la tabla y ordena los registros por campofecha ascendentemente (los más antiguos primero). 
				SELECT campo1, campo2 FROM nombre_tabla ORDER BY campofecha ASC 
--------------------------------------------------------------------------------------

CIausuIa WHERE 
		SELECT * FROM nombre_tabla WHERE campo_numerico >= 150 
        SELECT * FROM nombre_tabla WHERE Ciudad = 'Cali' AND Edad > 35
= Mism0
<> distint0
> may0r
< men0r
>= may0r 0 iguaI
<= men0r 0 iguaI

--------------------------------------------------------------------------------------

CIausuIa WHERE BETWEEN
Devuelve los registros cuyo valor este Incluido en el rango de valores
especificados en el BETWEEN
			SELECT campo1, campo2 FROM nombre_tabla
			WHERE campo1 BETWEEN valor1 AND valor 2

--------------------------------------------------------------------------------------

Busqqueda patr0nes Iike
			SELECT * FROM nombre_tabla WHERE ciudad LIKE 'Bo%’       C0MIENZAN ---%
            SELECT * FROM nombre_tabla WHERE ciudad LIKE '%a’        TERMINAN %---
            SELECT * FROM nombre_tabla WHERE campo1 LIKE '%bruno%'   C0NTENGAN %---%
            
Si quier0 buscar I0s que n0 c0miencen, ni que terminen, ni que c0ntengan, p0ner N0T IIKE

--------------------------------------------------------------------------------------

Funci0nes agregadas
1- Devuelve el registro con el valor más alto del campo indicado.
			SELECT MAX(campo) FROM nombre_tabla

2- Devuelve el registro con el valor más bajo del campo indicado.
			SELECT MIN(campo) FROM nombre_tabla

3- Devuelve la cantidad de registros según el campo y/o condición indicado(a).
			SELECT COUNT(campo) FROM nombre_tabla
	EJEMPLO: Mostrar la cantidad total de VOTOS EN BLANCO registrados
			SELECT COUNT(idpostCandidatoFK) AS 'Votos en Blanco’ FROM Votacion WHERE idPostCandidatoFK=1;

4- Devuelve la media (promedio) de todos los registros según el campo indicado.
			SELECT AVG(campo) FROM nombre_tabla

5- Devuelve la sumatoria de registros según el campo y/o condición indicado(a).
			SELECT SUM(campo) FROM nombre_tabla
            
---------------------------------------------------------------------------------------------------------------            
            
Tipos de Join: 
select campos_que_quiero_consultar from tabla 1 inner join tabla 2 on tabla1.nombreCampoTabla1 = tabla2.nombre columna tabla2
inner join tabla3 on tabla1.nombreColumnaTabla1 = tabla3.nombrecolumna

1. Inner: Devuelve solo las filas (Registros) que coincidan en ambas tablas (intersección)
2. Left: Devuelve todas las filas de la izquierda + la que coincidan con la de la derecha 
3. Right: Devuelve todas las filas de la derecha + la que coincidan con la de la izquierda 
4. Full: Devuelve todas las filas
			select nombreEmpleado, departamento from empleados inner join departamento 
			on empleados.idDepartamentoFK = departamento.idDepartamento;

			select nombreEmpleado, departamento from empleados left join departamento 
			on empleados.idDepartamentoFK = departamento.idDepartamento;

			select nombreEmpleado, departamento from empleados right join departamento 
			on departamento.idDepartamento = empleados.idDepartamentoFK;
            
--------------------------------------------------------------------------------------------------------------------
            
Eleminación
		delete from nombreTabla where condición

--------------------------------------------------------------------------------------

Procedimientos almacenaos: Stored Procedure - Conjunto de instrudcciones de SQL que se almacenan en la base de datos
y estos se pueden ejecutar muchas veces
SINTAXIS DEL PROCEDIMIENTO:
			DELIMITER //
			Create procedure InsertarMascota(parametros entrada in salida out)
			begin
			---instrucciones de SQL
			END
			// DEMILITER
-- Ejecutar el procedimiento
-- Sintaxis es call nombreProcedimiento (valores)
call InsertarMascota ('3', 'Firulais', 'Macho', 'pitbull', 3);
EJ
				DELIMITER //
			Create procedure InsertarMascota(in idMascota int, nombreMascota varchar(15), generoMascota varchar(15), razaMascota varchar(15),cantidad int)
			begin
			-- instrucciones de SQL
				insert into mascota values (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);
			END // 
			DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------

Vistas - Views: Es una consulta que genera una tabla virtual pero que no queda almacenada dentro de la base de datos
SINTAXIS:
			create view nombreVista as 
			select valoresaConsultar from nombreTabla where condiciones
Modificar una vista
			alter view nombreVista as
			select valoresaConsultar from nombreTabla where condiciones
Eliminar una vista:
			drop view nombreVista
            
EJ-
			Crear una vista que contenga el 4,6 y 7
				create view vistaTel as select*from cliente where telefono='%4%' or telefono ='%6%' or telefono ='%7%';
				select*from vistaTel;
				alter view vistaTel as select*from cliente where telefono like '%4%' and telefono like '%6%' and telefono like '%7%';
				select*from cliente;

-------------------------------------------------------------------------------------------------------------------------

DISPARADORES - TRIGGERS - DESENCADENADORES
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
Variables old y new (acceder a registros)
New: Al nuevo valor que se va a insertar o modificar.
old: el valor anterior.

Ejemplo:
			Delimiter $$
			Create trigger descontarinventario 
			after insert on detallefactura
			for each row
			begin
			update producto
			set producto.stockProducto= producto.stockProducto -new.cantidad where producto.idProducto=new.idproductofk;
			end;
			$$
			Delimiter ;
            
            
			create trigger validar_precio
			after insert on producto
			for each row
			begin
				if new.precio<0 then
					signal sqlstate '45000'
					set message_text='el precio es incorrecto';
				end if;
			end;

			create trigger registrar_cambio
			after update on empleado
			for each row
			begin
				insert into historial_cambios values(old.id,old.nobre,new.nombre, now())
			end;

			create trigger actualizar_inventario
			after insert on venta
			for each row
			begin
				update inventario
				set cantidad=cantidad-new.cantida_vendida
				where idProducto=new.IdProducto;
			end;

			create trigger registro_papelera
			before delete on usuarios
			for each row
			begin
				insert into usuariosEliminados values (old.id, ol.nombre, ol.apellido, ol.telefono, now());
			end;

Cada vez que alguien actualice el salario de un empleado, queremos guardar el cambio en la tabla de log.
			CREATE TRIGGER trigger_log_salario
			AFTER UPDATE ON empleados
			FOR EACH ROW
			BEGIN
			  IF NEW.salario <> OLD.salario THEN
				INSERT INTO log_cambios(empleado_id, salario_antiguo, salario_nuevo, fecha_cambio)
				VALUES (OLD.id, OLD.salario, NEW.salario, NOW());
			  END IF;
			END;

-----------------------------------------------------------------------------------------------------------------
EJEMPI0S DE AITER
Agregar una columna:
ALTER TABLE nombre_tabla
ADD nombre_columna tipo_dato;

Eliminar una columna:
ALTER TABLE nombre_tabla
DROP COLUMN nombre_columna;

Cambiar el tipo de una columna:
ALTER TABLE nombre_tabla
MODIFY nombre_columna nuevo_tipo; 

Renombrar una columna:
ALTER TABLE nombre_tabla
RENAME COLUMN viejo_nombre TO nuevo_nombre;

Renombrar la tabla:
ALTER TABLE nombre_tabla
RENAME TO nuevo_nombre;

----------------------------------------------------------------------------------------------------------------------

Subconsultas: una consulta ue esta dentro de otra consulta
Tipos:
	1- Subconsultas de 1 columna: Devuelve una lista de valores en una
	sola columna
	2- Subconsultas de varias columna: Devuelve multiples valores varias 
	columnas
	3- Subconsultas correlacionales: Depende de la consulta principal
Sintaxis
			Select camposaConsultar from nombreTablaPirncipal 
			Where (Select camposaConsultardelaSubconsulta from nombreTablasecundaria
			where condicion)
#Consulta el cliente que compro el producto con mayor precio
#consulta principal
Select cedulaCliente as 'Documento Cliente' from cliente 
where precioTotal=(select max(precio) as 'Precio', nombreProducto from producto);
describe producto;

------------------------------------------------------------------------------------------------------------
 
*/
