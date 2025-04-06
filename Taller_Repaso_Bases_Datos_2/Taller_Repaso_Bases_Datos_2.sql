CREATE DATABASE bibliotecaOnlineBD;
USE bibliotecaOnlineBD;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT not null,
    nombre VARCHAR(100) not null,
    email VARCHAR(100) not null,
    fecha_registro DATE not null
);

CREATE TABLE libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT not null,
    titulo VARCHAR(150) not null,
    autor VARCHAR(100) not null,
    precio DECIMAL(10, 2) not null,
    stock INT not null
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT not null,
    id_cliente INT not null,
    fecha_pedido DATE not null,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_pedido (
    id_pedido INT not null,
    id_libro INT not null,
    cantidad INT not null,
    PRIMARY KEY (id_pedido, id_libro),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);

/*EJEMPI0S DE AITER
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
*/
select*from clientes;
INSERT INTO clientes (nombre, email, fecha_registro) VALUES('Laura Gómez', 'laura@example.com', '2024-01-10'),('Carlos Ruiz', 'carlos@example.com', '2024-02-15'),
('Ana Martínez', 'ana@example.com', '2024-03-05');

INSERT INTO libros (titulo, autor, precio, stock) VALUES ('Cien Años de Soledad', 'Gabriel García Márquez', 25.00, 10),
('El Principito', 'Antoine de Saint-Exupéry', 15.00, 20),('Don Quijote de la Mancha', 'Miguel de Cervantes', 30.00, 5),
('Rayuela', 'Julio Cortázar', 22.00, 8),('Ficciones', 'Jorge Luis Borges', 18.00, 12);

INSERT INTO pedidos (id_cliente, fecha_pedido) VALUES(1, '2025-04-01'),(2, '2025-04-02'),(3, '2025-04-03');
INSERT INTO pedidos (id_cliente, fecha_pedido) VALUES(1, '2025-04-01');

desc detalle_pedido;
-- Pedido 1: Laura compró 2 de "Cien Años de Soledad" y 1 de "El Principito"
INSERT INTO detalle_pedido VALUES(1, 1, 2),(1, 2, 1);
-- Pedido 2: Carlos compró 1 de "Don Quijote" y 3 de "Rayuela"
INSERT INTO detalle_pedido VALUES (2, 3, 1), (2, 4, 3);
-- Pedido 3: Ana compró 2 de "Ficciones"
INSERT INTO detalle_pedido VALUES (3, 5, 2);


/*Actualizar el stock de los libros una vez que se realice un pedido*/
DELIMITER //
CREATE TRIGGER actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW BEGIN
    UPDATE libros
    SET stock = stock - NEW.cantidad
    WHERE id_libro = NEW.id_libro;
END//
DELIMITER ;
select*from libros;
INSERT INTO detalle_pedido (id_pedido, id_libro, cantidad)
VALUES (2, 2, 3);  /*Antes habían 20 deI principit0, ah0ra hay 17*/


/*listar los pedidos hechos por un cliente específico y obtener detalles de los libros comprados.*/
SELECT clientes.nombre,pedidos.id_pedido,pedidos.fecha_pedido,libros.titulo,libros.precio,detalle_pedido.cantidad
FROM clientes 
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
JOIN detalle_pedido ON pedidos.id_pedido = detalle_pedido.id_pedido
JOIN libros ON detalle_pedido.id_libro = libros.id_libro
WHERE clientes.id_cliente = 1;

/*Consultar el cliente que ha realizado el mayor número de pedidos.*/
SELECT clientes.id_cliente,nombre,COUNT(pedidos.id_pedido) AS total_pedidos
FROM clientes JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente, clientes.nombre ORDER BY total_pedidos DESC LIMIT 1; /*EI Iimit es para que me de s0I0 un dat0*/


/*Crear un procedimiento almacenado que permita registrar un nuevo pedido, 
actualizando la tabla de pedidos y reduciendo el stock del libro correspondiente.*/
DELIMITER //
CREATE PROCEDURE registrar_pedido (IN p_id_pedido INT,IN p_id_cliente INT,IN p_fecha DATE,IN p_id_libro INT,
IN p_cantidad INT)
BEGIN
    -- Insertar el pedido con el ID y fecha recibidos
    INSERT INTO pedidos (id_pedido, id_cliente, fecha_pedido)
    VALUES (p_id_pedido, p_id_cliente, p_fecha);

    -- Insertar el detalle del pedido
    INSERT INTO detalle_pedido (id_pedido, id_libro, cantidad)
    VALUES (p_id_pedido, p_id_libro, p_cantidad);

    -- Actualizar el stock del libro
    UPDATE libros
    SET stock = stock - p_cantidad
    WHERE id_libro = p_id_libro;
END //
DELIMITER ;
CALL registrar_pedido(10, 2, '2025-04-05', 3, 2);


/*Selecciona los libros cuyo precio sea mayor a $20.00 */
SELECT * FROM libros WHERE precio > 20.00;


/*Selecciona los pedidos realizados después del 1 de octubre de 2024.*/
SELECT *FROM pedidos WHERE fecha_pedido > '2024-10-01';

/* Selecciona todos los libros ordenados por su precio de mayor a menor.*/
SELECT * FROM libros order by precio desc;

/*Obtén el total de clientes registrados en la tabla clientes. Obtén el total de unidades vendidas en la tabla pedidos. */
SELECT(SELECT COUNT(*) FROM clientes) AS total_clientes,
(SELECT SUM(cantidad) FROM detalle_pedido) AS total_unidades_vendidas;

/*Muestra el número de pedidos realizados por cada cliente.*/
SELECT clientes.id_cliente,clientes.nombre,COUNT(pedidos.id_pedido) AS total_pedidos
FROM clientes LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente, clientes.nombre;

/*Muestra el nombre del cliente, el título del libro y la cantidad de cada pedido.*/
SELECT clientes.nombre AS nombre_cliente, libros.titulo AS titulo_libro, detalle_pedido.cantidad
FROM clientes
JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
JOIN detalle_pedido ON pedidos.id_pedido = detalle_pedido.id_pedido
JOIN libros ON detalle_pedido.id_libro = libros.id_libro;

/*Muestra los títulos de los libros y la cantidad total vendida de cada uno. */
SELECT libros.titulo,SUM(detalle_pedido.cantidad) AS total_vendido
FROM detalle_pedido
JOIN libros ON detalle_pedido.id_libro = libros.id_libro
GROUP BY libros.titulo;




