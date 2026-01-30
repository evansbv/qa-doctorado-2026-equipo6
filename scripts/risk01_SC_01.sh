#!/bin/bash
# risk01_SC_01.sh: Smoke tests para disponibilidad (R01, SC-01 extension)
# Verifica HTTP < 500 en endpoints críticos
# Uso: ./risk01_SC_01.sh

set -euo pipefail

API_BASE_URL="http://localhost:8080/api/v3"  # Ajusta si es /api/v3
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week3"
mkdir -p $EVIDENCE_DIR

LOG_FILE="$EVIDENCE_DIR/smoke_results_${TIMESTAMP}.log"
HTTP_CODES_FILE="$EVIDENCE_DIR/smoke_http_codes_${TIMESTAMP}.txt"

echo "Smoke Tests para Disponibilidad (R01 - SC-01) - Fecha: $(date)" > $LOG_FILE
echo "Endpoints probados:" >> $LOG_FILE

# Endpoints críticos
endpoints=(
  "$API_BASE_URL/pet/findByStatus?status=available"  # GET lista
  "$API_BASE_URL/store/inventory"                   # GET inventory
  "$API_BASE_URL/user/login?username=test&password=test"  # GET login (ajusta credenciales)
)

all_pass=true
echo "" > $HTTP_CODES_FILE

for endpoint in "${endpoints[@]}"; do
  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$endpoint")
  echo "$endpoint: $http_code" >> $HTTP_CODES_FILE
  echo "- $endpoint: HTTP $http_code" >> $LOG_FILE
  
  if [ $http_code -ge 500 ]; then
    all_pass=false
    echo "  FAIL: Código >= 500 (no disponible)" >> $LOG_FILE
  else
    echo "  OK: Código < 500" >> $LOG_FILE
  fi
done

echo "" >> $LOG_FILE
if $all_pass; then
  echo "Resultado global: OK (100% disponible)" >> $LOG_FILE
else
  echo "Resultado global: FAIL (algunos endpoints no disponibles)" >> $LOG_FILE
fi

echo "Evidencia generada en: $LOG_FILE y $HTTP_CODES_FILE"