#!/bin/bash
# This script run Lambda locally
# Usage:
#   ./run-locally.sh        
#   then press 'w' to enable watch mode aka Hot Reloading

set -e

cd "$(dirname "$0")/../backend"

echo "Lambda local development"
echo "Endpoint: http://localhost:8000/2015-03-31/functions/function/invocations"
echo ""

echo "Starting container..."
docker compose up --build
