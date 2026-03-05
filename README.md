# Proyecto Base de Datos - Documentación Académica Profesional

## 📋 Descripción del Proyecto

Este repositorio contiene la documentación académica profesional de un proyecto de Base de Datos, incluyendo:
- ✅ Diseño lógico con Modelo Entidad Relación (MER)
- ✅ Diccionario de Datos completo
- ✅ Proceso de Normalización (1FN, 2FN, 3FN)
- ✅ Scripts SQL optimizados con InnoDB
- ✅ Consultas principales documentadas

Se utiliza **LaTeX** para generación de informes profesionales y **GitHub** para control de versiones.

---

## 👥 Integrantes del Grupo

| Nombre y Apellido | Rol / Responsabilidad | Usuario de GitHub | Sección Asignada |
| :--- | :--- | :--- | :--- |
| **Bryan Guatemal** | Coordinador / Gestión de Repo | @BryanGtmk | Estructura general |
| Carlos Benjarano | Diseño MER / Documentación | @usuario1 | Diseño Lógico (Sección 2) |
| Karen Molina | Scripts SQL / Normalización | @usuario2 | Normalización (Sección 4) |
| [Nombre Socio 3] | Consultas / Documentación | @usuario3 | Consultas SQL (Sección 5) |
| [Nombre Socio 4] | Diccionario de Datos | @usuario4 | Diccionario de Datos (Sección 3) |

---

## 📁 Estructura del Repositorio

```
Proyecto_BD/
├── README.md                          # Este archivo - Guía de colaboración
├── documentacion/
│   ├── main.tex                       # 📄 Documento LaTeX PRINCIPAL
│   └── img/                           # 📸 Carpeta para imágenes
│       ├── mer.png                    # [RESPONSABLE: Miembro 2] Modelo Entidad Relación
│       └── ...
├── scripts/
│   ├── schema.sql                     # 🗄️ Creación del esquema (DDL)
│   ├── queries.sql                    # [A CREAR] Consultas principales
│   └── ...
└── .gitignore                         # Ignorar archivos temporales LaTeX
```

### 📄 Archivos Clave

| Archivo | Responsable | Estado | Descripción |
|---------|-------------|--------|-------------|
| `main.tex` | Coordinador | ✅ Creado | Documento principal con estructura lista |
| `schema.sql` | Karen Molina | ✅ Creado | Esquema base con tablas ejemplo |
| `mer.png` | Carlos Benjarano | ⏳ Pendiente | Insertar diagrama en `img/` |
| Sección 1: Introducción | Miembro 1 | ⏳ Pendiente | Completar en `main.tex` |
| Sección 3: Diccionario | Miembro 4 | ⏳ Pendiente | Agregar todas las tablas |
| Sección 4: Normalización | Karen Molina | ⏳ Pendiente | Procesos 1FN, 2FN, 3FN |
| Sección 5: Consultas SQL | Miembro 3 | ⏳ Pendiente | Documentar en `main.tex` |

---

## 🚀 Inicio Rápido

### 1️⃣ Clonar el Repositorio
```bash
git clone https://github.com/BryanGtmk/Proyecto_BD.git
cd Proyecto_BD
```

### 2️⃣ Requisitos Previos

Instala según tu sistema operativo:

**Windows:**
```powershell
# LaTeX (MiKTeX)
# Descargar desde: https://miktex.org/download

# MySQL
choco install mysql  # o descargar desde https://dev.mysql.com/downloads/mysql/
```

**macOS:**
```bash
brew install mactex mysql
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install texlive-full mysql-server mysql-client
```

### 3️⃣ Compilar el Documento LaTeX

**Opción A: Línea de Comandos**
```bash
cd documentacion
pdflatex -interaction=nonstopmode main.tex
# Output: main.pdf
```

**Opción B: Overleaf (Recomendado - Sin instalación local)**
1. Ve a https://www.overleaf.com
2. Crea nuevo proyecto → Upload → Selecciona `main.tex`
3. Compila automáticamente en el navegador

### 4️⃣ Crear la Base de Datos

```bash
# Conectar a MySQL
mysql -u root -p

# Crear la BD y ejecutar schema
mysql -u root -p < scripts/schema.sql

# Verificar
mysql -u root -p -e "USE proyecto_bd; SHOW TABLES;"
```

---

## 📝 Flujo de Trabajo para Colaboradores

### Paso 1: Identificar tu Sección

Busca en `documentacion/main.tex`:
```latex
% TODO: [RESPONSABLE: Tu Nombre]
% Descripción: ...
% Fecha esperada: [FECHA]
```

### Paso 2: Crear una Rama

```bash
# Para Sección de Introducción
git checkout -b feature/seccion-introduccion

# Para agregar tablas SQL
git checkout -b feature/tabla-pedidos
```

### Paso 3: Realizar Cambios

**Editar archivos LaTeX:**
```bash
code documentacion/main.tex
```

**Agregar tablas SQL:**
```bash
code scripts/schema.sql
```

### Paso 4: Guardar Cambios

```bash
git add documentacion/main.tex scripts/schema.sql
git commit -m "Ampliar: Sección Introducción y Diccionario de Datos

- Completar objetivo general del proyecto
- Agregar 3 objetivos específicos
- Documentar 5 nuevas tablas en Diccionario
- Incluir restricciones y relaciones

Contribuidor: Tu Nombre"
```

### Paso 5: Subir y Crear Pull Request

```bash
git push origin feature/seccion-introduccion
```

Luego crear el PR en GitHub descriptivamente.

---

## 📋 Asignación de Responsabilidades Detallada

### 🔴 Sección 1: INTRODUCCIÓN (Miembro 1)
**Ubicación** → `documentacion/main.tex` línea ~45

**Tareas:**
- [ ] Escribir Objetivo General (2-3 párrafos)
- [ ] Listar 3-5 Objetivos Específicos (SMART)
- [ ] Definir Alcance del Proyecto
- [ ] Mencionar limitaciones
- [ ] Enlazar al MER en Sección 2

---

### 🟠 Sección 2: DISEÑO LÓGICO - MER (Miembro 2)
**Ubicación** → `documentacion/main.tex` línea ~80

**Tareas:**
- [ ] Crear diagrama MER en herramienta (Lucidchart, Draw.io, MySQL Workbench)
- [ ] Guardar imagen como `documentacion/img/mer.png`
- [ ] Describir TODAS las entidades
- [ ] Explicar relaciones y cardinalidad (1:1, 1:N, N:M)
- [ ] Justificar decisiones de diseño

---

### 🟡 Sección 3: DICCIONARIO DE DATOS (Miembro 4)
**Ubicación** → `documentacion/main.tex` línea ~130

**Tareas:**
- [ ] Crear tabla LaTeX por CADA entidad del MER
- [ ] Documentar campos: Nombre, Tipo, NOT NULL, Clave
- [ ] Incluir descripción clara de cada campo
- [ ] Especificar restricciones (UNIQUE, CHECK)
- [ ] Mínimo 10-15 tablas documentadas

---

### 🟢 Sección 4: NORMALIZACIÓN (Karen Molina)
**Ubicación** → `documentacion/main.tex` línea ~180

**Tareas:**
- [ ] Explicar detalladamente 1FN (atomicidad)
- [ ] Mostrar ejemplos ANTES y DESPUÉS
- [ ] Explicar 2FN y 3FN con transformaciones
- [ ] Justificar cambios realizados

---

### 🔵 Sección 5: CONSULTAS SQL (Miembro 3)
**Ubicación** → `documentacion/main.tex` línea ~240

**Tareas:**
- [ ] Documentar SELECT, INSERT, UPDATE, DELETE
- [ ] Mínimo 10 consultas diferentes
- [ ] Explicar JOINs complejos
- [ ] Incluir comentarios en cada consulta

---

## ✍️ Convenciones de Codificación

### SQL
```sql
-- Convención: snake_case para tablas y campos
CREATE TABLE nombre_tabla (
    tabla_id INT PRIMARY KEY,
    otro_campo VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Git Commits
```bash
git commit -m "Acción: Descripción breve

- Detalle 1
- Detalle 2

Contribuidor: Nombre"
```

---

## 📚 Recursos Útiles

### Herramientas
- **Editor LaTeX Online**: [Overleaf](https://www.overleaf.com)
- **Diagramas ER**: [Lucidchart](https://lucidchart.com), [Draw.io](https://draw.io)
- **SQL IDE**: [MySQL Workbench](https://www.mysql.com/products/workbench/)

### Documentación
- 📖 [LaTeX Beginner's Guide](https://www.overleaf.com/learn)
- 📖 [SQL Tutorial](https://www.w3schools.com/sql/)
- 📖 [Normalización de BD](https://en.wikipedia.org/wiki/Database_normalization)
- 📖 [Git SCM](https://git-scm.com/doc)

---

## 📄 Licencia

Proyecto académico. Respeta el código de honor universitario.

---

## ✨ Notas Finales

✅ **Todos los archivos base ya están creados** - Solo necesitas completar tu sección  
✅ **Comentarios guían cada sección** - Busca "TODO" en `main.tex`  
✅ **Ejemplos incluidos** - El documento tiene ejemplos para cada tipo de tabla  
✅ **Git está configurado** - Solo hace falta hacer commits y PRs  

**Última actualización:** 04 de marzo de 2026
