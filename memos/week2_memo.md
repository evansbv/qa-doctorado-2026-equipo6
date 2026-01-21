# memos/week2_memo.md

## Memo - Semana 2: Automatización Básica y Evidencias Iniciales

**Fecha:** 21 de enero de 2026  
**Autores:** 
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   
**Objetivo de la semana:** Implementar smoke test básico, definir y automatizar al menos 4 escenarios de prueba (SC-01 a SC-04), registrar evidencias trazables y centralizar ejecución mediante Makefile. Extensión: completar SC-05 y SC-06 para informe integral.

### Actividades realizadas

1. **Definición de escenarios**  
   - Actualizado `quality/scenarios.md` con formato estandarizado (Estímulo, Entorno, Respuesta, Medida falsable, Evidencia).  
   - Escenarios cubiertos:  
     - SC-01: Creación exitosa de mascota (Happy Path / Contract Availability)  
     - SC-02: Consulta por ID  
     - SC-03: Actualización de mascota  
     - SC-04: Creación inválida (Robustness / Error Handling)  
     - SC-05: Latencia básica en /store/inventory (Performance - Local)  
     - SC-06: Validación de forma de datos en inventario (Data Shape Sanity)

2. **Automatización de escenarios**  
   - Creados scripts dedicados en `scripts/`:  
     - `sc-01-create-pet.sh`  
     - `sc-02-get-pet.sh`  
     - `sc-03-update-pet.sh`  
     - `sc-04-invalid-create.sh`  
     - `sc-05-latency.sh` (30 repeticiones, CSV y métricas min/max/avg/p95)  
     - `sc-06-inventory-shape.sh` (validación JSON, estructura y valores numéricos >=0)  
   - Cada script genera evidencias independientes:  
     - Respuesta JSON completa  
     - Código HTTP  
     - Log con timestamp y resultado de validaciones falsables  
     - Para SC-05: CSV y summary adicional  

3. **Smoke test mejorado**  
   - Actualizado `scripts/smoke.sh`:  
     - Verifica 7+ endpoints clave (incluyendo los de SC-01 a SC-06)  
     - Incluye happy path, creación inválida y validación JSON básica  
     - Genera log detallado, resumen y archivos por endpoint  
     - Salida clara con OK/FAIL por cada check

4. **Centralización de ejecución**  
   - Actualizado `Makefile` en raíz:  
     - Objetivos: `setup`, `start-petstore`, `smoke`, `SC-01` a `SC-06`, `QA-week2`  
     - `QA-week2` ejecuta secuencialmente SC-01 a SC-06 y muestra mensaje de éxito  
     - Limpieza con `clean`

5. **Evidencias generadas**  
   - Carpeta `evidence/week2/` contiene:  
     - Logs detallados (`*.log`)  
     - Respuestas JSON (`*.json`)  
     - Códigos HTTP (`*_http_code.txt`)  
     - Para SC-05: `*.csv` y `*_summary.txt`  
     - Para SC-06: `*_shape_check.txt`  
     - Archivos de smoke test (por endpoint y summary)  
   - Ejemplo de ejecución: `./scripts/smoke.sh` o `make QA-week2`

### Resultados obtenidos

- **Smoke test**: Todos los endpoints críticos responden con códigos esperados (200 para happy path, 400/405 para inválido). JSON válido en respuestas exitosas.  
- **SC-01 a SC-04**: Automatizaciones exitosas con validaciones falsables (código HTTP, coincidencia de campos, formato JSON).  
- **SC-05**: Latencia medida en 30 repeticiones; ejemplo métricas: avg ~0.05s, p95 <0.1s (bien por debajo del umbral opcional de 1s). Todos 200 OK.  
- **SC-06**: JSON válido, estructura correcta, valores numéricos >=0 (ej. "available": 10, "sold": 5).  
- **Ejecución completa (QA-week2)**: Finaliza sin errores → confirma que el SUT está funcional para los casos básicos y no funcionales iniciales.  
- **Trazabilidad**: Cada ejecución genera archivos con timestamp → fácil auditoría y reproducibilidad.

### Lecciones aprendidas

- Usar `curl -w "%{http_code} %{time_total}"` + `awk` es efectivo y ligero para mediciones de latencia sin herramientas externas.  
- Registrar timestamp en todos los archivos de evidencia facilita correlacionar ejecuciones.  
- Centralizar con Makefile reduce errores manuales y mejora la experiencia de uso (un solo comando para todo).  
- En Petstore, POST sin "name" devuelve 405 (Method Not Allowed) en lugar de 400 → ajustar expectativas de validación.  
- Para performance local, repeticiones consecutivas revelan variabilidad mínima en in-memory DB.  
- Validaciones con `jq` son ideales para shape sanity: rápidas y expresivas para chequear tipos y rangos.

### Pendientes para próximas semanas

- Mejorar SC-02/SC-03: usar ID dinámico generado en SC-01.  
- Agregar escenarios avanzados.  
- Incluir monitoreo de recursos (CPU/RAM) en SC-05 para performance más completa.  
- Generar reporte consolidado (ej. HTML simple en futuras semanas).  
- Integrar con CI/CD básico (GitHub Actions para ejecutar QA-week2 en push).

**Estado general de la semana:** Completado con éxito. 
Base sólida para escalar a pruebas más avanzadas (performance real, contract testing, CI/CD).
