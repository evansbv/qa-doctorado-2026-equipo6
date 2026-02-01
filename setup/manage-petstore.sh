#!/usr/bin/env bash

# manage-petstore.sh
# Gestión simple del contenedor Swagger Petstore (SUT para evidencias QA)
# Uso: ./setup/manage-petstore.sh [comando]
# Comandos disponibles: start, stop, restart, status, health, logs, clean, help

set -euo pipefail

CONTAINER_NAME="petstore3"
IMAGE_NAME="swaggerapi/petstore3"
PORT_MAPPING="8080:8080"
HEALTH_URL="http://localhost:8080"

function show_help() {
    echo "Gestión del SUT Swagger Petstore"
    echo ""
    echo "Uso: $0 [comando]"
    echo ""
    echo "Comandos:"
    echo "  start     Inicia el contenedor en background"
    echo "  stop      Detiene el contenedor suavemente"
    echo "  restart   Reinicia el contenedor (stop + start)"
    echo "  status    Muestra si está corriendo y puerto"
    echo "  health    Verifica si la API responde (health check básico)"
    echo "  logs      Muestra las últimas 50 líneas de logs"
    echo "  logs-f    Sigue los logs en tiempo real (Ctrl+C para salir)"
    echo "  clean     Elimina el contenedor (datos in-memory se pierden)"
    echo "  help      Muestra esta ayuda"
    echo ""
}

function is_running() {
    docker ps --filter "name=${CONTAINER_NAME}" --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"
}

case "${1:-help}" in
    start)
        if is_running; then
            echo "→ El contenedor ${CONTAINER_NAME} ya está corriendo."
            exit 0
        fi
        echo "→ Iniciando Swagger Petstore..."
        docker run -d --name "${CONTAINER_NAME}" -p "${PORT_MAPPING}" "${IMAGE_NAME}"
        echo "→ Contenedor iniciado. Accede en: ${HEALTH_URL}"
        sleep 3
        $0 health
        ;;

    stop)
        if ! is_running; then
            echo "→ El contenedor ${CONTAINER_NAME} no está corriendo."
            exit 0
        fi
        echo "→ Deteniendo ${CONTAINER_NAME}..."
        docker stop "${CONTAINER_NAME}"
        echo "→ Contenedor detenido."
        ;;

    restart)
        $0 stop
        sleep 1
        $0 start
        ;;

    status)
        if is_running; then
            echo "Estado: RUNNING"
            docker ps --filter "name=${CONTAINER_NAME}" --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}"
        else
            echo "Estado: STOPPED / NO EXISTE"
        fi
        ;;

    health)
        if ! is_running; then
            echo "→ El contenedor no está corriendo → health: DOWN"
            exit 1
        fi

        echo -n "→ Verificando salud (${HEALTH_URL}) ... "
        if curl -s -o /dev/null -w "%{http_code}" "${HEALTH_URL}" | grep -q "200"; then
            echo "OK (200 OK)"
        else
            echo "FALLÓ (no responde 200)"
            exit 1
        fi
        ;;

    logs)
        if ! is_running; then
            echo "→ El contenedor no está corriendo."
            exit 1
        fi
        docker logs --tail 50 "${CONTAINER_NAME}"
        ;;

    logs-f)
        if ! is_running; then
            echo "→ El contenedor no está corriendo."
            exit 1
        fi
        echo "→ Siguiendo logs (Ctrl+C para salir)..."
        docker logs -f "${CONTAINER_NAME}"
        ;;

    clean)
        if is_running; then
            $0 stop
        fi
        echo "→ Eliminando contenedor ${CONTAINER_NAME}..."
        docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
        echo "→ Limpieza completada."
        ;;

    help|--help|-h)
        show_help
        ;;

    *)
        echo "Comando desconocido: $1"
        show_help
        exit 1
        ;;
esac
