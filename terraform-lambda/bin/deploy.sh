#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BACKEND_DIR="$ROOT_DIR/backend"
DIST_DIR="$BACKEND_DIR/dist"
ZIP_PATH="$BACKEND_DIR/lambda.zip"

echo "🔨 Building TypeScript Lambda..."
cd "$BACKEND_DIR"
npm ci # Installs the exact versions of dependencies specified in your package-lock.json
rm -rf "$DIST_DIR"
npm run build
npm prune --production # Removes all devDependencies from node_modules, leaving only the packages needed to run

echo "📦 Creating zip package..."
rm -f "$ZIP_PATH"
cd "$DIST_DIR"
zip -r "$ZIP_PATH" .

echo "🚀 Deploying with Terraform..."
cd "$ROOT_DIR/iac"
terraform init
terraform apply --auto-approve

echo "✅ Lambda deployed successfully!"