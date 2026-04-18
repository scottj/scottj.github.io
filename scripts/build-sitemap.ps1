Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Push-Location "$PSScriptRoot/.."
try {
    $pages = Get-Content sitemap.json -Raw | ConvertFrom-Json
    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add('<?xml version="1.0" encoding="UTF-8"?>')
    $lines.Add('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
    foreach ($prop in $pages.PSObject.Properties) {
        $url = [System.Security.SecurityElement]::Escape($prop.Value)
        $lines.Add('  <url>')
        $lines.Add("    <loc>$url</loc>")
        $lines.Add('  </url>')
    }
    $lines.Add('</urlset>')
    Set-Content -Path sitemap.xml -Value (($lines -join "`n") + "`n") -NoNewline -Encoding utf8
} finally {
    Pop-Location
}
