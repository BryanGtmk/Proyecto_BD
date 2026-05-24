DOCUMENTO PRÁCTICO - BASE DE DATOS VETERINARIA
Temas: SELECT, WHERE, ORDER BY, INNER JOIN, GROUP BY, HAVING y Subconsultas.
Base de datos: VETERINARIA_DB

============================================================
1. CREACIÓN DE USUARIO ORACLE
============================================================

CONNECT SYSTEM/SYSTEM;

CREATE USER VETERINARIA_DB IDENTIFIED BY VETERINARIA_DB;
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO VETERINARIA_DB;

CONNECT VETERINARIA_DB/VETERINARIA_DB;

============================================================
2. CREACIÓN DE TABLAS
============================================================

CREATE TABLE PROPIETARIO (
    id_propietario NUMBER PRIMARY KEY,
    cedula VARCHAR2(10) NOT NULL UNIQUE,
    nombres VARCHAR2(80) NOT NULL,
    telefono VARCHAR2(15),
    ciudad VARCHAR2(50) NOT NULL,
    correo VARCHAR2(100) UNIQUE
);

CREATE TABLE ESPECIE (
    id_especie NUMBER PRIMARY KEY,
    nombre_especie VARCHAR2(50) NOT NULL UNIQUE
);

CREATE TABLE ESPECIALIDAD (
    id_especialidad NUMBER PRIMARY KEY,
    nombre_especialidad VARCHAR2(80) NOT NULL UNIQUE
);

CREATE TABLE VETERINARIO (
    id_veterinario NUMBER PRIMARY KEY,
    nombres VARCHAR2(80) NOT NULL,
    cedula VARCHAR2(10) NOT NULL UNIQUE,
    sueldo NUMBER(8,2) NOT NULL
);

CREATE TABLE MASCOTA (
    id_mascota NUMBER PRIMARY KEY,
    nombre_mascota VARCHAR2(60) NOT NULL,
    raza VARCHAR2(60),
    edad NUMBER(3) NOT NULL,
    peso NUMBER(5,2) NOT NULL,
    id_propietario NUMBER NOT NULL,
    id_especie NUMBER NOT NULL,
    CONSTRAINT fk_mascota_propietario FOREIGN KEY (id_propietario)
        REFERENCES PROPIETARIO(id_propietario),
    CONSTRAINT fk_mascota_especie FOREIGN KEY (id_especie)
        REFERENCES ESPECIE(id_especie),
    CONSTRAINT chk_mascota_edad CHECK (edad >= 0),
    CONSTRAINT chk_mascota_peso CHECK (peso > 0)
);

CREATE TABLE CONSULTA (
    id_consulta NUMBER PRIMARY KEY,
    fecha_consulta DATE NOT NULL,
    diagnostico VARCHAR2(150) NOT NULL,
    tratamiento VARCHAR2(150) NOT NULL,
    costo NUMBER(8,2) NOT NULL,
    estado VARCHAR2(30) NOT NULL,
    id_mascota NUMBER NOT NULL,
    id_veterinario NUMBER NOT NULL,
    id_especialidad NUMBER NOT NULL,
    CONSTRAINT fk_consulta_mascota FOREIGN KEY (id_mascota)
        REFERENCES MASCOTA(id_mascota),
    CONSTRAINT fk_consulta_veterinario FOREIGN KEY (id_veterinario)
        REFERENCES VETERINARIO(id_veterinario),
    CONSTRAINT fk_consulta_especialidad FOREIGN KEY (id_especialidad)
        REFERENCES ESPECIALIDAD(id_especialidad),
    CONSTRAINT chk_consulta_costo CHECK (costo > 0)
);

============================================================
3. INSERTS DE DATOS
============================================================

INSERT INTO PROPIETARIO VALUES (1, '1801111111', 'Carlos Pérez', '0991111111', 'Ambato', 'carlos@mail.com');
INSERT INTO PROPIETARIO VALUES (2, '1802222222', 'María López', '0992222222', 'Quito', 'maria@mail.com');

INSERT INTO ESPECIE VALUES (1, 'Perro');
INSERT INTO ESPECIE VALUES (2, 'Gato');

INSERT INTO ESPECIALIDAD VALUES (1, 'Medicina General');
INSERT INTO ESPECIALIDAD VALUES (2, 'Cirugía');

INSERT INTO VETERINARIO VALUES (1, 'Dr. Andrés Ramos', '1701111111', 1200);
INSERT INTO VETERINARIO VALUES (2, 'Dra. Paola Vega', '1702222222', 1500);

INSERT INTO MASCOTA VALUES (1, 'Max', 'Labrador', 5, 28.5, 1, 1);
INSERT INTO MASCOTA VALUES (2, 'Luna', 'Siamés', 3, 5.2, 2, 2);
INSERT INTO MASCOTA VALUES (3, 'Rocky', 'Pitbull', 2, 20.5, 1, 1);

INSERT INTO CONSULTA VALUES (1, DATE '2026-05-01', 'Infección leve', 'Antibiótico por 7 días', 35.00, 'Atendida', 1, 1, 1);
INSERT INTO CONSULTA VALUES (2, DATE '2026-05-02', 'Control general', 'Vitaminas y revisión general', 25.00, 'Atendida', 2, 1, 1);
INSERT INTO CONSULTA VALUES (3, DATE '2026-05-03', 'Cirugía menor', 'Reposo y control postoperatorio', 120.00, 'Atendida', 1, 2, 2);
INSERT INTO CONSULTA VALUES (4, DATE '2026-05-04', 'Vacunación anual', 'Aplicación de vacuna y control', 40.00, 'Atendida', 3, 1, 1);

COMMIT;

============================================================
4. PREGUNTAS SQL RESUELTAS
============================================================

------------------------------------------------------------
1. Mostrar las mascotas con edad mayor a 4 años.
------------------------------------------------------------

SELECT nombre_mascota, raza, edad
FROM MASCOTA
WHERE edad > 4;

Explicación:
La consulta usa SELECT para mostrar los datos de las mascotas y WHERE para filtrar únicamente aquellas cuya edad sea mayor a 4 años.

------------------------------------------------------------
2. Mostrar las consultas atendidas ordenadas por costo.
------------------------------------------------------------

SELECT id_consulta, fecha_consulta, diagnostico, costo, estado
FROM CONSULTA
WHERE estado = 'Atendida'
ORDER BY costo DESC;

Explicación:
La consulta filtra las consultas cuyo estado sea 'Atendida' y ordena los resultados de mayor a menor costo mediante ORDER BY DESC.

------------------------------------------------------------
3. Mostrar mascota, propietario y ciudad.
------------------------------------------------------------

SELECT m.nombre_mascota,
       p.nombres AS propietario,
       p.ciudad
FROM MASCOTA m
INNER JOIN PROPIETARIO p
    ON m.id_propietario = p.id_propietario;

Explicación:
Se usa INNER JOIN para unir la tabla MASCOTA con PROPIETARIO. La relación se realiza mediante el campo id_propietario.

------------------------------------------------------------
4. Mostrar consulta, mascota, veterinario y especialidad.
------------------------------------------------------------

SELECT c.id_consulta,
       c.fecha_consulta,
       m.nombre_mascota,
       v.nombres AS veterinario,
       e.nombre_especialidad,
       c.diagnostico,
       c.costo
FROM CONSULTA c
INNER JOIN MASCOTA m
    ON c.id_mascota = m.id_mascota
INNER JOIN VETERINARIO v
    ON c.id_veterinario = v.id_veterinario
INNER JOIN ESPECIALIDAD e
    ON c.id_especialidad = e.id_especialidad;

Explicación:
La consulta une CONSULTA, MASCOTA, VETERINARIO y ESPECIALIDAD para mostrar información completa de cada consulta registrada.

------------------------------------------------------------
5. Contar mascotas por especie.
------------------------------------------------------------

SELECT e.nombre_especie,
       COUNT(*) AS total_mascotas
FROM MASCOTA m
INNER JOIN ESPECIE e
    ON m.id_especie = e.id_especie
GROUP BY e.nombre_especie;

Explicación:
Se utiliza GROUP BY para agrupar las mascotas por especie y COUNT(*) para contar cuántas mascotas existen en cada grupo.

------------------------------------------------------------
6. Mostrar especies con más de una mascota.
------------------------------------------------------------

SELECT e.nombre_especie,
       COUNT(*) AS total_mascotas
FROM MASCOTA m
INNER JOIN ESPECIE e
    ON m.id_especie = e.id_especie
GROUP BY e.nombre_especie
HAVING COUNT(*) > 1;

Explicación:
La consulta agrupa las mascotas por especie y con HAVING filtra solo aquellas especies que tienen más de una mascota registrada.

------------------------------------------------------------
7. Mostrar consultas cuyo costo sea mayor al promedio.
------------------------------------------------------------

SELECT id_consulta,
       diagnostico,
       costo
FROM CONSULTA
WHERE costo > (
    SELECT AVG(costo)
    FROM CONSULTA
);

Explicación:
La subconsulta calcula el costo promedio de las consultas. Luego, la consulta principal muestra solo aquellas consultas cuyo costo supera ese promedio.

------------------------------------------------------------
8. Mostrar cuánto dinero ha generado cada veterinario.
------------------------------------------------------------

SELECT v.nombres AS veterinario,
       SUM(c.costo) AS total_generado
FROM VETERINARIO v
INNER JOIN CONSULTA c
    ON v.id_veterinario = c.id_veterinario
GROUP BY v.nombres
ORDER BY total_generado DESC;

Explicación:
La consulta une VETERINARIO con CONSULTA y utiliza SUM(c.costo) para calcular el dinero generado por cada veterinario. Los resultados se agrupan por veterinario.

------------------------------------------------------------
9. Mostrar veterinarios cuyos ingresos superen el promedio.
------------------------------------------------------------

SELECT v.nombres AS veterinario,
       SUM(c.costo) AS total_generado
FROM VETERINARIO v
INNER JOIN CONSULTA c
    ON v.id_veterinario = c.id_veterinario
GROUP BY v.nombres
HAVING SUM(c.costo) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(costo) AS total
        FROM CONSULTA
        GROUP BY id_veterinario
    )
);

Explicación:
La subconsulta calcula el promedio de ingresos generados por los veterinarios. Luego, la consulta principal muestra únicamente los veterinarios cuyo total generado supera ese promedio.

------------------------------------------------------------
10. Mostrar propietario, mascota, especie, diagnóstico y tratamiento.
------------------------------------------------------------

SELECT p.nombres AS propietario,
       m.nombre_mascota,
       e.nombre_especie,
       c.diagnostico,
       c.tratamiento
FROM PROPIETARIO p
INNER JOIN MASCOTA m
    ON p.id_propietario = m.id_propietario
INNER JOIN ESPECIE e
    ON m.id_especie = e.id_especie
INNER JOIN CONSULTA c
    ON m.id_mascota = c.id_mascota;

Explicación:
La consulta usa INNER JOIN para unir PROPIETARIO, MASCOTA, ESPECIE y CONSULTA. De esta forma se obtiene el propietario, la mascota, su especie, el diagnóstico y el tratamiento registrado.

============================================================
5. CONCLUSIÓN
============================================================

La práctica permite aplicar los temas principales vistos en clase: SELECT, WHERE, ORDER BY, INNER JOIN, GROUP BY, HAVING y subconsultas. Además, se corrigió la estructura de la tabla CONSULTA para que tenga relación con MASCOTA, VETERINARIO y ESPECIALIDAD. Gracias a estas relaciones, se pueden resolver correctamente las consultas solicitadas y obtener información completa del sistema veterinario.
