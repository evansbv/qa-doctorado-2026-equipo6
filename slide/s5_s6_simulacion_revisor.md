# Evaluación de Propuesta - Equipo  6
**Propuesta evaluada:** A — Empresa: Q-Edge Consulting  
**Veredicto:** Aceptar con condiciones

**Regla aplicada:** Todos los puntos están respaldados por las secciones evaluadas de la propuesta, donde no se identificó un criterio suficiente de aprobación se reportó como “Vacío”.

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
- Objetivo declarado: “Establecer control de calidad continuo en el sistema del cliente con un quality gate en CI que entregue evidencia auditable por ejecución.”  
**Referencia:** Sección 1) Resumen ejecutivo

- Alcance / exclusiones (2+ puntos):
  - Incluye: escenarios (6–10), matriz de riesgos y estrategia Top 3, pruebas sistemáticas (≥12 casos por objeto), oráculos, gate CI con artifacts.  
  **Ref:** Sección 3) Alcance y exclusiones
  - Excluye: pruebas de seguridad especializadas, pruebas de carga a nivel producción, auditoría formal de arquitectura.  
  **Ref:** Sección 3) Alcance y exclusiones

- Entregables principales (3+ puntos):  
  - Catálogo de escenarios con evidencia esperada.  
  **Ref:** Sección 4) Metodologia
  - Documento de estrategia riesgo→escenario→evidencia.  
  **Ref:** Sección 4) Metodologia
  - Gate CI implementado con artifacts por ejecución.  
  **Ref:** Sección 4) Metodologia + Sección 5) Quality Gate propuesto

---

## Slide 2 - Fortalezas (basadas en texto)
- F1: Uso explícito de escenarios estructurados  
**Evidencia en propuesta:** Sección 4) Metodologia
**Por qué es valioso:** Permite trazabilidad clara entre estímulo, entorno, respuesta y medida.

- F2: Priorización basada en riesgo (Top 3)  
**Evidencia en propuesta:** Sección 4) Metodología  
**Por qué es valioso:** Enfoca cobertura en riesgos de mayor impacto y probabilidad.

- F3: Aplicación de diseño sistemático (EQ/BV + pairwise)  
**Evidencia en propuesta:** Sección 4) Metodología  
**Por qué es valioso:** Reduce pruebas ad-hoc y mejora representatividad de casos.

- F4: Quality gate con publicación de artifacts 
**Evidencia en propuesta:** Sección 5) Quality gate propuesto 
**Por qué es valioso:** Genera evidencia auditable por ejecución.

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
- D1 (Severidad: **Crítica**): Gate aprueba con 3 de 4 checks
**Texto/Sección relacionada:** Sección 5)
**Riesgo/impacto:** Puede aprobar builds con una dimensión crítica fallando, sin considerar potenciales retest.
- D2 (Severidad: **Mayor**): Exclusión explícita de pruebas de seguridad
**Texto/Sección relacionada:** Sección 3)
**Riesgo/impacto:** No se evidencia inclusión de controles de seguridad en diseño, lo que implica que se esté ingresando vulnerabilidades a producción.
- D3 (Severidad: **Mayor**): Recalibración de umbrales sin procedimiento formal explícito
**Texto/Sección relacionada:** Sección 6) y 7)
**Riesgo/impacto:** Posible degradación progresiva del estándar del gate.
- D4 (Severidad: **Mayor**): Gobernanza ligera del control de cambios
**Texto/Sección relacionada:** Sección 7)
**Riesgo/impacto:** No se define mecanismo formal documentado de aprobación, ya que no menciona procedimientos o procesos formalmente establecidos.
- D5 (Severidad: **Menor–Mayor**): Cobertura superficial de integridad de datos
**Texto/Sección relacionada:** Sección 5) (robustez básica)
**Riesgo/impacto:** No se detallan controles sobre modificación/eliminación de datos ya que la misma no forma parte del proceso de ingeniería.

---

## Slide 4 - Cobertura explícita vs vacíos

### A) Lo que la propuesta sí define
- Fases estructuradas con cronograma de 8 semanas.
**Ref:** Sección 4 y 8
- Definición de oráculos mínimos y evidencia reproducible.
**Ref:** Sección 4, Fase 3
- Gobernanza semanal del gate con líder técnico.
**Ref:** Sección 7

### B) Vacíos/ambigüedades que impiden evaluar bien
- Vacío 1: Políticas formales de desarrollo
**Qué falta exactamente:** No se menciona alineación con políticas institucionales.
**Por qué importa:** Impide evaluar sostenibilidad y cumplimiento regulatorio.
- Vacío 2: Inclusión formal de seguridad en diseño
**Qué falta exactamente:** No se indica participación de responsable de seguridad.
**Por qué importa:** Seguridad queda fuera del alcance explícito.
- Vacío 3: Procedimiento formal documentado de control de cambios
**Qué falta exactamente:** No se describe flujo formal de aprobación y registro.
**Por qué importa:** Afecta gobernanza y auditabilidad.
- Vacío 4: Separación formal de ambientes Dev/Test/Prod
**Qué falta exactamente:** Solo se menciona entorno controlado (docker/staging).
**Por qué importa:** No se evidencia segregación estructural.

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ¿Cómo se formaliza la aprobación de cambios en umbrales del gate?
- P2: ¿Se incorporarán escenarios o checks específicos de seguridad?
- P3: ¿Cómo se asegura segregación formal de ambientes?
- P4: ¿Existe documento de alineación con políticas internas del cliente?

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
- Señal en la propuesta: “pipeline se aprueba si se cumplen al menos 3 de los 4 checks.”  
**Referencia:** Sección 5) 
- Riesgo de gaming: Optimizar para pasar el gate en lugar de reducir riesgo real. 
- Consecuencia probable: Ajuste de umbrales o redefinición de criterios para evitar bloqueos.
- Mitigación/condición: Definir procedimiento formal y criterios mínimos no negociables.

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
- C1: Formalizar procedimiento de control de cambios del gate  
**Cómo se verifica:** Documento versionado que defina responsables y flujo de aprobación.  
**Motivo (D# o Vacío #):** D3 / D4

- C2: Incluir al menos un check de seguridad en el gate 
**Cómo se verifica:** Evidencia de ejecución en CI con artifact correspondiente. 
**Motivo:** D2 / Vacío 2

- C3: Documentar segregación de ambientes Dev/Test/Prod  
**Cómo se verifica:** Diagrama y política formal aprobada. 
**Motivo:** Vacío 4


---

## Slide 7 - Veredicto (decisión final)
- Decisión: **Aceptar con condiciones**
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) Gate permisivo puede comprometer señal de calidad (D1).
  2) Exclusión explícita de seguridad en alcance (D2).
  3) Programa genera valor rápido (gate en semana 7) y transferencia de conocimiento con bajo costo relativo

----------------------------------------------------------------------------------------------------