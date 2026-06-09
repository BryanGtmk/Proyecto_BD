
-- ============================================================
-- SCRIPT COMPLETO - BASE DE DATOS TRANSPORTE_DB
-- EXAMEN PRÁCTICO No. 2 - BASE DE DATOS
-- TEMA: NORMALIZACIÓN, DDL, DML, SQL AVANZADO Y PL/SQL
-- UNIVERSIDAD TÉCNICA DE AMBATO - FISEI
-- ============================================================


-- ============================================================
-- 1. CONEXIÓN COMO SYSTEM
      CONNECT SYSTEM/SYSTEM;
-- ============================================================

-- Si tu contraseña de SYSTEM es diferente, cámbiala.
CONNECT SYSTEM/SYSTEM;


-- ============================================================
-- 2. ELIMINAR USUARIO SI YA EXISTE
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP USER TRANSPORTE_DB CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/


-- ============================================================
-- 3. CREACIÓN DE USUARIO
-- ============================================================

CREATE USER TRANSPORTE_DB IDENTIFIED BY TRANSPORTE_DB;

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO TRANSPORTE_DB;

CONNECT TRANSPORTE_DB/TRANSPORTE_DB;


-- ============================================================
-- 4. CONFIGURACIÓN INICIAL
-- ============================================================

SET SERVEROUTPUT ON;
SET LINESIZE 200;
SET PAGESIZE 100;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


-- ============================================================
-- 5. NORMALIZACIÓN Y MODELO RELACIONAL
-- ============================================================

-- CASO ORIGINAL:
-- Num_Viaje | Fecha | Cliente | Teléfono | Conductor | Vehículo | Placa | Origen | Destino | Valor | FormaPago

-- ENTIDADES IDENTIFICADAS:
-- CLIENTES
-- CONDUCTORES
-- VEHICULOS
-- VIAJES
-- RESERVAS
-- FACTURAS

-- PRIMERA FORMA NORMAL 1FN:
-- Se eliminan grupos repetidos y todos los datos quedan atómicos.
-- Cada campo contiene un solo valor.
--
-- VIAJE_GENERAL(
--   Num_Viaje,
--   Fecha,
--   Cliente,
--   Telefono,
--   Conductor,
--   Vehiculo,
--   Placa,
--   Origen,
--   Destino,
--   Valor,
--   FormaPago
-- )

-- SEGUNDA FORMA NORMAL 2FN:
-- Se separan los datos que no dependen directamente del viaje.
-- Los datos del cliente, conductor y vehículo se guardan en tablas independientes.
--
-- CLIENTES(id_cliente, nombres, telefono)
-- CONDUCTORES(id_conductor, nombres, licencia)
-- VEHICULOS(id_vehiculo, placa, tipo_vehiculo)
-- VIAJES(id_viaje, fecha, origen, destino, valor, forma_pago, id_conductor, id_vehiculo)

-- TERCERA FORMA NORMAL 3FN:
-- Se eliminan dependencias transitivas.
-- Por ejemplo:
-- La placa depende del vehículo, no del viaje.
-- El teléfono depende del cliente, no del viaje.
-- El conductor depende de su propia tabla, no directamente de la hoja general.

-- MODELO RELACIONAL FINAL:
--
-- CLIENTES(
--   id_cliente PK,
--   cedula UNIQUE,
--   nombres,
--   telefono UNIQUE
-- )
--
-- CONDUCTORES(
--   id_conductor PK,
--   cedula UNIQUE,
--   nombres,
--   licencia UNIQUE
-- )
--
-- VEHICULOS(
--   id_vehiculo PK,
--   placa UNIQUE,
--   tipo_vehiculo,
--   capacidad
-- )
--
-- VIAJES(
--   id_viaje PK,
--   fecha,
--   origen,
--   destino,
--   valor,
--   forma_pago,
--   id_conductor FK,
--   id_vehiculo FK
-- )
--
-- RESERVAS(
--   id_reserva PK,
--   id_cliente FK,
--   id_viaje FK,
--   asiento,
--   estado
-- )
--
-- FACTURAS(
--   id_factura PK,
--   numero_factura UNIQUE,
--   fecha,
--   id_cliente FK,
--   total
-- )

-- CARDINALIDADES:
-- CLIENTES 1 --- N RESERVAS
-- VIAJES 1 --- N RESERVAS
-- CONDUCTORES 1 --- N VIAJES
-- VEHICULOS 1 --- N VIAJES
-- CLIENTES 1 --- N FACTURAS


-- ============================================================
-- 6. CREACIÓN DE TABLAS DDL
-- ============================================================

CREATE TABLE CLIENTES (
    id_cliente NUMBER PRIMARY KEY,
    cedula VARCHAR2(10) NOT NULL UNIQUE,
    nombres VARCHAR2(80) NOT NULL,
    telefono VARCHAR2(10) NOT NULL UNIQUE,
    correo VARCHAR2(100),
    CONSTRAINT chk_cliente_cedula 
        CHECK (LENGTH(cedula) = 10),
    CONSTRAINT chk_cliente_telefono 
        CHECK (LENGTH(telefono) = 10)
);

CREATE TABLE CONDUCTORES (
    id_conductor NUMBER PRIMARY KEY,
    cedula VARCHAR2(10) NOT NULL UNIQUE,
    nombres VARCHAR2(80) NOT NULL,
    licencia VARCHAR2(20) NOT NULL UNIQUE,
    telefono VARCHAR2(10) NOT NULL,
    CONSTRAINT chk_conductor_cedula 
        CHECK (LENGTH(cedula) = 10),
    CONSTRAINT chk_conductor_telefono 
        CHECK (LENGTH(telefono) = 10)
);

CREATE TABLE VEHICULOS (
    id_vehiculo NUMBER PRIMARY KEY,
    placa VARCHAR2(10) NOT NULL UNIQUE,
    tipo_vehiculo VARCHAR2(40) NOT NULL,
    marca VARCHAR2(40) NOT NULL,
    capacidad NUMBER NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_capacidad_vehiculo 
        CHECK (capacidad > 0),
    CONSTRAINT chk_estado_vehiculo 
        CHECK (estado IN ('DISPONIBLE', 'MANTENIMIENTO'))
);

CREATE TABLE VIAJES (
    id_viaje NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    origen VARCHAR2(80) NOT NULL,
    destino VARCHAR2(80) NOT NULL,
    valor NUMBER(8,2) NOT NULL,
    forma_pago VARCHAR2(30) NOT NULL,
    id_conductor NUMBER NOT NULL,
    id_vehiculo NUMBER NOT NULL,
    CONSTRAINT fk_viaje_conductor 
        FOREIGN KEY (id_conductor) REFERENCES CONDUCTORES(id_conductor),
    CONSTRAINT fk_viaje_vehiculo 
        FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS(id_vehiculo),
    CONSTRAINT chk_valor_viaje 
        CHECK (valor > 0),
    CONSTRAINT chk_forma_pago_viaje 
        CHECK (forma_pago IN ('EFECTIVO', 'TRANSFERENCIA', 'TARJETA'))
);

CREATE TABLE RESERVAS (
    id_reserva NUMBER PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    id_viaje NUMBER NOT NULL,
    asiento NUMBER NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    fecha_reserva DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_reserva_cliente 
        FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente),
    CONSTRAINT fk_reserva_viaje 
        FOREIGN KEY (id_viaje) REFERENCES VIAJES(id_viaje),
    CONSTRAINT chk_asiento_reserva 
        CHECK (asiento > 0),
    CONSTRAINT chk_estado_reserva 
        CHECK (estado IN ('RESERVADO', 'PAGADO', 'ANULADO')),
    CONSTRAINT uk_viaje_asiento 
        UNIQUE (id_viaje, asiento)
);

CREATE TABLE FACTURAS (
    id_factura NUMBER PRIMARY KEY,
    numero_factura VARCHAR2(20) NOT NULL UNIQUE,
    fecha DATE NOT NULL,
    id_cliente NUMBER NOT NULL,
    total NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_factura_cliente 
        FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente),
    CONSTRAINT chk_total_factura 
        CHECK (total >= 0)
);


-- ============================================================
-- 7. CREACIÓN DE SECUENCIAS
-- ============================================================

CREATE SEQUENCE seq_reserva
START WITH 11
INCREMENT BY 1;

CREATE SEQUENCE seq_factura
START WITH 1
INCREMENT BY 1;


-- ============================================================
-- 8. INSERCIÓN DE DATOS DML
-- ============================================================

-- 5 CLIENTES
INSERT INTO CLIENTES VALUES (1, '1800000001', 'Ana Perez', '0991111111', 'ana@gmail.com');
INSERT INTO CLIENTES VALUES (2, '1800000002', 'Luis Gomez', '0992222222', 'luis@gmail.com');
INSERT INTO CLIENTES VALUES (3, '1800000003', 'Maria Lopez', '0993333333', 'maria@gmail.com');
INSERT INTO CLIENTES VALUES (4, '1800000004', 'Carlos Ruiz', '0994444444', 'carlos@gmail.com');
INSERT INTO CLIENTES VALUES (5, '1800000005', 'Sofia Torres', '0995555555', 'sofia@gmail.com');

-- 5 CONDUCTORES
INSERT INTO CONDUCTORES VALUES (1, '1700000001', 'Pedro Molina', 'LIC-001', '0981111111');
INSERT INTO CONDUCTORES VALUES (2, '1700000002', 'Gabriela Castro', 'LIC-002', '0982222222');
INSERT INTO CONDUCTORES VALUES (3, '1700000003', 'Jorge Salazar', 'LIC-003', '0983333333');
INSERT INTO CONDUCTORES VALUES (4, '1700000004', 'Daniela Vega', 'LIC-004', '0984444444');
INSERT INTO CONDUCTORES VALUES (5, '1700000005', 'Marco Herrera', 'LIC-005', '0985555555');

-- 5 VEHÍCULOS
INSERT INTO VEHICULOS VALUES (1, 'ABC-1234', 'Automovil', 'Chevrolet', 4, 'DISPONIBLE');
INSERT INTO VEHICULOS VALUES (2, 'DEF-5678', 'Camioneta', 'Toyota', 5, 'DISPONIBLE');
INSERT INTO VEHICULOS VALUES (3, 'GHI-9012', 'Van', 'Hyundai', 12, 'DISPONIBLE');
INSERT INTO VEHICULOS VALUES (4, 'JKL-3456', 'Automovil', 'Kia', 4, 'DISPONIBLE');
INSERT INTO VEHICULOS VALUES (5, 'MNO-7890', 'Buseta', 'Mercedes', 18, 'MANTENIMIENTO');

-- 5 VIAJES
INSERT INTO VIAJES VALUES (1, TO_DATE('2026-06-10', 'YYYY-MM-DD'), 'Ambato', 'Quito', 25.00, 'EFECTIVO', 1, 1);
INSERT INTO VIAJES VALUES (2, TO_DATE('2026-06-11', 'YYYY-MM-DD'), 'Ambato', 'Latacunga', 15.00, 'TRANSFERENCIA', 2, 2);
INSERT INTO VIAJES VALUES (3, TO_DATE('2026-06-12', 'YYYY-MM-DD'), 'Quito', 'Guayaquil', 45.00, 'TARJETA', 1, 3);
INSERT INTO VIAJES VALUES (4, TO_DATE('2026-06-13', 'YYYY-MM-DD'), 'Riobamba', 'Quito', 35.00, 'EFECTIVO', 3, 4);
INSERT INTO VIAJES VALUES (5, TO_DATE('2026-06-14', 'YYYY-MM-DD'), 'Ambato', 'Cuenca', 55.00, 'TARJETA', 4, 5);

-- 10 RESERVAS
INSERT INTO RESERVAS VALUES (1, 1, 1, 1, 'PAGADO', SYSDATE);
INSERT INTO RESERVAS VALUES (2, 1, 2, 1, 'RESERVADO', SYSDATE);
INSERT INTO RESERVAS VALUES (3, 1, 3, 1, 'PAGADO', SYSDATE);
INSERT INTO RESERVAS VALUES (4, 2, 1, 2, 'PAGADO', SYSDATE);
INSERT INTO RESERVAS VALUES (5, 2, 4, 1, 'ANULADO', SYSDATE);
INSERT INTO RESERVAS VALUES (6, 2, 5, 1, 'PAGADO', SYSDATE);
INSERT INTO RESERVAS VALUES (7, 3, 3, 2, 'PAGADO', SYSDATE);
INSERT INTO RESERVAS VALUES (8, 3, 5, 2, 'RESERVADO', SYSDATE);
INSERT INTO RESERVAS VALUES (9, 4, 4, 2, 'ANULADO', SYSDATE);
INSERT INTO RESERVAS VALUES (10, 4, 2, 2, 'PAGADO', SYSDATE);

COMMIT;


-- ============================================================
-- 9. MOSTRAR DATOS INSERTADOS
-- ============================================================

SELECT * FROM CLIENTES;
SELECT * FROM CONDUCTORES;
SELECT * FROM VEHICULOS;
SELECT * FROM VIAJES;
SELECT * FROM RESERVAS;


-- ============================================================
-- 10. ACTUALIZACIÓN
-- ============================================================

-- ENUNCIADO:
-- Incrementar en 10% el valor de todos los viajes con destino Quito.

UPDATE VIAJES
SET valor = valor * 1.10
WHERE destino = 'Quito';

SELECT 
    id_viaje,
    origen,
    destino,
    valor
FROM VIAJES
WHERE destino = 'Quito';


-- ============================================================
-- 11. ELIMINACIÓN
-- ============================================================

-- ENUNCIADO:
-- Eliminar las reservas anuladas.

DELETE FROM RESERVAS
WHERE estado = 'ANULADO';

SELECT * FROM RESERVAS;

COMMIT;


-- ============================================================
-- 12. TRANSACCIÓN DE PRUEBA CON ROLLBACK
-- ============================================================

-- Primero se inserta un cliente temporal.
INSERT INTO CLIENTES VALUES (6, '1800000006', 'Cliente Temporal', '0996666666', 'temporal@gmail.com');

-- Se comprueba que sí fue insertado.
SELECT * FROM CLIENTES WHERE id_cliente = 6;

-- Se revierte la transacción.
ROLLBACK;

-- Se comprueba que el cliente temporal ya no existe.
SELECT * FROM CLIENTES WHERE id_cliente = 6;


-- ============================================================
-- 13. CONSULTAS SQL AVANZADAS
-- ============================================================


-- ------------------------------------------------------------
-- CONSULTA 1
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el cliente que ha realizado el mayor número de reservas.

SELECT 
    c.id_cliente,
    c.nombres AS cliente,
    COUNT(r.id_reserva) AS total_reservas
FROM CLIENTES c
INNER JOIN RESERVAS r
    ON c.id_cliente = r.id_cliente
GROUP BY 
    c.id_cliente,
    c.nombres
ORDER BY total_reservas DESC


-- ------------------------------------------------------------
-- CONSULTA 2
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el conductor que ha realizado más viajes.

SELECT 
    co.id_conductor,
    co.nombres AS conductor,
    COUNT(v.id_viaje) AS total_viajes
FROM CONDUCTORES co
INNER JOIN VIAJES v
    ON co.id_conductor = v.id_conductor
GROUP BY 
    co.id_conductor,
    co.nombres
ORDER BY total_viajes DESC


-- ------------------------------------------------------------
-- CONSULTA 3
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el total de ingresos generados por cada viaje.
-- Se consideran ingresos solo de reservas con estado PAGADO.

SELECT 
    v.id_viaje,
    v.origen,
    v.destino,
    v.valor,
    SUM(
        CASE 
            WHEN r.estado = 'PAGADO' THEN v.valor 
            ELSE 0 
        END
    ) AS total_ingresos
FROM VIAJES v
LEFT JOIN RESERVAS r
    ON v.id_viaje = r.id_viaje
GROUP BY 
    v.id_viaje,
    v.origen,
    v.destino,
    v.valor
ORDER BY v.id_viaje;


-- ------------------------------------------------------------
-- CONSULTA 4
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar los clientes que nunca han realizado reservas.

SELECT 
    c.id_cliente,
    c.nombres AS cliente,
    c.telefono
FROM CLIENTES c
LEFT JOIN RESERVAS r
    ON c.id_cliente = r.id_cliente
WHERE r.id_reserva IS NULL;


-- ------------------------------------------------------------
-- CONSULTA 5
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el promedio de ingresos generado por cada conductor.

SELECT 
    co.id_conductor,
    co.nombres AS conductor,
    AVG(
        CASE 
            WHEN r.estado = 'PAGADO' THEN v.valor 
            ELSE 0 
        END
    ) AS promedio_ingresos
FROM CONDUCTORES co
INNER JOIN VIAJES v
    ON co.id_conductor = v.id_conductor
LEFT JOIN RESERVAS r
    ON v.id_viaje = r.id_viaje
GROUP BY 
    co.id_conductor,
    co.nombres
ORDER BY promedio_ingresos DESC;


-- ------------------------------------------------------------
-- CONSULTA 6
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el viaje con el valor más alto registrado.

SELECT 
    id_viaje,
    fecha,
    origen,
    destino,
    valor
FROM VIAJES
ORDER BY valor DESC



-- ------------------------------------------------------------
-- CONSULTA 7
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar los tres clientes con mayor cantidad de reservas.

SELECT 
    c.id_cliente,
    c.nombres AS cliente,
    COUNT(r.id_reserva) AS cantidad_reservas
FROM CLIENTES c
INNER JOIN RESERVAS r
    ON c.id_cliente = r.id_cliente
GROUP BY 
    c.id_cliente,
    c.nombres
ORDER BY cantidad_reservas DESC



-- ------------------------------------------------------------
-- CONSULTA 8
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar cuántos viajes existen por destino.

SELECT 
    destino,
    COUNT(id_viaje) AS cantidad_viajes
FROM VIAJES
GROUP BY destino
ORDER BY cantidad_viajes DESC;


-- ------------------------------------------------------------
-- CONSULTA 9
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar el conductor cuyos viajes generan más ingresos acumulados.

SELECT 
    co.id_conductor,
    co.nombres AS conductor,
    SUM(
        CASE 
            WHEN r.estado = 'PAGADO' THEN v.valor 
            ELSE 0 
        END
    ) AS ingresos_acumulados
FROM CONDUCTORES co
INNER JOIN VIAJES v
    ON co.id_conductor = v.id_conductor
LEFT JOIN RESERVAS r
    ON v.id_viaje = r.id_viaje
GROUP BY 
    co.id_conductor,
    co.nombres
ORDER BY ingresos_acumulados DESC
FETCH FIRST 1 ROW ONLY;


-- ------------------------------------------------------------
-- CONSULTA 10
-- ------------------------------------------------------------
-- ENUNCIADO:
-- Mostrar los destinos cuyo ingreso promedio sea superior al promedio general de todos los viajes.

SELECT 
    destino,
    AVG(valor) AS ingreso_promedio_destino
FROM VIAJES
GROUP BY destino
HAVING AVG(valor) > (
    SELECT AVG(valor)
    FROM VIAJES
)
ORDER BY ingreso_promedio_destino DESC;


-- ============================================================
-- 14. PL/SQL - EJERCICIO 1: BLOQUE ANÓNIMO
-- ============================================================

-- ENUNCIADO:
-- Crear un bloque anónimo que reciba el código de un viaje.
-- Obtenga el valor del viaje mediante SELECT INTO.
-- Muestre VIAJE ECONÓMICO si el valor es menor a 20 dólares.
-- Muestre VIAJE PREMIUM si el valor es mayor o igual a 20 dólares.

DECLARE
    v_codigo_viaje NUMBER := 2;
    v_valor VIAJES.valor%TYPE;
BEGIN
    SELECT valor 
    INTO v_valor
    FROM VIAJES
    WHERE id_viaje = v_codigo_viaje;

    IF v_valor < 20 THEN
        DBMS_OUTPUT.PUT_LINE('VIAJE ECONÓMICO');
    ELSE
        DBMS_OUTPUT.PUT_LINE('VIAJE PREMIUM');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Código de viaje: ' || v_codigo_viaje);
    DBMS_OUTPUT.PUT_LINE('Valor del viaje: ' || v_valor);
END;
/


-- ============================================================
-- 15. PL/SQL - EJERCICIO 2: PROCEDURE REGISTRAR_RESERVA
-- ============================================================

-- ENUNCIADO:
-- Crear un procedimiento almacenado llamado REGISTRAR_RESERVA
-- que reciba CLIENTE, VIAJE y ASIENTO.
--
-- El procedimiento debe:
-- Verificar si el asiento está disponible.
-- Registrar la reserva.
-- Confirmar la transacción.
-- Generar una excepción cuando el asiento ya se encuentre ocupado.

CREATE OR REPLACE PROCEDURE REGISTRAR_RESERVA (
    p_id_cliente IN NUMBER,
    p_id_viaje IN NUMBER,
    p_asiento IN NUMBER
)
AS
    v_asiento_ocupado NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_asiento_ocupado
    FROM RESERVAS
    WHERE id_viaje = p_id_viaje
    AND asiento = p_asiento;

    IF v_asiento_ocupado > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'EL ASIENTO YA SE ENCUENTRA OCUPADO');
    ELSE
        INSERT INTO RESERVAS (
            id_reserva,
            id_cliente,
            id_viaje,
            asiento,
            estado,
            fecha_reserva
        )
        VALUES (
            seq_reserva.NEXTVAL,
            p_id_cliente,
            p_id_viaje,
            p_asiento,
            'RESERVADO',
            SYSDATE
        );

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('RESERVA REGISTRADA CORRECTAMENTE');
    END IF;
END;
/

SHOW ERRORS;


-- PRUEBA CORRECTA DEL PROCEDIMIENTO
BEGIN
    REGISTRAR_RESERVA(5, 4, 1);
END;
/

SELECT * FROM RESERVAS WHERE id_cliente = 5;


-- PRUEBA DE ERROR DEL PROCEDIMIENTO
-- Este asiento ya está ocupado en el viaje 1.
BEGIN
    REGISTRAR_RESERVA(3, 1, 1);
END;
/


-- ============================================================
-- 16. PL/SQL - EJERCICIO 3: CURSOR EXPLÍCITO
-- ============================================================

-- ENUNCIADO:
-- Crear un cursor que recorra todas las reservas registradas.
-- Mostrar por pantalla:
-- Cliente, Viaje, Asiento y Estado.

DECLARE
    CURSOR c_reservas IS
        SELECT 
            c.nombres AS cliente,
            'Viaje ' || v.id_viaje || ': ' || v.origen || ' - ' || v.destino AS viaje,
            r.asiento,
            r.estado
        FROM RESERVAS r
        INNER JOIN CLIENTES c
            ON r.id_cliente = c.id_cliente
        INNER JOIN VIAJES v
            ON r.id_viaje = v.id_viaje
        ORDER BY r.id_reserva;

    v_cliente VARCHAR2(80);
    v_viaje VARCHAR2(150);
    v_asiento NUMBER;
    v_estado VARCHAR2(20);
BEGIN
    OPEN c_reservas;

    LOOP
        FETCH c_reservas 
        INTO v_cliente, v_viaje, v_asiento, v_estado;

        EXIT WHEN c_reservas%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_cliente);
        DBMS_OUTPUT.PUT_LINE('Viaje: ' || v_viaje);
        DBMS_OUTPUT.PUT_LINE('Asiento: ' || v_asiento);
        DBMS_OUTPUT.PUT_LINE('Estado: ' || v_estado);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;

    CLOSE c_reservas;
END;
/


-- ============================================================
-- 17. PL/SQL - EJERCICIO 4: TRIGGER
-- ============================================================

-- ENUNCIADO:
-- Crear un Trigger BEFORE INSERT sobre la tabla RESERVAS.
-- El Trigger debe impedir ASIENTO <= 0.
-- Si ocurre la inserción inválida deberá mostrar ASIENTO INVÁLIDO.

CREATE OR REPLACE TRIGGER trg_validar_asiento_reserva
BEFORE INSERT ON RESERVAS
FOR EACH ROW
BEGIN
    IF :NEW.asiento <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'ASIENTO INVÁLIDO');
    END IF;
END;
/

SHOW ERRORS;


-- PRUEBA DEL TRIGGER
-- Esta inserción debe generar error: ASIENTO INVÁLIDO.

INSERT INTO RESERVAS (
    id_reserva,
    id_cliente,
    id_viaje,
    asiento,
    estado,
    fecha_reserva
)
VALUES (
    seq_reserva.NEXTVAL,
    1,
    1,
    0,
    'RESERVADO',
    SYSDATE
);


-- ============================================================
-- 18. BONUS - PROCEDURE GENERAR_FACTURA
-- ============================================================

-- ENUNCIADO:
-- Crear un procedimiento almacenado llamado GENERAR_FACTURA que:
-- Recorra todas las reservas mediante un cursor.
-- Calcule el total pagado por cada cliente.
-- Genere automáticamente registros en una tabla FACTURAS.
-- Registre:
-- Número de factura
-- Fecha
-- Cliente
-- Total

CREATE OR REPLACE PROCEDURE GENERAR_FACTURA
AS
    CURSOR c_reservas_pagadas IS
        SELECT 
            r.id_cliente,
            v.valor
        FROM RESERVAS r
        INNER JOIN VIAJES v
            ON r.id_viaje = v.id_viaje
        WHERE r.estado = 'PAGADO'
        ORDER BY r.id_cliente;

    v_id_cliente RESERVAS.id_cliente%TYPE;
    v_valor VIAJES.valor%TYPE;
    v_existe NUMBER;
    v_id_factura NUMBER;
BEGIN
    -- Se limpian facturas anteriores para evitar duplicados al volver a ejecutar.
    DELETE FROM FACTURAS;

    OPEN c_reservas_pagadas;

    LOOP
        FETCH c_reservas_pagadas 
        INTO v_id_cliente, v_valor;

        EXIT WHEN c_reservas_pagadas%NOTFOUND;

        SELECT COUNT(*)
        INTO v_existe
        FROM FACTURAS
        WHERE id_cliente = v_id_cliente;

        IF v_existe = 0 THEN
            SELECT seq_factura.NEXTVAL
            INTO v_id_factura
            FROM dual;

            INSERT INTO FACTURAS (
                id_factura,
                numero_factura,
                fecha,
                id_cliente,
                total
            )
            VALUES (
                v_id_factura,
                'FAC-' || TO_CHAR(v_id_factura, 'FM0000'),
                SYSDATE,
                v_id_cliente,
                v_valor
            );
        ELSE
            UPDATE FACTURAS
            SET total = total + v_valor
            WHERE id_cliente = v_id_cliente;
        END IF;
    END LOOP;

    CLOSE c_reservas_pagadas;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('FACTURAS GENERADAS CORRECTAMENTE');
END;
/

SHOW ERRORS;


-- EJECUTAR PROCEDIMIENTO BONUS
BEGIN
    GENERAR_FACTURA;
END;
/


-- MOSTRAR FACTURAS GENERADAS
SELECT 
    f.numero_factura,
    f.fecha,
    c.nombres AS cliente,
    f.total
FROM FACTURAS f
INNER JOIN CLIENTES c
    ON f.id_cliente = c.id_cliente
ORDER BY f.numero_factura;


-- ============================================================
-- 19. CONSULTAS FINALES DE VERIFICACIÓN
-- ============================================================

SELECT * FROM CLIENTES;
SELECT * FROM CONDUCTORES;
SELECT * FROM VEHICULOS;
SELECT * FROM VIAJES;
SELECT * FROM RESERVAS;
SELECT * FROM FACTURAS;

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
```
