
Create database viajesURosario;
Create database tienda;

use tienda;

create table cliente(
idCliente int AUTO_INCREMENT PRIMARY KEY,
documentCliente int NOT NULL,
nombreCliente varchar(50) NOT NULL,
emailCliente varchar(50) NOT NULL,
telefonoCliente varchar(50) NOT NULL,
direccionCliente text,
fechaRegistro timestamp default current_timestamp
);

create table pedido(
idPedido int AUTO_INCREMENT PRIMARY KEY,
idClienteFK int NOT NULL,
idProductoFK int not null,
fechaPedido date NOT NULL,
totalPedido decimal(10,2) NOT NULL, 
estado enum('Pendiente', 'Enviado', 'Entregado', 'Cancelado') default 'Pendiente',
fechaRegistro timestamp default current_timestamp,
foreign key(idProductoFK) references Producto(idProducto) on delete cascade on update cascade
);

create table producto(
idProducto int AUTO_INCREMENT PRIMARY KEY,
codigoProduto varchar(50) NOT NULL,
nombreProducto varchar(50) NOT NULL,
precioProducto decimal (10,2) NOT NULL,
stock int default 0,
fechaCreacion timestamp default current_timestamp
);

describe producto;


alter table producto add column descripcionProducto varchar(50) not null;

alter table producto modify column precioProducto decimal(12,2);

alter table producto rename to product;

/* eliminar tablas drop table nombreTabla*/
drop table pedido;

drop database viajesurosario;

truncate table pedido;

alter table pedido add constraint FKclientPed
foreign key (idClienteFK) references cliente (idCliente);

describe clientes;
select * from clientes;
/*INSERCIÓN DE CLIENTES*/
/*Sale un warning por el campo autoincrement*/
insert into clientes values (' ', 'mariana', 'acma@urosario', 52477, 'avenida 68', '22/08/2088');
insert into clientes values (' ', 'tatiana', 'tati@urosario', 3883, 'carrera 5', '20/10/2008'),
(' ', 'gabriel', 'gabo@urosario', 2838, 'diagonal 5', '24/03/6203'),
(' ', 'santiago', 'santi@urosario', 3273, 'calle 73', '5/22/1023'),
(' ', 'felipe', 'pipe@urosario', 3478, 'diagonal 7', '5/22/1023');

describe producto;
/*INSERCIÓN DE PRODUCTOS*/
/*Sale un warning por el campo autoincrement*/
insert into producto values (' ', '83784', 'mariana', 7686, '97', '22/08/2088','asdfsa');
insert into producto values (' ', '98438', 'tatiana', 7686, '83', '22/08/2088','asdfsa'),
(' ', '98438', 'gabirel', 7686, '83', '22/08/2088','asdfsa'),
(' ', '98438', 'felipe', 7686, '83', '22/08/2088','asdfsa'),(' ', '98438', 'amaya', 7686, '83', '22/08/2088','asdfsa');
select*from producto;


/*MODIFICACIÓN DE REGISTROS: si no se incluye la clausula where, actualiza o modifica todos los clientes*/
update producto set marca='animals' where codigoProducto=2;
select*from producto;

update producto set marca = 'Prueba' where codigoProducto=3;