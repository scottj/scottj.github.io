# scottj.info

Personal website deployed to GitHub Pages.

## Architecture

- `src/index.html` and `src/sitemap.html` are the sources of truth (readable, 2-space indent, inline CSS and JS, no frameworks, no external deps except Google Fonts). The root `index.html` and `sitemap.html` are minified build artifacts — never edit them directly.
- Build: `uv run scripts/build.sh` (PowerShell: `uv run scripts/build.ps1`) runs the full build pipeline — updates `sitemap.json` from GitHub, regenerates `sitemap.xml`, then minifies all `src/*.html` into root counterparts. Requires `bun` and `uv` on PATH. Run before committing any source change.
- `sitemap.json` is the source of truth — a `{ title: url }` map. `scripts/create-xml-sitemap.py` regenerates `sitemap.xml` from it; run with `uv run scripts/create-xml-sitemap.py` before committing any `sitemap.json` change. `sitemap.html` fetches `sitemap.json` directly and renders titles client-side (no XSLT).
- `scripts/update-sitemap.py` queries the GitHub API for public repos belonging to `scottj` and appends any repo homepage URLs on the `scottj.info` domain that are missing from `sitemap.json`. Run with `uv run scripts/update-sitemap.py` (no dependencies beyond the stdlib). After running, regenerate `sitemap.xml` with `uv run scripts/create-xml-sitemap.py` before committing.
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
uv run scripts/minify.py
uv run scripts/screenshot.py
```
