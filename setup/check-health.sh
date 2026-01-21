#!/usr/bin/env bash
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080 | grep -q "200"; then
    echo "HEALTH: OK"
    exit 0
else
    echo "HEALTH: DOWN"
    exit 1
fi
