# RUNLOG - Quality Gate Semana 5

**Fecha y hora de ejecución local**: 2026-02-11 23:30:03 -04 (Santa Cruz, BO)

**Comando utilizado para ejecutar el gate localmente**:
```bash
make QA-week5

Resultado global: PASSED ✓
Tiempo aproximado de ejecución: ~3-4 minutos
Rama actual: week5 (commit: [pega el hash si quieres: git rev-parse HEAD])
Evidencias generadas y ubicación:

evidence/week5/SUMMARY.md → Tabla resumen de checks con Status (PASS/FAIL) y detalles
evidence/week5/RUNLOG.md → Este archivo (log detallado con timestamps y mensajes)
evidence/week5/docker-build-log.txt → Salida completa de docker compose up --build
evidence/week5/docker-ps.txt → Estado de contenedores al final del build
evidence/week5/healthcheck-log.txt → (opcional, si lo agregaste) log de espera del health
evidence/week5/openapi.json → Descarga del contrato OpenAPI del SUT
evidence/week5/openapi_http_code.txt → Código HTTP de la petición al openapi.json (debe ser 200)
evidence/week5/systematic_summary.txt → Salida del script systematic_cases.sh (Semana 4)
evidence/week5/systematic_results.csv → (si se copió o generó) resultados detallados de casos sistemáticos
evidence/week5/invalid_inputs_log.txt → Log de pruebas de robustez (entradas inválidas)

Notas adicionales:

Todos los checks fueron PASS en esta ejecución.
El entorno fue completamente limpio antes de cada run (docker compose down --volumes).
Trazabilidad completa en ci/quality_gates.md.

Firma: Evans
Fecha: 2026-02-11


#### 2. Guardar / preservar los archivos producidos

Ya que tu workflow de GitHub Actions está configurado para subir `evidence/week5/` como artifact, lo ideal es:

- Hacer commit y push de los archivos locales generados en tu última ejecución exitosa (los que aparecen en `ls evidence/week5/` después de `make QA-week5`).
- Ejecutar el workflow en GitHub (ya sea por push/PR o manualmente desde la pestaña Actions) → esto generará una nueva carpeta de evidencias en el CI.
- Descargar el artifact desde GitHub Actions (como en el ejemplo que mencionas: https://github.com/robertop87/qa-doctorado-2026-equipoX/actions/workflows/ci.yml)

**Cómo hacerlo en GitHub**:

1. Commit y push los archivos locales:

   ```bash
   git add evidence/week5/
   git commit -m "Semana 5: Evidencias locales del Quality Gate (RUNLOG + archivos generados)"
   git push origin week5


2. Ve a tu repositorio en GitHub → pestaña Actions → selecciona el workflow "CI - Quality Gate (Semana 5)" → selecciona el run más reciente → baja hasta "Artifacts" → descarga quality-gate-evidence-week5El enlace directo sería algo como:
https://github.com/evansbv/qa-doctorado-2026-equipo6/actions/runs/<run-id>/artifacts/<artifact-id>Puedes pegar ese enlace (o el de la página del workflow) en tu memo o README para que quede referenciado.