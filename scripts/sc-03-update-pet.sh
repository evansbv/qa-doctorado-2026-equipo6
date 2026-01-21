#!/usr/bin/env bash
# scripts/sc-03-update-pet.sh
# Escenario SC-03: Actualización de mascota
# Nota: requiere ID existente

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
PET_ID="1000001"  # ← Ajustar según SC-01/SC-02

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
NEW_NAME="Firulais-Updated-${TIMESTAMP}"
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

RESPONSE_FILE="${EVIDENCE_DIR}/sc-03_update_pet_response_${TIMESTAMP}.json"
HTTP_CODE_FILE="${EVIDENCE_DIR}/sc-03_update_pet_http_code_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-03_update_pet_log_${TIMESTAMP}.txt"

echo "SC-03 - Actualización de mascota - $(date)" > "$LOG_FILE"
echo "PET_ID: $PET_ID" >> "$LOG_FILE"
echo "Nuevo nombre: $NEW_NAME" >> "$LOG_FILE"

BODY="{\"id\": ${PET_ID}, \"name\": \"${NEW_NAME}\", \"status\": \"sold\"}"

response=$(curl -s -X PUT \
    -H "Content-Type: application/json" \
    -d "$BODY" \
    -w "\n%{http_code}" \
    "${BASE_URL}/pet" \
    2>>"$LOG_FILE")

http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')

echo "$body" > "$RESPONSE_FILE"
echo "$http_code" > "$HTTP_CODE_FILE"

if [ "$http_code" != "200" ]; then
    echo "→ FALLÓ: Código HTTP esperado 200, obtenido $http_code" >> "$LOG_FILE"
    exit 1
fi

updated_name=$(echo "$body" | jq -r '.name // empty')

if [ "$updated_name" != "$NEW_NAME" ]; then
    echo "→ FALLÓ: Nombre no actualizado (esperado: $NEW_NAME, obtenido: $updated_name)" >> "$LOG_FILE"
    exit 1
fi

echo "→ OK: Mascota actualizada correctamente" >> "$LOG_FILE"
echo "SC-03 FINALIZADO - $(date)" >> "$LOG_FILE"

exit 0