#!/usr/bin/env bash
# scripts/sc-05-latency.sh
# Escenario SC-05: Latencia básica en /store/inventory (Performance - Local)

set -euo pipefail

BASE_URL="http://localhost:8080/api/v3"
ENDPOINT="/store/inventory"
REPETITIONS=30
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVIDENCE_DIR="evidence/week2"

mkdir -p "$EVIDENCE_DIR"

CSV_FILE="${EVIDENCE_DIR}/sc-05_latency_${TIMESTAMP}.csv"
SUMMARY_FILE="${EVIDENCE_DIR}/sc-05_latency_summary_${TIMESTAMP}.txt"
LOG_FILE="${EVIDENCE_DIR}/sc-05_latency_log_${TIMESTAMP}.txt"

echo "SC-05 - Latencia básica en $ENDPOINT - $(date)" > "$LOG_FILE"
echo "Repeticiones: $REPETITIONS" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

# Cabecera del CSV
echo "ejecucion,http_code,time_total_s" > "$CSV_FILE"

overall_status="OK"

for i in $(seq 1 $REPETITIONS); do
    echo -n "Repetición $i: GET $ENDPOINT ... " >> "$LOG_FILE"

    response=$(curl -s -w "%{http_code} %{time_total}" \
        "${BASE_URL}${ENDPOINT}" \
        -o /dev/null \
        2>>"$LOG_FILE")

    http_code=$(echo "$response" | awk '{print $1}')
    time_total=$(echo "$response" | awk '{print $2}')

    echo "$i,$http_code,$time_total" >> "$CSV_FILE"

    if [ "$http_code" != "200" ]; then
        echo "FALLÓ (código $http_code)" >> "$LOG_FILE"
        overall_status="FAIL"
    else
        echo "OK ($http_code) - Tiempo: $time_total s" >> "$LOG_FILE"
    fi
done

echo "" >> "$LOG_FILE"
echo "Cálculo de métricas (min, max, avg, p95)..." >> "$LOG_FILE"

# Cálculo simple con awk (solo tiempos válidos con code 200)
awk -F, '
NR>1 && $2==200 { times[NR-1] = $3; sum += $3; count++ }
END {
    if (count > 0) {
        min = times[1]; max = times[1];
        for (i in times) {
            if (times[i] < min) min = times[i];
            if (times[i] > max) max = times[i];
        }
        avg = sum / count;
        asort(times);
        p95_idx = int(count * 0.95); if (p95_idx == 0) p95_idx = 1;
        p95 = times[p95_idx];
        print "Min: " min " s"
        print "Max: " max " s"
        print "Avg: " avg " s"
        print "P95: " p95 " s"
        if (p95 > 1.0) print "WARN: P95 > 1.0 s (umbral opcional excedido)"
    } else {
        print "No hay ejecuciones válidas (code 200)"
    }
}' "$CSV_FILE" > "$SUMMARY_FILE"

cat "$SUMMARY_FILE" >> "$LOG_FILE"

echo "→ Resultado global: $overall_status" >> "$LOG_FILE"
echo "CSV generado: $CSV_FILE" >> "$LOG_FILE"
echo "Resumen: $SUMMARY_FILE" >> "$LOG_FILE"
echo "SC-05 FINALIZADO - $(date)" >> "$LOG_FILE"

if [ "$overall_status" = "FAIL" ]; then
    exit 1
fi

exit 0