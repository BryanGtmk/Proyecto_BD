-- ============================================================================
-- ARCHIVO: queries.sql
-- PROPÓSITO: Consultas SQL principales del sistema
-- INSTRUCCIONES:
--   Esta archivo contendrá todas las consultas documentadas en main.tex
--   Cada sección debe estar comentada y numerada para fácil referencia
-- ============================================================================

-- ============================================================================
-- SECCIÓN 1: CONSULTAS DE SELECCIÓN (SELECT)
-- ============================================================================

-- QUERY 1.1: Obtener todos los usuarios activos
SELECT usuario_id, nombre, apellido, email, fecha_creacion
FROM usuarios
WHERE activo = TRUE
ORDER BY fecha_creacion DESC;

-- QUERY 1.2: Obtener productos con stock disponible
SELECT producto_id, nombre, precio, stock, categoria_id
FROM productos
WHERE stock > 0
ORDER BY nombre ASC;

-- QUERY 1.3: Obtener productos por categoría
SELECT 
    p.producto_id,
    p.nombre,
    p.descripcion,
    p.precio,
    p.stock,
    c.nombre AS nombre_categoria
FROM productos p
INNER JOIN categorias c ON p.categoria_id = c.categoria_id
WHERE c.nombre = 'Electrónica'
ORDER BY p.precio DESC;

-- QUERY 1.4: Resumen de pedidos por usuario
SELECT 
    u.usuario_id,
    u.nombre,
    u.apellido,
    COUNT(p.pedido_id) AS total_pedidos,
    SUM(p.total) AS monto_total
FROM usuarios u
LEFT JOIN pedidos p ON u.usuario_id = p.usuario_id
GROUP BY u.usuario_id, u.nombre, u.apellido
HAVING COUNT(p.pedido_id) > 0
ORDER BY monto_total DESC;

-- QUERY 1.5: Detalles de un pedido específico
SELECT 
    p.pedido_id,
    p.fecha_pedido,
    dp.producto_id,
    pr.nombre,
    dp.cantidad,
    dp.precio_unitario,
    dp.subtotal,
    (SELECT SUM(subtotal) FROM detalles_pedido WHERE pedido_id = p.pedido_id) AS total_pedido
FROM pedidos p
INNER JOIN detalles_pedido dp ON p.pedido_id = dp.pedido_id
INNER JOIN productos pr ON dp.producto_id = pr.producto_id
WHERE p.pedido_id = 1;

-- QUERY 1.6: Productos que están cerca de agotarse
SELECT producto_id, nombre, stock, categoria_id
FROM productos
WHERE stock < 10 AND stock > 0
ORDER BY stock ASC;

-- QUERY 1.7: Productos sin stock
SELECT producto_id, nombre, stock, categoria_id
FROM productos
WHERE stock = 0
ORDER BY nombre ASC;

-- QUERY 1.8: Top 5 productos más vendidos
SELECT 
    pr.producto_id,
    pr.nombre,
    SUM(dp.cantidad) AS cantidad_vendida,
    SUM(dp.subtotal) AS ingresos_totales,
    ROUND(SUM(dp.subtotal) / SUM(dp.cantidad), 2) AS precio_promedio
FROM productos pr
INNER JOIN detalles_pedido dp ON pr.producto_id = dp.producto_id
INNER JOIN pedidos p ON dp.pedido_id = p.pedido_id
WHERE p.estado IN ('entregado', 'enviado')
GROUP BY pr.producto_id, pr.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

-- QUERY 1.9: Categorías con más productos
SELECT 
    c.categoria_id,
    c.nombre,
    COUNT(p.producto_id) AS cantidad_productos,
    AVG(p.precio) AS precio_promedio
FROM categorias c
LEFT JOIN productos p ON c.categoria_id = p.categoria_id
GROUP BY c.categoria_id, c.nombre
ORDER BY cantidad_productos DESC;

-- ============================================================================
-- SECCIÓN 2: CONSULTAS DE INSERCIÓN (INSERT)
-- ============================================================================

-- QUERY 2.1: Insertar nuevo usuario
INSERT INTO usuarios (nombre, apellido, email, activo)
VALUES ('Juan', 'García', 'juan.garcia@example.com', TRUE);

-- QUERY 2.2: Insertar nueva categoría
INSERT INTO categorias (nombre, descripcion)
VALUES ('Accesorios', 'Accesorios para dispositivos electrónicos');

-- QUERY 2.3: Insertar nuevo producto
INSERT INTO productos (nombre, descripcion, precio, stock, categoria_id)
VALUES ('Funda para Laptop', 'Funda resistente para laptop de 15 pulgadas', 29.99, 20, 1);

-- QUERY 2.4: Insertar nuevo pedido
INSERT INTO pedidos (usuario_id, total, estado)
VALUES (1, 0.00, 'pendiente');

-- QUERY 2.5: Insertar detalle de pedido
INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
VALUES (1, 5, 2, 12.99, 25.98);

-- ============================================================================
-- SECCIÓN 3: CONSULTAS DE ACTUALIZACIÓN (UPDATE)
-- ============================================================================

-- QUERY 3.1: Actualizar stock después de una venta
UPDATE productos
SET stock = stock - 1
WHERE producto_id = 5 AND stock > 0;

-- QUERY 3.2: Actualizar estado de un pedido
UPDATE pedidos
SET estado = 'entregado'
WHERE pedido_id = 1;

-- QUERY 3.3: Cambiar precio de un producto
UPDATE productos
SET precio = precio * 1.10
WHERE categoria_id = 1;

-- QUERY 3.4: Desactivar usuario
UPDATE usuarios
SET activo = FALSE
WHERE usuario_id = 999;

-- QUERY 3.5: Actualizar descripción de categoría
UPDATE categorias
SET descripcion = 'Productos electrónicos de última generación'
WHERE categoria_id = 1;

-- ============================================================================
-- SECCIÓN 4: CONSULTAS DE ELIMINACIÓN (DELETE)
-- ============================================================================

-- QUERY 4.1: Eliminar producto específico (con precaución)
DELETE FROM productos
WHERE producto_id = 999
AND producto_id NOT IN (SELECT producto_id FROM detalles_pedido);

-- QUERY 4.2: Eliminar pedido pendiente (cascada a detalles)
DELETE FROM pedidos
WHERE pedido_id = 999 AND estado = 'pendiente';

-- QUERY 4.3: Eliminar usuarios inactivos (muy restrictivo)
DELETE FROM usuarios
WHERE activo = FALSE
AND fecha_ultimo_acceso < DATE_SUB(NOW(), INTERVAL 1 YEAR)
AND usuario_id NOT IN (SELECT usuario_id FROM pedidos);

-- ============================================================================
-- SECCIÓN 5: CONSULTAS CON TRANSACCIONES (TRANSACTIONS)
-- ============================================================================

-- QUERY 5.1: Crear pedido con validación de stock
START TRANSACTION;

SET @usuario_id = 1;
SET @producto_id = 5;
SET @cantidad = 2;

-- Verificar que el usuario existe
IF NOT EXISTS (SELECT 1 FROM usuarios WHERE usuario_id = @usuario_id) THEN
    ROLLBACK;
    SELECT 'Error: Usuario no existe' AS Mensaje;
ELSE
    -- Verificar que el producto existe y hay stock
    IF NOT EXISTS (SELECT 1 FROM productos WHERE producto_id = @producto_id AND stock >= @cantidad) THEN
        ROLLBACK;
        SELECT 'Error: Stock insuficiente' AS Mensaje;
    ELSE
        -- Crear el nuevo pedido
        INSERT INTO pedidos (usuario_id, total, estado)
        VALUES (@usuario_id, 0, 'pendiente');
        
        SET @pedido_id = LAST_INSERT_ID();
        
        -- Obtener precio del producto
        SELECT precio INTO @precio_unitario FROM productos WHERE producto_id = @producto_id;
        
        -- Insertar detalle del pedido
        INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
        VALUES (@pedido_id, @producto_id, @cantidad, @precio_unitario, @cantidad * @precio_unitario);
        
        -- Actualizar stock
        UPDATE productos
        SET stock = stock - @cantidad
        WHERE producto_id = @producto_id;
        
        -- Actualizar total del pedido
        UPDATE pedidos
        SET total = (SELECT SUM(subtotal) FROM detalles_pedido WHERE pedido_id = @pedido_id)
        WHERE pedido_id = @pedido_id;
        
        COMMIT;
        SELECT CONCAT('Pedido creado: ', @pedido_id) AS Mensaje;
    END IF;
END IF;

-- ============================================================================
-- SECCIÓN 6: CONSULTAS CON SUBCONSULTAS (SUBQUERIES)
-- ============================================================================

-- QUERY 6.1: Usuarios que han realizado compras mayores a X cantidad
SELECT 
    usuario_id,
    nombre,
    apellido,
    (SELECT COUNT(*) FROM pedidos WHERE pedidos.usuario_id = usuarios.usuario_id) AS pedidos_realizados,
    (SELECT SUM(total) FROM pedidos WHERE pedidos.usuario_id = usuarios.usuario_id) AS gasto_total
FROM usuarios
WHERE usuario_id IN (
    SELECT usuario_id FROM pedidos 
    GROUP BY usuario_id 
    HAVING SUM(total) > 100
);

-- QUERY 6.2: Productos en categorías populares
SELECT DISTINCT producto_id, nombre, precio
FROM productos
WHERE categoria_id IN (
    SELECT categoria_id FROM categorias 
    WHERE categoria_id IN (
        SELECT categoria_id FROM productos 
        GROUP BY categoria_id 
        HAVING COUNT(*) > 5
    )
);

-- ============================================================================
-- SECCIÓN 7: CONSULTAS CON FUNCIONES DE AGREGACIÓN
-- ============================================================================

-- QUERY 7.1: Estadísticas generales
SELECT 
    (SELECT COUNT(*) FROM usuarios WHERE activo = TRUE) AS usuarios_activos,
    (SELECT COUNT(*) FROM productos WHERE stock > 0) AS productos_disponibles,
    (SELECT COUNT(*) FROM pedidos WHERE estado = 'pendiente') AS pedidos_pendientes,
    (SELECT SUM(total) FROM pedidos WHERE estado = 'entregado') AS ingresos_totales;

-- QUERY 7.2: Análisis de inventario
SELECT 
    categoria_id,
    COUNT(*) AS cantidad_productos,
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    SUM(stock) AS stock_total
FROM productos
GROUP BY categoria_id;

-- ============================================================================
-- FIN DEL ARCHIVO
-- ============================================================================
-- Historial de versiones:
-- v1.0 - 04/03/2026 - Creación inicial con consultas básicas (7 secciones)
-- Agregar nuevas consultas cuando nuevas funcionalidades sean implementadas
-- ============================================================================
