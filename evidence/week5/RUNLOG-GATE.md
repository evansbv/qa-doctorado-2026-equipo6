# Quality Gate Run - 2026-02-20 17:11:44
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
Exit code del script: 0
- **Casos Sistemáticos**: FAIL
Integridad rota: falta o número incorrecto de TOTAL_CASOS_EJECUTADOS:14

Defensa anti-gaming activada: contador de casos no encontrado o incorrecto
