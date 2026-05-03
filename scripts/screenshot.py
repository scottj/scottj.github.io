# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
import subprocess
from pathlib import Path

root = Path(__file__).parent.parent

LIGHT_CSS = ':root{--bg:#faf8f4!important;--text:#151513!important;--accent:#2956c1!important;--border:#dbd6cc!important;--card:#fff!important}'
DARK_CSS = ':root{--bg:#1a1917!important;--text:#e8e6e1!important;--accent:#5b9fd4!important;--border:#2e2d29!important;--card:#232220!important}'

def rodney(*args: str) -> None:
    subprocess.run(["uvx", "rodney", *args], cwd=root, check=True)

def inject_theme(css: str) -> None:
    js = f"(()=>{{var e=document.getElementById('theme-override'); if(e)e.remove(); var s=document.createElement('style'); s.id='theme-override'; s.textContent='{css}'; document.head.appendChild(s); return 'ok'}})()"
    rodney("js", js)

file_url = (root / "index.html").resolve().as_uri()

rodney("start")
try:
    rodney("open", file_url)
    rodney("sleep", "2")

    inject_theme(LIGHT_CSS)
    rodney("sleep", "1")
    rodney("screenshot", "screenshot-light.png")
    print("Saved screenshot-light.png")

    inject_theme(DARK_CSS)
    rodney("sleep", "1")
    rodney("screenshot", "screenshot-dark.png")
    print("Saved screenshot-dark.png")
finally:
    rodney("stop")
