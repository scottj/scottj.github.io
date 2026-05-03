# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
import subprocess
import sys
from pathlib import Path

root = Path(__file__).parent.parent

ARGS = [
    "--collapse-boolean-attributes",
    "--collapse-whitespace",
    "--decode-entities",
    "--minify-css", "true",
    "--minify-js", '{"module":true}',
    "--remove-attribute-quotes",
    "--remove-comments",
    "--remove-empty-attributes",
    "--remove-redundant-attributes",
    "--remove-script-type-attributes",
    "--remove-style-link-type-attributes",
    "--sort-attributes",
    "--sort-class-name",
    "--trim-custom-fragments",
    "--use-short-doctype",
    "--process-conditional-comments",
]

def minify(src: str, out: str) -> None:
    result = subprocess.run(
        ["bunx", "html-minifier-terser", *ARGS, "-o", out, src],
        cwd=root,
    )
    if result.returncode != 0:
        sys.exit(result.returncode)

minify("src/index.html", "index.html")
minify("src/sitemap.html", "sitemap.html")
