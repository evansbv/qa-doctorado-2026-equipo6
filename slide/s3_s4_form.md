# Presentación Semanas 3 y 4 – Formato de slides  
**Curso**: DCC-M10_T3-4_CS-SEM3-4  
**Equipo**: Equipo 6  
**Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO  
**Fecha**: 7 de febrero de 2026


## Slide 1 — Semana 3: Top 3 riesgos priorizados

**SUT**: Swagger Petstore API v3[](http://localhost:8080/api/v3)

**Fuente**: risk/risk_matrix.csv

| Riesgo | Atributo         | Impacto | Prob. | Score | Justificación breve                                      |
|--------|------------------|---------|-------|-------|----------------------------------------------------------|
| **R01** | Disponibilidad   | 5       | 4     | **20** | Sin disponibilidad → cero valor entregado (crítico), aspecto que no está asumido en el apetito de riesgo      |
| **R02** | Latencia         | 4       | 4     | **16** | Impacta percepción de calidad y UX del consumidor, aspecto identificado mediante lluvia de ideas de los expertos (ISO 31010)        |
| **R03** | Consistencia     | 4       | 4     | **16** | Genera pérdida de confianza y errores lógicos downstream, aspecto que tiene un plan de acción no operativizado |

**Decisión clave (1 frase)**  
Priorizamos riesgos de alto impacto observable y alta probabilidad local (disponibilidad, latencia, consistencia) después de realizar el análisis de riesgo mediante el proceso de la ISO 31000, aceptando el residual en seguridad/carga para maximizar evidencia reproducible en tiempo limitado basado en los proceso de tratamiento de riesgos que esté alineado al apetito de riesgo organizacional.

## Slide 2 — Semana 3: trazabilidad (Riesgo → Escenario → Evidencia → Oráculo → Residual)

**Fuente principal (repo)**:  
- risk/test_strategy.md (tabla Top 3 y conexión explícita)  
- evidence/week3/ + RUNLOG.md (evidencia versionada)

**Trazabilidad completa de los Top 3 riesgos**  
(Enfoque: conexión defendible, no cantidad de pruebas)

| Riesgo (Top) | Escenario (Estímulo / Entorno / Respuesta / Medida)                          | Evidencia (archivo principal)                          | Oráculo mínimo (pass/fail)                              | Riesgo residual (1 línea)                                      |
|--------------|-------------------------------------------------------------------------------|--------------------------------------------------------|---------------------------------------------------------|----------------------------------------------------------------|
| **R01 – Disponibilidad** (Score 20) | Estímulo: GET/POST a endpoints clave<br>Entorno: Docker local, múltiples reps<br>Respuesta: HTTP <500<br>Medida: 100% éxito (SC-01 smoke extension) | evidence/week3/smoke_results.log<br>evidence/week3/smoke_http_codes.txt<br>RUNLOG.md#1 | 100% ejecuciones con HTTP < 500 (no 5xx inesperados)   | Persiste riesgo de caídas intermitentes bajo carga o en producción no probada |
| **R02 – Latencia** (Score 16) | Estímulo: GET /store/inventory repetido<br>Entorno: local, 30 reps consecutivas<br>Respuesta: HTTP 200 + time_total<br>Medida: p95 ≤ 2.0s (SC-05 baseline) | evidence/week3/latency_measurements.csv<br>evidence/week3/latency_summary.txt<br>RUNLOG.md#2 | HTTP 200 en todas; p95 ≤ 2.0s (umbral conservador local) | No representa rendimiento real bajo concurrencia ni en producción |
| **R03 – Consistencia** (Score 16) | Estímulo: GET /pet/findByStatus repetido (sin cambios)<br>Entorno: local, 5 reps<br>Respuesta: JSON coherente, counts idénticos<br>Medida: counts consistentes (SC-06 extension) | evidence/week3/consistency_asserts.log<br>evidence/week3/findByStatus_sample.json<br>RUNLOG.md#3 | Schema válido; valores ≥0; counts coherentes entre llamadas repetidas | No cubre inconsistencias semánticas profundas o con cambios concurrentes |

**Decisión clave de trazabilidad**  
Cada riesgo Top 3 se conecta explícitamente a un escenario existente de Semana 2 (reutilización), evidencia reproducible (scripts + Makefile), oráculo mínimo cuantificable y riesgo residual explícito y aceptado (documentado en test_strategy.md y RUNLOG.md), priorizando defendibilidad sobre exhaustividad.

## Slide 3 — Semana 3: riesgo residual (qué queda fuera y por qué)

**Riesgos NO priorizados (al menos 2 – ejemplos clave de la matriz)**

- **R07 – Seguridad** (Score 10: Impacto 5 / Probabilidad 2)  
  Queda fuera ahora porque: probabilidad baja en el entorno mock local (sin autenticación real enforced, sin exposición pública), y no hay evidencia observable inmediata de broken auth o data leak en esta etapa. Se acepta residual alto por ahora; priorizamos riesgos más observables y frecuentes (disponibilidad, latencia, consistencia).

- **R06 – Cumplimiento del contrato OpenAPI** (Score 9: Impacto 3 / Probabilidad 3)  
  Queda fuera ahora porque: el mock Petstore respeta mayormente el esquema base, y la desviación parcial (campos faltantes o tipos erróneos) no rompe flujos críticos en uso local. Requiere validación automática vs spec (ej. Spectral/Dredd) que se pospone para iteraciones futuras; se acepta residual medio-bajo en esta fase.

**Riesgo residual clave (1 párrafo corto)**

Tras mitigar los Top 3 riesgos (disponibilidad, latencia, consistencia) con evidencia reproducible en entorno local, queda abierto un riesgo significativo en estabilidad bajo carga/concurrencia, seguridad (broken auth, exposición de datos), integridad profunda en flujos multi-operación y cumplimiento estricto del contrato OpenAPI en escenarios reales.  
Este residual es aceptable por ahora porque fue construir una base defendible y automatizada de calidad observable (con trazabilidad riesgo-escenario-evidencia), antes de escalar a complejidad mayor (carga, seguridad productiva, validación automática vs spec). 

## Slide 4 — Semana 4: objeto de prueba + técnica sistemática

**Objeto de prueba (endpoint/función)**  
POST /api/v3/store/order  

**Fuente (repo)**: design/test_cases.md (tabla de 14 casos sistemáticos)

**Por qué es buen candidato (al menos 2 razones)**

- Operación transaccional crítica con impacto directo en integridad de datos y flujo de negocio (creación de órdenes), alineada con riesgos de calidad previos (integridad, robustez, consistencia).  
- Parámetros con restricciones claras y variabilidad suficiente (tipos, rangos, enum, formato fecha, booleano) para derivar ≥12 casos sistemáticos defendibles mediante EQ + BV sin necesidad de herramientas externas.

**Técnica usada (marcar una)**

- **EQ/BV (equivalencia + valores límite)** ← seleccionada  
- Pairwise / combinatoria

**Cómo derivamos los casos (2–3 líneas)**

Particionamos cada campo clave en clases de equivalencia (válido/inválido por tipo/rango/enum/formato) y aplicamos valores límite (inferior/superior/extremo) en quantity (1, 0, -1, 999999), status (válido/inválido/ausente), shipDate (futura/pasada/inválida), petId (válido/inexistente/tipo erróneo) y combinaciones nominales/inválidas.  
Se generaron 14 casos trazables a estas particiones, priorizando bordes críticos y errores sintácticos/semánticos comunes en APIs de escritura.

**Cobertura que afirmamos (1–2 líneas) y qué NO afirmamos (1 línea)**

- **Afirmamos**: cobertura completa de clases de equivalencia y valores límite en campos principales (petId, quantity, status, shipDate, complete), incluyendo nominales, bordes e inválidos; validaciones sintácticas, semánticas y de integridad reflejada.  
- **No afirmamos**: interacciones exhaustivas entre todos los parámetros (pairwise no aplicado), comportamiento bajo carga/concurrencia, validación automática vs spec OpenAPI completa ni pruebas en entornos con autenticación/persistencia real.

## Slide 5 — Semana 4: oráculos defendibles (mínimos vs estrictos)

**Fuente (repo)**:  
- design/oracle_rules.md (6 reglas definidas)  
- evidence/week4/ (evidencia de aplicación en ejecución real)

**Reglas de oráculo (mín. 5, marcar cuáles son “mínimas” y cuáles “estrictas”)**

- **(Mínima)** OR-1 (R1): Código HTTP correcto según escenario  
  Pass: 200/201 (válido) o 400/422 (inválido); Fail: cualquier otro código inesperado  

- **(Mínima)** OR-2 (R2): Respuesta contiene cuerpo JSON válido  
  Pass: Content-Type application/json + parseable; Fail: no JSON o vacío en 200  

- **(Estricto)** OR-3 (R3): Integridad de datos de entrada en respuesta  
  Pass: Campos enviados (petId, quantity, status, complete) coinciden exactamente; Fail: modificación sin justificación  

- **(Estricto)** OR-4 (R4): Validación de rangos y valores límite en quantity  
  Pass: quantity ≥1 aceptado, ≤0 rechazado con mensaje claro; Fail: valores inválidos aceptados  

- **(Estricto)** OR-5 (R5): Validación de enum en status  
  Pass: solo "placed", "approved", "delivered" aceptados; Fail: valor arbitrario aceptado  

**Ambigüedad detectada y cómo se resolvió (2–3 líneas)**

Ambigüedad principal: el mock Petstore v3 es extremadamente permisivo (acepta quantity negativa, status inválido, shipDate malformado con HTTP 200 y sin mensaje de error).  
Se resolvió: priorizando oráculos débiles (R1, R2) como base obligatoria en todos los casos, y marcando FAIL explícito en oráculos estrictos cuando el mock no valida (TC-10 y TC-13), convirtiendo la permisividad en hallazgo valioso de calidad (falta de validación estricta) en vez de error de diseño.

**Evidencia clave (2 archivos)**

- evidence/week4/tc_10_response_*.json + tc_10_log_*.txt  
  (FAIL en shipDate inválido aceptado con 200 – muestra ambigüedad resuelta como hallazgo)

- evidence/week4/summary_*.txt  
  (Resumen global: 14 casos, 12 PASS / 2 FAIL, 85% – evidencia de aplicación real de oráculos)

  ## Slide 6 — Validez + mejora concreta

**Amenazas a la validez (1 línea cada una)**

- **Interna**: Variabilidad de recursos locales (CPU/memoria, warm-up de contenedor) puede sesgar latencia y disponibilidad → Mitigación futura: ejecutar pruebas múltiples con reinicio de Docker y descartar primeras ejecuciones (warm-up explícito).  

- **Constructo**: El mock Petstore v3 es permisivo (acepta inputs inválidos con 200 OK), subestima efectividad de oráculos fuertes → Mitigación futura: alinear oráculos con SLOs y contrato OpenAPI real (usar herramientas como Spectral/Dredd para validación automática vs spec).  

- **Externa**: Resultados específicos de entorno local/mock sin persistencia ni autenticación → Mitigación futura: replicar pruebas en staging/producción con auth real, base de datos y monitoreo de SLOs para generalizar hallazgos.

**Mejora concreta para la próxima quincena (1 bullet)**

- Incorporar validación automática del contrato OpenAPI en al menos un endpoint adicional, para fortalecer oráculos estrictos y reducir ambigüedad en mocks permisivos.

**Cierre (1 frase)**

“Lo más defendible del trabajo del equipo es la trazabilidad explícita riesgo-escenario-evidencia-oráculo-residual en ambas semanas; el límite principal es la permisividad del mock local que limita la detección de fallos reales de validación y robustez.”


**Repositorio**: https://github.com/evansbv/qa-doctorado-2026-equipo6/tree/week4  
