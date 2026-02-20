# Registro de cambios del Quality Gate

## Cambio 2026-02-19 – Anti-gaming en Check 3 (Casos sistemáticos)

**Qué cambió**:
- Agregado verificación de integridad: el archivo systematic_summary.txt debe contener la línea "TOTAL_CASOS_EJECUTADOS: 14"
- Contador generado al final de scripts/systematic_cases_with_counter.sh
- Oráculo falla si falta o el número es incorrecto

**Por qué**:
- Evitar gaming de filtrar/eliminar "FAIL" del summary (ocultar fallos reales)
- Garantizar que el número de casos ejecutados sea consistente y no haya manipulación

**Fecha**: 19 de febrero de 2026  
**Autor**: Evans  
**Impacto**: 
- Bajo (solo agrega una línea de verificación)
- Mejora seguridad del gate contra manipulación
- No afecta ejecuciones normales (solo falla si hay tampering)

**Regla de gobernanza mínima**:
- Cualquier cambio futuro en umbrales, oráculos o chequeos de integridad debe:
  1. Ser propuesto y revisado por al menos dos personas (desarrollador + QA/arquitectura)
  2. Justificarse con evidencia de riesgo real o incidente
  3. Registrarse en este archivo antes de aplicar