# Quality Gate - Semana 5 (SUT: Swagger Petstore API v3 en Docker)

## Objetivo del Quality Gate
Este quality gate verifica automáticamente que cambios en scripts de tests, configuración Docker, clientes o wrappers alrededor del Petstore API no rompan la capacidad básica de levantar y validar el SUT (API funcional y spec OpenAPI válida).  
Reduce el riesgo de integrar cambios que impidan el despliegue reproducible del contenedor o hagan fallar verificaciones básicas de la API.  
**No pretende** validar funcionalidad profunda de endpoints (eso sería larger testing), performance, seguridad, ni comportamientos con datos mutables en producción. Solo asegura "el API arranca y se ve sano" de forma determinística.

## Checks del Quality Gate (4 checks seleccionados)

1. **Docker Compose / Build del SUT exitoso**  
   - **Claim**: El contenedor Petstore v3 se construye y levanta sin errores (Dockerfile o compose válido).  
   - **Oráculo**: `docker compose up --build -d` o `docker build` termina con exit code 0; healthcheck pasa (si definido).  
   - **Evidencia**: `evidence/week5/docker-build-log.txt` y `evidence/week5/docker-ps.txt` (salida de `docker ps`).  
   - **Trazabilidad**: Semana 3 – Principios de CI: feedback temprano en build/deploy del SUT (Cap. 23 SWE Book).

2. **Validación de OpenAPI Specification (spec estática)**  
   - **Claim**: El archivo OpenAPI v3 del Petstore es sintácticamente válido y cumple reglas básicas (no cambios accidentales lo rompen).  
   - **Oráculo**: `npx @redocly/cli lint openapi.yaml` o `swagger-cli validate` termina con exit code 0.  
   - **Evidencia**: `evidence/week5/openapi-lint-report.txt`.  
   - **Trazabilidad**: Semana 4 – Calidad estática y mantenibilidad (análisis determinístico, similar a linting en Cap. 14).

3. **Smoke / Health Check básico del API (via curl)**  
   - **Claim**: El API responde correctamente al health endpoint o un GET simple (ej. /api/v3/pet/findByStatus?status=available).  
   - **Oráculo**: curl devuelve HTTP 200 y JSON válido (sin verificar contenido profundo para evitar flaky).  
   - **Evidencia**: `evidence/week5/smoke-test-log.txt` (incluye curl -v output).  
   - **Trazabilidad**: Semana 4 – Larger testing hermético/simple (verificación de integración básica, Cap. 14; determinismo via contenedor limpio).

4. **Repetibilidad del gate completo**  
   - **Claim**: Dos ejecuciones consecutivas del script dan el mismo resultado (PASS/PASS) sin cambios.  
   - **Oráculo**: El script se ejecuta dos veces seguidas → ambos PASS.  
   - **Evidencia**: `evidence/week5/RUNLOG.md` (muestra timestamps y resultados de run 1 y run 2).  
   - **Trazabilidad**: Semana 4 – Mitigación de flaky tests (alta señal/bajo ruido, hermeticidad y determinismo, blog Google flaky tests).

## Por qué estos checks son “alta señal / bajo ruido”
- **Determinismo alto**: Build Docker y lint OpenAPI son 100% locales/estáticos; smoke test usa contenedor fresco (docker compose down/up) sin estado persistente → resultados idénticos cada vez.
- **Oráculos binarios y claros**: Solo exit code 0/1 + HTTP 200 simple (sin asserts complejos sobre datos variables o timing).
- **Bajo ruido**: Nada de métricas inestables (latencia, throughput); smoke test evita DB mutación al no crear pets (solo read).

## Nota de diseño obligatoria
El gate **NO falla** por métricas inestables (latencia de respuesta, tiempo de startup del contenedor, número de pets en DB, etc.). Si se miden (ej. tiempo de respuesta < 5s), queda solo como **registro informativo** en los logs/evidencia, nunca como criterio de bloqueo.