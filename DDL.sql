-- DDL
drop database if exists pizzeria;
create database if not exists pizzeria;

use pizzeria;

create table Pizza(
	id int auto_increment primary key,
	pizza varchar(50),
    precio int
);

create table Panzerotti(
	id int auto_increment primary key,
    panzerotti varchar(50),
    precio int
);

create table Bebidas(
	id int auto_increment primary key,
    bebida varchar(50),
    precio int
);

create table Postres(
	id int auto_increment primary key,
    postre varchar(50),
    precio int
);

create table Productos(
	id int auto_increment primary key,
	foreign key (id_pizza) references Pizza,
    foreign key (id_panzerotti) references Panzerotti,
    foreign key (id_bebida) references Bebidas,
    foreign key (id_postre) references Postres
);

create table Combos(
	id int auto_increment primary key,
    pizza_x2 varchar(50),
    pizza_x3_1_ingrediente varchar(50),
    pizza_bebida varchar(50),
    pizza_panzerotti varchar(50),
    pizza_postre varchar(50),
    precio int
);

create table Adiciones(
	id int auto_increment primary key,
    queso varchar(15),
    peperoni varchar(15),
    champiniones varchar(15),
    pinia varchar(15),
    salami varchar(15),
    pimientos varchar(15),
    carne_res varchar(15),
    salsas varchar(30),
    precio int
);

create table menu(
	id int auto_increment primary key,
    foreign key (id_productos) references Productos,
    foreign key (id_combos) references Combos
);

create table pedido(
	id int auto_increment primary key,
    descripcion varchar(500),
    consumo_en_local boolean,
    foreign key (id_productos) references Productos,
    foreign key (id_combos) references Combos,
    foreign key (id_adiciones) references Adiciones
);

create table Entrega_Pedido(
	id int auto_increment primary key,
    nombre varchar(20),
    telefono varchar(15),
    direccion varchar(100),
    foreign key (id_pedido) references Pedido
);

create table Factura(
	id int auto_increment primary key,
    descripcion varchar(500),
    total int,
    foreign key (id_pedido) references Pedido,
    foreign key (id_entrega_pedido) references Entrega_Pedido
);