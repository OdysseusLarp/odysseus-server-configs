#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="odysseus-mct"
IMAGE_NAME="odysseus-mct:latest"

docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true

docker run -d --restart unless-stopped -p 127.0.0.1:8080:8080 -v "$(pwd)/odysseus.json:/app/odysseus.json" --name "$CONTAINER_NAME" "$IMAGE_NAME"
