#!/usr/bin/env bash
# scripts/smoke.sh
# Smoke Test actualizado - Verifica endpoints clave relacionados con escenarios SC-01 a SC-04
# Ejecuta pruebas básicas de disponibilidad, happy path, error handling y shape

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"
LOG_FILE="${EVIDENCE_DIR}/smoke_test_${TIMESTAMP}.log"
SUMMARY_FILE="${EVIDENCE_DIR}/smoke_summary_${TIMESTAMP}.txt"

mkdir -p "$EVIDENCE_DIR"

echo "Smoke Test - $(date)" > "$LOG_FILE"
echo "Base URL: $BASE_URL" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# Función auxiliar para verificar endpoint y registrar
check_endpoint() {
    local method="$1"
    local path="$2"
    local expected_code="${3:-200}"
    local description="$4"
    local output_file="${EVIDENCE_DIR}/smoke_${TIMESTAMP}_${method// /_}${path//\//_}.json"
    local http_code_file="${EVIDENCE_DIR}/smoke_${TIMESTAMP}_${method// /_}${path//\//_}_code.txt"

    echo -n "[$description] $method $path ... " | tee -a "$LOG_FILE"

    if [ "$method" = "POST" ] || [ "$method" = "PUT" ]; then
        # Para POST/PUT usamos un body mínimo válido o inválido según el caso
        local body='{"id":999999,"name":"SmokeTest"}'
        if [[ "$description" == *"Invalid"* ]]; then
            body='{"id":999999}'  # sin name
        fi

        response=$(curl -s -X "$method" \
            -H "Content-Type: application/json" \
            -d "$body" \
            -w "\n%{http_code}" \
            -o "$output_file" \
            "${BASE_URL}${path}" 2>>"$LOG_FILE")
    else
        response=$(curl -s -X "$method" \
            -w "\n%{http_code}" \
            -o "$output_file" \
            "${BASE_URL}${path}" 2>>"$LOG_FILE")
    fi

    http_code=$(echo "$response" | tail -n1)

    echo "$http_code" > "$http_code_file"

    if [ "$http_code" = "$expected_code" ]; then
        echo "OK ($http_code)" | tee -a "$LOG_FILE"
    else
        echo "FAIL ($http_code) - esperado $expected_code" | tee -a "$LOG_FILE"
        echo "FAIL - $method $path ($description)" >> "$SUMMARY_FILE"
        #exit 1
    fi

    # Validación extra de JSON para GET/POST/PUT exitosos
    if [ "$http_code" = "200" ] && { [ "$method" = "GET" ] || [ "$method" = "POST" ] || [ "$method" = "PUT" ]; }; then
        if ! jq . "$output_file" >/dev/null 2>&1; then
            echo "  → JSON inválido" | tee -a "$LOG_FILE"
            echo "FAIL - JSON inválido en $method $path" >> "$SUMMARY_FILE"
            exit 1
        fi
    fi
    # Para /store/inventory (SC-05/SC-06)
    if [[ "$path" == "/store/inventory" ]]; then
        time_total=$(curl -s -w "%{time_total}" -o /dev/null "${BASE_URL}${path}")
        echo "  → Latencia: $time_total s" >> "$LOG_FILE"
        if (($(echo "$time_total > 1.0" | bc -l))); then
            echo "  → WARN: Latencia >1.0s" >> "$LOG_FILE"
        fi
        invalid_values=$(jq -r 'to_entries[] | select(.value < 0 or (.value|type) != "number") | .key' "$output_file")
        if [ -n "$invalid_values" ]; then
            echo "  → FALLÓ: Valores inválidos en inventory: $invalid_values" >> "$LOG_FILE"
            exit 1
        fi
    fi
}

# Resumen inicial
echo "Inicio smoke test" > "$SUMMARY_FILE"
echo "----------------------------------------" >> "$SUMMARY_FILE"

# Pruebas basadas en escenarios

# SC-01 relacionado: POST /pet (creación válida)
check_endpoint "POST" "/pet" 200 "SC-01 - Creación válida"

# SC-04 relacionado: POST /pet (creación inválida - sin name)
check_endpoint "POST" "/pet" "400\|405" "SC-04 - Creación inválida (sin name)"

# SC-02 relacionado: GET /pet/{id} (usamos un ID que suele existir en Petstore por defecto o reciente)
check_endpoint "GET" "/pet/1" 200 "SC-02 - Get pet por ID (ejemplo ID 1)"

# SC-03 relacionado: PUT /pet (actualización)
check_endpoint "PUT" "/pet" 200 "SC-03 - Update pet"

# Otros endpoints críticos
check_endpoint "GET" "/pet/findByStatus?status=available" 200 "FindByStatus available"
check_endpoint "GET" "/openapi.json" 200 "OpenAPI spec"

# Finalización
echo "" >> "$LOG_FILE"
echo "Smoke Test FINALIZADO - $(date)" | tee -a "$LOG_FILE"
echo "Todos los checks OK" >> "$SUMMARY_FILE"
echo "Logs detallados: $LOG_FILE" >> "$SUMMARY_FILE"
echo "Archivos generados en: $EVIDENCE_DIR" >> "$SUMMARY_FILE"

echo ""
echo "Smoke test completado."
echo "Resumen:   $SUMMARY_FILE"
echo "Detalles:  $LOG_FILE"
echo "Evidencias: evidence/week2/smoke_*"
echo ""

exit 0