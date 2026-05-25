-- ============================================================
-- TAREA PRACTICA - CONSULTAS SQL EN ORACLE
-- Base de datos: VETERINARIA_DB
-- Estudiante: Bryan Guatemal
-- Archivo: consultas_veterinaria_bryan.sql
-- Nota: Ejecutar despues de crear las tablas e insertar los datos.
-- ============================================================

SET LINESIZE 200;
SET PAGESIZE 100;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

PROMPT ============================================================
PROMPT 1. Mostrar las mascotas con edad mayor a 4 años.
PROMPT ============================================================
SELECT nombre_mascota, raza, edad
FROM MASCOTA
WHERE edad > 4;

PROMPT ============================================================
PROMPT 2. Mostrar las consultas atendidas ordenadas por costo.
PROMPT ============================================================
SELECT id_consulta, fecha_consulta, diagnostico, costo, estado
FROM CONSULTA
WHERE estado = 'Atendida'
ORDER BY costo DESC;

PROMPT ============================================================
PROMPT 3. Mostrar mascota, propietario y ciudad.
PROMPT ============================================================
SELECT m.nombre_mascota,
       p.nombres AS propietario,
       p.ciudad
FROM MASCOTA m
INNER JOIN PROPIETARIO p
    ON m.id_propietario = p.id_propietario;

PROMPT ============================================================
PROMPT 4. Mostrar consulta, mascota, veterinario y especialidad.
PROMPT ============================================================
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

PROMPT ============================================================
PROMPT 5. Contar mascotas por especie.
PROMPT ============================================================
SELECT e.nombre_especie,
       COUNT(*) AS total_mascotas
FROM MASCOTA m
INNER JOIN ESPECIE e
    ON m.id_especie = e.id_especie
GROUP BY e.nombre_especie;

PROMPT ============================================================
PROMPT 6. Mostrar especies con más de una mascota.
PROMPT ============================================================
SELECT e.nombre_especie,
       COUNT(*) AS total_mascotas
FROM MASCOTA m
INNER JOIN ESPECIE e
    ON m.id_especie = e.id_especie
GROUP BY e.nombre_especie
HAVING COUNT(*) > 1;

PROMPT ============================================================
PROMPT 7. Mostrar consultas cuyo costo sea mayor al promedio.
PROMPT ============================================================
SELECT id_consulta,
       diagnostico,
       costo
FROM CONSULTA
WHERE costo > (
    SELECT AVG(costo)
    FROM CONSULTA
);

PROMPT ============================================================
PROMPT 8. Mostrar cuánto dinero ha generado cada veterinario.
PROMPT ============================================================
SELECT v.nombres AS veterinario,
       SUM(c.costo) AS total_generado
FROM VETERINARIO v
INNER JOIN CONSULTA c
    ON v.id_veterinario = c.id_veterinario
GROUP BY v.nombres
ORDER BY total_generado DESC;

PROMPT ============================================================
PROMPT 9. Mostrar veterinarios cuyos ingresos superen el promedio.
PROMPT ============================================================
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

PROMPT ============================================================
PROMPT 10. Mostrar propietario, mascota, especie, diagnóstico y tratamiento.
PROMPT ============================================================
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

PROMPT ============================================================
PROMPT 11. Mostrar mascotas cuyo peso sea mayor a 10 kg.
PROMPT ============================================================
SELECT nombre_mascota, raza, peso
FROM MASCOTA
WHERE peso > 10;

PROMPT ============================================================
PROMPT 12. Mostrar veterinarios con sueldo mayor a 1300.
PROMPT ============================================================
SELECT nombres AS veterinario, cedula, sueldo
FROM VETERINARIO
WHERE sueldo > 1300;

PROMPT ============================================================
PROMPT 13. Mostrar mascotas ordenadas alfabéticamente.
PROMPT ============================================================
SELECT id_mascota, nombre_mascota, raza, edad, peso
FROM MASCOTA
ORDER BY nombre_mascota ASC;

PROMPT ============================================================
PROMPT 14. Mostrar consultas cuyo costo esté entre 30 y 100 dólares.
PROMPT ============================================================
SELECT id_consulta, fecha_consulta, diagnostico, costo
FROM CONSULTA
WHERE costo BETWEEN 30 AND 100
ORDER BY costo ASC;

PROMPT ============================================================
PROMPT 15. Mostrar propietarios que viven en Ambato.
PROMPT ============================================================
SELECT id_propietario, cedula, nombres, telefono, ciudad, correo
FROM PROPIETARIO
WHERE ciudad = 'Ambato';

PROMPT ============================================================
PROMPT 16. Mostrar el promedio de costo de consultas.
PROMPT ============================================================
SELECT AVG(costo) AS promedio_costo_consultas
FROM CONSULTA;

PROMPT ============================================================
PROMPT 17. Mostrar el costo máximo y mínimo de consultas.
PROMPT ============================================================
SELECT MAX(costo) AS costo_maximo,
       MIN(costo) AS costo_minimo
FROM CONSULTA;

PROMPT ============================================================
PROMPT 18. Mostrar cuántas consultas realizó cada mascota.
PROMPT ============================================================
SELECT m.nombre_mascota,
       COUNT(c.id_consulta) AS total_consultas
FROM MASCOTA m
INNER JOIN CONSULTA c
    ON m.id_mascota = c.id_mascota
GROUP BY m.nombre_mascota
ORDER BY total_consultas DESC;

PROMPT ============================================================
PROMPT 19. Mostrar veterinarios que hayan generado más de 100 dólares.
PROMPT ============================================================
SELECT v.nombres AS veterinario,
       SUM(c.costo) AS total_generado
FROM VETERINARIO v
INNER JOIN CONSULTA c
    ON v.id_veterinario = c.id_veterinario
GROUP BY v.nombres
HAVING SUM(c.costo) > 100;

PROMPT ============================================================
PROMPT 20. Mostrar la mascota con la consulta más costosa.
PROMPT ============================================================
SELECT m.nombre_mascota,
       c.diagnostico,
       c.tratamiento,
       c.costo
FROM MASCOTA m
INNER JOIN CONSULTA c
    ON m.id_mascota = c.id_mascota
WHERE c.costo = (
    SELECT MAX(costo)
    FROM CONSULTA
);

PROMPT ============================================================
PROMPT 21. Mostrar consultas realizadas por veterinarios de Medicina General.
PROMPT ============================================================
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
    ON c.id_especialidad = e.id_especialidad
WHERE e.nombre_especialidad = 'Medicina General';

PROMPT ============================================================
PROMPT 22. Mostrar cuántas mascotas tiene cada propietario.
PROMPT ============================================================
SELECT p.nombres AS propietario,
       COUNT(m.id_mascota) AS total_mascotas
FROM PROPIETARIO p
INNER JOIN MASCOTA m
    ON p.id_propietario = m.id_propietario
GROUP BY p.nombres
ORDER BY total_mascotas DESC;

PROMPT ============================================================
PROMPT 23. Mostrar consultas junto con el nombre de la mascota y tratamiento.
PROMPT ============================================================
SELECT c.id_consulta,
       c.fecha_consulta,
       m.nombre_mascota,
       c.diagnostico,
       c.tratamiento,
       c.costo
FROM CONSULTA c
INNER JOIN MASCOTA m
    ON c.id_mascota = m.id_mascota
ORDER BY c.fecha_consulta;

PROMPT ============================================================
PROMPT 24. Mostrar consultas cuyo costo sea menor al promedio.
PROMPT ============================================================
SELECT id_consulta,
       diagnostico,
       tratamiento,
       costo
FROM CONSULTA
WHERE costo < (
    SELECT AVG(costo)
    FROM CONSULTA
);

PROMPT ============================================================
PROMPT 25. Mostrar el total de dinero generado por todas las consultas.
PROMPT ============================================================
SELECT SUM(costo) AS total_generado_consultas
FROM CONSULTA;

PROMPT ============================================================
PROMPT 26. Consulta propia 1: propietarios que tienen más mascotas que el promedio de mascotas por propietario.
PROMPT ============================================================
SELECT p.nombres AS propietario,
       COUNT(m.id_mascota) AS total_mascotas,
       AVG(m.peso) AS peso_promedio
FROM PROPIETARIO p
INNER JOIN MASCOTA m
    ON p.id_propietario = m.id_propietario
GROUP BY p.nombres
HAVING COUNT(m.id_mascota) > (
    SELECT AVG(total_mascotas)
    FROM (
        SELECT COUNT(*) AS total_mascotas
        FROM MASCOTA
        GROUP BY id_propietario
    )
);

PROMPT ============================================================
PROMPT 27. Consulta propia 2: veterinarios cuyo total generado supera el promedio de ingresos por veterinario.
PROMPT ============================================================
SELECT v.nombres AS veterinario,
       COUNT(c.id_consulta) AS total_consultas,
       SUM(c.costo) AS total_generado
FROM VETERINARIO v
INNER JOIN CONSULTA c
    ON v.id_veterinario = c.id_veterinario
GROUP BY v.nombres
HAVING SUM(c.costo) > (
    SELECT AVG(total_generado)
    FROM (
        SELECT SUM(costo) AS total_generado
        FROM CONSULTA
        GROUP BY id_veterinario
    )
);

PROMPT ============================================================
PROMPT 28. Consulta propia 3: especies que han generado más dinero que el costo promedio general de consultas.
PROMPT ============================================================
SELECT e.nombre_especie,
       COUNT(c.id_consulta) AS total_consultas,
       SUM(c.costo) AS total_generado
FROM ESPECIE e
INNER JOIN MASCOTA m
    ON e.id_especie = m.id_especie
INNER JOIN CONSULTA c
    ON m.id_mascota = c.id_mascota
GROUP BY e.nombre_especie
HAVING SUM(c.costo) > (
    SELECT AVG(costo)
    FROM CONSULTA
);

PROMPT ============================================================
PROMPT 29. Consulta propia 4: mascotas que tienen más consultas que el promedio de consultas por mascota.
PROMPT ============================================================
SELECT m.nombre_mascota,
       COUNT(c.id_consulta) AS total_consultas,
       SUM(c.costo) AS total_generado
FROM MASCOTA m
INNER JOIN CONSULTA c
    ON m.id_mascota = c.id_mascota
GROUP BY m.nombre_mascota
HAVING COUNT(c.id_consulta) > (
    SELECT AVG(total_consultas)
    FROM (
        SELECT COUNT(*) AS total_consultas
        FROM CONSULTA
        GROUP BY id_mascota
    )
);

PROMPT ============================================================
PROMPT 30. Consulta propia 5: especialidades con ingresos mayores al promedio de ingresos por especialidad.
PROMPT ============================================================
SELECT e.nombre_especialidad,
       COUNT(c.id_consulta) AS total_consultas,
       SUM(c.costo) AS total_generado
FROM ESPECIALIDAD e
INNER JOIN CONSULTA c
    ON e.id_especialidad = c.id_especialidad
GROUP BY e.nombre_especialidad
HAVING SUM(c.costo) > (
    SELECT AVG(total_generado)
    FROM (
        SELECT SUM(costo) AS total_generado
        FROM CONSULTA
        GROUP BY id_especialidad
    )
);
xd

