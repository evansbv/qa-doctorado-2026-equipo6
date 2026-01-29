# Estrategia de Pruebas Basada en Riesgo - Semana 3

## 1. Propósito
Aplicar risk-based testing para priorizar esfuerzos de calidad en la API Petstore con tiempo limitado.  
Enfocarse en riesgos de alto impacto y observables (disponibilidad, latencia, consistencia) que afectan directamente el valor entregado y la percepción del producto.  
Generar evidencia reproducible que conecte Riesgo → Escenario → Evidencia → Oráculo → Riesgo residual, justificando decisiones de testing de forma defendible.

## 2. Alcance
**Cubierto esta semana (Top 3 riesgos):**
- Disponibilidad básica (no 5xx inesperados).
- Baseline de latencia local en endpoints clave.
- Consistencia mínima en respuestas (coherencia de datos y formato).

**No cubierto por ahora:**
- Seguridad profunda (authn/authz, inyección).
- Pruebas de carga/concurrencia.
- Integridad de datos bajo múltiples operaciones.
- Validación completa del contrato OpenAPI.
- Entornos no locales (staging/producción).

## 3. Top 3 riesgos priorizados

| Riesgo (ID) | Por qué es Top (razón principal)                  | Escenario asociado                          | Evidencia generada (week3)                          | Oráculo mínimo (pass/fail)                          | Riesgo residual esperado                          |
|-------------|---------------------------------------------------|---------------------------------------------|-----------------------------------------------------|-----------------------------------------------------|---------------------------------------------------|
| R01         | Sin disponibilidad → cero valor entregado        | quality/scenarios.md#SC-01 (smoke extension: múltiples endpoints) | evidence/week3/smoke_results.log<br>evidence/week3/health_check.txt | 100% ejecuciones HTTP < 500 (no 5xx inesperados)   | Persiste riesgo de caídas intermitentes o bajo carga no probada |
| R02         | Afecta percepción de calidad y UX del consumidor | quality/scenarios.md#SC-05 (latencia baseline) | evidence/week3/latency_measurements.csv<br>evidence/week3/latency_summary.txt | HTTP 200 en todas; p95 ≤ 2.0s (umbral local conservador) | No representa rendimiento en producción ni bajo concurrencia |
| R03         | Inconsistencias generan pérdida de confianza y errores lógicos | quality/scenarios.md#SC-06 (consistency extension: listas/filtros) | evidence/week3/consistency_asserts.log<br>evidence/week3/findByStatus_sample.json | Schema válido; valores ≥0; counts coherentes entre llamadas repetidas | No cubre inconsistencias semánticas profundas o con cambios de estado |

## 4. Reglas de evidencia
- Toda evidencia se almacena en carpeta `evidence/week3/`.
- Cada prueba debe ser reproducible: registrar comando/script exacto (ej. `make smoke`, `pytest tests/test_smoke.py -v`).
- Oráculo mínimo explícito (pass/fail) definido por riesgo y documentado en RUNLOG.md.
- Incluir salida cruda (logs, CSV, JSON) + summary legible (ej. tabla o texto con pass/fail).
- `evidence/week3/RUNLOG.md`: registro cronológico con fecha, comando, resultado global (OK/FAIL), enlaces a archivos.

## 5. Riesgo residual
Tras mitigar los Top 3 con evidencia básica reproducible en entorno local, persiste riesgo significativo en: estabilidad bajo carga/concurrencia, seguridad (exposición real), integridad de datos en flujos multi-operación, y generalización a entornos no locales.  
Se acepta este residual en la etapa actual porque el foco es construir una base defendible y automatizada de calidad observable, antes de escalar alcance o introducir complejidad (carga, seguridad, producción).

## 6. Validez
- **Validez interna**: Warm-up del contenedor y variabilidad de red local pueden sesgar latencia y disponibilidad → mitigar reiniciando Docker y descartando primeras ejecuciones.
- **Validez de constructo**: Mediciones locales (time_total, HTTP codes) son proxies razonables para disponibilidad y latencia básica, pero no equivalen a rendimiento real ni SLOs productivos → declarado explícitamente como "baseline local".
- **Validez externa**: Resultados dependen de hardware, versión Docker y configuración local del equipo → no se generalizan a otros entornos sin repetición; registrar specs del entorno en RUNLOG.md.

**Aprobado / Responsable**: Equipo
- BALCAZAR VEIZAGA EVANS
- ROSALES FUENTES JORGE MARCELO
- CORDERO FLORES MARCELO
- PEREZ DELGADILLO SHIRLEY EULALIA  
  
**Fecha**: Semana 3 - [29/01/2026]
