# 🚀 GUÍA RÁPIDA - Cómo Comenzar

## ¿Cuál es tu rol en el proyecto?

### 👤 Si eres **Miembro 1** - Sección INTRODUCCIÓN
```
📄 Archivo: documentacion/main.tex
📍 Busca: "TODO: [RESPONSABLE: Miembro 1]"
📝 Qué escribir:
   - Objetivo general (2-3 párrafos)
   - 3-5 objetivos específicos
   - Alcance y limitaciones
```

### 🎨 Si eres **Miembro 2** - Sección DISEÑO LÓGICO (MER)
```
📄 Archivo: documentacion/main.tex
📍 Busca: "TODO: [RESPONSABLE: Miembro 2]"
📸 Qué hacer:
   1. Crear diagrama MER (usa Lucidchart, Draw.io o MySQL Workbench)
   2. Guardar como: documentacion/img/mer.png
   3. Descomenta la línea: \includegraphics[width=0.9\textwidth]{img/mer.png}
   4. Escribe descripción de entidades y relaciones
```

### 📋 Si eres **Miembro 3** - Sección DICCIONARIO DE DATOS
```
📄 Archivo: documentacion/main.tex
📍 Busca: "TODO: [RESPONSABLE: Miembro 3]"
📝 Qué hacer:
   - Crear Una tabla LaTeX por cada entidad
   - Documentar: Campo | Tipo | NULL | Clave | Descripción
   - Mínimo 10-15 tablas
   
💡 Ejemplo:
\begin{tabular}{|l|l|l|l|p{4cm}|}
    usuario_id | INT | NO | PK | ID único usuario
\end{tabular}
```

### ✔️ Si eres **Miembro 4** - Sección NORMALIZACIÓN
```
📄 Archivo: documentacion/main.tex
📍 Busca: "TODO: [RESPONSABLE: Miembro 4]"
📝 Qué documentar:
   ✓ 1FN: Atomicidad (ejemplo ANTES/DESPUÉS)
   ✓ 2FN: Eliminar dependencias parciales
   ✓ 3FN: Eliminar dependencias transitivas
   ✓ Justificar cada transformación
```

### 🔗 Si eres **Miembro 5** - Sección CONSULTAS SQL
```
📄 Archivo: documentacion/main.tex
📍 Busca: "TODO: [RESPONSABLE: Miembro 5]"
📝 Qué documentar:
   - SELECT (queries de lectura)
   - INSERT (inserción de datos)
   - UPDATE (actualización)
   - DELETE (eliminación con precaución)
   - JOINs complejos
   - Transacciones
   
✅ Ya hay ejemplos en: scripts/queries.sql
```

---

## 1️⃣ Paso 1: Configurar tu Entorno Local

### Necesitas Instalar:

#### 📦 LaTeX (elige UNO):
```bash
# Windows - Descarga MiKTeX
https://miktex.org/download

# macOS
brew install mactex

# Linux
sudo apt-get install texlive-full
```

#### 🗄️ MySQL
```bash
# Windows / macOS / Linux desde: https://dev.mysql.com/downloads/mysql/

# O usando package manager:
brew install mysql          # macOS
sudo apt-get install mysql-server   # Linux
```

---

## 2️⃣ Paso 2: Clonar y Configurar el Repo

```bash
# Clonar
git clone https://github.com/BryanGtmk/Proyecto_BD.git
cd Proyecto_BD

# Crear rama para tu sección
git checkout -b feature/seccion-introduccion
# O reemplaza "seccion-introduccion" con tu sección
```

---

## 3️⃣ Paso 3: Crear la Base de Datos de Prueba

```bash
# Conectar a MySQL
mysql -u root -p

# Ejecutar script SQL
mysql -u root -p < scripts/schema.sql

# Verificar tablas creadas
mysql -u root -p proyecto_bd -e "SHOW TABLES;"
```

---

## 4️⃣ Paso 4: Compilar el Documento LaTeX

### Opción A: Línea de Comandos
```bash
cd documentacion/
pdflatex -interaction=nonstopmode main.tex
# Genera: main.pdf
```

### Opción B: Overleaf (Recomendado)
1. Ve a: https://www.overleaf.com
2. Sign up / Log in
3. New Project → Upload
4. Selecciona `main.tex` y carpeta `img/`
5. ¡Se compila automáticamente!

---

## 5️⃣ Paso 5: Editar tu Sección

### En VS Code (Recomendado para editar .tex):
```bash
code documentacion/main.tex
```

### Busca el comentario `TODO` de tu sección:
```latex
% ========================================================================
% SECCIÓN 1: INTRODUCCIÓN
% ========================================================================
% TODO: [RESPONSABLE: Tu Nombre]
% Descripción: Completar la introducción del proyecto
% Fecha esperada: [FECHA]
% ========================================================================
```

### Edita entre these comentarios:
```latex
\section{Introducción}

% Tu contenido va aquí
\subsection{Objetivo General}
[ESCRIBE AQUÍ TU OBJETIVO GENERAL]

\subsection{Objetivos Específicos}
\begin{itemize}
    \item [OBJETIVO 1]
    \item [OBJETIVO 2]
    \item [OBJETIVO 3]
\end{itemize}
```

---

## 6️⃣ Paso 6: Guardar y Hacer Commit

```bash
# Ver cambios
git status

# Agregar cambios
git add documentacion/main.tex

# Hacer commit CON MENSAJE DESCRIPTIVO
git commit -m "Completar Sección: Introducción

- Escribir objetivo general del proyecto
- Listar 5 objetivos específicos (SMART)
- Definir alcance del proyecto
- Mencionar limitaciones identificadas

Por: Tu Nombre"
```

---

## 7️⃣ Paso 7: Subir y Crear Pull Request

```bash
# Subir tu rama
git push origin feature/seccion-introduccion

# (En GitHub, crearás un PR - Click en el botón "Pull Request")
```

---

## 🆘 Problemas Comunes y Soluciones

### ❌ Error: "command not found: pdflatex"
```bash
# Instala texlive (ya debería estar si instalaste MiKTeX/MacTeX/texlive-full)
# Windows: Re-descarga MiKTeX
# macOS: brew install mactex
# Linux: sudo apt-get install texlive-full
```

### ❌ Error: "acentos se ven mal" en PDF
✅ El archivo main.tex **ya incluye** la configuración correcta:
```latex
\usepackage[utf-8]{inputenc}
\usepackage[spanish]{babel}
```

### ❌ Error: "mysql: command not found"
```bash
# Windows: Agrega MySQL al PATH
# O especifica ruta completa:
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql" -u root -p

# macOS/Linux: Instala mysql-client
brew install mysql-client          # macOS
sudo apt-get install mysql-client  # Linux
```

### ❌ Error: "Access denied for user 'root'"
```bash
# Probablemente no ingresaste tu contraseña de MySQL
# Intenta sin -p primero para verificar:
mysql -u root

# O con contraseña:
mysql -u root -p
(Then type your password)
```

### ❌ Error de compilación LaTeX
1. **Verifica la sintaxis** - ¿Cerraste todas las `{llaves}`?
2. **Verifica caracteres especiales** - El archivo está en UTF-8 ✅
3. **Verifica rutas de imágenes** - ¿Está `img/mer.png` en lugar correcto?
4. **Intenta recompilar:**
   ```bash
   rm -f *.aux *.log main.pdf  # Limpiar archivos temporales
   pdflatex -interaction=nonstopmode main.tex
   ```

---

## 📚 Ejemplos de Sintaxis LaTeX

### Escribir Texto
```latex
\textbf{Texto en negrita}
\textit{Texto en itálica}
\texttt{texto_monoespaciado}
```

### Listas
```latex
\begin{itemize}
    \item Elemento 1
    \item Elemento 2
\end{itemize}

\begin{enumerate}
    \item Elemento numerado 1
    \item Elemento numerado 2
\end{enumerate}
```

### Tablas
```latex
\begin{center}
\begin{tabular}{|l|l|l|}
    \hline
    \textbf{Columna 1} & \textbf{Columna 2} & \textbf{Columna 3} \\
    \hline
    Dato 1 & Dato 2 & Dato 3 \\
    \hline
\end{tabular}
\end{center}
```

### Código SQL
```latex
\begin{lstlisting}
SELECT * FROM usuarios WHERE ID = 1;
\end{lstlisting}
```

### Imágenes
```latex
\begin{center}
\includegraphics[width=0.9\textwidth]{img/mi_imagen.png}
\end{center}
```

---

## 📞 ¿Necesitas Ayuda?

1. **WhatsApp/Telegram**: Contacta al coordinador (Bryan)
2. **Issues GitHub**: Abre un issue describiendo el error
3. **Overleaf Chat**: Si estás usando Overleaf, usa el chat integrado
4. **Stack Overflow**: Para preguntas LaTeX avanzadas

---

## ✅ Checklist Antes de Hacer Commit

- [ ] Compilé el PDF sin errores LaTeX
- [ ] La sección se ve correcta en el PDF
- [ ] Agregué comentarios si fue necesario
- [ ] Las imágenes están en la carpeta `img/`
- [ ] No hay caracteres especiales que rompan el PDF
- [ ] Mi commit tiene un mensaje descriptivo
- [ ] No modifiqué secciones de otros compañeros

---

## 🎓 Recordatorio Final

> **Este es un trabajo en equipo.**
> 
> ✅ Completa TU sección profesionalmente
> ✅ Respeta el trabajo de tus compañeros
> ✅ Comunica si necesitas cambios en otras secciones
> ✅ Haz commits pequeños y frecuentes
> ✅ Escribe mensajes descriptivos

---

## 📅 Cronograma

| Semana | Hito |
|--------|------|
| Semana 1 | Secciones 1 y 2 listas |
| Semana 2 | Sección 3 lista |
| Semana 3 | Secciones 4 y 5 listas |
| Semana 4 | Revisión y ajustes finales |

---

¡**BUENA SUERTE** con tu sección! 🚀

Última actualización: 04 de marzo de 2026
