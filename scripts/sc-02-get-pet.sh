#!/usr/bin/env bash
# scripts/sc-02-get-pet.sh
# Escenario SC-02: Consulta de mascota por ID
# Nota: requiere que exista una mascota (ejecutar SC-01 antes o ajustar ID)

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
PET_ID="1000001"  # ← Cambiar si usas otro ID generado en SC-01
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

RESPONSE_FILE="${EVIDENCE_DIR}/sc-02_get_pet_response_${TIMESTAMP}.json"
HTTP_CODE_FILE="${EVIDENCE_DIR}/sc-02_get_pet_http_code_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-02_get_pet_log_${TIMESTAMP}.txt"

echo "SC-02 - Consulta de mascota por ID - $(date)" > "$LOG_FILE"
echo "PET_ID usado: $PET_ID" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

response=$(curl -s -w "\n%{http_code}" \
    "${BASE_URL}/pet/${PET_ID}" \
    2>>"$LOG_FILE")

http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')

echo "$body" > "$RESPONSE_FILE"
echo "$http_code" > "$HTTP_CODE_FILE"

echo "Código HTTP: $http_code" >> "$LOG_FILE"

if [ "$http_code" != "200" ]; then
    echo "→ FALLÓ: Código HTTP esperado 200, obtenido $http_code" >> "$LOG_FILE"
    exit 1
fi

if ! echo "$body" | jq . >/dev/null 2>&1; then
    echo "→ FALLÓ: Respuesta no es JSON válido" >> "$LOG_FILE"
    exit 1
fi

returned_id=$(echo "$body" | jq -r '.id // empty')

if [ "$returned_id" != "$PET_ID" ]; then
    echo "→ FALLÓ: ID devuelto ($returned_id) no coincide con solicitado ($PET_ID)" >> "$LOG_FILE"
    exit 1
fi

echo "→ OK: Mascota obtenida correctamente" >> "$LOG_FILE"
echo "SC-02 FINALIZADO - $(date)" >> "$LOG_FILE"

exit 0