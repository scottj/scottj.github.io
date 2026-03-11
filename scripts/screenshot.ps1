Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Push-Location "$PSScriptRoot/.."

# Light-mode variable overrides (match :root defaults)
$LightCSS = ':root{--bg:#faf8f4!important;--text:#151513!important;--accent:#2956c1!important;--border:#dbd6cc!important;--card:#fff!important}'

# Dark-mode variable overrides (match @media(prefers-color-scheme:dark) values)
$DarkCSS = ':root{--bg:#1a1917!important;--text:#e8e6e1!important;--accent:#5b9fd4!important;--border:#2e2d29!important;--card:#232220!important}'

function Invoke-InjectTheme($css) {
    uvx rodney js "(()=>{var e=document.getElementById('theme-override'); if(e)e.remove(); var s=document.createElement('style'); s.id='theme-override'; s.textContent='$css'; document.head.appendChild(s); return 'ok'})()"
}

$FileUrl = "file:///$((Get-Item ./index.html).FullName -replace '\\','/')"

try {
    uvx rodney start
    uvx rodney open $FileUrl
    uvx rodney sleep 2

    Invoke-InjectTheme $LightCSS
    uvx rodney sleep 1
    uvx rodney screenshot screenshot-light.png
    Write-Host 'Saved screenshot-light.png'

    Invoke-InjectTheme $DarkCSS
    uvx rodney sleep 1
    uvx rodney screenshot screenshot-dark.png
    Write-Host 'Saved screenshot-dark.png'
} finally {
    uvx rodney stop
    Pop-Location
}
