#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

# Light-mode variable overrides (match :root defaults)
LIGHT_CSS=':root{--bg:#faf8f4!important;--text:#151513!important;--accent:#2956c1!important;--border:#dbd6cc!important;--card:#fff!important}'

# Dark-mode variable overrides (match @media(prefers-color-scheme:dark) values)
DARK_CSS=':root{--bg:#1a1917!important;--text:#e8e6e1!important;--accent:#5b9fd4!important;--border:#2e2d29!important;--card:#232220!important}'

inject_theme() {
  uvx rodney js "(()=>{var e=document.getElementById('theme-override'); if(e)e.remove(); var s=document.createElement('style'); s.id='theme-override'; s.textContent='$1'; document.head.appendChild(s); return 'ok'})()"
}

FILE_URL="file:///$(cygpath -w "$(pwd)/index.html" | sed 's|\\|/|g')"

uvx rodney start
trap 'uvx rodney stop' EXIT

uvx rodney open "$FILE_URL"
uvx rodney sleep 2

inject_theme "$LIGHT_CSS"
uvx rodney sleep 1
uvx rodney screenshot screenshot-light.png
echo "Saved screenshot-light.png"

inject_theme "$DARK_CSS"
uvx rodney sleep 1
uvx rodney screenshot screenshot-dark.png
echo "Saved screenshot-dark.png"
