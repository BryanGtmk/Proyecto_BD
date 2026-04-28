CONNECT system/system;

CREATE USER BIBLIOTECA_ACAD IDENTIFIED BY BIB123;
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO BIBLIOTECA_ACAD;

CONNECT BIBLIOTECA_ACAD/BIB123;

-- =========================================================
-- UNIVERSIDAD TÉCNICA DE AMBATO
-- Facultad de Ingeniería en Sistemas
-- Asignatura: Base de Datos
-- Docente: José Caiza
-- Formato: APA 7
-- =========================================================
-- EJERCICIO 2: SISTEMA DE BIBLIOTECA
-- Objetivo: Implementar un sistema con relaciones,
-- restricciones y pruebas de integridad.
-- =========================================================


-- =========================================================
-- FASE P1: CREAR TABLAS BASE
-- =========================================================

CREATE TABLE CATEGORIA_LIBRO (
    ID_CAT_LIB     NUMBER(10) PRIMARY KEY,
    NOM_CAT_LIB    VARCHAR2(40) NOT NULL UNIQUE,
    DES_CAT_LIB    VARCHAR2(100)
);

CREATE TABLE EDITORIAL (
    ID_EDI      NUMBER(10) PRIMARY KEY,
    NOM_EDI     VARCHAR2(50) NOT NULL UNIQUE,
    DIR_EDI     VARCHAR2(80)
);

CREATE TABLE AUTOR (
    ID_AUT      NUMBER(10) PRIMARY KEY,
    NOM_AUT     VARCHAR2(30) NOT NULL,
    APE_AUT     VARCHAR2(30) NOT NULL,
    NAC_AUT     VARCHAR2(30)
);

CREATE TABLE ESTADO_EJEMPLAR (
    ID_EST_EJE     NUMBER(10) PRIMARY KEY,
    NOM_EST_EJE    VARCHAR2(30) NOT NULL UNIQUE
);


-- =========================================================
-- FASE P2: APLICAR RESTRICCIONES
-- =========================================================

CREATE TABLE LECTOR (
    CED_LEC      VARCHAR2(10) PRIMARY KEY,
    NOM_LEC      VARCHAR2(30) NOT NULL,
    APE_LEC      VARCHAR2(30) NOT NULL,
    TEL_LEC      VARCHAR2(10),
    DIR_LEC      VARCHAR2(50),
    COR_LEC      VARCHAR2(60) UNIQUE,
    EST_LEC      VARCHAR2(10) DEFAULT 'ACTIVO' NOT NULL,
    CONSTRAINT CHK_EST_LECTOR 
    CHECK (EST_LEC IN ('ACTIVO','INACTIVO'))
);

CREATE TABLE BIBLIOTECARIO (
    CED_BIB      VARCHAR2(10) PRIMARY KEY,
    NOM_BIB      VARCHAR2(30) NOT NULL,
    APE_BIB      VARCHAR2(30) NOT NULL,
    TUR_BIB      VARCHAR2(15) NOT NULL,
    CONSTRAINT CHK_TURNO_BIB 
    CHECK (TUR_BIB IN ('MATUTINO','VESPERTINO','NOCTURNO'))
);


-- =========================================================
-- FASE P3: IMPLEMENTAR RELACIONES
-- =========================================================

CREATE TABLE LIBRO (
    COD_LIB        VARCHAR2(10) PRIMARY KEY,
    TIT_LIB        VARCHAR2(80) NOT NULL,
    ANIO_LIB       NUMBER(4) NOT NULL,
    ID_CAT_PER     NUMBER(10) NOT NULL,
    ID_EDI_PER     NUMBER(10) NOT NULL,
    ID_AUT_PER     NUMBER(10) NOT NULL,
    CONSTRAINT CHK_ANIO_LIB CHECK (ANIO_LIB >= 1900),
    FOREIGN KEY (ID_CAT_PER) REFERENCES CATEGORIA_LIBRO(ID_CAT_LIB),
    FOREIGN KEY (ID_EDI_PER) REFERENCES EDITORIAL(ID_EDI),
    FOREIGN KEY (ID_AUT_PER) REFERENCES AUTOR(ID_AUT)
);

CREATE TABLE EJEMPLAR (
    ID_EJE        NUMBER(10) PRIMARY KEY,
    COD_LIB_PER   VARCHAR2(10) NOT NULL,
    COD_BARRA     VARCHAR2(20) NOT NULL UNIQUE,
    ID_EST_PER    NUMBER(10) NOT NULL,
    FOREIGN KEY (COD_LIB_PER) REFERENCES LIBRO(COD_LIB),
    FOREIGN KEY (ID_EST_PER) REFERENCES ESTADO_EJEMPLAR(ID_EST_EJE)
);

CREATE TABLE PRESTAMO_LIBRO (
    ID_PRE_LIB     NUMBER(10) PRIMARY KEY,
    FEC_PRE_LIB    DATE DEFAULT SYSDATE NOT NULL,
    FEC_DEV_PREV   DATE NOT NULL,
    CED_LEC_PER    VARCHAR2(10) NOT NULL,
    CED_BIB_PER    VARCHAR2(10) NOT NULL,
    EST_PRE_LIB    VARCHAR2(20) DEFAULT 'ABIERTO' NOT NULL,
    CONSTRAINT CHK_EST_PRE_LIB 
    CHECK (EST_PRE_LIB IN ('ABIERTO','DEVUELTO','ATRASADO','CANCELADO')),
    FOREIGN KEY (CED_LEC_PER) REFERENCES LECTOR(CED_LEC),
    FOREIGN KEY (CED_BIB_PER) REFERENCES BIBLIOTECARIO(CED_BIB)
);

CREATE TABLE DETALLE_PRESTAMO_LIBRO (
    ID_DET_LIB      NUMBER(10) PRIMARY KEY,
    ID_PRE_LIB_PER  NUMBER(10) NOT NULL,
    ID_EJE_PER      NUMBER(10) NOT NULL,
    FEC_DEV_REAL    DATE,
    OBS_DET_LIB     VARCHAR2(100),
    FOREIGN KEY (ID_PRE_LIB_PER) REFERENCES PRESTAMO_LIBRO(ID_PRE_LIB),
    FOREIGN KEY (ID_EJE_PER) REFERENCES EJEMPLAR(ID_EJE),
    CONSTRAINT UQ_DET_LIBRO UNIQUE (ID_PRE_LIB_PER, ID_EJE_PER)
);


-- =========================================================
-- INSERTAR CATEGORIAS
-- =========================================================

INSERT INTO CATEGORIA_LIBRO VALUES (1,'BASE DE DATOS','Libros de diseño y administración de datos');
INSERT INTO CATEGORIA_LIBRO VALUES (2,'PROGRAMACIÓN','Libros de desarrollo de software');
INSERT INTO CATEGORIA_LIBRO VALUES (3,'REDES','Libros de comunicación de datos');
INSERT INTO CATEGORIA_LIBRO VALUES (4,'MATEMÁTICAS','Libros de cálculo y álgebra');
INSERT INTO CATEGORIA_LIBRO VALUES (5,'INVESTIGACIÓN','Libros de metodología');


-- =========================================================
-- INSERTAR EDITORIALES
-- =========================================================

INSERT INTO EDITORIAL VALUES (1,'PEARSON','QUITO');
INSERT INTO EDITORIAL VALUES (2,'MCGRAW HILL','GUAYAQUIL');
INSERT INTO EDITORIAL VALUES (3,'ALFAOMEGA','AMBATO');
INSERT INTO EDITORIAL VALUES (4,'OXFORD','CUENCA');
INSERT INTO EDITORIAL VALUES (5,'UTA EDITORIAL','AMBATO');


-- =========================================================
-- INSERTAR AUTORES
-- =========================================================

INSERT INTO AUTOR VALUES (1,'CARLOS','CORONEL','ECUADOR');
INSERT INTO AUTOR VALUES (2,'DEITEL','HARVEY','ESTADOS UNIDOS');
INSERT INTO AUTOR VALUES (3,'ANDREW','TANENBAUM','PAÍSES BAJOS');
INSERT INTO AUTOR VALUES (4,'JAMES','STEWART','CANADÁ');
INSERT INTO AUTOR VALUES (5,'ROBERTO','HERNÁNDEZ','MÉXICO');


-- =========================================================
-- INSERTAR ESTADOS DE EJEMPLAR
-- =========================================================

INSERT INTO ESTADO_EJEMPLAR VALUES (1,'DISPONIBLE');
INSERT INTO ESTADO_EJEMPLAR VALUES (2,'PRESTADO');
INSERT INTO ESTADO_EJEMPLAR VALUES (3,'MANTENIMIENTO');
INSERT INTO ESTADO_EJEMPLAR VALUES (4,'PERDIDO');


-- =========================================================
-- INSERTAR LECTORES
-- =========================================================

INSERT INTO LECTOR VALUES ('1801','JUAN','MERA','0981111111','AMBATO','juan.mera@uta.edu.ec','ACTIVO');
INSERT INTO LECTOR VALUES ('1802','ANA','LOPEZ','0982222222','QUITO','ana.lopez@uta.edu.ec','ACTIVO');
INSERT INTO LECTOR VALUES ('1803','CARLOS','PEREZ','0983333333','LOJA','carlos.perez@uta.edu.ec','ACTIVO');
INSERT INTO LECTOR VALUES ('1804','MARIA','GOMEZ','0984444444','CUENCA','maria.gomez@uta.edu.ec','ACTIVO');
INSERT INTO LECTOR VALUES ('1805','LUIS','MORA','0985555555','MANTA','luis.mora@uta.edu.ec','ACTIVO');


-- =========================================================
-- INSERTAR BIBLIOTECARIOS
-- =========================================================

INSERT INTO BIBLIOTECARIO VALUES ('2001','PEDRO','CASTRO','MATUTINO');
INSERT INTO BIBLIOTECARIO VALUES ('2002','LAURA','VEGA','VESPERTINO');
INSERT INTO BIBLIOTECARIO VALUES ('2003','DIEGO','SALAS','NOCTURNO');


-- =========================================================
-- INSERTAR LIBROS
-- =========================================================

INSERT INTO LIBRO VALUES ('L01','FUNDAMENTOS DE BASE DE DATOS',2020,1,1,1);
INSERT INTO LIBRO VALUES ('L02','JAVA CÓMO PROGRAMAR',2021,2,2,2);
INSERT INTO LIBRO VALUES ('L03','REDES DE COMPUTADORAS',2019,3,3,3);
INSERT INTO LIBRO VALUES ('L04','CÁLCULO DE UNA VARIABLE',2018,4,4,4);
INSERT INTO LIBRO VALUES ('L05','METODOLOGÍA DE LA INVESTIGACIÓN',2022,5,5,5);


-- =========================================================
-- INSERTAR EJEMPLARES
-- =========================================================

INSERT INTO EJEMPLAR VALUES (1,'L01','BAR-001',1);
INSERT INTO EJEMPLAR VALUES (2,'L02','BAR-002',1);
INSERT INTO EJEMPLAR VALUES (3,'L03','BAR-003',1);
INSERT INTO EJEMPLAR VALUES (4,'L04','BAR-004',1);
INSERT INTO EJEMPLAR VALUES (5,'L05','BAR-005',1);


-- =========================================================
-- INSERTAR PRESTAMOS DE LIBROS
-- =========================================================

INSERT INTO PRESTAMO_LIBRO VALUES (1,TO_DATE('01/03/2026','DD/MM/YYYY'),TO_DATE('08/03/2026','DD/MM/YYYY'),'1801','2001','ABIERTO');
INSERT INTO PRESTAMO_LIBRO VALUES (2,TO_DATE('02/03/2026','DD/MM/YYYY'),TO_DATE('09/03/2026','DD/MM/YYYY'),'1802','2002','ABIERTO');
INSERT INTO PRESTAMO_LIBRO VALUES (3,TO_DATE('03/03/2026','DD/MM/YYYY'),TO_DATE('10/03/2026','DD/MM/YYYY'),'1803','2003','DEVUELTO');


-- =========================================================
-- INSERTAR DETALLE DE PRESTAMO DE LIBROS
-- =========================================================

INSERT INTO DETALLE_PRESTAMO_LIBRO VALUES (1001,1,1,NULL,'Libro prestado para consulta académica');
INSERT INTO DETALLE_PRESTAMO_LIBRO VALUES (1002,2,2,NULL,'Libro prestado para práctica de programación');
INSERT INTO DETALLE_PRESTAMO_LIBRO VALUES (1003,3,5,TO_DATE('10/03/2026','DD/MM/YYYY'),'Libro devuelto correctamente');

COMMIT;


-- =========================================================
-- CONSULTAS DE COMPROBACIÓN
-- =========================================================

SELECT * FROM CATEGORIA_LIBRO;
SELECT * FROM EDITORIAL;
SELECT * FROM AUTOR;
SELECT * FROM ESTADO_EJEMPLAR;
SELECT * FROM LECTOR;
SELECT * FROM BIBLIOTECARIO;
SELECT * FROM LIBRO;
SELECT * FROM EJEMPLAR;
SELECT * FROM PRESTAMO_LIBRO;
SELECT * FROM DETALLE_PRESTAMO_LIBRO;


-- =========================================================
-- CONSULTA CON JOIN
-- Mostrar lectores que han realizado préstamos
-- =========================================================

SELECT 
    PL.ID_PRE_LIB,
    L.NOM_LEC || ' ' || L.APE_LEC AS LECTOR,
    B.NOM_BIB || ' ' || B.APE_BIB AS BIBLIOTECARIO,
    PL.FEC_PRE_LIB,
    PL.EST_PRE_LIB
FROM PRESTAMO_LIBRO PL
JOIN LECTOR L ON PL.CED_LEC_PER = L.CED_LEC
JOIN BIBLIOTECARIO B ON PL.CED_BIB_PER = B.CED_BIB;


-- =========================================================
-- CONSULTA CON JOIN
-- Mostrar libros prestados
-- =========================================================

SELECT 
    DPL.ID_DET_LIB,
    LI.TIT_LIB AS LIBRO,
    LE.NOM_LEC || ' ' || LE.APE_LEC AS LECTOR,
    PL.EST_PRE_LIB
FROM DETALLE_PRESTAMO_LIBRO DPL
JOIN EJEMPLAR E ON DPL.ID_EJE_PER = E.ID_EJE
JOIN LIBRO LI ON E.COD_LIB_PER = LI.COD_LIB
JOIN PRESTAMO_LIBRO PL ON DPL.ID_PRE_LIB_PER = PL.ID_PRE_LIB
JOIN LECTOR LE ON PL.CED_LEC_PER = LE.CED_LEC;


-- =========================================================
-- CONSULTA SIN JOIN
-- Mostrar libros que han sido prestados
-- =========================================================

SELECT COD_LIB, TIT_LIB
FROM LIBRO
WHERE COD_LIB IN (
    SELECT COD_LIB_PER
    FROM EJEMPLAR
    WHERE ID_EJE IN (
        SELECT ID_EJE_PER
        FROM DETALLE_PRESTAMO_LIBRO
    )
);


-- =========================================================
-- FASE P4: EVOLUCIÓN DEL ESQUEMA Y RECUPERACIÓN
-- =========================================================

-- Agregar columna ISBN
ALTER TABLE LIBRO ADD ISBN_LIB VARCHAR2(20);

-- Modificar tamaño del título
ALTER TABLE LIBRO MODIFY TIT_LIB VARCHAR2(100);

-- Agregar restricción UNIQUE para ISBN
ALTER TABLE LIBRO ADD CONSTRAINT UQ_ISBN_LIB UNIQUE (ISBN_LIB);

-- Actualizar ISBN
UPDATE LIBRO SET ISBN_LIB = 'ISBN-001' WHERE COD_LIB = 'L01';
UPDATE LIBRO SET ISBN_LIB = 'ISBN-002' WHERE COD_LIB = 'L02';
UPDATE LIBRO SET ISBN_LIB = 'ISBN-003' WHERE COD_LIB = 'L03';
UPDATE LIBRO SET ISBN_LIB = 'ISBN-004' WHERE COD_LIB = 'L04';
UPDATE LIBRO SET ISBN_LIB = 'ISBN-005' WHERE COD_LIB = 'L05';

COMMIT;

-- Crear tabla temporal para probar DROP TABLE y FLASHBACK
CREATE TABLE PRUEBA_FLASHBACK_BIB (
    ID_PRU      NUMBER(10) PRIMARY KEY,
    NOM_PRU     VARCHAR2(30)
);

INSERT INTO PRUEBA_FLASHBACK_BIB VALUES (1,'PRUEBA BIBLIOTECA');
COMMIT;

-- Eliminar tabla
DROP TABLE PRUEBA_FLASHBACK_BIB;

-- Recuperar tabla eliminada
FLASHBACK TABLE PRUEBA_FLASHBACK_BIB TO BEFORE DROP;

-- Comprobar recuperación
SELECT * FROM PRUEBA_FLASHBACK_BIB;


SET LINESIZE 200;
SET PAGESIZE 200;