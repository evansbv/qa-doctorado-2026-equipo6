# Evaluación de Propuesta - Equipo  6
**Propuesta evaluada:** A — Empresa: Q-Edge Consulting  
**Veredicto:** Aceptar con condiciones


**Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO  
  
**Fecha**: 21 de febrero de 2026

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado: “Programa integral para establecer control de calidad continuo en el sistema del cliente , acelerar la adopción y asegurar que el gate sea operativo rápidamente.”  
  **Referencia:** Sección 1) Resumen ejecutivo

- Alcance / exclusiones (2+ puntos):
  - Incluye: 6–10 escenarios, matriz de riesgos + estrategia Top 3, ≥12 casos por objeto, oráculos, gate CI con artifacts, guía de mantenimiento  
    **Ref:** Sección 3) Alcance y exclusiones
  - Excluye: pruebas de seguridad especializadas, pruebas de carga a nivel producción, auditoría formal de arquitectura  
    **Ref:** Sección 3) Alcance y exclusiones

- Entregables principales (3+ puntos):  
  - Escenarios y evidencia reproducible versionados  
    **Ref:** Sección 9) Criterios de aceptación
  - Gate CI que ejecuta checks y publica artifacts por run  
    **Ref:** Sección 9) Criterios de aceptación + Sección 5) Quality gate propuesto
  - Documentación de operación entregada y transferida al equipo  
    **Ref:** Sección 9) Criterios de aceptación + Sección 4) Metodología (Fase 4)

---

## Slide 2 - Fortalezas (basadas en texto)
- F1: Enfoque pragmático y progresivo con criterio flexible (≥3 de 4 checks) y reintentos automáticos  
  **Evidencia en propuesta:** Sección 5) Quality gate propuesto + Sección 6) Manejo de ruido y fallas intermitentes  
  **Por qué es valioso:** Reduce riesgo de bloqueos prematuros y facilita adopción en equipos reales de entrega continua

- F2: Estructura clara por fases con entregables tangibles y cronograma acotado (8 semanas)  
  **Evidencia en propuesta:** Sección 4) Metodología (fases) + Sección 8) Costos y cronograma  
  **Por qué es valioso:** Permite seguimiento predecible y minimiza riesgo de proyecto abierto indefinido

- F3: Uso de oráculos mínimos para reducir fricción y permitir evolución del sistema  
  **Evidencia en propuesta:** Sección 4) Metodología – Fase 3 — Diseño sistemático y oráculos  
  **Por qué es valioso:** Evita deuda de mantenimiento excesiva y alinea con madurez variable de equipos

- F4: Costo y duración realistas para el alcance propuesto  
  **Evidencia en propuesta:** Sección 8) Costos y cronograma  
  **Por qué es valioso:** USD 12,000 por 8 semanas con gate operativo en semana 7 es competitivo para un programa 360

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
- D1 (Severidad: **Mayor**): Dependencia crítica en el líder técnico con capacidad de decisión real  
  **Texto/Sección relacionada:** Sección 2) Supuestos y dependencias  
  **Riesgo/impacto:** Si no participa o carece de autoridad, el programa puede estancarse en validaciones y ajustes

- D2 (Severidad: **Mayor**): Cobertura inicial muy limitada (solo 2 objetos profundizados + 6–10 escenarios)  
  **Texto/Sección relacionada:** Sección 3) Alcance + Fase 3  
  **Riesgo/impacto:** Deja expuestos muchos flujos críticos en sistemas medianos/grandes tras las 8 semanas

- D3 (Severidad: **Media**): Criterio 3/4 permite pasar el pipeline aunque falle la suite sistemática  
  **Texto/Sección relacionada:** Sección 5) Quality gate propuesto – Criterio operativo  
  **Riesgo/impacto:** Genera falsa sensación de seguridad ante regresiones importantes

- D4 (Severidad: **Media**): Umbrales no funcionales basados en “experiencia previa” sin baseline del cliente  
  **Texto/Sección relacionada:** Sección 6) Manejo de ruido y fallas intermitentes  
  **Riesgo/impacto:** Puede causar gate ruidoso (muchos falsos positivos) o permisivo (regresiones no detectadas)

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
- 4 fases con duración y entregables claros  
  **Ref:** Sección 4) Metodología (fases)
- Quality gate con 4 checks específicos y criterio 3/4  
  **Ref:** Sección 5) Quality gate propuesto
- Reintentos automáticos ×1 y recalibración de umbrales  
  **Ref:** Sección 6) Manejo de ruido y fallas intermitentes
- Revisión semanal con líder técnico y gestión de cambios vía repo  
  **Ref:** Sección 7) Gobernanza y cambios

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: No especifica criterio de selección de los 6–10 escenarios críticos  
  **Qué falta exactamente:** ¿Son los de mayor negocio o los más automatizables?  
  **Por qué importa:** Define el ROI real y la protección efectiva del sistema

- Vacío 2: Detalle insuficiente sobre el alcance del check no funcional (p95) en CI  
  **Qué falta exactamente:** ¿Cuántos endpoints? ¿Dependencias externas? ¿Paralelismo?  
  **Por qué importa:** Puede ser ruidoso o poco representativo en entornos reales

- Vacío 3: No menciona estrategia de mantenimiento a mediano plazo de la suite  
  **Qué falta exactamente:** Ownership, refactor, manejo de deuda técnica post-8 semanas  
  **Por qué importa:** El equipo del cliente puede perder capacidad de sostener la suite

- Vacío 4: Ausencia de KPIs / métricas de éxito post-implantación  
  **Qué falta exactamente:** Ej. tasa de falsos positivos, reducción de defectos escapados  
  **Por qué importa:** Difícil medir si los USD 12k generaron valor real

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ¿Qué porcentaje aproximado de flujos críticos esperan cubrir con los 6–10 escenarios y 2 objetos profundizados?
- P2: En caso de líder técnico sin autoridad real o baja participación, ¿qué plan de mitigación proponen?
- P3: ¿Ofrecen soporte opcional post-8 semanas (retainer, horas de escalabilidad) y a qué costo aproximado?

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
- Señal en la propuesta: Criterio flexible ≥3 de 4 checks + reintentos automáticos + recalibración de umbrales  
  **Referencia:** Sección 5) + Sección 6)
- Riesgo de gaming: Equipo puede presionar para bajar umbrales o ignorar fallos en checks valiosos manteniendo ≥3/4  
- Consecuencia probable: Gate pierde poder protector → defectos regresión pasan a producción
- Mitigación/condición: Hacer obligatorio el check de suite sistemática + al menos 2 de los otros 3

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
- C1: Compromiso escrito del líder técnico con autoridad real para aprobar ajustes operativos  
  **Cómo se verifica:** Email o acta de kick-off antes de Fase 1  
  **Motivo (D# o Vacío #):** D1 (dependencia del líder técnico)

- C2: Modificar criterio del gate → **Obligatorio pasar check 2 (suite sistemática)** + ≥2 de los otros 3  
  **Cómo se verifica:** Ajuste documentado en estrategia (Fase 2) y probado en semana 7  
  **Motivo:** D3 (riesgo de falsa seguridad)

- C3: Entregar roadmap 3–6 meses con criterios para próximos objetos/escenarios y estimación de esfuerzo  
  **Cómo se verifica:** Documento validado en revisión semana 8  
  **Motivo:** Vacío 3 (mantenimiento a mediano plazo)

- C4: Definir y acordar ≥3 KPIs cuantificables al cierre (ej. tasa falsos positivos <15%, % cobertura estimada)  
  **Cómo se verifica:** Incluidos en resumen ejecutivo final y aceptados en reunión de cierre  
  **Motivo:** Vacío 4 (ausencia de métricas de éxito)

---

## Slide 7 - Veredicto (decisión final)
- Decisión: **Aceptar con condiciones**
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) Fortalezas pragmáticas y estructura sólida superan riesgos si se mitigan dependencias y criterio flexible (D1 + D3)
  2) Cobertura inicial limitada y falta de plan de continuidad se corrigen con condiciones verificables (D2 + Vacío 3)
  3) Programa genera valor rápido (gate en semana 7) y transferencia de conocimiento con bajo costo relativo

----------------------------------------------------------------------------------------------------