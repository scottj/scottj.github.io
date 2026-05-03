Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

uv run "$PSScriptRoot/update-sitemap.py"
uv run "$PSScriptRoot/create-xml-sitemap.py"
uv run "$PSScriptRoot/minify.py"
