#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

uv run scripts/update-sitemap.py
uv run scripts/create-xml-sitemap.py
uv run scripts/minify.py
