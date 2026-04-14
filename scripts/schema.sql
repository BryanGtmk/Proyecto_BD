-- ============================================================================
-- PROYECTO: Base de Datos Académica
-- PROPÓSITO: Script de creación del esquema inicial
-- INSTRUCCIONES PARA COLABORADORES:
--   1. Este archivo contiene la estructura base de la BD
--   2. Cada sección está comentada para indicar dónde agregar nuevas tablas
--   3. Respeta la nomenclatura: tablas en minúscula, campos con guiones bajos
--   4. Siempre usa INT para IDs y TIMESTAMP para fechas
--   5. Documenta la relación entre tablas con comentarios
-- ============================================================================

-- ============================================================================
-- SECCIÓN 1: TABLAS PRINCIPALES
-- RESPONSABLE: [Ingrese su nombre]
-- ============================================================================

-- Tabla: usuarios
-- Descripción: Almacena información de los usuarios del sistema
-- Claves: usuario_id (PK)
CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    
    -- Índices para optimizar búsquedas
    INDEX idx_email (email),
    INDEX idx_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Tabla de usuarios registrados en el sistema';

-- Tabla: categorias
-- Descripción: Categorías de productos
-- Claves: categoria_id (PK)
CREATE TABLE categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Categorías de productos';

-- Tabla: productos
-- Descripción: Inventario de productos
-- Claves: producto_id (PK), categoria_id (FK -> categorias)
CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Definición de clave foránea
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Índices para optimizar búsquedas
    INDEX idx_nombre (nombre),
    INDEX idx_categoria (categoria_id),
    INDEX idx_precio (precio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Productos disponibles en el inventario';

-- ============================================================================
-- SECCIÓN 2: TABLAS DE TRANSACCIONES
-- RESPONSABLE: [Ingrese su nombre]
-- ============================================================================

-- Tabla: pedidos
-- Descripción: Registro de pedidos realizados por usuarios
-- Claves: pedido_id (PK), usuario_id (FK -> usuarios)
CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12, 2) NOT NULL,
    estado ENUM('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado') 
        DEFAULT 'pendiente',
    
    -- Definición de clave foránea
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Índices
    INDEX idx_usuario (usuario_id),
    INDEX idx_fecha (fecha_pedido),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Pedidos realizados en el sistema';

-- Tabla: detalles_pedido
-- Descripción: Detalles de líneas de items en cada pedido
-- Claves: detalles_pedido_id (PK), pedido_id (FK -> pedidos), producto_id (FK -> productos)
-- Nota: Esta es una tabla de relación N:M entre pedidos y productos
CREATE TABLE detalles_pedido (
    detalles_pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    
    -- Claves foráneas
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Índices
    INDEX idx_pedido (pedido_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Detalles de productos en cada pedido (relación N:M)';

-- ============================================================================
-- SECCIÓN 3: TABLAS DE AUDITORÍA (OPCIONAL)
-- RESPONSABLE: [Ingrese su nombre]
-- Descripción: Registra cambios en tablas críticas para auditoría
-- ============================================================================

-- Tabla: auditoria_usuarios
-- Descripción: Registra cambios en la tabla usuarios (INSERT, UPDATE, DELETE)
CREATE TABLE auditoria_usuarios (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    datos_anteriores JSON,
    datos_nuevos JSON,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_responsable VARCHAR(100),
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_fecha (fecha_cambio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Auditoría de cambios en usuarios';

-- ============================================================================
-- SECCIÓN 4: DATOS DE PRUEBA (TEST DATA)
-- RESPONSABLE: [Ingrese su nombre]
-- Instrucciones: Descomentar para insertar datos de prueba
-- ============================================================================

-- Insertar categorías de prueba
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Productos electrónicos y gadgets'),
('Ropa', 'Prendas de vestir para hombre y mujer'),
('Libros', 'Libros impresos y digitales');

-- Insertar usuarios de prueba
INSERT INTO usuarios (nombre, apellido, email) VALUES
('Juan', 'García', 'juan.garcia@example.com'),
('María', 'López', 'maria.lopez@example.com'),
('Carlos', 'Martínez', 'carlos.martinez@example.com');

-- Insertar productos de prueba
INSERT INTO productos (nombre, descripcion, precio, stock, categoria_id) VALUES
('Laptop HP i7', 'Laptop de 15 pulgadas con procesador Intel i7', 899.99, 5, 1),
('Mouse inalámbrico', 'Mouse USB inalámbrico de 2.4GHz', 19.99, 50, 1),
('Camiseta básica', 'Camiseta de algodón 100% para hombre', 14.99, 100, 2),
('Pantalón Jean', 'Pantalón jean azul de corte recto', 39.99, 40, 2),
('El Quijote', 'Novela clásica de Miguel de Cervantes', 12.99, 30, 3);

-- Insertar pedidos de prueba
INSERT INTO pedidos (usuario_id, total, estado) VALUES
(1, 919.98, 'entregado'),
(2, 54.98, 'procesando'),
(3, 12.99, 'pendiente');

-- Insertar detalles de pedidos de prueba
INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 899.99, 899.99),
(1, 2, 1, 19.99, 19.99),
(2, 3, 2, 14.99, 29.98),
(2, 4, 1, 39.99, 39.99),
(3, 5, 1, 12.99, 12.99);

-- ============================================================================
-- SECCIÓN 5: VISTAS (VIEWS)
-- RESPONSABLE: [Ingrese su nombre]
-- Descripción: Vistas útiles para consultas comunes
-- ============================================================================

-- Vista: resumen_pedidos
-- Propósito: Obtener resumen de pedidos con información del usuario
CREATE OR REPLACE VIEW resumen_pedidos AS
SELECT 
    p.pedido_id,
    p.fecha_pedido,
    u.nombre,
    u.apellido,
    u.email,
    p.total,
    p.estado,
    COUNT(dp.detalles_pedido_id) AS cantidad_items
FROM pedidos p
INNER JOIN usuarios u ON p.usuario_id = u.usuario_id
LEFT JOIN detalles_pedido dp ON p.pedido_id = dp.pedido_id
GROUP BY p.pedido_id, p.fecha_pedido, u.nombre, u.apellido, u.email, p.total, p.estado;

-- Vista: inventario_bajo
-- Propósito: Identificar productos con bajo stock
CREATE OR REPLACE VIEW inventario_bajo AS
SELECT 
    producto_id,
    nombre,
    stock,
    categoria_id,
    CASE 
        WHEN stock = 0 THEN 'Sin stock'
        WHEN stock < 10 THEN 'Stock bajo'
        ELSE 'Stock normal'
    END AS estado_inventario
FROM productos
WHERE stock < 10;

-- ============================================================================
-- SECCIÓN 6: PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
-- RESPONSABLE: [Ingrese su nombre]
-- Instrucciones: Agregar procedimientos según sea necesario
-- ============================================================================

-- Procedimiento: crear_nuevo_pedido
-- Propósito: Crear un nuevo pedido con validaciones
DELIMITER //

CREATE PROCEDURE crear_nuevo_pedido(
    IN p_usuario_id INT,
    IN p_total DECIMAL(12, 2),
    OUT p_pedido_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_pedido_id = -1;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al crear el pedido';
    END;
    
    START TRANSACTION;
    
    -- Verificar que el usuario existe
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE usuario_id = p_usuario_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no existe';
    END IF;
    
    -- Insertar el pedido
    INSERT INTO pedidos (usuario_id, total, estado)
    VALUES (p_usuario_id, p_total, 'pendiente');
    
    SET p_pedido_id = LAST_INSERT_ID();
    
    COMMIT;
END //

DELIMITER ;

-- SECCIÓN 7: EJERCICIO 4 - ORGANIZACIÓN INTERNA DE EMPRESA
-- RESPONSABLE: [Ingrese su nombre]
-- Descripción: Modelo relacional para organización interna de empresa (departamentos, empleados, hijos, habilidades)
-- ============================================================================

-- 1. CREACIÓN DE TABLAS (EJERCICIO 4)
CREATE TABLE centros_trabajo (
    cod_cen VARCHAR(10) PRIMARY KEY,
    nom_cen VARCHAR(50),
    pob_cen VARCHAR(50),
    dir_cen VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Centros de trabajo de la empresa';

CREATE TABLE departamentos (
    cod_dep VARCHAR(10) PRIMARY KEY,
    nom_dep VARCHAR(50),
    pre_dep DECIMAL(12,2),
    cod_cen_per VARCHAR(10),
    FOREIGN KEY (cod_cen_per) REFERENCES centros_trabajo(cod_cen)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Departamentos de la empresa';

CREATE TABLE empleados (
    id_emp VARCHAR(10) PRIMARY KEY,
    nom_emp VARCHAR(50),
    ape_emp VARCHAR(50),
    tel_emp VARCHAR(15),
    fech_alta DATE,
    sal_emp DECIMAL(10,2),
    cod_dep_per VARCHAR(10),
    FOREIGN KEY (cod_dep_per) REFERENCES departamentos(cod_dep)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Empleados de la empresa';

CREATE TABLE hijos_empleados (
    cod_hij VARCHAR(10) PRIMARY KEY,
    nom_hij VARCHAR(50),
    ape_hij VARCHAR(50),
    fec_nac DATE,
    id_emp_per VARCHAR(10),
    FOREIGN KEY (id_emp_per) REFERENCES empleados(id_emp)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Hijos de empleados';

CREATE TABLE habilidades (
    cod_hab VARCHAR(10) PRIMARY KEY,
    des_hab VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Catálogo de habilidades';

CREATE TABLE detalle_habilidad (
    id_det VARCHAR(10) PRIMARY KEY,
    id_emp_per VARCHAR(10),
    cod_hab_per VARCHAR(10),
    porcentaje VARCHAR(10),
    FOREIGN KEY (id_emp_per) REFERENCES empleados(id_emp)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cod_hab_per) REFERENCES habilidades(cod_hab)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Relación empleados-habilidades';

-- 2. INSERCIÓN DE DATOS DE PRUEBA (EJERCICIO 4)
INSERT INTO centros_trabajo VALUES
('CEN-01', 'Matriz Ambato', 'Ambato', 'Av. Capulies'),
('CEN-02', 'Sucursal Ficoa', 'Ambato', 'Guaytambos'),
('CEN-03', 'Planta Izamba', 'Izamba', 'Av. Guayaquil');

INSERT INTO departamentos VALUES
('DEP-01', 'Sistemas', 50000, 'CEN-01'),
('DEP-02', 'Marketing', 30000, 'CEN-01'),
('DEP-03', 'Producción', 120000, 'CEN-03');

INSERT INTO empleados VALUES
('E-101', 'Giselle', 'Lopez', '0984119555', '2024-12-05', 1200.00, 'DEP-01'),
('E-102', 'Henry', 'Castro', '0984113566', '2024-11-03', 1000.00, 'DEP-02'),
('E-103', 'José', 'Perez', '0931063141', '2024-01-04', 950.00, 'DEP-03');

INSERT INTO hijos_empleados VALUES
('H-01', 'Luis', 'Lopez', '2018-06-12', 'E-101'),
('H-02', 'Ana', 'Perez', '2016-02-12', 'E-103'),
('H-03', 'Carlos', 'Perez', '2005-05-13', 'E-103');

INSERT INTO habilidades VALUES
('HAB-101', 'Mercadotecnia'),
('HAB-102', 'Trato al cliente'),
('HAB-103', 'Operador');

INSERT INTO detalle_habilidad VALUES
('DH-01', 'E-101', 'HAB-101', '90%'),
('DH-02', 'E-102', 'HAB-102', '80%'),
('DH-03', 'E-103', 'HAB-103', '70%');

COMMIT;

-- Consulta 1: Mostrar las habilidades de cada empleado y su porcentaje
SELECT e.nom_emp, e.ape_emp, hab.des_hab, dh.porcentaje
FROM detalle_habilidad dh
JOIN empleados e ON dh.id_emp_per = e.id_emp
JOIN habilidades hab ON dh.cod_hab_per = hab.cod_hab;
--- Consulta 2: Mostrar el número de empleados por departamento
SELECT d.nom_dep, d.pre_dep, COUNT(e.id_emp) AS num_empleados
FROM departamentos d
LEFT JOIN empleados e ON d.cod_dep = e.cod_dep_per
GROUP BY d.cod_dep, d.nom_dep, d.pre_dep;

-- ============================================================================ 
-- PROCEDIMIENTOS ALMACENADOS PARA EJERCICIO 4


-- Configuramos el formato primero para que se vea bien
SET LINESIZE 150;
COLUMN NOM_EMP FORMAT A15;
COLUMN APE_EMP FORMAT A15;
COLUMN SAL_EMP FORMAT 9999.99;

SELECT id_emp, nom_emp, ape_emp, sal_emp, cod_dep_per 
FROM empleados 
WHERE id_emp = 'E-600';


-- ============================================================================
-- FIN SECCIÓN EJERCICIO 4

-- ============================================================================


-- Explicación:
-- - Muestra departamentos y centros con más de 1 empleado
-- - Solo considera empleados que tengan alguna de las habilidades listadas
-- - Muestra los nombres de empleados y habilidades presentes en cada departamento
