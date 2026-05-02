Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

uv run "$PSScriptRoot/update-sitemap.py"
& "$PSScriptRoot/create-xml-sitemap.ps1"
& "$PSScriptRoot/minify.ps1"
