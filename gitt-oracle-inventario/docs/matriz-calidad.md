# Matriz de calidad

| Atributo | Criterio | Evidencia sugerida |
| --- | --- | --- |
| Usabilidad | Interfaz intuitiva, filtros visibles y diseno responsivo. | Capturas de dashboard, inventario y formularios. |
| Seguridad | Login, JWT, roles, endpoints protegidos y auditoria. | Swagger con token y tabla AUDITORIA. |
| Mantenibilidad | Capas separadas, nombres consistentes y documentacion. | Estructura backend y manual tecnico. |
| Eficiencia | Indices en correo, codigo, estado y fechas. | Script DDL y consultas DQL. |
| Confiabilidad | Claves, checks, FKs y triggers de reglas criticas. | Ejecucion de `00_bd_completa.sql` y prueba de triggers. |
| Portabilidad | Ejecucion con Docker Compose. | Captura de contenedores activos. |
