# memos/week3_memo.md

## Memo - Semana 3: Estrategia Basada en Riesgos + Evidencia 

**Fecha**: 29 de enero de 2026 
- **Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   

**Objetivo de la semana:** Implementar estrategia de pruebas basada en riesgo + evidencia para la API Petstore.  
Priorizar control de calidad conectando: Riesgo → Escenario → Evidencia → Riesgo residual.  
Entregar artefactos obligatorios: risk_matrix.csv (≥8 riesgos, Top 3), test_strategy.md, evidence/week3/ + RUNLOG.md, week3_memo.md.

## Actividades realizadas
1. Entendimiento del proceso de gestión de riesgos
  - Revisión conceptual del enfoque de gestión de riesgos basado en ISO 31000 aplicado a calidad de software.
  - Alineación del equipo respecto al modelo Riesgo → Escenario → Evidencia → Riesgo residual.
  - Discusión y consenso sobre criterios de impacto y probabilidad (escala 1–5).
  - Identificación de riesgos técnicos enfocados exclusivamente en calidad del producto (no gestión).
2. Preparación de rama y estructura de carpetas (risk/, evidence/week3/, memos/).
  - Creación y validación de la rama de trabajo correspondiente a la Semana 3.
  - Definición de la estructura de carpetas estándar:
      * risk/ para activos de gestión de riesgos.
      * evidence/week3/ para evidencias técnicas reproducibles.
      * memos/ para documentación ejecutiva semanal.
  - Verificación de consistencia con la estructura utilizada en semanas previas
3. Definición de riesgos de calidad del producto (excluyendo gestión).
  - Lluvia de ideas orientada a riesgos técnicos observables en la API Petstore.
  - Exclusión explícita de riesgos administrativos, contractuales o de gestión.
  - Redacción clara y homogénea de cada riesgo, asegurando que sea:
       * Medible.
       * Asociable a escenarios de prueba.
       * Evidenciable mediante artefactos técnicos.
4. Construcción de matriz de riesgos (8 riesgos, scores 1–5, orden por score, Top 3: Disponibilidad, Latencia, Consistencia).
  - Asignación de valores de impacto y probabilidad a cada riesgo identificado.
  - Cálculo del score total y ordenamiento descendente por criticidad.
  - Consolidación de una matriz con un total de 8 riesgos.
  - Identificación y validación de los Top 3 riesgos críticos:
        * R01 – Disponibilidad.
        * R02 – Latencia.
        * R03 – Consistencia.
5. Mapeo de Top 3 riesgos a escenarios existentes de quality/scenarios.md (SC-01, SC-05, SC-06 + extensiones).
  - Revisión del archivo quality/scenarios.md generado en la Semana 2.
  - Asociación explícita de los Top 3 riesgos a escenarios existentes:
        * SC-01 para disponibilidad.
        * SC-05 para latencia.
        * SC-06 para consistencia.
  - Definición de extensiones o ajustes a los escenarios cuando fue necesario para cubrir el riesgo de forma adecuada.
  - Aseguramiento de trazabilidad entre riesgo, escenario y evidencia futura.
6. Redacción de estrategia mínima en risk/test_strategy.md (propósito, alcance, tabla Top 3, reglas de evidencia, residual, validez).
  - Redacción del documento risk/test_strategy.md.
  - Inclusión de los siguientes componentes:
         * Propósito y alcance de la estrategia.
         * Tabla de priorización de los Top 3 riesgos.
         * Reglas para la generación y aceptación de evidencias.
         * Criterios para evaluación de riesgo residual.
         * Consideraciones de validez y reproducibilidad de resultados.
    - Revisión grupal de la estrategia para asegurar coherencia y defendibilidad técnica.
7. Creación de scripts de prueba para la generación de evidencia.
  - Definición del alcance de los scripts en función de los Top 3 riesgos priorizados.
  - Selección del tipo de scripts a desarrollar (smoke, medición de latencia, validación de consistencia).
  - Implementación de scripts reutilizables para consumo de la API Petstore.
  - Parametrización básica de entradas y endpoints para facilitar ejecuciones repetibles.
  - Validación de la correcta captura de salidas (responses, tiempos de respuesta, códigos HTTP).
  - Preparación de los scripts para su ejecución controlada y registro posterior en el RUNLOG.
8. Actualización y organización de las carpetas evidence, memos, scripts y risk
  - Revisión integral de la estructura de carpetas del proyecto para asegurar alineación con los objetivos de la Semana 3.
  - Actualización de la carpeta evidence/ para preparar el almacenamiento de evidencias técnicas reproducibles.
  - Ajustes en la carpeta memos/ para incorporar la documentación y temas acordados con el grupo.
  - Organización de la carpeta scripts/ para centralizar los scripts de prueba desarrollados.
  - Actualización de la carpeta risk/ para consolidar la matriz de riesgos y la estrategia de pruebas basada en riesgos.
  - Validación de la coherencia entre estructura de carpetas, artefactos generados y trazabilidad Riesgo → Escenario → Evidencia.

## Resultados clave
- Matriz completa con 8 riesgos (risk_matrix.csv), priorización clara y trazabilidad a escenarios Semana 2.
- Estrategia documentada y defendible (risk/test_strategy.md).
- Scripts de prueba desarrollados y preparados para la ejecución de escenarios asociados a los Top 3 riesgos priorizados (disponibilidad, latencia y consistencia).
- Evidencia técnica reproducible generada para los Top 3 riesgos, almacenada en la carpeta evidence/week3/, incluyendo logs de ejecución, mediciones y muestras de respuestas.
- Registro cronológico de las ejecuciones y resultados documentado en evidence/week3/RUNLOG.md, asegurando trazabilidad y auditabilidad de las pruebas realizadas.

## Reflexión breve
La gestión de riesgos está ingresando a los procesos operativos organizacionales como un paradigma de aplicación, entre los aspectos discutidos en el grupo en la reunión estuvo definiendo que estándares de riesgos y aspectos de aplicabilidad existen en el mercado, de la cual se identificó las siguientes respuestas:
- Existen estandares y buenas prácticas como la ISO 31000 (Gestión de riesgos empresariales) que emite pasos, tareas, responsables y objetivos de todo el ciclo de la gestión de riesgos.
- Desde un punto de vista aplicativo a los procesos actuales observamos que en normas como la generada por ASFI hace mención a las metodologías de auditoría basadas en riesgos.
Lo anterior descrito denota que las necesidades de implementar gestión de riesgos en las tareas operativas es un paradigma que apoya en centrar todos los recursos en los puntos más criticos que se vayan a determinar, por lo que la priorización en riesgos observables (disponibilidad, latencia, consistencia) permite generar valor rápido y evidencia defendible con bajo esfuerzo inicial.
El enfoque basado en escenarios existentes de Semana 2 facilita la trazabilidad y reutilización.
