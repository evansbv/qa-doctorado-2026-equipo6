# RUNLOG - Semana 4  
**Evidencia de casos sistemáticos para POST /api/v3/store/order**

**Fecha/Hora de ejecución principal**: 2026-02-06 16:27:36 -04 (Santa Cruz de la Sierra)  
**SUT**: Swagger Petstore API v3<a href="http://localhost:8080/api/v3" target="_blank" rel="noopener noreferrer nofollow"></a>  
**Endpoint probado**: POST /api/v3/store/order  
**Técnica**: EQ + BV (14 casos diseñados en design/test_cases.md)  
**Oráculos aplicados**: design/oracle_rules.md (principalmente R1 y R2 débiles; fuertes en casos específicos)  
**Script ejecutado**: scripts/systematic_cases.sh  

**Comando exacto usado**:
```bash
sh scripts/systematic_cases.sh

$sh scripts/systematic_cases.sh
Ejecución de casos sistemáticos - vie 06 feb 2026 16:27:36 -04
Endpoint: http://localhost:8080/api/v3/store/order
----------------------------------------
Resultado: PASS 01

Resultado: PASS 02

Resultado: PASS 03

Resultado: PASS 04

Resultado: PASS 05

Resultado: PASS 06

Resultado: PASS 07

Resultado: PASS 08

Resultado: PASS 09

Resultado: FAIL 10

Resultado: PASS 11

Resultado: PASS 12

Resultado: FAIL 13

Resultado: PASS 14

----------------------------------------
Total casos ejecutados: 14
PASS: 12
FAIL: 2
Porcentaje PASS: 85%
Evidencia completa en: evidence/week4/

**Resumen de resultados (de systematic_summary.txt):**
 - Total casos ejecutados: 14
 - PASS: 12
 - FAIL: 2 (TC-10: shipDate formato inválido; TC-13: petId tipo erróneo)
 - Porcentaje PASS: 85%
**Observaciones clave:**
 - El mock Petstore v3 es permisivo: acepta la mayoría de inputs inválidos y devuelve HTTP 200 con reflejo parcial.
 - FAILs detectados en TC-10 y TC-13 muestran falta de validación estricta de formato y tipo (oportunidad de mejora en backend real).
 - Todos los casos generaron respuesta JSON válida (R2 siempre PASS).
 - No hubo timeouts ni errores de conexión.
**Evidencias generadas por caso (en evidence/week4/):**
 - tc_XX_log.txt: descripción, payload, HTTP code, resultado pass/fail
 - tc_XX_response.json: cuerpo JSON de respuesta
 - tc_XX_http_code.txt: solo código HTTP
 - summary_TIMESTAMP.txt: resumen global PASS/FAIL
**Oráculos aplicados:**
 - R1 (código HTTP): aplicado en todos (esperado 200 para la mayoría).
 - R2 (JSON válido): aplicado en todos (siempre PASS en esta ejecución).
 - R3–R6 (integridad, quantity, status, shipDate): chequeos fuertes limitados por permisividad del mock.
**Firma / Responsable:** Evans y Colaboradores(JORGE, MARCELO y SHIRLEY EULALIA) 
**Última actualización:** 2026-02-06 16:35 -04