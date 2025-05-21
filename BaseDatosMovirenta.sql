create type genero_peliculas as enum('romance', 'accion', 'drama', 'comedia', 'terror');
create type diponibilidad_peliculas as enum('disponible','no disponible','retirada');
create type estado_pago as enum('pago','pendiente');


-- creacion de tablas
create table cliente(
	id serial primary key,
	nombre varchar(50) not null,
	telefono varchar(13)not null,
	correo varchar(70) not null, 
	direccion varchar(70) not null
);

create table sucursal (
	id serial primary key,
	nombre varchar(50) not null,
	ubicacion varchar(70) not null
);

create table pelicula (
	id serial primary key, 
	titulo varchar(50) not null, 
	genero genero_peliculas,
	director varchar(50)not null, 
	anio_lanzamieto date, 
	disponibilidad diponibilidad_peliculas,
	precio_alquiler decimal(10,2)
);

create table inventario(
	id_sucursal int not null,
	id_pelicula int not null,
	cantidad int,
	foreign key(id_sucursal) references sucursal(id),
	foreign key(id_pelicula) references pelicula(id)
);



create table pago(
	id serial primary key,
	referencia int unique,
	fecha_pago timestamp default current_timestamp,
	monto decimal(10,2),
	estado estado_pago
);

create table historial ( 
	id serial primary key,
	id_pelicula int,
	id_cliente int,
	fecha_inicio date,
	fecha_devolucion date,
	costo_total decimal(10,2),
	pago int,
	foreign key(pago) references pago(id),
	foreign key(id_pelicula) references pelicula(id),
	foreign key(id_cliente) references cliente(id)
);


-- inserciones
-- inserciones cliente
insert into cliente (nombre, telefono, correo, direccion) values
('jennifer', '123456789','jennifer@gmail.com', 'cra 11 N1'),
('juan', '123456789','juan@gmail.com', 'cra 12 N32'),
('luis', '123456789','luis@gmail.com', 'cra 13 N5'),
('carme', '123456789','carmen@gmail.com', 'cra 52 N4'),
('damian', '123456789','damian@gmail.com', 'cra 22 N9'),
('carlos', '123456789','carlos@gmail.com', 'cra 42 N5'),
('laura', '123456789','laura@gmail.com', 'cra 92 N10'),
('maria', '123456789','maria@gmail.com', 'cra 27 N120'),
('rey', '123456789','rey@gmail.com', 'cra 27 N10'),
('ruben', '123456789','ruben@gmail.com', 'cra 28 N10');

-- inserciones pelicula
insert into pelicula (titulo, genero, director, anio_lanzamieto, disponibilidad, precio_alquiler) values 
('titanic', 'romance', 'juanin Anthon', '2001-12-1', 'disponible', 15000.00),
('avengers', 'accion', 'Carlos Ramirez', '2019-12-2', 'disponible', 20000.00),
('Nausica valle del viento', 'drama', 'mayaho', '1999-12-3', 'disponible', 15000.00),
('Arietty', 'drama', 'mayaho', '1999-12-4', 'disponible', 15000.00),
('castillo Ambulante', 'romance', 'jayao miyasaki', '2001-10-5', 'disponible', 20000.00),
('el chico y la garza', 'accion', 'jayao miyasaki', '2024-10-6', 'disponible', 30000.00),
('viaje agartha', 'drama', 'juanin Anthon', '2010-9-7', 'disponible', 20000.00),
('tumba de las luciernagas', 'drama', 'jayao miyasaki', '2011-4-8', 'disponible', 20000.00),
('madre', 'terror', 'Carlos Ramirez', '2005-3-9', 'disponible', 10000.00),
('niebla', 'terror', 'Carlos Ramirez', '2002-2-10', 'disponible', 10000.00),
('cadaver de la novia', 'romance', 'Tim Burton', '2006-8-11', 'disponible', 13000.00),
('coraline', 'terror', 'Tim Burton', '2008-9-12', 'disponible', 10000.00),
('makia', 'drama', 'mayaho', '2020-12-13', 'disponible', 15000.00),
('que paso ayer', 'comedia', 'Noshe quien', '2010-3-14', 'disponible', 10000.00),
('casa embrujada 2', 'comedia', 'Noshe quien', '2011-5-15', 'disponible', 15000.00);


-- inserciones pagos
insert into pago (referencia, fecha_pago, monto, estado) values 
(12340, '2024-05-20', 15000.00, 'pago'),
(12350, '2024-05-20', 20000.00, 'pago'),
(12360, '2024-05-16', 30000.00, 'pago'),
(12370, '2024-05-24', 10000.00, 'pago'),
(12380, '2024-05-20', 15000.00, 'pago'),
(12390, '2024-05-20', 20000.00, 'pago'),
(1243, '2024-05-3', 30000.00, 'pendiente'),
(1244, '2024-05-3', 30000.00, 'pendiente'),
(12450, '2024-05-5', 15000.00, 'pendiente'),
(12460, '2024-05-15', 10000.00, 'pendiente'),
(12470, '2024-05-14', 15000.00, 'pendiente'),
(12480, '2024-05-19', 15000.00, 'pendiente');



-- inserciones sucursales
insert into sucursal (nombre, ubicacion) values 
('movirenta centro', 'cra 27 NO 10'),
('movirenta palmas', 'cra 45 NO 32'),
('movirenta biblioteca', 'cra 27 NO 33'),
('movirenta neomundo', 'cra 50 NO 32'),
('movirenta norte', 'cra 15 NO 15');

-- inserciones inentario de la sucursal y  sus peliculas
insert into inventario (id_sucursal, id_pelicula, cantidad) values
(1,2, 2),
(1,7, 2),
(1,8, 2),
(3,1, 2),
(3,9, 2),
(3,10, 2),
(2,3, 1),
(2,13, 1),
(2,15, 1),
(4,2, 2),
(4,15, 1),
(4,1, 2),
(4,4, 1),
(5,5, 2),
(5,4, 1),
(5,12, 2),
(5,1, 2),
(5,2, 2);

-- inserciones historial 
insert into historial (id_pelicula, id_cliente, fecha_inicio, fecha_devolucion, costo_total, pago) values
(1,1, '2024-05-20', '2024-05-24', 15000.00, 1),
(6,2, '2024-04-20', '2024-04-24', 30000.00, 7),
(2,3, '2024-04-10', '2024-04-14', 20000.00, 2),
(4,4, '2024-05-12', '2024-05-15', 15000.00, 5),
(6,5, '2024-03-10', '2024-03-14', 3000.00, 3),
(9,6, '2024-03-11', '2024-03-13', 1000.00, 4),
(9,6, '2024-05-20', '2024-05-24', 3000.00, 8),
(8,7, '2024-04-1', '2024-04-4', 2000.00, 6),
(13,8, '2024-05-5', '2024-05-9', 1500.00, 11),
(15,9, '2024-04-10', '2024-04-14', 1500.00, 9),
(14,10, '2024-05-15', '2024-05-17', 1000.00, 10);


-- consultas 
-- 1 calcular los ingresos generados por cada sucursal el ultimo mes
select s.nombre, sum(p2.monto) as total 
from historial h 
join pelicula p on h.id_pelicula = p.id 
join inventario i on i.id_pelicula = p.id 
join sucursal s on i.id_sucursal = s.id
join pago p2 on p2.id = h.pago 
where p2.estado = 'pago' 
group by s.nombre;


--2 consultar el cliente con el mayor monto total de pagos realizados
select h.costo_total as pago, c.nombre 
from historial h 
join cliente c on h.id_cliente = c.id
order by pago desc 
limit 1;

-- 3 obtener el porcetaje de las peliculas alquiladas por genero 
select count(p.genero) as cantidad, p.genero 
from historial h 
join pelicula p on h.id_pelicula = p.id
group by p.genero;

-- 4. identificar las sucursales con mayor numero de alquiler
select s.nombre, count(*)  as alquiler 
from historial h 
join pelicula p on h.id_pelicula = p.id 
join inventario i on i.id_pelicula = p.id 
join sucursal s on i.id_sucursal = s.id
join pago p2 on p2.id = h.pago 
group by s.nombre
order by alquiler desc limit 1;

-- 5 listar peliculas disponibles para alquiler( titulo, genero y precio)
select p.titulo, p.genero, p.precio_alquiler 
from historial h
right join pelicula p on p.id = h.id_pelicula
where h.id is null;

-- 6. obtener un historial de un cliente espesifico(fechas y titulos de las peliculas)
select c.id, h.id_pelicula, p.titulo, h.fecha_inicio, h.fecha_devolucion 
from historial h 
join cliente c on h.id_cliente = c.id 
join pelicula p on p.id = h.id_pelicula 
where c.id = 6;  

-- 7. consultar peliculas con precios de alquiler superiores a un valor espesifico
select p.titulo, p.precio_alquiler 
from historial h 
join pelicula p on h.id_pelicula = p.id 
where p.precio_alquiler  > 25000.00;


-- 8. listar peliculas lanzadas los ultimos 5 años y disponibles para alquilar 

select p.titulo, p.genero, p.precio_alquiler, age(current_date, p.anio_lanzamieto) as año
from historial h
right join pelicula p on p.id = h.id_pelicula
order by año asc
limit 4;

