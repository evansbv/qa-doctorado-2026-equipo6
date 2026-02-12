# Memo - Semana 5: Quality Gate

**Curso**: DCC-M10_T5-6_CS-SEM5-6 
**Equipo**: Equipo 6  
**Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   
**Fecha**: 11 de febrero de 2026  

## Objetivos de la semana

- Operacionalizar un quality gate en un entorno de Continuous Integration que proporcione feedback temprano, reduzca riesgos y minimice falsos positivos (alta señal / bajo ruido).
- Asegurar que el gate sea reproducible tanto en ejecución local como en CI.
- Vincular explícitamente el quality gate con los artefactos generados en Semanas 3 (riesgos y matriz de riesgos) y Semana 4 (oráculos, reglas y casos sistemáticos).
- Generar y preservar evidencia estructurada de la ejecución del gate.

## Logros alcanzados

- Quality gate definido y documentado en `ci/quality_gates.md` con 5 checks principales:
  1. SUT arriba + healthcheck (Docker Compose fresco)
  2. Contrato OpenAPI accesible y validación básica
  3. Ejecución de casos sistemáticos (Semana 4)
  4. Robustez ante entradas inválidas
  5. Repetibilidad del gate completo
- Gate ejecutable de forma consistente tanto localmente (`make QA-week5`) como en CI (GitHub Actions workflow en `.github/workflows/ci.yml`).
- Evidencia de la Semana 5 generada automáticamente en `evidence/week5/` y subida como artifact en cada ejecución de CI (nombre: `quality-gate-evidence-week5`).
  - Incluye: SUMMARY.md, RUNLOG.md, openapi.json, systematic_summary.txt, invalid_inputs_log.txt, logs de Docker, etc.
- Relación explícita con Semanas previas:
  - Semana 3: Los checks 1 y 4 mitigan riesgos clave identificados en `risk/risk_matrix.csv` (disponibilidad del SUT y robustez/error handling).
  - Semana 4: El check 3 reutiliza directamente `scripts/systematic_cases.sh` y valida contra los oráculos y reglas definidos en `design/oracle_rules.md` y `design/test_cases.md`.

## Evidencia principal

- Definición del gate: `ci/quality_gates.md`
- Script ejecutor: `ci/run_quality_gate.sh`
- Workflow CI: `.github/workflows/ci.yml`
- Evidencias locales y de CI: `evidence/week5/` (incluye RUNLOG.md con fecha/hora/comando y artifact descargable desde GitHub Actions)
- Ejecución exitosa más reciente (local): 11-feb-2026 23:30 -04 → **PASSED ✓**
- Ejecución en CI: https://github.com/evansbv/qa-doctorado-2026-equipo6/actions/workflows/ci.yml  
  (último run exitoso con artifact descargado: quality-gate-evidence-week5)

## Retos / Notas

- Conflicto inicial de nombres y puertos entre `manage-petstore.sh` (docker run --name petstore3) y `docker-compose.yml` (servicio petstore-api) → resuelto eliminando dependencia de `start-petstore` en Makefile y limpiando contenedores manuales al inicio del script.
- Falso positivo en Check 2 por patrón estricto de grep en openapi.json → corregido con búsqueda flexible de clave `"openapi"`.
- Falso positivo en Check 3 por palabra "FAIL" en salida de `systematic_cases.sh` → refinado el oráculo con regex contextual y logging adicional.
- Tiempo de ejecución del gate (~3-4 min) aceptable para feedback temprano, pero podría optimizarse eliminando rebuilds forzados en entornos de desarrollo.

## Lecciones aprendidas

- La autonomía del quality gate (limpieza + levantamiento fresco del SUT) es clave para reproducibilidad y evitar flaky en CI/local.
- Oráculos deben ser precisos y evitar falsos positivos (ej. grep simple vs regex contextual).
- Centralizar la ejecución en Makefile facilita mantenimiento y consistencia entre local y CI.
- Subir evidencias como artifacts en GitHub Actions es esencial para trazabilidad y revisión posterior (evita depender solo de ejecuciones locales).
- Integrar artefactos previos (Semana 3–4) directamente en el gate aumenta su valor y coherencia con el proceso de calidad completo.

## Próximos pasos

- Refinar oráculos de Check 3 y Check 4 para ser aún más específicos (ej. contar % de casos pass o validar códigos HTTP exactos).
- Agregar check opcional de coverage si se incorporan tests unitarios o de API en cliente.
- Explorar integración con SonarQube o similar para análisis estático más profundo en CI.
- Preparar entrega consolidada de las Semanas 3–5 (repositorio + memo final + evidencias descargadas).


Fecha: 11 de febrero de 2026