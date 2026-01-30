#!/bin/bash

# risk03_SC_06.sh: Consistencia de respuestas (R03, SC-06 extension)
# Repite llamadas y verifica counts/formato coherente
# Uso: ./risk03_SC_06.sh [num_reps]  (default: 5)

API_BASE_URL="http://localhost:8080/api/v3"  # Ajusta si es /api/v3
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ENDPOINT="$API_BASE_URL/pet/findByStatus?status=available"  # Extensión a listas
NUM_REPS=${1:-5}
EVIDENCE_DIR="evidence/week3"
mkdir -p $EVIDENCE_DIR

LOG_FILE="$EVIDENCE_DIR/consistency_asserts_${TIMESTAMP}.log"
SAMPLE_JSON="$EVIDENCE_DIR/findByStatus_sample_${TIMESTAMP}.json"

echo "Pruebas de consistencia (R03 - SC-06) - Fecha: $(date)" > $LOG_FILE
echo "Endpoint: $ENDPOINT ($NUM_REPS reps sin cambios de estado)" >> $LOG_FILE

prev_count=-1
all_consistent=true

for i in $(seq 1 $NUM_REPS); do
  response=$(curl -s "$ENDPOINT")
  count=$(echo "$response" | jq 'length')  # Requiere jq instalado
  echo "Ejecución $i: count = $count" >> $LOG_FILE
  
  if [ $i -gt 1 ] && [ $count -ne $prev_count ]; then
    all_consistent=false
    echo "  INCONSISTENTE: count varió ($prev_count -> $count)" >> $LOG_FILE
  fi
  prev_count=$count
  
  # Guardar sample en primera ejecución
  if [ $i -eq 1 ]; then
    echo "$response" > $SAMPLE_JSON
    echo "  Sample JSON guardado en $SAMPLE_JSON" >> $LOG_FILE
  fi
  
  sleep 0.5
done

echo "" >> $LOG_FILE
if $all_consistent; then
  echo "Resultado global: OK (counts consistentes, valores >=0 implícito en API)" >> $LOG_FILE
else
  echo "Resultado global: FAIL (inconsistencias detectadas)" >> $LOG_FILE
fi

echo "Evidencia generada en: $LOG_FILE y $SAMPLE_JSON"