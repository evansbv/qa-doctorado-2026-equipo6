# Informe Metodológico - Semana 4  
**Diseño Sistemático de Pruebas + Reglas de Oráculo**  
**Curso**: DCC-M10_T3-4_CS-SEM3-4  
**Autores:** 
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   
**Fecha**: 6 de febrero de 2026  

## 1. Endpoint elegido y motivación

Se seleccionó el endpoint **POST /api/v3/store/order** como objeto de prueba único para esta actividad.  

Este endpoint permite crear una orden de compra de mascotas mediante un payload JSON que incluye campos como petId (entero), quantity (entero positivo), shipDate (fecha ISO 8601), status (enum: placed, approved, delivered), complete (booleano) e id (generado por servidor).  

La elección se fundamenta en su relevancia transaccional (impacta directamente la integridad de datos y el flujo de negocio del sistema Petstore), su variabilidad moderada en parámetros (tipos, rangos, enums, semántica de fecha), y la posibilidad de definir un conjunto manejable pero representativo de casos sistemáticos (≥12) que cubran riesgos críticos de calidad identificados en semanas previas (integridad, consistencia, cumplimiento de contrato y robustez ante entradas inválidas).  

A diferencia de endpoints de solo lectura (GET /pet/{id}), este permite evaluar tanto validaciones de entrada como coherencia de salida en operaciones de escritura, lo que lo hace ideal para demostrar diseño sistemático en un contexto limitado de tiempo.

## 2. Técnica de diseño usada y justificación

Se adoptó la combinación de **Clases de Equivalencia (EQ)** + **Análisis de Valores Límite (BV)** como técnica principal de diseño sistemático.  

EQ permite particionar el espacio de input en clases representativas (válidas/inválidas por tipo, rango, enum, formato), mientras que BV enfoca la detección de fallos en fronteras críticas (quantity=0, quantity=1, quantity muy grande; shipDate pasada/futura; status fuera del enum).  

Esta combinación fue preferida sobre pairwise testing porque:  
- El número de parámetros independientes es moderado (5–6 campos clave).  
- Las interacciones críticas son más de tipo "regla de negocio" (ej. quantity > 0, status válido) que combinaciones exhaustivas.  
- Permite generar un conjunto de casos exhaustivo pero controlado (14 casos) sin requerir herramientas externas de generación automática.  

La decisión asegura cobertura estructurada y defendible con esfuerzo razonable, alineada con principios de testing basado en riesgos y evidencia reproducible.

## 3. Definición de oráculos (mínimos vs estrictos)

Se definieron 6 reglas de oráculo en `design/oracle_rules.md`, clasificadas en dos niveles:

- **Oráculos débiles (mínimos y seguros)**: R1 (código HTTP correcto) y R2 (respuesta JSON válida y parseable). Estos se aplican en todos los casos y constituyen la base de evaluación (siempre deben cumplirse para considerar la prueba válida).  
- **Oráculos fuertes (más estrictos)**: R3 (integridad de campos reflejados), R4 (validación de rangos en quantity), R5 (enum de status), R6 (semántica de shipDate). Estos se aplican selectivamente en casos de borde/inválidos y detectan desviaciones sutiles de calidad.

En el mock Petstore v3, los oráculos fuertes fueron limitados por la permisividad del servidor (acepta quantity negativa, status arbitrario y fechas inválidas con HTTP 200). Esto resultó en 12 PASS y 2 FAIL (TC-10: shipDate inválido; TC-13: petId tipo erróneo), evidenciando falta de validación estricta.

## 4. Cobertura afirmada y limitaciones

**Cobertura afirmada**:  
- Cobertura de clases de equivalencia: todas las particiones principales de los campos clave (petId válido/inválido/tipo erróneo, quantity válido/límite/inválido, status válido/inválido/ausente, shipDate válida/inválida, complete booleano).  
- Cobertura de valores límite: inferior (quantity=1), superior razonable (999999), inválidos extremos (0, -1, fechas pasadas/inválidas).  
- Cobertura funcional: creación nominal, errores de validación sintáctica/semántica, integridad de datos reflejados.

**Cobertura NO afirmada**:  
- Interacciones complejas entre múltiples campos (ej. combinaciones exhaustivas de status + shipDate).  
- Pruebas de carga, concurrencia o rendimiento.  
- Comportamiento bajo condiciones reales (autenticación, base de datos persistente, límites de negocio no mockeados).  
- Validación completa del contrato OpenAPI (ej. uso de herramientas como Dredd).  

La cobertura es representativa para un endpoint transaccional en entorno local/mock, pero no sustituye pruebas integrales en staging/producción.

## 5. Amenazas a la validez

- **Validez interna** (¿los resultados son atribuibles al diseño y no a factores externos?):  
  Amenaza moderada por variabilidad del contenedor Docker (warm-up, recursos CPU/memoria locales). Mitigada reiniciando el contenedor antes de la ejecución y usando timeout en curl, pero persiste riesgo de latencia intermitente que podría afectar percepción de "cuelgue" en casos lentos.

- **Validez de constructo** (¿las mediciones representan fielmente los constructos de calidad?):  
  Amenaza alta: el mock Petstore v3 es extremadamente permisivo (acepta casi cualquier input con 200 OK), lo que subestima la efectividad de oráculos fuertes. Los FAILs detectados (TC-10, TC-13) reflejan desviaciones reales del contrato ideal, pero no necesariamente fallos en un backend productivo con validaciones estrictas. Los oráculos se basan en expectativas teóricas, no en SLOs(Service Level Objective-Objetivo de Nivel de Servicio) reales.

- **Validez externa** (¿los resultados generalizan a otros contextos?):  
  Amenaza significativa: los resultados son específicos del mock local (sin persistencia, sin auth, sin límites reales de negocio). No se generalizan a entornos productivos con validaciones backend, rate limiting, autenticación o bases de datos. La ejecución única en hardware local (Santa Cruz, -04) no captura variabilidad cross-plataforma o bajo carga.

En conclusión, el diseño sistemático demostró ser efectivo para identificar limitaciones de validación en el mock (85% PASS, FAILs en tipo y formato), pero sus límites resaltan la necesidad de iterar hacia entornos más realistas y oráculos alineados con el contrato OpenAPI completo.

