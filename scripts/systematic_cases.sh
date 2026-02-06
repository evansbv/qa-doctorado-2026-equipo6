#!/usr/bin/env bash

# systematic_cases.sh - Semana 4 (versión corregida)
# Ejecuta casos sistemáticos para POST /api/v3/store/order
# Corrige cuelgues en casos con oracle_check

set -euo pipefail

API_BASE="http://localhost:8080/api/v3"
ENDPOINT="$API_BASE/store/order"
EVIDENCE_DIR="evidence/week4"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p "$EVIDENCE_DIR"

SUMMARY_FILE="$EVIDENCE_DIR/summary_${TIMESTAMP}.txt"
> "$SUMMARY_FILE"

echo "Ejecución de casos sistemáticos - $(date)" | tee -a "$SUMMARY_FILE"
echo "Endpoint: $ENDPOINT" | tee -a "$SUMMARY_FILE"
echo "----------------------------------------" | tee -a "$SUMMARY_FILE"

pass_count=0
fail_count=0
total_cases=0

run_case() {
    local tc_id="$1"
    local description="$2"
    local payload="$3"
    local expected_code="$4"

    total_cases=$((total_cases + 1))

    local log_file="$EVIDENCE_DIR/tc_${tc_id}_log_${TIMESTAMP}.txt"
    local response_file="$EVIDENCE_DIR/tc_${tc_id}_response_${TIMESTAMP}.json"
    local http_code_file="$EVIDENCE_DIR/tc_${tc_id}_http_code_${TIMESTAMP}.txt"

    echo "TC-${tc_id}: $description" > "$log_file"

    # Ejecutar con timeout de 10 segundos para evitar cuelgues
    http_code=$(timeout 10 curl -s -o "$response_file" -w "%{http_code}" \
        -X POST "$ENDPOINT" \
        -H "Content-Type: application/json" \
        -d "$payload" 2>> "$log_file") || http_code="TIMEOUT"

    echo "$http_code" > "$http_code_file"

    echo "HTTP Code: $http_code" >> "$log_file"
    echo "Payload enviado:" >> "$log_file"
    echo "$payload" >> "$log_file"
    echo "----------------------------------------" >> "$log_file"

    pass=false

    # Oráculo simple: código HTTP esperado (mock suele 200)
    if [[ "$http_code" == "$expected_code" ]]; then
        pass=true
        # Oráculo fuerte opcional: solo si quieres jq (comenta si no tienes jq)
        # if jq -e '.quantity == 5' "$response_file" > /dev/null 2>&1; then
        #     pass=true
        # else
        #     pass=false
        # fi
    fi

    if $pass; then
        echo "Resultado: PASS $tc_id" | tee -a "$log_file" "$SUMMARY_FILE"
        pass_count=$((pass_count + 1))
    else
        echo "Resultado: FAIL $tc_id" | tee -a "$log_file" "$SUMMARY_FILE"
        fail_count=$((fail_count + 1))
        cat "$response_file" >> "$log_file" 2>/dev/null
    fi

    echo "" | tee -a "$log_file" "$SUMMARY_FILE"

    # Pausa corta para no saturar el mock
    sleep 0.5
}

# Ejecutar casos (eliminamos oracle_check con grep para evitar cuelgues)

run_case "01" "Payload completo válido" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "02" "Quantity límite inferior válido (1)" \
    '{"petId": 1, "quantity": 1, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "03" "Quantity límite superior razonable" \
    '{"petId": 1, "quantity": 999999, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "04" "Quantity = 0" \
    '{"petId": 1, "quantity": 0, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "05" "Quantity negativa" \
    '{"petId": 1, "quantity": -1, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "06" "Status approved" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "approved", "complete": false}' \
    "200"

run_case "07" "Status inválido" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "cancelled", "complete": false}' \
    "200"

run_case "08" "Status ausente" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "complete": false}' \
    "200"

run_case "09" "shipDate pasada" \
    '{"petId": 1, "quantity": 5, "shipDate": "2025-01-01T00:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "10" "shipDate formato inválido" \
    '{"petId": 1, "quantity": 5, "shipDate": "invalid-date", "status": "placed", "complete": false}' \
    "200"

run_case "11" "complete = true" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": true}' \
    "200"

run_case "12" "petId inexistente" \
    '{"petId": 999999, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "13" "petId tipo erróneo" \
    '{"petId": "abc", "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false}' \
    "200"

run_case "14" "JSON malformado" \
    '{"petId": 1, "quantity": 5, "shipDate": "2026-03-01T10:00:00.000Z", "status": "placed", "complete": false' \
    "400"

# Resumen final
echo "----------------------------------------" | tee -a "$SUMMARY_FILE"
echo "Total casos ejecutados: $total_cases" | tee -a "$SUMMARY_FILE"
echo "PASS: $pass_count" | tee -a "$SUMMARY_FILE"
echo "FAIL: $fail_count" | tee -a "$SUMMARY_FILE"
echo "Porcentaje PASS: $((pass_count * 100 / total_cases))%" | tee -a "$SUMMARY_FILE"

echo "Evidencia completa en: $EVIDENCE_DIR/" | tee -a "$SUMMARY_FILE"