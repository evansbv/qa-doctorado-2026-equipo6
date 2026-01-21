# quality/scenarios.md

## Lista de Escenarios de Prueba - Semana 2

### Escenario SC-01 - Creación exitosa de una mascota (Happy Path / Contract Availability)
**ID:** SC-01  
**Descripción:** Crear una nueva mascota con datos válidos  

**Estímulo:** se solicita POST /api/v3/pet con body JSON completo y válido  
**Entorno:** ejecución local, sin carga, 1 vez  
**Respuesta:** el SUT responde con HTTP 200 y devuelve el objeto mascota creado  
**Medida (falsable):**  
- Código HTTP = 200  
- El cuerpo de respuesta es JSON válido  
- El campo "id" coincide con el enviado (o es generado correctamente)  
- El campo "name" coincide exactamente con el enviado  

**Evidencia:**  
- evidence/week2/sc-01_create_pet_response.json  
- evidence/week2/sc-01_create_pet_http_code.txt  
- evidence/week2/sc-01_create_pet_log.txt  

**Prioridad:** Alta

### Escenario SC-02 - Consulta de mascota por ID (Happy Path / Contract Availability)
**ID:** SC-02  
**Descripción:** Obtener los datos de una mascota existente  

**Estímulo:** se solicita GET /api/v3/pet/{petId} con un ID válido existente  
**Entorno:** ejecución local, sin carga, 1 vez (precondición: SC-01 ejecutado)  
**Respuesta:** el SUT responde con HTTP 200 y devuelve el objeto mascota  
**Medida (falsable):**  
- Código HTTP = 200  
- El cuerpo es JSON válido  
- El campo "id" en la respuesta coincide con el {petId} solicitado  

**Evidencia:**  
- evidence/week2/sc-02_get_pet_response.json  
- evidence/week2/sc-02_get_pet_http_code.txt  

**Prioridad:** Alta

### Escenario SC-03 - Actualización de mascota (Happy Path / Contract Availability)
**ID:** SC-03  
**Descripción:** Modificar el nombre y status de una mascota existente  

**Estímulo:** se solicita PUT /api/v3/pet con body JSON actualizado (nuevo name y status)  
**Entorno:** ejecución local, sin carga, 1 vez (precondición: SC-01 o SC-02)  
**Respuesta:** el SUT responde con HTTP 200 y devuelve la mascota actualizada  
**Medida (falsable):**  
- Código HTTP = 200  
- El campo "name" en la respuesta coincide con el nuevo valor enviado  
- El campo "status" en la respuesta coincide con el nuevo valor enviado  

**Evidencia:**  
- evidence/week2/sc-03_update_pet_response.json  
- evidence/week2/sc-03_update_pet_http_code.txt  
- evidence/week2/sc-03_update_pet_before_after.txt (opcional: comparación)

**Prioridad:** Alta

### Escenario SC-04 - Intento de creación inválida (Robustness / Error Handling)
**ID:** SC-04  
**Descripción:** Enviar mascota sin el campo obligatorio "name"  

**Estímulo:** se solicita POST /api/v3/pet con body JSON sin el campo "name"  
**Entorno:** ejecución local, sin carga, 1 vez  
**Respuesta:** el SUT responde con código de error (400 o 405 según implementación)  
**Medida (falsable):**  
- Código HTTP = 400 o 405  
- El cuerpo de respuesta contiene mensaje de error o es JSON con detalle  
- No se crea la mascota (GET /pet/{id} debería dar 404 si se intenta con ID enviado)  

**Evidencia:**  
- evidence/week2/sc-04_invalid_pet_response.json  
- evidence/week2/sc-04_invalid_pet_http_code.txt  

**Prioridad:** Media-Alta

### Escenario SC-05 - Latencia básica del endpoint de inventario (Performance - Local)
**ID:** SC-05  
**Descripción:** Medir latencia básica del endpoint de inventario  

**Estímulo:** se solicita GET /store/inventory  
**Entorno:** ejecución local, sin carga externa, 30 repeticiones consecutivas  
**Respuesta:** el SUT responde con HTTP 200 en todas las ejecuciones  
**Medida (falsable):**  
- Cada ejecución devuelve HTTP 200  
- Registrar time_total (en segundos) por cada repetición  
- Opcional: p95 <= 1.0 segundos (percentil 95 de latencia)  

**Evidencia:**  
- evidence/week2/sc-05_latency.csv (columnas: ejecución, http_code, time_total_s)  
- evidence/week2/sc-05_latency_summary.txt (min, max, avg, p95)

**Prioridad:** Media

### Escenario SC-06 - Validación básica de forma de datos en inventario (Data Shape Sanity)
**ID:** SC-06  
**Descripción:** Verificar que el inventario devuelve un objeto JSON coherente  

**Estímulo:** se solicita GET /store/inventory  
**Entorno:** ejecución local, sin carga, 1 vez  
**Respuesta:** el cuerpo es un JSON válido y no contiene valores inesperados  
**Medida (falsable):**  
- Código HTTP = 200  
- El cuerpo comienza con '{'  
- El cuerpo es un objeto JSON (no array, no texto plano, no HTML)  
- Contiene al menos una clave (ej. "sold", "pending", etc.) con valor numérico >= 0  

**Evidencia:**  
- evidence/week2/sc-06_inventory_response.json  
- evidence/week2/sc-06_inventory_http_code.txt  
- evidence/week2/sc-06_inventory_shape_check.txt (resumen de validación)

**Prioridad:** Media

