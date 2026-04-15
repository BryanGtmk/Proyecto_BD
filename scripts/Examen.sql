/* =========================================================
   1. CREAR USUARIO
   ========================================================= */

CREATE USER Hospedaje_Empresa IDENTIFIED BY Hospedaje123;

GRANT CONNECT, RESOURCE TO Hospedaje_Empresa;
ALTER USER Hospedaje_Empresa QUOTA UNLIMITED ON USERS;

CONNECT Hospedaje_Empresa/Hospedaje123;


/* =========================================================
   2. CREAR TABLAS (SIN IDENTITY)
   ========================================================= */

CREATE TABLE empresa (
    id_empresa NUMBER PRIMARY KEY,
    nombre VARCHAR2(40) NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(20) NOT NULL
);

CREATE TABLE ejecutivo (
    id_ejecutivo NUMBER PRIMARY KEY,
    nombre VARCHAR2(40) NOT NULL,
    apellido VARCHAR2(40) NOT NULL,
    cargo VARCHAR2(40) NOT NULL,
    id_empresa NUMBER,
    CONSTRAINT fk_ejecutivo_empresa 
        FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE hotel (
    id_hotel NUMBER PRIMARY KEY,
    nombre VARCHAR2(40) NOT NULL,
    ciudad VARCHAR2(40) NOT NULL,
    direccion VARCHAR2(50) NOT NULL
);

CREATE TABLE recepcionista (
    id_recepcionista NUMBER PRIMARY KEY,
    nombre VARCHAR2(40) NOT NULL,
    turno VARCHAR2(20) NOT NULL,
    id_hotel NUMBER,
    CONSTRAINT fk_recepcionista_hotel 
        FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
);

CREATE TABLE habitacion (
    id_habitacion NUMBER PRIMARY KEY,
    numero VARCHAR2(10) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    precio NUMBER(10,2) NOT NULL,
    id_hotel NUMBER,
    CONSTRAINT fk_habitacion_hotel 
        FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
);

CREATE TABLE hospedaje (
    id_hospedaje NUMBER PRIMARY KEY,
    id_ejecutivo NUMBER,
    id_habitacion NUMBER,
    id_recepcionista NUMBER,
    fecha_ingreso DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    CONSTRAINT fk_hospedaje_ejecutivo 
        FOREIGN KEY (id_ejecutivo) REFERENCES ejecutivo(id_ejecutivo),
    CONSTRAINT fk_hospedaje_habitacion 
        FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion),
    CONSTRAINT fk_hospedaje_recepcionista 
        FOREIGN KEY (id_recepcionista) REFERENCES recepcionista(id_recepcionista)
);

CREATE TABLE novedad (
    id_novedad NUMBER PRIMARY KEY,
    descripcion CLOB NOT NULL,
    fecha DATE NOT NULL,
    id_hospedaje NUMBER,
    CONSTRAINT fk_novedad_hospedaje 
        FOREIGN KEY (id_hospedaje) REFERENCES hospedaje(id_hospedaje)
);


/* =========================================================
   3. SECUENCIAS
   ========================================================= */

CREATE SEQUENCE seq_empresa START WITH 1;
CREATE SEQUENCE seq_ejecutivo START WITH 1;
CREATE SEQUENCE seq_hotel START WITH 1;
CREATE SEQUENCE seq_recepcionista START WITH 1;
CREATE SEQUENCE seq_habitacion START WITH 1;
CREATE SEQUENCE seq_hospedaje START WITH 1;
CREATE SEQUENCE seq_novedad START WITH 1;


/* =========================================================
   4. TRIGGERS AUTO-INCREMENT
   ========================================================= */

CREATE OR REPLACE TRIGGER trg_empresa
BEFORE INSERT ON empresa
FOR EACH ROW
BEGIN
    SELECT seq_empresa.NEXTVAL INTO :NEW.id_empresa FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_ejecutivo
BEFORE INSERT ON ejecutivo
FOR EACH ROW
BEGIN
    SELECT seq_ejecutivo.NEXTVAL INTO :NEW.id_ejecutivo FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_hotel
BEFORE INSERT ON hotel
FOR EACH ROW
BEGIN
    SELECT seq_hotel.NEXTVAL INTO :NEW.id_hotel FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_recepcionista
BEFORE INSERT ON recepcionista
FOR EACH ROW
BEGIN
    SELECT seq_recepcionista.NEXTVAL INTO :NEW.id_recepcionista FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_habitacion
BEFORE INSERT ON habitacion
FOR EACH ROW
BEGIN
    SELECT seq_habitacion.NEXTVAL INTO :NEW.id_habitacion FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_hospedaje
BEFORE INSERT ON hospedaje
FOR EACH ROW
BEGIN
    SELECT seq_hospedaje.NEXTVAL INTO :NEW.id_hospedaje FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_novedad
BEFORE INSERT ON novedad
FOR EACH ROW
BEGIN
    SELECT seq_novedad.NEXTVAL INTO :NEW.id_novedad FROM dual;
END;
/

/* =========================================================
   5. INSERTAR DATOS
   ========================================================= */

-- EMPRESA
INSERT INTO empresa (nombre, direccion, telefono) VALUES ('Petroecuador', 'Av. Amazonas, Quito', '022999100');
INSERT INTO empresa (nombre, direccion, telefono) VALUES ('CNT', 'Av. Gaspar de Villarroel', '023371700');
INSERT INTO empresa (nombre, direccion, telefono) VALUES ('Celec EP', 'Av. 6 de Diciembre', '022093100');

-- EJECUTIVO
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Carlos', 'Vera', 'Gerente General', 1);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Ana Lucia', 'Guerra', 'Directora TI', 1);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Roberto', 'Mera', 'Auditor', 1);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Elena', 'Solis', 'Coordinadora', 2);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Marcos', 'Ruiz', 'Consultor', 3);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Julio', 'Paz', 'Analista', 3);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Diego', 'Luna', 'Planificador', 1);
INSERT INTO ejecutivo (nombre, apellido, cargo, id_empresa) VALUES ('Sofia', 'Alba', 'Tesorera', 2);

-- HOTEL
INSERT INTO hotel (nombre, ciudad, direccion) VALUES ('Hotel Ambato', 'Ambato', 'Calle Guayaquil');
INSERT INTO hotel (nombre, ciudad, direccion) VALUES ('Hotel Empoderado', 'Ambato', 'Av. Cevallos');
INSERT INTO hotel (nombre, ciudad, direccion) VALUES ('Oro Verde', 'Cuenca', 'Av. Ordóñez');

-- RECEPCIONISTA
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('Henry', 'Mañana', 1);
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('José', 'Tarde', 1);
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('Aaron', 'Noche', 2);
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('Javi', 'Mañana', 2);
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('Melany', 'Tarde', 3);
INSERT INTO recepcionista (nombre, turno, id_hotel) VALUES ('Jonathan', 'Noche', 3);

-- HABITACION
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('101', 'Individual', 45, 1);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('102', 'Doble', 75, 1);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('103', 'Matrimonial', 120, 1);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('201', 'Individual', 50, 2);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('202', 'Doble', 80, 2);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('203', 'Suite', 150, 3);
INSERT INTO habitacion (numero, tipo, precio, id_hotel) VALUES ('301', 'Suite', 160, 3);

-- HOSPEDAJE
INSERT INTO hospedaje (id_ejecutivo, id_habitacion, id_recepcionista, fecha_ingreso, fecha_salida)
VALUES (1, 1, 1, DATE '2026-04-01', DATE '2026-04-03');

INSERT INTO hospedaje (id_ejecutivo, id_habitacion, id_recepcionista, fecha_ingreso, fecha_salida)
VALUES (2, 2, 2, DATE '2026-04-01', DATE '2026-04-05');

INSERT INTO hospedaje (id_ejecutivo, id_habitacion, id_recepcionista, fecha_ingreso, fecha_salida)
VALUES (3, 3, 3, DATE '2026-04-02', DATE '2026-04-04');

-- NOVEDAD
INSERT INTO novedad (descripcion, fecha, id_hospedaje)
VALUES ('Aire acondicionado ruidoso', DATE '2026-04-01', 1);


/* =========================================================
   6. CONSULTAS 31 - 36
   ========================================================= */

-- 31
SELECT h.tipo
FROM habitacion h
JOIN hospedaje ho ON h.id_habitacion = ho.id_habitacion
JOIN ejecutivo e ON ho.id_ejecutivo = e.id_ejecutivo
JOIN empresa em ON e.id_empresa = em.id_empresa
WHERE em.nombre = 'CNT'
GROUP BY h.tipo
HAVING COUNT(*) > (
    SELECT AVG(freq)
    FROM (
        SELECT COUNT(*) freq
        FROM habitacion h2
        JOIN hospedaje ho2 ON h2.id_habitacion = ho2.id_habitacion
        JOIN ejecutivo e2 ON ho2.id_ejecutivo = e2.id_ejecutivo
        JOIN empresa em2 ON e2.id_empresa = em2.id_empresa
        WHERE em2.nombre = 'CNT'
        GROUP BY h2.tipo
    )
);

-- 32
SELECT *
FROM hotel h
WHERE h.id_hotel IN (
    SELECT ha.id_hotel
    FROM habitacion ha
    WHERE ha.precio = (SELECT MAX(precio) FROM habitacion)
);

-- 33
SELECT e.nombre, e.apellido
FROM ejecutivo e
WHERE e.id_ejecutivo IN (
    SELECT ho.id_ejecutivo
    FROM hospedaje ho
    JOIN habitacion h ON ho.id_habitacion = h.id_habitacion
    WHERE h.tipo = 'Suite'
);

-- 34
SELECT *
FROM recepcionista r
WHERE r.id_recepcionista IN (
    SELECT ho.id_recepcionista
    FROM hospedaje ho
    GROUP BY ho.id_recepcionista
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM hospedaje
        GROUP BY id_recepcionista
    )
);

-- 35
SELECT *
FROM empresa em
WHERE NOT EXISTS (
    SELECT tipo FROM habitacion
    MINUS
    SELECT DISTINCT h.tipo
    FROM hospedaje ho
    JOIN habitacion h ON ho.id_habitacion = h.id_habitacion
    JOIN ejecutivo e ON ho.id_ejecutivo = e.id_ejecutivo
    WHERE e.id_empresa = em.id_empresa
);

-- 36
SELECT *
FROM habitacion
WHERE id_habitacion NOT IN (
    SELECT DISTINCT id_habitacion FROM hospedaje
);
------ FIN DEL SCRIPT