#!/usr/bin/env bash
docker ps --filter "name=petstore3" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
