# Casos de Prueba Sistemáticos - Semana 4

**Endpoint**: POST /store/order  
**Técnica de diseño**: Combinación de Clases de Equivalencia (EQ) + Valores Límite (BV)  
**Referencia de oráculos**: design/oracle_rules.md (R1 a R6)  
**Versión**: 1.0  
**Fecha**: Febrero 2026  

Los casos se derivan de las particiones identificadas en los campos principales del body:

- petId: entero positivo (>0), existe en el catálogo (válido) / no existe (inválido)
- quantity: entero > 0 (válido) / ≤ 0 (inválido) / valores límite (1, muy grande)
- status: enum válido ("placed", "approved", "delivered") / inválido
- shipDate: fecha ISO válida y futura / pasada / formato inválido
- complete: booleano (true/false)
- Campos obligatorios ausentes o tipos erróneos

Se diseñaron 14 casos para cubrir particiones nominales, límites y errores comunes.

| TC-ID | Input (variación clave del payload)                                                                 | Expected (oráculos aplicados)                  | Evidencia esperada                              |
|-------|-----------------------------------------------------------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| TC-01 | payload completo válido (quantity=5, status="placed", shipDate futura, complete=false)            | R1 (201), R2 (JSON válido), R3 (integridad), R5 (status válido) | HTTP 201, body JSON con id generado, campos coincidentes |
| TC-02 | quantity = 1 (límite inferior válido)                                                              | R1 (201), R3, R4 (quantity ≥1 aceptado)       | HTTP 201, quantity=1 en respuesta               |
| TC-03 | quantity = 999999 (límite superior razonable)                                                      | R1 (201), R3, R4 (aceptado o mensaje claro)   | HTTP 201 o 422 con mensaje si hay límite interno |
| TC-04 | quantity = 0 (límite inválido)                                                                     | R1 (400/422), R4 (rechazado)                   | HTTP 4xx, mensaje de error sobre quantity       |
| TC-05 | quantity = -1 (valor negativo)                                                                     | R1 (400/422), R4 (rechazado)                   | HTTP 4xx, mensaje explícito sobre cantidad      |
| TC-06 | status = "approved" (otro valor válido del enum)                                                   | R1 (201), R5 (status válido)                   | HTTP 201, status="approved" en respuesta        |
| TC-07 | status = "invalid" (valor fuera del enum)                                                          | R1 (400/422), R5 (rechazado)                   | HTTP 4xx, mensaje sobre status inválido         |
| TC-08 | status ausente (campo obligatorio omitido)                                                         | R1 (400/422), R2 (error JSON), R5              | HTTP 4xx, mensaje sobre campo requerido         |
| TC-09 | shipDate en formato ISO válido pero pasada (ej. "2025-01-01T00:00:00Z")                            | R1 (400/422), R6 (rechazado si semántica estricta) | HTTP 4xx o 201 (depende de validación), mensaje si rechaza |
| TC-10 | shipDate formato inválido (ej. "2026-02-abc")                                                      | R1 (400/422), R2 (error parseo), R6            | HTTP 4xx, mensaje sobre formato de fecha        |
| TC-11 | complete = true (variación booleana)                                                               | R1 (201), R3 (integridad)                      | HTTP 201, complete=true en respuesta            |
| TC-12 | petId inexistente (ej. petId=999999 que no existe en el catálogo)                                  | R1 (400/422 o 404 según implementación), R3    | HTTP 4xx, mensaje sobre petId no encontrado     |
| TC-13 | petId tipo erróneo (string en vez de entero: "abc")                                                | R1 (400/422), R2 (parseo fallido)              | HTTP 4xx, mensaje sobre tipo inválido           |
| TC-14 | payload vacío o malformado (JSON inválido: { "petId": 1, "quantity": )                              | R1 (400), R2 (no JSON válido)                  | HTTP 400, mensaje de parseo JSON                |

### Notas sobre cobertura
- Casos TC-01 a TC-03: particiones válidas + límites inferiores/superiores.
- TC-04 a TC-05: límites inválidos para quantity.
- TC-06 a TC-08: particiones para status (válido/inválido/ausente).
- TC-09 a TC-10: particiones para shipDate (semántica y sintáctica).
- TC-11: variación booleana simple.
- TC-12 a TC-14: errores de referencia y tipo.

Todos los casos se ejecutarán mediante el script `scripts/systematic_cases.sh` y generarán evidencia en `evidence/week4/`.

**Autor**: Evans y Colaboradores(JORGE, MARCELO y SHIRLEY EULALIA) 
**Última revisión**: Febrero 2026