#!/bin/bash
# Run Lambda locally
# Usage:
#   ./run.sh        - Run once (build and start)
#   ./run.sh --watch - Run with hot reload (auto-rebuild on file changes)

set -e

cd "$(dirname "$0")/../backend"

echo "Lambda local development"
echo "Endpoint: http://localhost:8000/2015-03-31/functions/function/invocations"
echo ""

if [ "$1" = "--watch" ] || [ "$1" = "-w" ]; then
    echo "Starting with hot reload (watching for changes)..."
    docker compose watch
else
    echo "Starting container..."
    docker compose up --build
fi
