# Reglas de Oráculo - Semana 4

**Endpoint de prueba**: POST /store/order  
**Descripción**: Crea una nueva orden de compra de mascotas.  
**Versión del documento**: 1.0 (Semana 4)  
**Fecha**: Febrero 2026  

Estas reglas definen criterios pass/fail claros y reutilizables para evaluar respuestas del endpoint. Se dividen en:

- **Oráculos débiles** (mínimos, seguros, de bajo riesgo): siempre deben cumplirse para considerar la prueba válida.
- **Oráculos fuertes** (más estrictos): detectan problemas sutiles de calidad, integridad o cumplimiento del contrato.

## Reglas de oráculo

### R1 – Código HTTP correcto según el escenario (oráculo débil)
- **Qué se observa**: Código de estado HTTP en la respuesta.
- **Pass**: 
  - 200 OK o 201 Created cuando el payload es válido.
  - 400 Bad Request cuando hay errores de validación de entrada.
  - 422 Unprocessable Entity cuando hay errores semánticos (ej. quantity negativa).
- **Fail**: Cualquier otro código (ej. 500, 404, 405, 415) o código inesperado para el caso.
- **Justificación**: Cumplimiento básico del contrato HTTP y manejo de errores.

### R2 – Respuesta contiene cuerpo JSON válido (oráculo débil)
- **Qué se observa**: La respuesta es un JSON parseable (Content-Type: application/json).
- **Pass**: 
  - Respuesta 200/201: cuerpo JSON con estructura esperada (incluye al menos "id", "petId", "quantity", "status").
  - Respuesta 4xx: cuerpo JSON con mensaje de error descriptivo (ej. {"message": "...", "errors": [...] }).
- **Fail**: 
  - Respuesta no es JSON válido.
  - Content-Type incorrecto.
  - Cuerpo vacío en 200/201.
- **Justificación**: Garantiza que el consumidor pueda procesar la respuesta.

### R3 – Integridad de los datos de entrada en la respuesta (oráculo fuerte)
- **Qué se observa**: Los valores enviados en el body (petId, quantity, status, complete) aparecen correctamente en la respuesta.
- **Pass**: 
  - Todos los campos enviados coinciden exactamente con los recibidos (excepto "id" generado por el servidor y "shipDate" normalizado).
  - quantity y complete no se modifican.
- **Fail**: 
  - Algún campo modificado sin justificación.
  - Campos enviados desaparecen o cambian de valor.
- **Justificación**: Detecta problemas de integridad de datos en operaciones de escritura.

### R4 – Validación de rangos y valores límite en quantity (oráculo fuerte)
- **Qué se observa**: Comportamiento en valores límite y fuera de rango para quantity (entero positivo).
- **Pass**: 
  - quantity = 1 → aceptado (200/201).
  - quantity = 0 → rechazado (400/422).
  - quantity = -1 → rechazado (400/422).
  - quantity muy grande (ej. 999999999) → aceptado o rechazado con mensaje claro (dependiendo de implementación).
- **Fail**: 
  - quantity negativa o cero aceptada sin error.
  - quantity muy grande causa 500 o comportamiento indefinido.
- **Justificación**: Cubre clases de equivalencia y valores límite críticos.

### R5 – Validación de enum en status (oráculo fuerte)
- **Qué se observa**: Campo status solo acepta valores del conjunto definido en OpenAPI (placed, approved, delivered).
- **Pass**: 
  - status = "placed" / "approved" / "delivered" → aceptado (200/201).
  - status = "invalid" / "" / null → rechazado (400/422) con mensaje descriptivo.
- **Fail**: 
  - Valor inválido aceptado.
  - Valor válido rechazado sin razón.
- **Justificación**: Garantiza cumplimiento del contrato y evita estados inválidos en el negocio.

### R6 – shipDate como fecha válida y futura (opcional – oráculo fuerte adicional)
- **Qué se observa**: Formato y semántica de shipDate (ISO 8601).
- **Pass**: 
  - Fecha futura válida → aceptada.
  - Fecha pasada o formato inválido → rechazada (400/422).
- **Fail**: 
  - Fecha inválida aceptada.
  - Formato no ISO aceptado sin normalización.
- **Justificación**: Evita órdenes con fechas ilógicas.

### Resumen de aplicación
- Reglas R1 y R2: **siempre** se aplican (oráculos débiles – base de cualquier prueba).
- Reglas R3–R6: se aplican según el caso específico (bordes, combinaciones inválidas, integridad).
- Todas las reglas son automatizables (con curl + jq + assertions) y versionadas en el repositorio.

**Autor**: Evans y Colaboradores(JORGE, MARCELO y SHIRLEY EULALIA)  
**Última revisión**: Febrero 2026