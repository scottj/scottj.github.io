Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Push-Location "$PSScriptRoot/.."
try {
    (Get-Content sitemap.xml) |
        Where-Object { $_ -notmatch '<\?xml-stylesheet' -and $_ -notmatch 'xmlns:friendly' -and $_ -notmatch '<friendly:' } |
        ForEach-Object { $_ -replace '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"$', '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' } |
        Set-Content sitemap-dumbed-down-for-google.xml
} finally {
    Pop-Location
}
