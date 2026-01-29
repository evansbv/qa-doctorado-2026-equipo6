# Estrategia de Pruebas Basada en Riesgo - Semana 3

## 1. Propósito
Priorizar el control de calidad mediante **risk-based testing**, enfocándonos en riesgos de alto impacto y observables.  
Conexión explícita: **Riesgo → Escenario → Evidencia → Riesgo residual**.  
Esto genera una estrategia defendible y reproducible.

## 2. Definición de Riesgos de Calidad
Riesgos del producto (no de gestión):  
- Disponibilidad  
- Latencia / Rendimiento  
- Consistencia de respuestas  
- Robustez  
- Cumplimiento del contrato OpenAPI  
- Integridad de datos  
- Seguridad  
- Usabilidad para consumidores  

## 3. Matriz de Riesgos y Priorización
Ver [`risk/risk_matrix.csv`](./risk_matrix.csv) (8 riesgos identificados).  

**Criterios**: Severidad = Probabilidad × Impacto.  
**Top 3 priorizados** (alto impacto + observables por usuarios/consumidores):

1. **R01 - Disponibilidad** → Sin sistema disponible no hay valor entregado (Crítico)  
2. **R02 - Latencia** → Afecta directamente la experiencia del usuario y percepción de calidad (Alto)  
3. **R03 - Consistencia** → Inconsistencias generan pérdida de confianza y errores lógicos (Alto)

## 4. Enfoque de Pruebas Basado en Riesgo
- **Top 3**: Cobertura alta → pruebas automatizadas (smoke, mediciones, asserts consistencia), ejecución frecuente, evidencia completa en `evidence/week3/`.  
- **Otros**: Cobertura media/baja → selectiva o exploratoria.

**Conexión Riesgo → Escenario → Evidencia → Riesgo residual** (para Top 3):

| Riesgo | Escenario clave | Tipo de evidencia | Riesgo residual esperado |
|--------|-----------------|-------------------|--------------------------|
| R01 (Disponibilidad) | Health check falla o 5xx inesperado | Smoke tests logs, HTTP codes, RUNLOG | Bajo (si pasa consistentemente) |
| R02 (Latencia) | Respuestas > umbral en /pet/findByStatus | Mediciones CSV/txt (avg, p95), summary | Medio (baseline local; no producción) |
| R03 (Consistencia) | Respuestas variables en listas/filtros | Asserts en schema, counts, valores lógicos | Bajo-Medio (si asserts cubren casos clave) |

## 5. Evidencia y Trazabilidad
- Carpeta: `evidence/week3/`  
- `RUNLOG.md`: Registro cronológico (fecha, comando, resultado, enlaces).  
- Evidencia detallada solo para Top 3 esta semana (logs, CSVs, outputs de pytest, etc.).

## 6. Riesgo residual general
Aun mitigando Top 3, persisten riesgos en robustez profunda, seguridad, integridad bajo carga y entornos reales. Se acepta en esta etapa para enfocarnos en evidencia reproducible y básica.


**Aprobado / Responsable**: Equipo
- BALCAZAR VEIZAGA EVANS
- ROSALES FUENTES JORGE MARCELO
- CORDERO FLORES MARCELO
- PEREZ DELGADILLO SHIRLEY EULALIA  
  
**Fecha**: Semana 3 - [29/01/2026]
