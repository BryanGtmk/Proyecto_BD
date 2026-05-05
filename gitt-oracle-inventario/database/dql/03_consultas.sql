-- Q1. Listar articulos disponibles con ubicacion y responsable.
SELECT a.id_articulo, a.codigo, a.nombre, u.nombre AS ubicacion, d.nombre AS departamento, r.nombre AS responsable
FROM ARTICULO a
JOIN UBICACION u ON u.id_ubicacion = a.id_ubicacion
JOIN DEPARTAMENTO d ON d.id_departamento = u.id_departamento
LEFT JOIN USUARIO r ON r.id_usuario = a.id_responsable
WHERE a.estado = 'DISPONIBLE'
ORDER BY a.nombre;

-- Q2. Obtener total de articulos por categoria.
SELECT c.nombre AS categoria, COUNT(a.id_articulo) AS total_articulos
FROM CATEGORIA c
LEFT JOIN ARTICULO a ON a.id_categoria = c.id_categoria
GROUP BY c.nombre
ORDER BY c.nombre;

-- Q3. Mostrar prestamos activos y fecha de devolucion.
SELECT p.id_prestamo, u.nombre AS usuario, p.fecha_prestamo, p.fecha_devolucion, p.estado
FROM PRESTAMO p
JOIN USUARIO u ON u.id_usuario = p.id_usuario
WHERE p.estado = 'ACTIVO'
ORDER BY p.fecha_devolucion;

-- Q4. Mostrar articulos con mantenimiento pendiente.
SELECT a.codigo, a.nombre AS articulo, m.tipo, m.fecha, m.estado, m.observacion
FROM MANTENIMIENTO m
JOIN ARTICULO a ON a.id_articulo = m.id_articulo
WHERE m.estado = 'PENDIENTE'
ORDER BY m.fecha;

-- Q5. Mostrar movimientos por articulo.
SELECT a.codigo, a.nombre AS articulo, mo.fecha, mo.tipo, mo.observacion
FROM MOVIMIENTO mo
JOIN ARTICULO a ON a.id_articulo = mo.id_articulo
ORDER BY a.codigo, mo.fecha DESC;

-- Q6. Mostrar notificaciones por prestamo.
SELECT p.id_prestamo, n.mensaje, n.estado, n.fecha_creacion
FROM NOTIFICACION n
JOIN PRESTAMO p ON p.id_prestamo = n.id_prestamo
ORDER BY p.id_prestamo, n.fecha_creacion DESC;

-- Q7. Mostrar auditoria por usuario.
SELECT u.nombre AS usuario, au.accion, au.fecha, au.tabla, au.descripcion
FROM AUDITORIA au
JOIN USUARIO u ON u.id_usuario = au.id_usuario
ORDER BY au.fecha DESC;

-- Q8. Mostrar articulos por departamento.
SELECT d.nombre AS departamento, a.codigo, a.nombre AS articulo, a.estado
FROM ARTICULO a
JOIN UBICACION u ON u.id_ubicacion = a.id_ubicacion
JOIN DEPARTAMENTO d ON d.id_departamento = u.id_departamento
ORDER BY d.nombre, a.nombre;

-- Q9. Mostrar historial completo de un prestamo.
SELECT p.id_prestamo, us.nombre AS usuario, a.codigo, a.nombre AS articulo, p.fecha_prestamo, p.fecha_devolucion, p.estado AS estado_prestamo, a.estado AS estado_articulo
FROM PRESTAMO p
JOIN USUARIO us ON us.id_usuario = p.id_usuario
JOIN DETALLE_PRESTAMO dp ON dp.id_prestamo = p.id_prestamo
JOIN ARTICULO a ON a.id_articulo = dp.id_articulo
ORDER BY p.id_prestamo, a.codigo;

-- Q10. Mostrar articulos prestados actualmente.
SELECT a.codigo, a.nombre AS articulo, p.id_prestamo, u.nombre AS usuario, p.fecha_devolucion
FROM ARTICULO a
JOIN DETALLE_PRESTAMO dp ON dp.id_articulo = a.id_articulo
JOIN PRESTAMO p ON p.id_prestamo = dp.id_prestamo
JOIN USUARIO u ON u.id_usuario = p.id_usuario
WHERE p.estado = 'ACTIVO'
ORDER BY p.fecha_devolucion;

-- Q11. Mostrar usuarios por rol.
SELECT r.nombre_rol, u.nombre, u.correo
FROM ROL r
LEFT JOIN USUARIO u ON u.id_rol = r.id_rol
ORDER BY r.nombre_rol, u.nombre;

-- Q12. Mostrar prestamos vencidos.
SELECT p.id_prestamo, u.nombre AS usuario, p.fecha_prestamo, p.fecha_devolucion, p.estado
FROM PRESTAMO p
JOIN USUARIO u ON u.id_usuario = p.id_usuario
WHERE p.estado = 'ACTIVO'
  AND p.fecha_devolucion < TRUNC(SYSDATE)
ORDER BY p.fecha_devolucion;

-- Q13. Calcular el valor total del inventario por departamento.
SELECT d.nombre AS departamento, COUNT(a.id_articulo) AS total_articulos, SUM(a.valor_estimado) AS valor_total
FROM DEPARTAMENTO d
JOIN UBICACION u ON u.id_departamento = d.id_departamento
JOIN ARTICULO a ON a.id_ubicacion = u.id_ubicacion
GROUP BY d.nombre
ORDER BY valor_total DESC;

-- Q14. Listar movimientos realizados por rango de fechas.
SELECT mo.id_movimiento, a.codigo, a.nombre AS articulo, mo.fecha, mo.tipo, mo.observacion
FROM MOVIMIENTO mo
JOIN ARTICULO a ON a.id_articulo = mo.id_articulo
WHERE mo.fecha BETWEEN TRUNC(SYSDATE) - 30 AND TRUNC(SYSDATE) + 1
ORDER BY mo.fecha DESC, a.codigo;
