#!/bin/bash

# risk02_SC_05.sh: Baseline de latencia (R02, SC-05)
# Mide time_total en endpoint clave con repeticiones
# Uso: ./risk02_SC_05.sh [num_reps]  (default: 30)

API_BASE_URL="http://localhost:8080/v3"  # Ajusta si es /api/v3
ENDPOINT="$API_BASE_URL/store/inventory"  # Endpoint de SC-05
NUM_REPS=${1:-30}
EVIDENCE_DIR="evidence/week3"
mkdir -p $EVIDENCE_DIR

CSV_FILE="$EVIDENCE_DIR/latency_measurements.csv"
SUMMARY_FILE="$EVIDENCE_DIR/latency_summary.txt"

echo "request,time_total (s)" > $CSV_FILE

echo "Midiendo latencia en $ENDPOINT ($NUM_REPS reps) - Fecha: $(date)" > $SUMMARY_FILE

for i in $(seq 1 $NUM_REPS); do
  time_total=$(curl -s -o /dev/null -w "%{time_total}" "$ENDPOINT")
  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$ENDPOINT")
  echo "$i,$time_total" >> $CSV_FILE
  
  if [ $http_code -ne 200 ]; then
    echo "WARN: Ejecución $i falló (HTTP $http_code)" >> $SUMMARY_FILE
  fi
  sleep 0.2  # Evitar sobrecarga
done

# Resumen estadístico básico (sin awk si no tienes; usa echo simple)
avg=$(awk -F, 'NR>1 {sum+=$2} END {print sum/(NR-1)}' $CSV_FILE)
min=$(awk -F, 'NR>1 {if(NR==2) m=$2; if($2<m) m=$2} END {print m}' $CSV_FILE)
max=$(awk -F, 'NR>1 {if(NR==2) m=$2; if($2>m) m=$2} END {print m}' $CSV_FILE)
p95=$(awk -F, 'NR>1 {a[NR-1]=$2} END {asort(a); print a[int((NR-1)*0.95)]}' $CSV_FILE)  # Aprox p95

echo "Estadísticas:" >> $SUMMARY_FILE
echo "- Media: $avg s" >> $SUMMARY_FILE
echo "- Mín: $min s" >> $SUMMARY_FILE
echo "- Máx: $max s" >> $SUMMARY_FILE
echo "- p95: $p95 s" >> $SUMMARY_FILE

if (( $(echo "$p95 <= 2.0" | bc -l) )); then
  echo "Resultado: OK (p95 <= 2.0s)" >> $SUMMARY_FILE
else
  echo "Resultado: FAIL (p95 > 2.0s)" >> $SUMMARY_FILE
fi

echo "Evidencia generada en: $CSV_FILE y $SUMMARY_FILE"