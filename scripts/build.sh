#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

uv run scripts/update-sitemap.py
bash scripts/create-xml-sitemap.sh
bash scripts/minify.sh
