create database pizzeria1;

use pizzeria1;

create table clientes (
id_clientes INT PRIMARY KEY,
nombre VARCHAR(40),
telefono INT(10),
direccion VARCHAR(50)
);

insert into clientes(id_clientes,nombre,telefono,direccion) values
("1","Scarlet Black","1721340","689-4948 Bibendum Av."),
("2","Richard Cervantes","1864451","3392 Consectetuer Road"),
("3","Oren Sawyer","1108879","550-733 Mauris Street"),
("4","Stacy Bean","1246537","288-7681 In Ave"),
("5","Gary Hill","1674367","Ap #502-1662 Lectus, Rd."),
("6","Leila Jenkins","1636576","Ap #308-331 Sit Street");

-- drop table combos,menu,populares;

create table combos (
id_combos INT PRIMARY KEY,
pizzas VARCHAR(50),
postres VARCHAR(40),
bebidas VARCHAR(40),
precio INT(10)
);

insert into combos(id_combos,pizzas,postres,bebidas,precio) values
(1, 'Pizza Margherita', 'Cheesecake', 'Coca-Cola (1.5 L)', "15000"),
(2, 'Pizza Pepperoni', 'Tiramisu', 'Pepsi (1.5 L)', "17000"),
(3, 'Pizza Hawaiana', 'Brownie con helado', 'Sprite (1.5 L)', "16000"),
(4, 'Pizza Cuatro Quesos', 'Helado Sundae', 'Fanta (1.5 L)', "18000"),
(5, 'Pizza BBQ de Pollo', 'Crepas de Nutella', 'Red Bull (250 ml)', "19000");

create table bebidas (
id_bebidas INT PRIMARY KEY,
id_clientes INT,
nombre VARCHAR(20),
precio INT(10),
foreign key (id_clientes) references clientes(id_clientes)
);

insert into bebidas(id_bebidas,nombre,precio) values
("1","CocaCola", "5000"),
("2","Pepsi","4000"),
("3","Fanta","3000"),
("4","Agua","2000"),
("5","Jugo Hit","5000");

create table pizzas (
id_pizzas INT PRIMARY KEY,
id_clientes INT,
nombre VARCHAR(30),
precio INT(10),
foreign key (id_clientes) references clientes(id_clientes)
);

insert into pizzas(id_pizzas,nombre,precio) values
("1","Pizza Vegetariana", "10000"),
("2","Pizza Cuatro Quesos","9000"),
("3","Pizza BBQ de Pollo","8000"),
("4","Pizza Pepperoni","7000"),
("5","Pizza Margherita","6000");

create table postres (
id_postres INT PRIMARY KEY,
id_clientes INT,
nombre VARCHAR(20),
precio INT(10),
foreign key (id_clientes) references clientes(id_clientes)
);

insert into postres(id_postres,nombre,precio) values
(1, "Cheesecake", "4000"),
(2, "Tiramisu", "5000"),
(3, "Brownie con helado", "3000"),
(4, "Helado Sundae", "3000"),
(5, "Crepas de Nutella", "4200");

create table menu (
id_menu INT PRIMARY KEY,
id_combos INT,
id_postres INT,
id_bebidas INT,
id_pizzas INT,
id_clientes INT,
foreign key (id_combos) references combos(id_combos),
foreign key (id_postres) references postres(id_postres),
foreign key (id_bebidas) references bebidas(id_bebidas),
foreign key (id_pizzas) references pizzas(id_pizzas),
foreign key (id_clientes) references clientes(id_clientes)
);

insert into menu(id_menu,id_combos,id_postres,id_bebidas,id_pizzas,id_clientes) values
("1","2","3","4","3","1"),
("2","1","2","3","2","2"),
("3","3","5","2","1","3"),
("4","5","1","4","5","4"),
("5","4","4","1","4","5");

create table populares (
id_populares INT PRIMARY KEY,
id_pizzas INT,
id_combos INT,
pedido VARCHAR(60),
cantidad INT(10),
foreign key (id_pizzas) references pizzas(id_pizzas),
foreign key (id_combos) references combos(id_combos)
);

insert into populares(id_populares,pedido,cantidad) values
("1","Pizza Vegetariana","4"),
("2","Pizza Cuatro Quesos","8"),
("3","Pizza BBQ de Pollo","6"),
("4","Pizza Pepperoni","4"),
("5","Brownie con helado","3"),
("6","CocaCola","15"),
("7","Crepas de Nutella","6");

create table pagos (
id_pagos INT PRIMARY KEY,
banco VARCHAR(30),
id_clientes INT,
foreign key (id_clientes) references clientes(id_clientes)
);

insert into pagos(id_pagos,id_clientes,banco) values 
("1","5","Bancolombia"),
("2","4","Daviplata"),
("3","3","PayPal"),
("4","2","Nequi"),
("5","1","Uala");

create table pedidos (
id_pedidos INT PRIMARY KEY,
cantidad INT(4),
id_pagos INT,
id_clientes INT,
descripcion VARCHAR(60),
foreign key (id_pagos) references pagos(id_pagos),
foreign key (id_clientes) references clientes(id_clientes)
);

insert into pedidos (id_pedidos, cantidad, id_pagos, id_clientes, descripcion) values
("1", "2", "1", "5", "Pedido de dos pizzas margarita"),
("2", "5", "2", "4", "Pedido de cinco Pizzas Vegetarianas"),
("3", "1", "3", "3", "Pedido de un combo Tiramisu"),
("4", "3", "4", "2", "Pedido de tres jugos hit"),
("5", "4", "5", "1", "Pedido de cuatro Pizzas Hawaianas");

-- drop table perzonalizadas;

create table perzonalizadas (
id_perzonalizadas INT PRIMARY KEY,
id_pizzas INT,
id_pedidos INT,
nombre VARCHAR(40),
descripcion VARCHAR(60),
lugar VARCHAR(20),
foreign key (id_pizzas) references pizzas(id_pizzas),
foreign key (id_pedidos) references pedidos(id_pedidos)
);

insert into perzonalizadas (id_perzonalizadas, id_pizzas, id_pedidos, nombre, descripcion, lugar) values
("1", "1", "4", "Pizza Vegetariana", "Pizza Vegetariana con extra champiñones", "domicilio"),
("2", "2", "1", "Pizza Cuatro Quesos", "Pizza Cuatro Quesos con borde de ajo", "domicilio"),
("3", "3", "2", "Pizza BBQ de Pollo", "Pizza BBQ de Pollo con cebolla caramelizada", "domicilio"),
("4", "4", "3", "Pizza Pepperoni", "Pizza Pepperoni extra crujiente", "local"),
("5", "5", "5", "Brownie con Helado", "Brownie con helado y chispas de chocolate", "local");

-- Productos más vendidos
select id_populares,pedido,cantidad from populares;
-- Total de ingresos generados por cada combo
select sum(precio) from combos;
-- Pedidos realizados para recoger vs. comer en la pizzería
select nombre,lugar from perzonalizadas;
-- Adiciones más solicitadas en pedidos personalizados
select id_pizzas,nombre,descripcion from perzonalizadas;
-- Cantidad total de productos vendidos por categoría

-- Promedio de pizzas pedidas por cliente

-- Total de ventas por día de la semana

-- Cantidad de panzarottis vendidos con extra queso|

-- Pedidos que incluyen bebidas como parte de un combo
select * from combos;
-- Clientes que han realizado más de 5 pedidos en el último mes

-- Ingresos totales generados por productos no elaborados

-- Promedio de adiciones por pedido

-- Total de combos vendidos en el último mes

-- Clientes con pedidos tanto para recoger como para consumir en el lugar
select id_pizzas,lugar from perzonalizadas inner join pedidos on  perzonalizadas.id_pedidos=pedidos.id_pedidos inner join clientes on pedidos.id_clientes=id_clientes;
-- Total de productos personalizados con adiciones
select * from perzonalizadas;
select * from pedidos;
select * from clientes;
-- Pedidos con más de 3 productos diferentes

-- Promedio de ingresos generados por día

-- Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos

-- Porcentaje de ventas provenientes de productos no elaborados

-- Día de la semana con mayor número de pedidos para recoger