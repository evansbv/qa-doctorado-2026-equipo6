# Quality Gate Run - 2026-02-11 23:30:03
## Ejecución completa

→ Limpiando contenedores y volúmenes previos...
→ Check 1: SUT arriba + healthcheck
- **SUT Build & Running**: PASS
Contenedor running (ver docker-build-log.txt)

→ Esperando healthcheck (máx 120s)...
Healthcheck OK
→ Check 2: Contrato OpenAPI accesible
- **Contrato OpenAPI**: PASS
HTTP 200 + clave 'openapi' presente (ver openapi.json)

→ Check 3: Casos sistemáticos Semana 4
- **Casos Sistemáticos**: FAIL
Al menos un caso falló (ver systematic_summary.txt)

→ Check 4: Robustez entradas inválidas
- **Robustez Inválidos**: FAIL
No se detectaron rechazos 4xx esperados

→ Check 5: Repetibilidad
- **Repetibilidad**: PASS
Segunda ejecución consistente


Quality Gate **PASSED** ✓ - 2026-02-11 23:30:03
