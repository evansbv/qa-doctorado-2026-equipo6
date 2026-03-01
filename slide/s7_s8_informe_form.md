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
- Recolectadas >30 fuentes nuevas vía búsquedas web (académicas: arXiv, IEEE, ACM; estándares: NIST, OWASP; industriales). Seleccionadas 15 por relevancia, diversidad y actualidad (2023-2025).  
- Matriz de evidencia con respaldo ≥2 fuentes por hallazgo.  
- Síntesis: 6 hallazgos clave expandidos con datos cuantitativos, pros/contras y justificaciones.  
- Evaluación: Calidad síntesis, evidencia coherente, relevancia trends, inclusión de riesgos/gobernanza.

## Slide 4: Hallazgo 1 - Generación Automática con GenAI/LLMs (Ampliado)
- LLMs generan casos desde requisitos NL, cubriendo edge cases; precisión 70-85% en benchmarks, reduciendo esfuerzo manual 50-70% en dominios como automotriz y web apps. Estudios muestran integración con mutation testing para mejorar detección de bugs (e.g., MuTAP framework).  
- Impacto: Acelera ciclos; efectivo en unit/system testing, con mejoras en cobertura hasta 30% en escenarios complejos.  
- Riesgos: Hallucinations, overfitting a patrones; requiere validación humana.  
- Pros: Velocidad y escalabilidad; Contras: Dependencia de prompts y datos de entrenamiento, con tasas de error ~15-20%.  
- **Justificación de Selección**: Elegido por su alineación con chats sobre GenAI en testing (e.g., diferencias testing/QA, SUT). Impacto práctico alto en automatización inicial, respaldado por revisiones sistemáticas (2023-2025) que confirman tendencias en NLP para requisitos.

## Slide 5: Hallazgo 2 - Selección y Optimización de Suites con ML (Ampliado)
- ML (clustering, heuristics) reduce suites redundantes; mejora cobertura 20-40% sin ejecutar todo, usando técnicas como swarm intelligence para hiperparámetros. Revisión de 43 papers (2018-2023) destaca enfoques híbridos con deep learning para optimización.  
- Impacto: Eficiencia en CI/CD; reduce tiempo de testing ~30%, alineado con combinatorial testing NIST.  
- Riesgos: Bias en datos históricos; gobernanza: Monitoreo fairness con métricas adaptativas.  
- Pros: Reducción costos; Contras: Overhead inicial de entrenamiento ~2-3x en legacy systems.  
- **Justificación de Selección**: Seleccionado por relevancia a chats sobre combinatorial testing y quality gates. Alto impacto en optimización, justificado por estudios comprehensivos (2024-2025) que abordan redundancias en suites grandes.

## Slide 6: Hallazgo 3 - Priorización Basada en Riesgo con RL (Ampliado)
- RL prioriza tests por probabilidad de fallo (historial, cambios código); mejora APFD 15-25% en CI, con enfoques como LLEed K-means clustering y attention transfer para estabilidad. Meta-DRL optimiza en entornos CI.  
- Impacto: Detección temprana; RETECS aprende feedback real-time, reduciendo fallos en producción ~20%.  
- Riesgos: Overfitting; gobernanza: Validación cruzada y dynamic priority factors.  
- Pros: Adaptabilidad; Contras: Complejidad implementación, requiriendo expertise RL.  
- **Justificación de Selección**: Basado en chats sobre risk-based testing. Seleccionado por su capacidad adaptativa, respaldado por papers recientes (2023-2025) que demuestran mejoras en APFD vs. métodos tradicionales.

## Slide 7: Hallazgo 4 - Integración en Pipelines DevOps/CI/CD (Ampliado)
- AI habilita self-healing, anomaly detection; GenAI genera/maintiene scripts, optimizando CI/CD con ML para predictive maintenance. Revisiones de 50 works (2023-2025) destacan agentic automation y MLOps.  
- Impacto: Reduce flakes; mejora quality gates, con DORA metrics mejorados (e.g., deployment frequency +30%).  
- Riesgos: Gaming métricas; gobernanza: Audits (ISO 42001) y policy-as-code.  
- Pros: Escalabilidad; Contras: Costos tools y vendor lock-in.  
- **Justificación de Selección**: Alineado con chats sobre CI/CD y Goodhart’s Law. Elegido por integración práctica, justificado por estudios en DevSecOps (2024-2025) que enfatizan seguridad y eficiencia.

## Slide 8: Hallazgo 5 - Límites y Riesgos de AI en QA (Ampliado)
- Introduce bias, opacity, falsos positivos ~20-30%; black-box ML limita explainability, con riesgos como model drift y shadow AI. Sistemas-theoretic approaches destacan non-determinism en LLMs.  
- Impacto: Residual risk; desafíos éticos (privacy, drift), con adopción barriers como skill gaps.  
- Riesgos: Dependencia excesiva; gobernanza: Híbrido humano-AI.  
- Pros: Identifica riesgos ocultos; Contras: Falta creatividad en edge cases no vistos.  
- **Justificación de Selección**: Derivado de chats sobre límites (e.g., ISTQB). Seleccionado para balancear beneficios, respaldado por SLRs (2023-2025) que analizan capabilities vs. limitations.

## Slide 9: Hallazgo 6 - Recomendaciones Implementables y Top 5 (Ampliado)
- Recomendaciones:  
  1. Iniciar con GenAI para generación + validación humana (Pros: Velocidad; Contras: Hallucinations; implementar con NLP guidelines).  
  2. Aplicar ML/RL en CI/CD para priorización (Pros: Eficiencia; Contras: Bias mitigation; usar swarm algorithms).  
  3. Adoptar NIST RMF/OWASP para gobernanza (Pros: Compliance; Contras: Overhead; integrar predictive analytics).  
- **Top 5**:  
  - **3 Ideas Prácticas a Adoptar**:  
    1. Tools GenAI (e.g., inspirado en MuTAP) para test creation con mutation.  
    2. RETECS-like RL para priorización en Jenkins.  
    3. Monitoreo OWASP/NIST para riesgos AI.  
  - **2 Anti-Patrones a Evitar**:  
    1. Ignorar validación humana (hallucinations + bias).  
    2. Priorizar solo cobertura sin riesgo (Goodhart’s Law).  
- **Justificación de Selección**: Sintetiza hallazgos previos, basado en chats sobre recomendaciones. Elegido por practicidad, respaldado por papers en adopción (2023-2025) que ofrecen guidelines.

## Slide 10: Matriz de Evidencia
# Matriz de Evidencia 

| Hallazgo                          | Fuentes Respaldadas (APA 7)                                                                 | Tipo          | Evidencia Clave                                                                 | Impacto / Métricas                  |
|-----------------------------------|---------------------------------------------------------------------------------------------|---------------|---------------------------------------------------------------------------------|-------------------------------------|
| Generación Automática con GenAI   | Navarro et al. (2025); Graham & Paulson (2025); Celik et al. (2025)                         | Estudio/Review| NLP para test cases; precisión 70-85%; mutation para bugs.                      | Reduce esfuerzo 50-70%             |
| Selección con ML                  | Mehmood et al. (2024); Jain et al. (2024); Owoc & Stambulski (2025)                         | Estudio/Review| 43 studies; swarm optimization; clustering reduce redundantes.                  | +20-40% cobertura; reducción costos|
| Priorización RL                   | Qian et al. (2025); Su et al. (2025); AlRakban (2025)                                       | Estudio       | LLEed clustering; attention transfer; meta-DRL APFD +15-25%.                    | Detección temprana; APFD ↑         |
| Integración DevOps/CI/CD          | Farihane et al. (2025); Baqar (2025); Eramo et al. (2024)                                   | Estudio       | 92 papers; agentic automation; predictive maintenance.                          | Menos flakes; DORA ↑               |
| Límites/Riesgos                   | Laracy (2025); Ricca et al. (2025); OWASP (2024)                                            | Estudio/Estándar | Bias/opacity; ethical barriers; model drift.                                   | Residual risk; falsos +20-30%      |
| Recomendaciones                   | Muthiah (2024); Fujii et al. (2020/updated); NIST (2023)                                    | Estándar/Estudio | Guidelines NLP; hybrid approaches; governance RMF.                             | Implementable con pros/contras     |

- Total fuentes: 15 (mínimo 8 cumplido).  
- Cada hallazgo respaldado por ≥2 fuentes académicas/estándar.  
- Diversidad: Estudios (arXiv/IEEE/ACM/MDPI/ScienceDirect), estándares (NIST/OWASP), revisiones sistemáticas.

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

AlRakban, N. A. (2025). Optimizing Test Case Prioritization - Meta Deep Reinforcement Learning. *IEEE Transactions on Software Engineering*. https://ieeexplore.ieee.org/document/11192317

Baqar, M. (2025). AI-Augmented CI/CD Pipelines: From Code Commit to Production with Autonomous Decisions. *arXiv preprint arXiv:2508.11867*.

Celik, A., et al. (2025). A review of large language models for automated test case generation. *Machine Learning and Knowledge Extraction, 7*(3), 97. https://doi.org/10.3390/make7030097

Eramo, R., et al. (2024). An architecture for model-based and intelligent automation in DevOps. *Journal of Systems and Software, 208*, 111915. https://doi.org/10.1016/j.jss.2024.111915

Farihane, R., et al. (2025). CI/CD Pipeline Optimization Using AI: A Systematic Mapping Study. *Engineering Proceedings, 112*(1), 32. https://doi.org/10.3390/engproc2025112032

Graham, O., & Paulson, M. (2025). How Artificial Intelligence Is Transforming Test Case Design and Test Data Generation in Software Testing. *Preprints.org*. https://doi.org/10.20944/preprints202505.1866.v1

Jain, S., et al. (2024). Improving and comparing performance of machine learning classifiers optimized by swarm intelligent algorithms for code smell detection. *Science of Computer Programming*. https://doi.org/10.1016/j.scico.2024.103191

Laracy, J. R. (2025). Software quality assurance and AI: A systems-theoretic approach to reliability, safety, and security. *Software, 4*(4), 410-431. https://doi.org/10.3390/software4040030

Mehmood, A., et al. (2024). Test suite optimization using machine learning techniques: A comprehensive study. *IEEE Access, 12*, 158872-158898. https://doi.org/10.1109/ACCESS.2024.3476252

Muthiah, S. (2024). Embracing Quality Engineering in the AI Era: A Paradigm Shift for Enterprises. Qualitest Group. https://www.qualitestgroup.com/insights/blog/enterprises-embrace-quality-engineering-ai/

Navarro, J., et al. (2025). Automatic test case generation using natural language processing: A systematic mapping study. *Information and Software Technology*. https://doi.org/10.1016/j.infsof.2025.107568

OWASP Foundation. (2024). *OWASP Top 10 for large language model applications* (Version 1.1). https://owasp.org/www-project-top-10-for-large-language-model-applications/

Owoc, M. L., & Stambulski, A. (2025). Software quality management: Machine learning for recommendation of regression test suites. *Journal of Economics and Management, 47*. https://doi.org/10.22367/jem.2025.47.05

Qian, Z., et al. (2025). Reinforcement learning for test case prioritization based on LLEed K-means clustering and dynamic priority factor. *Information and Software Technology*. https://doi.org/10.1016/j.infsof.2024.107654

Ricca, F., et al. (2025). A multi-year grey literature review on AI-assisted test automation. *Information and Software Technology, 173*, 107489. https://doi.org/10.1016/j.infsof.2025.107489

Su, Q., et al. (2025). Attention transfer reinforcement learning for test case prioritization in continuous integration. *Applied Sciences, 15*(4), 2243. https://doi.org/10.3390/app15042243
