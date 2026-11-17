#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
docker compose up --build -d
echo "Loja Web: http://localhost:8080/loja-web-sessao/"
