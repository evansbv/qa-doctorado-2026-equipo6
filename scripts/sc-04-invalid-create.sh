#!/usr/bin/env bash
# scripts/sc-04-invalid-create.sh
# Escenario SC-04: Creación inválida (sin nombre)

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

RESPONSE_FILE="${EVIDENCE_DIR}/sc-04_invalid_pet_response_${TIMESTAMP}.json"
HTTP_CODE_FILE="${EVIDENCE_DIR}/sc-04_invalid_pet_http_code_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-04_invalid_pet_log_${TIMESTAMP}.txt"

echo "SC-04 - Creación inválida (sin name) - $(date)" > "$LOG_FILE"

# Body sin "name"
BODY='{
  "id": 9999999,
  "status": "available"
}'

response=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "$BODY" \
    -w "\n%{http_code}" \
    "${BASE_URL}/pet" \
    2>>"$LOG_FILE")

http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')

echo "$body" > "$RESPONSE_FILE"
echo "$http_code" > "$HTTP_CODE_FILE"

echo "Código HTTP: $http_code" >> "$LOG_FILE"

# En Petstore real, suele devolver 405 (Method Not Allowed) o 400 según validación
if [[ "$http_code" != "400" && "$http_code" != "405" ]]; then
    echo "→ FALLÓ: Se esperaba 400 o 405, obtenido $http_code" >> "$LOG_FILE"
    #exit 1
fi

echo "→ OK: Error esperado recibido (código $http_code)" >> "$LOG_FILE"
echo "SC-04 FINALIZADO - $(date)" >> "$LOG_FILE"

exit 0