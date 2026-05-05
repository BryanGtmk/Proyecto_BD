# Sistema Web de Gestion de Inventario Tecnologico para la FISEI

Proyecto full stack orientado exclusivamente a Oracle Database. Convierte el modelo logico y relacional de la fase 1 al modelo fisico Oracle y agrega una API ASP.NET Core con JWT y un frontend React.

## Tecnologias

- Oracle Database Free/XE, Oracle SQL, DDL, DML, DQL, triggers, checks, indices y auditoria.
- ASP.NET Core Web API, C#, Entity Framework Core, Oracle.EntityFrameworkCore, Swagger y JWT.
- React + Vite, JavaScript, Tailwind CSS, React Router y Axios.
- Docker y Docker Compose.

## Estructura

```text
gitt-oracle-inventario/
  backend/
    GittInventario.Api/
    GittInventario.Application/
    GittInventario.Domain/
    GittInventario.Infrastructure/
  frontend/
  database/
    ddl/
    dml/
    dql/
    full/
    evidencias/
  docs/
    diagramas/
    manual-tecnico/
    manual-usuario/
    requerimientos.md
    matriz-calidad.md
```

## Docker

```bash
cd gitt-oracle-inventario
copy .env.example .env
docker compose up --build
```

Servicios:

- Oracle: `localhost:1521/FREEPDB1`
- API: `http://localhost:8080`
- Swagger: `http://localhost:8080/swagger`
- Frontend: `http://localhost:5173`

## Ejecutar script Oracle

El compose monta `database/full` en `/container-entrypoint-initdb.d`. Si la imagen no ejecuta el script automaticamente o el volumen ya existia, correrlo manualmente:

```bash
docker exec -it gitt-oracle-db sqlplus GITT_INV/Gitt2026*@FREEPDB1 @/container-entrypoint-initdb.d/00_bd_completa.sql
```

Tambien puede ejecutarse desde Oracle SQL Developer conectado a:

- Usuario: `GITT_INV`
- Contrasena: `Gitt2026*`
- Host: `localhost`
- Puerto: `1521`
- Service name: `FREEPDB1`

## Backend sin Docker

```bash
cd gitt-oracle-inventario/backend/GittInventario.Api
dotnet restore
dotnet run
```

Configure `ConnectionStrings:OracleConnection` en `appsettings.json` o variables de entorno.

## Frontend sin Docker

```bash
cd gitt-oracle-inventario/frontend
copy .env.example .env
npm install
npm run dev
```

## Swagger y login

1. Abrir `http://localhost:8080/swagger`.
2. Ejecutar `POST /api/auth/login`.
3. Body:

```json
{
  "correo": "admin@fisei.edu.ec",
  "contrasena": "Admin123*"
}
```

4. Copiar el token, pulsar `Authorize` y pegarlo como Bearer token.

## Capturas sugeridas

- Contenedores Docker activos.
- Ejecucion exitosa de `00_bd_completa.sql`.
- `SELECT COUNT(*)` de las tablas.
- Swagger con login y endpoints protegidos.
- Dashboard frontend.
- Inventario, crear articulo, prestamos y devolucion.
- Consultas DQL ejecutadas en SQL Developer.
- Auditoria generada por triggers.
- Detalle de articulo con imagen y valor estimado.
- Reporte de valor del inventario por departamento.

## Problemas comunes

- Oracle tarda en iniciar: esperar el healthcheck antes de usar la API.
- El script no se recarga: eliminar el volumen `oracle-data` o ejecutar el script manualmente.
- Error 401 en frontend: iniciar sesion nuevamente y verificar el JWT.
- Error de conexion Oracle: revisar service name `FREEPDB1`, puerto 1521 y credenciales.

## Verificacion de base de datos

No se usa MySQL, SQL Server, PostgreSQL, SQLite ni MongoDB. La persistencia esta implementada con Oracle Database, SQL Oracle y `Oracle.EntityFrameworkCore`.
