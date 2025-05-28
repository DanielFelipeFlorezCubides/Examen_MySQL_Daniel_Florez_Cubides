-- DML
-- Tabla Clientes
use Pizzeria;

INSERT INTO Clientes (id, nombre, telefono) VALUES
(1, 'Carlos Pérez', '5551234567'),
(2, 'Ana Gómez', '5559876543'),
(3, 'Luis Torres', '5556789123'),
(4, 'Marta Ruiz', '5554567890'),
(5, 'Pedro Díaz', '5553216547');

-- Tabla Producto
INSERT INTO Producto (id, nombre, precio, categoria, elaborado, disponible) VALUES
(1, 'Pizza Hawaiana', 5000, 'Pizza', 'si', 'si'),
(2, 'Panzerotti de Queso', 5500, 'Panzerotti', 'si', 'no'),
(3, 'Gaseosa', 3000, 'Bebidas', 'no', 'no'),
(4, 'Postre de Chocolate', 4000, 'Postres', 'si', 'no'),
(5, 'Pizza Margarita', 5200, 'Pizza', 'si', 'si');

-- Tabla Ingredientes
INSERT INTO Ingredientes (nombre, cantidad) VALUES
('Queso', '200g'),
('Jamón', '100g'),
('Piña', '50g'),
('Salsa de tomate', '150g'),
('Masa', '1ud');

-- Tabla Ingredientes_Producto
INSERT INTO Ingredientes_Producto (id, Ingredientes_id, Producto_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

-- Tabla Adicionales
INSERT INTO Adicionales (id, nombre, precio) VALUES
(1, 'Queso extra', 1000),
(2, 'Tocineta', 1500),
(3, 'Salsa BBQ', 800),
(4, 'Jalapeños', 700),
(5, 'Guacamole', 1200);

-- Tabla Combo
INSERT INTO Combo (id, nombre, descripcion, precio) VALUES
(1, 'Combo Clásico', 'Hamburguesa con papas y bebida', 9500),
(2, 'Combo Vegetariano', 'Ensalada y bebida', 6000),
(3, 'Combo Pizza', 'Pizza y bebida', 9000),
(4, 'Combo Doble', '2 Hamburguesas y papas', 12000),
(5, 'Combo Familiar', 'Pizza, papas y 2 bebidas', 15000);

-- Tabla Combo_Producto
INSERT INTO Combo_Producto (id, Combo_id, Producto_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 5, 1),
(5, 3, 4, 1);

-- Tabla Pedido
INSERT INTO Pedido (id, fecha, metodo_pago, Clientes_id) VALUES
(1, '2025-05-27 13:00:00', 'Efectivo', 1),
(2, '2025-05-27 14:30:00', 'Tarjeta credito', 2),
(3, '2025-05-27 15:15:00', 'Efectivo', 3),
(4, '2025-05-27 16:00:00', 'Tarjeta credito', 4),
(5, '2025-05-27 17:45:00', 'Efectivo', 5);

-- Tabla Producto_Pedido
INSERT INTO Producto_Pedido (id, Producto_id, Pedido_id, cantidad) VALUES
(1, 1, 1, 2),
(2, 2, 2, 1),
(3, 3, 3, 2),
(4, 5, 4, 1),
(5, 4, 5, 1);

-- Tabla Combo_Pedido
INSERT INTO Combo_Pedido (id, Combo_id, Pedido_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 1),
(4, 4, 4, 2),
(5, 5, 5, 1);

-- Tabla Adicionales_Pedido
INSERT INTO Adicionales_Pedido (id, Adicionales_id, Pedido_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 2),
(4, 4, 4, 1),
(5, 5, 5, 1);