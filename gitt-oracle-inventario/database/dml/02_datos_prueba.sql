-- Datos de prueba para Oracle

INSERT INTO ROL (id_rol, nombre_rol) VALUES (1, 'Administrador');
INSERT INTO ROL (id_rol, nombre_rol) VALUES (2, 'Responsable');
INSERT INTO ROL (id_rol, nombre_rol) VALUES (3, 'Docente');
INSERT INTO ROL (id_rol, nombre_rol) VALUES (4, 'Estudiante');

INSERT INTO USUARIO (id_usuario, nombre, correo, contrasena, id_rol) VALUES (1, 'Administrador FISEI', 'admin@fisei.edu.ec', 'Admin123*', 1);
INSERT INTO USUARIO (id_usuario, nombre, correo, contrasena, id_rol) VALUES (2, 'Responsable Laboratorio', 'responsable@fisei.edu.ec', 'Resp123*', 2);
INSERT INTO USUARIO (id_usuario, nombre, correo, contrasena, id_rol) VALUES (3, 'Docente Sistemas', 'docente@fisei.edu.ec', 'Docente123*', 3);
INSERT INTO USUARIO (id_usuario, nombre, correo, contrasena, id_rol) VALUES (4, 'Estudiante Software', 'estudiante@fisei.edu.ec', 'Estudiante123*', 4);

INSERT INTO DEPARTAMENTO (id_departamento, nombre) VALUES (1, 'Laboratorios FISEI');
INSERT INTO DEPARTAMENTO (id_departamento, nombre) VALUES (2, 'Aulas');
INSERT INTO DEPARTAMENTO (id_departamento, nombre) VALUES (3, 'Administracion');

INSERT INTO UBICACION (id_ubicacion, nombre, id_departamento) VALUES (1, 'Laboratorio 1', 1);
INSERT INTO UBICACION (id_ubicacion, nombre, id_departamento) VALUES (2, 'Laboratorio 2', 1);
INSERT INTO UBICACION (id_ubicacion, nombre, id_departamento) VALUES (3, 'Aula 401', 2);
INSERT INTO UBICACION (id_ubicacion, nombre, id_departamento) VALUES (4, 'Bodega Tecnologica', 3);

INSERT INTO CATEGORIA (id_categoria, nombre) VALUES (1, 'Computadores');
INSERT INTO CATEGORIA (id_categoria, nombre) VALUES (2, 'Proyectores');
INSERT INTO CATEGORIA (id_categoria, nombre) VALUES (3, 'Redes');
INSERT INTO CATEGORIA (id_categoria, nombre) VALUES (4, 'Impresion');
INSERT INTO CATEGORIA (id_categoria, nombre) VALUES (5, 'Audio y Video');

INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (1, 'Laptop Dell Latitude', 'DISPONIBLE', 'FISEI-LAP-001', 1, 1, 2, 950.00, 'Equipo portatil para docencia.');
INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (2, 'Proyector Epson X49', 'DISPONIBLE', 'FISEI-PRO-001', 2, 3, 2, 680.00, 'Proyector para aulas.');
INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (3, 'Switch Cisco 24P', 'DISPONIBLE', 'FISEI-RED-001', 3, 2, 2, 420.00, 'Switch de laboratorio.');
INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (4, 'Impresora HP LaserJet', 'MANTENIMIENTO', 'FISEI-IMP-001', 4, 4, 2, 540.00, 'Impresora en revision.');
INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (5, 'Tablet Android', 'BAJA', 'FISEI-TAB-001', 1, 4, NULL, 300.00, 'Equipo dado de baja.');
INSERT INTO ARTICULO (id_articulo, nombre, estado, codigo, id_categoria, id_ubicacion, id_responsable, valor_estimado, descripcion) VALUES (6, 'Camara Logitech', 'DISPONIBLE', 'FISEI-VID-001', 5, 1, 2, 180.00, 'Camara para videoconferencia.');

INSERT INTO IMAGEN_ARTICULO (id_imagen, id_articulo, url_imagen, descripcion, es_principal) VALUES (1, 1, 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853', 'Imagen referencial de laptop', 'S');
INSERT INTO IMAGEN_ARTICULO (id_imagen, id_articulo, url_imagen, descripcion, es_principal) VALUES (2, 2, 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3', 'Imagen referencial de proyector', 'S');
INSERT INTO IMAGEN_ARTICULO (id_imagen, id_articulo, url_imagen, descripcion, es_principal) VALUES (3, 3, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31', 'Imagen referencial de equipos de red', 'S');

INSERT INTO PRESTAMO (id_prestamo, fecha_prestamo, fecha_devolucion, id_usuario, estado, observacion) VALUES (1, SYSDATE - 1, SYSDATE + 5, 3, 'ACTIVO', 'Prestamo para clase practica.');
INSERT INTO PRESTAMO (id_prestamo, fecha_prestamo, fecha_devolucion, id_usuario, estado, observacion) VALUES (2, SYSDATE - 10, SYSDATE - 2, 4, 'DEVUELTO', 'Prestamo finalizado.');
INSERT INTO PRESTAMO (id_prestamo, fecha_prestamo, fecha_devolucion, id_usuario, estado, observacion) VALUES (3, SYSDATE - 7, SYSDATE - 1, 3, 'ACTIVO', 'Prestamo vencido pendiente de devolucion.');

INSERT INTO DETALLE_PRESTAMO (id_detalle, id_prestamo, id_articulo) VALUES (1, 1, 1);
INSERT INTO DETALLE_PRESTAMO (id_detalle, id_prestamo, id_articulo) VALUES (2, 1, 2);
INSERT INTO DETALLE_PRESTAMO (id_detalle, id_prestamo, id_articulo) VALUES (3, 2, 3);
INSERT INTO DETALLE_PRESTAMO (id_detalle, id_prestamo, id_articulo) VALUES (4, 3, 6);

INSERT INTO MANTENIMIENTO (id_mantenimiento, tipo, fecha, id_articulo, estado, observacion) VALUES (1, 'PREVENTIVO', SYSDATE + 3, 4, 'PENDIENTE', 'Revision de toner y fusor.');
INSERT INTO MANTENIMIENTO (id_mantenimiento, tipo, fecha, id_articulo, estado, observacion) VALUES (2, 'CORRECTIVO', SYSDATE - 4, 3, 'FINALIZADO', 'Cambio de fuente de poder.');

INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (1, SYSDATE - 30, 'INGRESO', 1, 'Ingreso inicial al inventario.');
INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (2, SYSDATE - 29, 'INGRESO', 2, 'Ingreso inicial al inventario.');
INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (3, SYSDATE - 1, 'PRESTAMO', 1, 'Prestamo registrado.');
INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (4, SYSDATE - 1, 'PRESTAMO', 2, 'Prestamo registrado.');
INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (5, SYSDATE - 4, 'MANTENIMIENTO', 4, 'Articulo enviado a mantenimiento.');
INSERT INTO MOVIMIENTO (id_movimiento, fecha, tipo, id_articulo, observacion) VALUES (6, SYSDATE - 7, 'PRESTAMO', 6, 'Prestamo vencido.');

INSERT INTO NOTIFICACION (id_notificacion, mensaje, estado, id_prestamo) VALUES (1, 'Prestamo 1 proximo a devolucion.', 'PENDIENTE', 1);
INSERT INTO NOTIFICACION (id_notificacion, mensaje, estado, id_prestamo) VALUES (2, 'Prestamo 3 vencido.', 'ENVIADA', 3);
INSERT INTO NOTIFICACION (id_notificacion, mensaje, estado, id_prestamo) VALUES (3, 'Prestamo 2 fue devuelto.', 'LEIDA', 2);

INSERT INTO AUDITORIA (id_auditoria, accion, fecha, id_usuario, tabla, descripcion) VALUES (1, 'LOGIN', SYSDATE - 2, 1, 'USUARIO', 'Ingreso administrativo.');
INSERT INTO AUDITORIA (id_auditoria, accion, fecha, id_usuario, tabla, descripcion) VALUES (2, 'PRESTAMO', SYSDATE - 1, 3, 'PRESTAMO', 'Registro de prestamo 1.');
INSERT INTO AUDITORIA (id_auditoria, accion, fecha, id_usuario, tabla, descripcion) VALUES (3, 'DEVOLUCION', SYSDATE - 2, 4, 'PRESTAMO', 'Devolucion del prestamo 2.');

COMMIT;
