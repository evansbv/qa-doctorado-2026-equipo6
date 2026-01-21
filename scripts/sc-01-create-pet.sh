#!/usr/bin/env bash
# scripts/sc-01-create-pet.sh
# Escenario SC-01: Creación exitosa de una mascota

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

RESPONSE_FILE="${EVIDENCE_DIR}/sc-01_create_pet_response_${TIMESTAMP}.json"
HTTP_CODE_FILE="${EVIDENCE_DIR}/sc-01_create_pet_http_code_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-01_create_pet_log_${TIMESTAMP}.txt"

echo "SC-01 - Creación exitosa de mascota - $(date)" > "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# Body de ejemplo válido
BODY='{
  "id": 1000001,
  "name": "Firulais-'${TIMESTAMP}'",
  "status": "available",
  "category": {"id": 1, "name": "perros"},
  "tags": [{"id": 1, "name": "amigable"}]
}'

echo "→ POST /pet" >> "$LOG_FILE"
echo "Body enviado:" >> "$LOG_FILE"
echo "$BODY" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Ejecutar request
response=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -w "\n%{http_code}" \
    -d "$BODY" \
    "${BASE_URL}/pet" \
    2>>"$LOG_FILE")

# Separar body y código HTTP
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')

echo "$body" > "$RESPONSE_FILE"
echo "$http_code" > "$HTTP_CODE_FILE"

echo "Código HTTP: $http_code" >> "$LOG_FILE"
echo "Respuesta guardada en: $RESPONSE_FILE" >> "$LOG_FILE"

# Validaciones falsables
if [ "$http_code" != "200" ]; then
    echo "→ FALLÓ: Código HTTP esperado 200, obtenido $http_code" >> "$LOG_FILE"
    exit 1
fi

if ! echo "$body" | jq . >/dev/null 2>&1; then
    echo "→ FALLÓ: Respuesta no es JSON válido" >> "$LOG_FILE"
    exit 1
fi

returned_id=$(echo "$body" | jq -r '.id // empty')
returned_name=$(echo "$body" | jq -r '.name // empty')

if [ -z "$returned_id" ] || [ "$returned_name" != "Firulais-${TIMESTAMP}" ]; then
    echo "→ FALLÓ: id o name no coinciden con lo enviado" >> "$LOG_FILE"
    exit 1
fi

echo "→ OK: Mascota creada correctamente" >> "$LOG_FILE"
echo "ID generado/devuelto: $returned_id" >> "$LOG_FILE"
echo "SC-01 FINALIZADO - $(date)" >> "$LOG_FILE"

exit 0