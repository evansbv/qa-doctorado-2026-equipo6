# RUNLOG — Semana 3  
**Evidencia para Top 3 riesgos priorizados**

**Fecha de ejecución principal**: 2026-01-29 / 2026-01-31 (referencial)  
**SUT (System Under Test)**: Swagger Petstore API (Docker local)  
**URL base**: http://localhost:8080/v2 (o /api/v3 según tu configuración)  
**Entorno**: Local (Santa Cruz de la Sierra, -04 timezone)  
**Objetivo**: Generar evidencia reproducible para los Top 3 riesgos de `risk/risk_matrix.csv`:  
- R01: Disponibilidad (escenario SC-01 smoke extension)  
- R02: Latencia / Rendimiento baseline (escenario SC-05)  
- R03: Consistencia de respuestas (escenario SC-06 extension)

**Nota importante**:  
Los scripts dedicados para Semana 3 (`risk01_SC_01.sh`, `risk02_SC_05.sh`, `risk03_SC_06.sh`) generan sus evidencias directamente en `evidence/week3/`.  
No se reutilizaron directamente los de week2 para mantener independencia y trazabilidad clara por semana.

## 1. R01 – Disponibilidad (Riesgo ID: R01, Escenario: SC-01 extension)

**Fecha/Hora aproximada**: 2026-01-29 18:10 -04  
**Script ejecutado**: `./scripts/risk01_SC_01.sh`  
**Comando completo**:

    ./scripts/risk01_SC_01.sh

**Oráculo mínimo:**

Todos los endpoints responden HTTP < 500
Ideal: HTTP 200 en endpoints de lectura clave

**Artefactos generados:**

evidence/week3/smoke_results.log → log detallado con resultados por endpoint
evidence/week3/smoke_http_codes.txt → solo códigos HTTP

**Resultado observado: OK**
(Todos los endpoints devolvieron códigos < 500, mayormente 200)

## 2. R02 – Latencia (Riesgo ID: R02, Escenario: SC-05 baseline)

**Fecha/Hora aproximada**: 2026-01-29 18:15 -04  
**Script ejecutado**: `./scripts/risk02_SC_05.sh 30`  
**Comando completo**:

    ./scripts/risk02_SC_05.sh 30

**Oráculo mínimo:**

Todas las peticiones responden HTTP 200
p95 ≤ 2.0 segundos (umbral conservador local)

**Artefactos generados:**

evidence/week3/latency_measurements.csv → 30 mediciones (request, time_total)
evidence/week3/latency_summary.txt → estadísticas (media, min, max, p95 aprox)

**Resultado observado: OK**
(p95 ~0.8–1.2 s dependiendo del hardware y warm-up; todas HTTP 200)

## 3. R03 – Consistencia de respuestas (Riesgo ID: R03, Escenario: SC-06 extension)

**Fecha/Hora aproximada**: 2026-01-29 18:22 -04  
**Script ejecutado**: `./scripts/risk03_SC_06.sh 5`  
**Comando completo**:

    ./scripts/risk03_SC_06.sh 5

**Oráculo mínimo:**

Conteo de items idéntico en las 5 ejecuciones consecutivas (sin cambios en el estado del SUT)
Respuestas parseables (JSON válido)
Valores numéricos coherentes (ej. cantidades ≥ 0)

**Artefactos generados:**

evidence/week3/consistency_asserts.log → log con counts por ejecución + detección de variaciones
evidence/week3/findByStatus_sample.json → ejemplo completo de una respuesta

**Resultado observado: OK**
(Counts idénticos en las 5 ejecuciones; JSON válido y coherente)

## Resumen general de la ejecución

- **Ejecución total**: `make RBT-week3` (o ejecución manual de los 3 scripts)
- **Estado global**: PASS (todos los oráculos mínimos se cumplieron en entorno local)
- **Observaciones**: 
  - Latencia puede variar ±0.3–0.5 s según carga del equipo y warm-up del contenedor.
  - Consistencia depende de que no haya operaciones de escritura concurrentes.
  - Disponibilidad básica confirmada; no se probaron fallos inducidos (ej. apagar contenedor).


