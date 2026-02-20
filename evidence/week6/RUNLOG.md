# RUNLOG - Gaming Drill Semana 6 (BEFORE)

**Fecha y hora de ejecución**: 19 de febrero de 2026 - 21:30 (aprox.) -04

**Comando exacto para reproducir el gaming (táctica aplicada)**:
```bash
# Ejecutar gate normal
make QA-week5

# Aplicar gaming: eliminar líneas con "FAIL"
grep -v -i "FAIL" evidence/week5/systematic_summary.txt > evidence/week5/systematic_summary_filtered.txt
mv evidence/week5/systematic_summary_filtered.txt evidence/week5/systematic_summary.txt

# Volver a ejecutar gate (ahora pasa Check 3)
make QA-week5

**Qué cambió para "pasar" el gate:**
- Se filtró la palabra "FAIL" (case insensitive) del archivo systematic_summary.txt usando grep -v -i "FAIL".
- El oráculo del Check 3 (grep -iq "FAIL") ya no encuentra nada → el check pasa aunque los casos reales hayan fallado.
- El quality gate completo pasa sin corregir los problemas detectados por los casos sistemáticos.

**Evidencias generadas y ubicación:**
- evidence/week6/before/normal_run.log → ejecución limpia antes del gaming
- evidence/week6/before/gaming_run.log → ejecución después del gaming (debe mostrar PASS en Check 3)
- evidence/week6/before/systematic_summary_before.txt → summary original (puede tener FAIL)
- evidence/week6/before/systematic_summary_after_gaming.txt → summary filtrado (sin FAIL)
- evidence/week6/before/SUMMARY_before.md y SUMMARY_after_gaming.md → comparación del resumen del gate
- evidence/week6/before/RUNLOG_before.md y RUNLOG_after_gaming.md → logs detallados



## Experimento AFTER - Verificación de la defensa (19-feb-2026)

**Fecha y hora**: 19 de febrero de 2026 - 21:45 (aprox.) -04

**Comando exacto reproducido (misma táctica de gaming)**:
```bash
make QA-week5

# Gaming: filtrar FAIL
grep -v -i "FAIL" evidence/week5/systematic_summary.txt > evidence/week5/systematic_summary_filtered.txt
mv evidence/week5/systematic_summary_filtered.txt evidence/week5/systematic_summary.txt

# Intentar pasar el gate
make QA-week5


Firma: Evans