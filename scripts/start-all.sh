#!/bin/bash
set -e

echo "=== Starting 5G Core Network ==="
cd ~/5GMECv2/core
docker compose -f docker-compose-core.yaml up -d

echo "Waiting for Core to initialize (60s)..."
sleep 10

echo "=== Starting gNB ==="
cd ~/5GMECv2/ran
docker compose -f docker-compose-ran.yaml up -d

echo "Waiting for gNB to initialize (30s)..."
sleep 10

echo "=== Starting UE ==="
cd ~/5GMECv2/ue
docker compose -f docker-compose-ue.yaml up -d

echo ""
echo "=== System Status ==="
docker ps --format "table {{.Names}}\t{{.Status}}"
