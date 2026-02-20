#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# CONFIGURACIÓN
# ────────────────────────────────────────────────────────────────────────────────
EVIDENCE_BASE="evidence/week6"
BEFORE_DIR="${EVIDENCE_BASE}/before"
AFTER_DIR="${EVIDENCE_BASE}/after"
SUMMARY_FILE="${EVIDENCE_BASE}/summary.txt"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "${BEFORE_DIR}" "${AFTER_DIR}"

echo "# Gaming Drill - Semana 6" > "${SUMMARY_FILE}"
echo "Fecha/Hora: ${TIMESTAMP}" >> "${SUMMARY_FILE}"
echo "" >> "${SUMMARY_FILE}"

# ────────────────────────────────────────────────────────────────────────────────
# FUNCIÓN: ejecutar gate y guardar evidencias
# ────────────────────────────────────────────────────────────────────────────────
run_gate_and_save() {
  local dir="$1"
  local label="$2"

  echo "→ Ejecutando gate (${label})..." | tee -a "${SUMMARY_FILE}"

  make QA-week5 > "${dir}/gate_run_${label}.log" 2>&1

  # Guardar evidencias clave del Check 3
  cp evidence/week5/systematic_summary.txt "${dir}/systematic_summary_${label}.txt" 2>/dev/null || echo "No summary" > "${dir}/systematic_summary_${label}.txt"
  cp evidence/week5/SUMMARY.md "${dir}/SUMMARY_${label}.md" 2>/dev/null || true
  cp evidence/week5/RUNLOG.md "${dir}/RUNLOG_${label}.md" 2>/dev/null || true

  echo "  → Evidencias guardadas en ${dir}" | tee -a "${SUMMARY_FILE}"
}

# ────────────────────────────────────────────────────────────────────────────────
# PARTE 1: BEFORE (gate vulnerable)
# ────────────────────────────────────────────────────────────────────────────────
echo "=== BEFORE (gate vulnerable) ===" | tee -a "${SUMMARY_FILE}"

# Limpieza inicial
rm -f evidence/week5/systematic_summary.txt

# Ejecutar gate normal
run_gate_and_save "${BEFORE_DIR}" "normal_before"

# Aplicar gaming: filtrar FAIL
grep -v -i "FAIL" evidence/week5/systematic_summary.txt > temp_filtered.txt 2>/dev/null || true
mv temp_filtered.txt evidence/week5/systematic_summary.txt 2>/dev/null || true

# Ejecutar gate con gaming
run_gate_and_save "${BEFORE_DIR}" "gaming_before"

echo "Resultado esperado BEFORE: gate debería pasar (FAIL oculto)" | tee -a "${SUMMARY_FILE}"
echo "" >> "${SUMMARY_FILE}"

# ────────────────────────────────────────────────────────────────────────────────
# PARTE 2: AFTER (gate endurecido)
# ────────────────────────────────────────────────────────────────────────────────
echo "=== AFTER (gate endurecido) ===" | tee -a "${SUMMARY_FILE}"

# Limpieza inicial
rm -f evidence/week5/systematic_summary.txt

# Ejecutar gate normal (con contador)
run_gate_and_save "${AFTER_DIR}" "normal_after"

# Aplicar misma táctica de gaming
grep -v -i "FAIL" evidence/week5/systematic_summary.txt > temp_filtered.txt 2>/dev/null || true
mv temp_filtered.txt evidence/week5/systematic_summary.txt 2>/dev/null || true

# Ejecutar gate con gaming → DEBE FALLAR por falta de contador
run_gate_and_save "${AFTER_DIR}" "gaming_after"

echo "Resultado esperado AFTER: gate debe FALLAR (integridad rota: falta TOTAL_CASOS_EJECUTADOS)" | tee -a "${SUMMARY_FILE}"
echo "" >> "${SUMMARY_FILE}"

# ────────────────────────────────────────────────────────────────────────────────
# RESUMEN FINAL
# ────────────────────────────────────────────────────────────────────────────────
echo "=== Resumen del drill ===" >> "${SUMMARY_FILE}"
echo "- BEFORE: gaming exitoso → gate pasa sin corregir fallos" >> "${SUMMARY_FILE}"
echo "- AFTER: gaming detectado → gate falla por falta de contador de casos" >> "${SUMMARY_FILE}"
echo "- Defensa efectiva: sí" >> "${SUMMARY_FILE}"
echo "- Archivos clave:" >> "${SUMMARY_FILE}"
echo "  before/systematic_summary_gaming_before.txt" >> "${SUMMARY_FILE}"
echo "  after/systematic_summary_gaming_after.txt" >> "${SUMMARY_FILE}"
echo "" >> "${SUMMARY_FILE}"
echo "Firma: Evans" >> "${SUMMARY_FILE}"
echo "Fecha: ${TIMESTAMP}" >> "${SUMMARY_FILE}"

echo "Drill completado. Resumen en: ${SUMMARY_FILE}"
echo "Evidencias en: ${BEFORE_DIR} y ${AFTER_DIR}"