#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
import json
from pathlib import Path
from xml.sax.saxutils import escape

root = Path(__file__).parent.parent
pages = json.loads((root / "sitemap.json").read_text(encoding="utf-8"))
lines = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
]
for url in pages.values():
    lines += ["  <url>", f"    <loc>{escape(url)}</loc>", "  </url>"]
lines += ["</urlset>", ""]
(root / "sitemap.xml").write_text("\n".join(lines), encoding="utf-8")
