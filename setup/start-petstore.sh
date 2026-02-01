#!/usr/bin/env bash
CONTAINER_NAME="petstore3"
IMAGE_NAME="swaggerapi/petstore3"

if docker ps --filter "name=${CONTAINER_NAME}" --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Ya está corriendo."
    exit 0
fi

docker run -d --name "${CONTAINER_NAME}" -p 8080:8080 "${IMAGE_NAME}"
echo "Iniciado → http://localhost:8080"
