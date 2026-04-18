# scottj.info

Personal website deployed to GitHub Pages.

## Architecture

- `src/index.html` is the source of truth (readable, 2-space indent, inline CSS and JS, no frameworks, no external deps except Google Fonts). The root `index.html` is a minified build artifact — never edit it directly.
- Build: `bash scripts/minify.sh` (PowerShell: `scripts/minify.ps1`) runs `bunx html-minifier-terser` on `src/index.html` and writes the root `index.html`. Requires `bun` on PATH. Regenerate before committing any `src/index.html` change.
- `sitemap.json` is the source of truth — a `{ title: url }` map. `scripts/build-sitemap.sh` (PowerShell: `scripts/build-sitemap.ps1`) regenerates `sitemap.xml` from it; regenerate before committing any `sitemap.json` change. `sitemap.html` fetches `sitemap.json` directly and renders titles client-side (no XSLT).
- `oldblog/` is a static archive of the former blog — each HTML file carries a `rel=canonical`.
- Canonical domain is `https://scottj.info/` (GitHub Pages custom domain via `CNAME`). `ads.txt` lives at the root.
- Deployed via GitHub Actions (`.github/workflows/deploy.yml`) using the official Pages actions.

## Conventions

- **CSS**: 2-space indent, starts with `* { box-sizing: border-box; }`, use CSS custom properties for theming
- **JS**: 2-space indent, `<script type="module">`, no indent at first level inside the script tag
- **Fonts**: Helvetica/Arial/sans-serif for headings; IBM Plex Mono for body/mono text
- **Headings**: Sentence case
- **Inputs/textareas**: 16px font size minimum
- **Theme**: Auto dark/light via `prefers-color-scheme` media query — no toggle button
- **Colors**: Light (`--bg: #faf8f4`, `--text: #151513`, `--accent: #2956c1`) / Dark (`--bg: #1a1917`, `--text: #e8e6e1`, `--accent: #5b9fd4`)
- **Editing**: only edit `src/index.html`; regenerate root `index.html` with the minify script before committing.

## Verification

```bash
bash scripts/minify.sh
bash scripts/screenshot.sh
```
