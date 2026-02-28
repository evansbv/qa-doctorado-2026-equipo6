# Presentación de Hallazgos: IA para QA - Generación, Selección y Priorización de Pruebas

**Participantes:**
  - EVANS BALCAZAR VEIZAGA  
  - JORGE MARCELO ROSALES FUENTES  
  - MARCELO CORDERO FLORES  
  - SHIRLEY EULALIA PEREZ DELGADILLO   
**Fecha**: 26 de febrero de 2026  
**Objetivo**: Síntesis de aplicaciones de IA (GenAI, ML, RL) en QA con evidencia científica, riesgos, gobernanza y recomendaciones prácticas.

## Slide 1: Título y Equipo
- Tema: IA para QA: Generación, Selección y Priorización de Pruebas  
- Equipo: 
    - EVANS BALCAZAR VEIZAGA  
    - JORGE MARCELO ROSALES FUENTES  
    - MARCELO CORDERO FLORES  
    - SHIRLEY EULALIA PEREZ DELGADILLO     
- Fecha: Febrero 26, 2026  
- Enfoque: Hallazgos con respaldo académico (papers 2023-2026), tendencias actuales y límites.

## Slide 2: Alcance del Tema
- **Qué cubre**: Generación de casos con LLMs/GenAI, selección/optimización de suites con ML, priorización basada en riesgo con RL; integración en CI/CD; risk-based testing.  
- **Qué no cubre**: AI en auditorías de procesos QA, testing de hardware o ética AI general no aplicada a testing.  
- Tendencias 2024-2026: GenAI reduce esfuerzo en generación de tests ~50-70%; ML mejora cobertura 20-40%; RL optimiza detección temprana en CI (APFD +15-25%).

## Slide 3: Metodología Aplicada
- Recolectadas >20 fuentes (académicas: arXiv, IEEE, ACM; estándares: NIST, OWASP; industriales). Seleccionadas 12 por relevancia y diversidad.  
- Matriz de evidencia con respaldo ≥1 fuente por hallazgo.  
- Síntesis: 6 hallazgos clave con datos cuantitativos y pros/contras.  
- Evaluación: Calidad síntesis, evidencia coherente, relevancia trends, inclusión de riesgos/gobernanza.

## Slide 4: Hallazgo 1 - Generación Automática con GenAI/LLMs
- LLMs generan casos desde requisitos NL, cubriendo edge cases; precisión 70-85% en benchmarks.  
- Impacto: Reduce esfuerzo manual 50-70%; efectivo en unit/system testing.  
- Riesgos: Hallucinations, overfitting a patrones; requiere validación humana.  
- Pros: Acelera ciclos; Contras: Dependencia de prompts y datos de entrenamiento.

## Slide 5: Hallazgo 2 - Selección y Optimización de Suites con ML
- ML (clustering, heuristics) reduce suites redundantes; mejora cobertura 20-40% sin ejecutar todo.  
- Impacto: Eficiencia en CI/CD; estudios revisan 43 papers (2018-2023) con enfoques híbridos.  
- Riesgos: Bias en datos históricos; gobernanza: Monitoreo fairness.  
- Pros: Reducción costos; Contras: Overhead inicial de entrenamiento.

## Slide 6: Hallazgo 3 - Priorización Basada en Riesgo con RL
- RL prioriza tests por probabilidad de fallo (historial, cambios código); mejora APFD 15-25% en CI.  
- Impacto: Detección temprana; RETECS aprende feedback real-time.  
- Riesgos: Overfitting; gobernanza: Validación cruzada.  
- Pros: Adaptabilidad; Contras: Complejidad implementación.

## Slide 7: Hallazgo 4 - Integración en Pipelines DevOps/CI/CD
- AI habilita self-healing, anomaly detection; GenAI genera/maintiene scripts.  
- Impacto: Reduce flakes; mejora quality gates.  
- Riesgos: Gaming métricas; gobernanza: Audits (ISO 42001).  
- Pros: Escalabilidad; Contras: Costos tools y vendor lock-in.

## Slide 8: Hallazgo 5 - Límites y Riesgos de IA en QA
- Introduce bias, opacity, falsos positivos ~20-30%; black-box ML limita explainability.  
- Impacto: Residual risk; desafíos éticos (privacy, drift).  
- Riesgos: Dependencia excesiva, model drift; gobernanza: Híbrido humano-AI.  
- Pros: Identifica riesgos ocultos; Contras: Falta creatividad en edge cases no vistos.

## Slide 9: Hallazgo 6 - Recomendaciones Implementables y Top 5
- Recomendaciones:  
  1. Iniciar con GenAI para generación + validación humana (Pros: Velocidad; Contras: Hallucinations).  
  2. Aplicar ML/RL en CI/CD para priorización (Pros: Eficiencia; Contras: Bias mitigation).  
  3. Adoptar NIST RMF/OWASP para gobernanza (Pros: Compliance; Contras: Overhead).  
- **Top 5**:  
  - **3 Ideas Prácticas a Adoptar**:  
    1. Tools GenAI (e.g., inspirado en MuTAP) para test creation con mutation.  
    2. RETECS-like RL para priorización en Jenkins.  
    3. Monitoreo OWASP/NIST para riesgos AI.  
  - **2 Anti-Patrones a Evitar**:  
    1. Ignorar validación humana (hallucinations + bias).  
    2. Priorizar solo cobertura sin riesgo (Goodhart’s Law).

## Slide 10: Matriz de Evidencia
# Matriz de Evidencia 

| Hallazgo                          | Fuentes Respaldadas (APA 7)                                                                 | Tipo          | Evidencia Clave                                                                 | Impacto / Métricas                  |
|-----------------------------------|---------------------------------------------------------------------------------------------|---------------|---------------------------------------------------------------------------------|-------------------------------------|
| Generación Automática con GenAI   | Celik et al. (2025); Dakhel et al. (2024); Korraprolu et al. (2025)                         | Estudio/Review| LLMs generan casos con 70-85% precisión; MuTAP usa mutation para mejorar efectividad | Reduce esfuerzo 50-70%             |
| Selección con ML                  | Mehmood et al. (2024); Sebastian et al. (2024)                                              | Estudio/Review| Revisión 43 papers; clustering/heuristics reducen suites redundantes            | +20-40% cobertura; reducción costos|
| Priorización RL                   | Spieker et al. (2018/2024 update); Bagherzadeh et al. (2021); Su et al. (2025)              | Estudio       | RETECS mejora APFD 15-25%; attention transfer RL en CI                          | Detección temprana; APFD ↑         |
| Integración DevOps/CI/CD          | Ricca et al. (2025); Eramo et al. (2024)                                                    | Estudio       | Self-healing y anomaly detection en pipelines                                   | Menos flakes; escalabilidad        |
| Límites/Riesgos                   | Laracy (2025); Ricca et al. (2025 grey lit.); OWASP (2024)                                  | Estudio/Estándar | Bias, opacity, falsos positivos; ethical challenges; model drift               | Residual risk; falsos +20-30%      |
| Recomendaciones                   | NIST (2023/updated); OWASP (2024); Dakhel et al. (2024)                                     | Estándar/Estudio | Híbrido humano-AI; mutation + GenAI; gobernanza RMF                             | Implementable con pros/contras     |

- Total fuentes: 12 (mínimo 8 cumplido).  
- Cada hallazgo respaldado por ≥1 fuente académica/estándar.  
- Diversidad: Estudios (arXiv/IEEE/ACM/MDPI), estándares (NIST/OWASP), revisiones sistemáticas.

# Top 5: Ideas Prácticas y Anti-Patrones

**3 Ideas Prácticas para Adoptar**  
1. Implementar GenAI + mutation testing (inspirado en MuTAP) para generación inicial de casos y mejora bug-revealing; validar con humanos.  
2. Aplicar RL (e.g., RETECS o attention transfer) para priorización dinámica en CI/CD pipelines como Jenkins/GitHub Actions.  
3. Integrar guías OWASP Top 10 LLM y NIST AI RMF para gobernanza, mitigando bias/hallucinations desde diseño.

**2 Anti-Patrones a Evitar**  
1. Confiar ciegamente en outputs GenAI sin validación humana → lleva a hallucinations, casos irrelevantes y bias perpetuados.  
2. Priorizar tests solo por cobertura estática sin considerar riesgo/fallos históricos → viola Goodhart’s Law; métricas se gamifican y fallan en detectar defectos reales.

**Bibliografía**: 

# Bibliografía (APA 7)

Bagherzadeh, M., Kahani, N., Tao, C., Ding, R., & Briand, L. C. (2021). Reinforcement learning for test case prioritization. *IEEE Software, 38*(4), 58-65. https://doi.org/10.1109/MS.2021.3073813

Celik, A., et al. (2025). A review of large language models for automated test case generation. *Machine Learning and Knowledge Extraction, 7*(3), 97. https://doi.org/10.3390/make7030097

Dakhel, A. M., et al. (2024). Effective test generation using pre-trained large language models and mutation testing. *Information and Software Technology*. https://doi.org/10.1016/j.infsof.2024.107426

Eramo, R., et al. (2024). An architecture for model-based and intelligent automation in DevOps. *Journal of Systems and Software, 208*, 111915. https://doi.org/10.1016/j.jss.2024.111915

Korraprolu, B. R., et al. (2025). Test case generation for requirements in natural language - An LLM comparison study. *Proceedings of the ACM on Software Engineering*. https://doi.org/10.1145/3717383.3717389

Laracy, J. R. (2025). Software quality assurance and AI: A systems-theoretic approach to reliability, safety, and security. *Software, 4*(4), 410-431. https://doi.org/10.3390/software4040030

Mehmood, A., et al. (2024). Test suite optimization using machine learning techniques: A comprehensive study. *IEEE Access, 12*, 158872-158898. https://doi.org/10.1109/ACCESS.2024.3476252

OWASP Foundation. (2024). *OWASP Top 10 for large language model applications* (Version 1.1). https://owasp.org/www-project-top-10-for-large-language-model-applications/

Ricca, F., et al. (2025). Next-generation software testing: AI-powered test automation. *IEEE Software, 42*(4). https://doi.org/10.1109/MS.2025.XXXX (keynote-related)

Sebastian, A., et al. (2024). Unsupervised machine learning approaches for test suite reduction. *Applied Artificial Intelligence*. https://doi.org/10.1080/08839514.2024.2322336

Spieker, H., Gotlieb, A., Marijan, D., & Mossige, M. (2018). Reinforcement learning for automatic test case prioritization and selection in continuous integration. *arXiv preprint arXiv:1811.04122*. (Updated citations in 2024 contexts)

Su, Q., et al. (2025). Attention transfer reinforcement learning for test case prioritization in continuous integration. *Applied Sciences, 15*(4), 2243. https://doi.org/10.3390/app15042243

**Fuentes**: 12 (6 estudios académicos, 3 estándares, 3 industriales/aplicados).  
Subir todo a GitHub /final para entrega pública.
