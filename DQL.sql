-- DQL
-- CONSULTAS PARA LA PIZZERÍA
USE Pizzeria;

-- 1. Productos más vendidos (pizza, panzarottis, bebidas, etc.)
SELECT 
    p.nombre,
    p.categoria,
    SUM(pp.cantidad) as total_vendido
FROM Producto p
JOIN Producto_Pedido pp ON p.id = pp.Producto_id
GROUP BY p.id, p.nombre, p.categoria
ORDER BY total_vendido DESC;

-- 2. Total de ingresos generados por cada combo
SELECT 
    c.nombre,
    c.precio,
    SUM(cp.cantidad) as combos_vendidos,
    SUM(cp.cantidad * c.precio) as ingresos_totales
FROM Combo c
JOIN Combo_Pedido cp ON c.id = cp.Combo_id
GROUP BY c.id, c.nombre, c.precio
ORDER BY ingresos_totales DESC;

-- 4. Adiciones más solicitadas en pedidos personalizados
SELECT 
    a.nombre,
    SUM(ap.cantidad) as total_solicitado,
    COUNT(DISTINCT ap.Pedido_id) as pedidos_con_adicion
FROM Adicionales a
JOIN Adicionales_Pedido ap ON a.id = ap.Adicionales_id
GROUP BY a.id, a.nombre
ORDER BY total_solicitado DESC;

-- 5. Cantidad total de productos vendidos por categoría
SELECT 
    p.categoria,
    SUM(pp.cantidad) as total_vendido
FROM Producto p
JOIN Producto_Pedido pp ON p.id = pp.Producto_id
GROUP BY p.categoria
ORDER BY total_vendido DESC;

-- 6. Promedio de pizzas pedidas por cliente
SELECT 
    c.nombre,
    AVG(pp.cantidad) as promedio_pizzas
FROM Clientes c
JOIN Pedido pe ON c.id = pe.Clientes_id
JOIN Producto_Pedido pp ON pe.id = pp.Pedido_id
JOIN Producto p ON pp.Producto_id = p.id
WHERE p.categoria = 'Pizza'
GROUP BY c.id, c.nombre
ORDER BY promedio_pizzas DESC;

-- 7. Total de ventas por día de la semana
SELECT 
    DAYNAME(pe.fecha) as dia_semana,
    COUNT(pe.id) as total_pedidos,
    SUM(
        COALESCE((SELECT SUM(pp.cantidad * p.precio) 
                 FROM Producto_Pedido pp 
                 JOIN Producto p ON pp.Producto_id = p.id 
                 WHERE pp.Pedido_id = pe.id), 0) +
        COALESCE((SELECT SUM(cp.cantidad * c.precio)
                 FROM Combo_Pedido cp
                 JOIN Combo c ON cp.Combo_id = c.id
                 WHERE cp.Pedido_id = pe.id), 0) +
        COALESCE((SELECT SUM(ap.cantidad * a.precio)
                 FROM Adicionales_Pedido ap
                 JOIN Adicionales a ON ap.Adicionales_id = a.id
                 WHERE ap.Pedido_id = pe.id), 0)
    ) as ingresos_totales
FROM Pedido pe
GROUP BY DAYOFWEEK(pe.fecha), DAYNAME(pe.fecha)
ORDER BY DAYOFWEEK(pe.fecha);

-- 8. Cantidad de panzarottis vendidos con extra queso
SELECT 
    p.nombre as panzerotti,
    SUM(pp.cantidad) as cantidad_vendida
FROM Producto p
JOIN Producto_Pedido pp ON p.id = pp.Producto_id
JOIN Adicionales_Pedido ap ON pp.Pedido_id = ap.Pedido_id
JOIN Adicionales a ON ap.Adicionales_id = a.id
WHERE p.categoria = 'Panzerotti' AND a.nombre = 'Queso extra'
GROUP BY p.id, p.nombre;

-- 9. Pedidos que incluyen bebidas como parte de un combo
SELECT DISTINCT
    pe.id as pedido_id,
    pe.fecha,
    c.nombre as combo_nombre
FROM Pedido pe
JOIN Combo_Pedido cp ON pe.id = cp.Pedido_id
JOIN Combo c ON cp.Combo_id = c.id
JOIN Combo_Producto cpr ON c.id = cpr.Combo_id
JOIN Producto p ON cpr.Producto_id = p.id
WHERE p.categoria = 'Bebidas';

-- 10. Clientes que han realizado más de 5 pedidos en el último mes
SELECT 
    c.nombre,
    c.telefono,
    COUNT(pe.id) as total_pedidos
FROM Clientes c
JOIN Pedido pe ON c.id = pe.Clientes_id
WHERE pe.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id, c.nombre, c.telefono
HAVING COUNT(pe.id) > 5;

-- 11. Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)
SELECT 
    p.categoria,
    SUM(pp.cantidad * p.precio) as ingresos_totales
FROM Producto p
JOIN Producto_Pedido pp ON p.id = pp.Producto_id
WHERE p.elaborado = 'no'
GROUP BY p.categoria
ORDER BY ingresos_totales DESC;

-- 12. Promedio de adiciones por pedido
SELECT 
    AVG(total_adiciones) as promedio_adiciones_por_pedido
FROM (
    SELECT 
        pe.id,
        SUM(ap.cantidad) as total_adiciones
    FROM Pedido pe
    LEFT JOIN Adicionales_Pedido ap ON pe.id = ap.Pedido_id
    GROUP BY pe.id
) as subquery;

-- 13. Total de combos vendidos en el último mes
SELECT 
    c.nombre,
    SUM(cp.cantidad) as combos_vendidos
FROM Combo c
JOIN Combo_Pedido cp ON c.id = cp.Combo_id
JOIN Pedido pe ON cp.Pedido_id = pe.id
WHERE pe.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id, c.nombre
ORDER BY combos_vendidos DESC;

-- 15. Total de productos personalizados con adiciones
SELECT 
    COUNT(DISTINCT pp.Pedido_id) as pedidos_con_personalizacion,
    SUM(ap.cantidad) as total_adiciones
FROM Producto_Pedido pp
JOIN Adicionales_Pedido ap ON pp.Pedido_id = ap.Pedido_id;

-- 16. Pedidos con más de 3 productos diferentes
SELECT 
    pe.id as pedido_id,
    pe.fecha,
    COUNT(DISTINCT pp.Producto_id) as productos_diferentes
FROM Pedido pe
JOIN Producto_Pedido pp ON pe.id = pp.Pedido_id
GROUP BY pe.id, pe.fecha
HAVING COUNT(DISTINCT pp.Producto_id) > 3;

-- 17. Promedio de ingresos generados por día
SELECT 
    AVG(ingresos_diarios) as promedio_ingresos_dia
FROM (
    SELECT 
        DATE(pe.fecha) as fecha,
        SUM(
            COALESCE((SELECT SUM(pp.cantidad * p.precio) 
                     FROM Producto_Pedido pp 
                     JOIN Producto p ON pp.Producto_id = p.id 
                     WHERE pp.Pedido_id = pe.id), 0) +
            COALESCE((SELECT SUM(cp.cantidad * c.precio) 
                     FROM Combo_Pedido cp 
                     JOIN Combo c ON cp.Combo_id = c.id 
                     WHERE cp.Pedido_id = pe.id), 0) +
            COALESCE((SELECT SUM(ap.cantidad * a.precio) 
                     FROM Adicionales_Pedido ap 
                     JOIN Adicionales a ON ap.Adicionales_id = a.id 
                     WHERE ap.Pedido_id = pe.id), 0)
        ) as ingresos_diarios
    FROM Pedido pe
    GROUP BY DATE(pe.fecha)
) as subquery;

-- 18. Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
SELECT 
    c.nombre,
    total_pedidos_pizza,
    pedidos_pizza_con_adiciones,
    (pedidos_pizza_con_adiciones / total_pedidos_pizza * 100) as porcentaje
FROM (
    SELECT 
        c.id,
        c.nombre,
        COUNT(DISTINCT pe.id) as total_pedidos_pizza,
        COUNT(DISTINCT CASE WHEN ap.id IS NOT NULL THEN pe.id END) as pedidos_pizza_con_adiciones
    FROM Clientes c
    JOIN Pedido pe ON c.id = pe.Clientes_id
    JOIN Producto_Pedido pp ON pe.id = pp.Pedido_id
    JOIN Producto p ON pp.Producto_id = p.id
    LEFT JOIN Adicionales_Pedido ap ON pe.id = ap.Pedido_id
    WHERE p.categoria = 'Pizza'
    GROUP BY c.id, c.nombre
) as subquery
WHERE (pedidos_pizza_con_adiciones / total_pedidos_pizza * 100) > 50;

-- 19. Porcentaje de ventas provenientes de productos no elaborados
SELECT 
    (SUM(CASE WHEN p.elaborado = 'no' THEN pp.cantidad * p.precio ELSE 0 END) / 
     SUM(pp.cantidad * p.precio) * 100) as porcentaje_no_elaborados
FROM Producto_Pedido pp
JOIN Producto p ON pp.Producto_id = p.id;