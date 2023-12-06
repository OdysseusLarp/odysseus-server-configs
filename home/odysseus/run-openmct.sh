#!/usr/bin/env bash

set -euo pipefail

CONTAINER_NAME="odysseus-mct"
IMAGE_NAME="117604685733.dkr.ecr.eu-west-1.amazonaws.com/odysseus-mct:latest"

docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true
docker pull "$IMAGE_NAME"

docker run -d --restart unless-stopped -p 127.0.0.1:8080:8080 -v /home/odysseus/odysseus.json:/app/odysseus.json --name "$CONTAINER_NAME" "$IMAGE_NAME"
