#!/usr/bin/env bash
# scripts/sc-06-inventory-shape.sh
# Escenario SC-06: Validación de forma de datos en inventario (Data Shape Sanity)

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
ENDPOINT="/store/inventory"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

RESPONSE_FILE="${EVIDENCE_DIR}/sc-06_inventory_response_${TIMESTAMP}.json"
HTTP_CODE_FILE="${EVIDENCE_DIR}/sc-06_inventory_http_code_${TIMESTAMP}.txt"
SHAPE_CHECK_FILE="${EVIDENCE_DIR}/sc-06_inventory_shape_check_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-06_inventory_log_${TIMESTAMP}.txt"

echo "SC-06 - Validación de forma en $ENDPOINT - $(date)" > "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

response=$(curl -s -w "\n%{http_code}" \
    "${BASE_URL}${ENDPOINT}" \
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

# Validación 1: Es JSON válido
if ! echo "$body" | jq . >/dev/null 2>&1; then
    echo "→ FALLÓ: Respuesta no es JSON válido" >> "$LOG_FILE"
    exit 1
fi

# Validación 2: Comienza con '{'
first_char=$(echo "$body" | tr -d ' \n' | cut -c1)
if [ "$first_char" != "{" ]; then
    echo "→ FALLÓ: Cuerpo no comienza con '{' (obtenido: $first_char)" >> "$LOG_FILE"
    exit 1
fi

# Validación 3: Claves con valores numéricos >=0
echo "Verificando valores numéricos >=0..." > "$SHAPE_CHECK_FILE"
echo "$body" | jq -r 'to_entries[] | select(.value < 0) | .key + ": " + (.value|tostring) + " (negativo!)"' >> "$SHAPE_CHECK_FILE"
echo "$body" | jq -r 'to_entries[] | select((.value|type) != "number") | .key + ": " + (.value|tostring) + " (no numérico!)"' >> "$SHAPE_CHECK_FILE"

if grep -q "negativo!\|no numérico!" "$SHAPE_CHECK_FILE"; then
    echo "→ FALLÓ: Valores inválidos detectados" >> "$LOG_FILE"
    cat "$SHAPE_CHECK_FILE" >> "$LOG_FILE"
    exit 1
fi

echo "Todos los valores son numéricos >=0" >> "$SHAPE_CHECK_FILE"

echo "→ OK: Forma de datos válida" >> "$LOG_FILE"
cat "$SHAPE_CHECK_FILE" >> "$LOG_FILE"
echo "SC-06 FINALIZADO - $(date)" >> "$LOG_FILE"

exit 0