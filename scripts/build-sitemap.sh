#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

bun run - <<'EOF'
const pages = JSON.parse(await Bun.file('sitemap.json').text());
const esc = (s) => s.replace(/[<>&'"]/g, (c) => ({
  '<': '&lt;', '>': '&gt;', '&': '&amp;', "'": '&apos;', '"': '&quot;',
}[c]));
const out = [
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
];
for (const url of Object.values(pages)) {
  out.push('  <url>', `    <loc>${esc(url)}</loc>`, '  </url>');
}
out.push('</urlset>', '');
await Bun.write('sitemap.xml', out.join('\n'));
EOF
