#!/bin/bash

echo "=== Stopping UE ==="
cd ~/5GMECv2/ue
docker compose -f docker-compose-ue.yaml down

echo "=== Stopping gNB ==="
cd ~/5GMECv2/ran
docker compose -f docker-compose-ran.yaml down

echo "=== Stopping Core ==="
cd ~/5GMECv2/core
docker compose -f docker-compose-core.yaml down

echo "=== All stopped ==="
