# Memo Semanal - Semana 4  
**Curso**: DCC-M10_T3-4_CS-SEM3-4  
**Equipo**: Equipo 6  
- **Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   
**Fecha**: 6 de febrero de 2026

## Objetivo de la semana
Diseñar pruebas sistemáticas (no ad-hoc) para un endpoint concreto del SUT (Petstore API), definir reglas de oráculo defendibles (pass/fail), implementar ejecución reproducible y generar evidencia versionada y trazable.  
El foco estuvo en demostrar un enfoque metodológico riguroso y reproducible, con énfasis en clases de equivalencia + valores límite (EQ+BV).

## Logros alcanzados
- **Endpoint elegido**: POST /api/v3/store/order (motivado por su relevancia transaccional, variabilidad de parámetros y alineación con riesgos de calidad previos).
- **Oráculos definidos**: Se crearon 6 reglas claras y reutilizables en `design/oracle_rules.md` (R1–R6), diferenciando oráculos débiles (mínimos: HTTP code y JSON válido) y fuertes (integridad, rangos, enum, semántica de fecha).
- **Casos sistemáticos diseñados**: 14 casos de prueba en `design/test_cases.md`, derivados sistemáticamente de EQ + BV, con formato TC-ID | Input | Expected (referencia a oráculos) | Evidencia esperada.
- **Ejecución reproducible implementada**: Script `scripts/systematic_cases.sh` que ejecuta los 14 casos, aplica oráculos, genera evidencia por caso (log, response JSON, http code) y produce resumen (summary.txt).
- **Evidencia week4 generada**: Carpeta `evidence/week4/` con archivos por caso (tc_XX_*.txt/json), resumen `summary_*.txt` y `RUNLOG.md` con trazabilidad completa (fecha/hora, comando, oráculos aplicados, resultados reales: 12 PASS / 2 FAIL).
- **Reporte metodológico producido**: Informe corto en `reports/week4_report.md` (1–2 páginas) que incluye motivación del endpoint, técnica EQ+BV, definición de oráculos, cobertura afirmada/no afirmada y 3 amenazas a la validez (interna, constructo, externa).

## Evidencia principal
- Repositorio: https://github.com/evansbv/qa-doctorado-2026-equipo6/tree/week4  
- Ruta clave: `evidence/week4/RUNLOG.md` y `evidence/week4/summary_*.txt` (12 PASS, 2 FAIL en TC-10 y TC-13).  
- Diff semana 4 vs main (una vez mergeado o como comparación):  
  https://github.com/evansbv/qa-doctorado-2026-equipo6/compare/main...week4  
  (muestra todos los archivos nuevos: design/, reports/, memos/week4_memo.md, evidence/week4/, scripts/systematic_cases.sh y Makefile actualizado)

## Retos / Notas
- El mock Petstore v3 es extremadamente permisivo (acepta quantity negativa, status arbitrario, fechas inválidas con HTTP 200), lo que generó solo 2 FAIL explícitos a pesar de casos inválidos. Esto limitó la utilidad de oráculos fuertes, pero sirvió como hallazgo valioso: evidencia falta de validación estricta en el mock.
- Los casos TC-04, TC-05, TC-07, etc. inicialmente causaban cuelgues por uso de `grep` en oracle_check; se resolvió eliminando chequeos fuertes innecesarios y agregando timeout + sleep.
- Ejecución local depende de Docker estable; variabilidad de recursos (CPU/memoria) puede afectar tiempos de respuesta.

## Lecciones aprendidas
- La permisividad del mock subestima la efectividad de pruebas sistemáticas; en un backend real con validaciones estrictas, los oráculos fuertes habrían generado más FAILs útiles.
- Combinar EQ + BV es eficiente y defendible para endpoints con reglas claras de negocio, pero requiere oráculos alineados con el contrato real (no solo con expectativas teóricas).
- Scripts reproducibles con timestamp y summary automático facilitan trazabilidad y revisión; el uso de `timeout` y `sleep` evita problemas de saturación en mocks locales.
- Definir oráculos débiles/fuertes desde el inicio permite evaluar tanto cumplimiento básico como calidad profunda.

