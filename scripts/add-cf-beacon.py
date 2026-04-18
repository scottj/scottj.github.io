#!/usr/bin/env python3
"""Insert the Cloudflare Insights beacon before </body> in every HTML page.

Skips files that already contain the beacon token, the Google site
verification stub, and the empty .well-known/index.html. The root
index.html is also skipped — it is a minified build artifact; edit
src/index.html and regenerate via scripts/minify.sh instead.

Usage: python scripts/add-cf-beacon.py [repo_root]
"""
from pathlib import Path
import re
import sys

BEACON = (
    "<script defer src='https://static.cloudflareinsights.com/beacon.min.js' "
    "data-cf-beacon='{\"token\": \"afb08e5a4f494fe78662f8696341892e\"}'></script>"
)
TOKEN_MARKER = "afb08e5a4f494fe78662f8696341892e"

SKIP = {
    Path("index.html"),
    Path("google7d8558f4a5334d37.html"),
    Path(".well-known/index.html"),
}

BODY_CLOSE = re.compile(r"</body\s*>", re.IGNORECASE)

# Files that must exist in the repo root — guards against running the
# script against the wrong directory (e.g. when __file__ resolves to a
# temp wrapper).
REPO_MARKERS = ("src/index.html", "sitemap.xml", "AGENTS.md")


def process(path: Path) -> str:
    text = path.read_text(encoding="utf-8")
    if TOKEN_MARKER in text:
        return "skip-already-present"
    match = BODY_CLOSE.search(text)
    if not match:
        return "skip-no-body-tag"
    indent_match = re.search(r"([ \t]*)$", text[: match.start()])
    indent = indent_match.group(1) if indent_match else ""
    insertion = f"{BEACON}\n{indent}"
    new_text = text[: match.start()] + insertion + text[match.start() :]
    path.write_text(new_text, encoding="utf-8", newline="")
    return "updated"


def main(argv: list[str]) -> int:
    if len(argv) > 1:
        repo = Path(argv[1]).resolve()
    else:
        repo = Path(__file__).resolve().parent.parent

    missing = [m for m in REPO_MARKERS if not (repo / m).exists()]
    if missing:
        print(f"refusing to run: {repo} is missing repo markers: {missing}", file=sys.stderr)
        return 2

    counts = {"updated": 0, "skip-already-present": 0, "skip-no-body-tag": 0, "skip-excluded": 0}
    for html in repo.rglob("*.html"):
        rel = html.relative_to(repo)
        if any(part in {".git", "node_modules"} for part in rel.parts):
            continue
        if rel in SKIP:
            counts["skip-excluded"] += 1
            continue
        result = process(html)
        counts[result] += 1
        if result == "updated":
            print(f"updated {rel}")
        elif result == "skip-no-body-tag":
            print(f"no </body>: {rel}")
    print()
    for k, v in counts.items():
        print(f"{k}: {v}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
