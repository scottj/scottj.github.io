# scottj.info

Personal website deployed to GitHub Pages.

## Architecture

- Single `index.html` file with inline CSS and JS — no build tools, no frameworks, no external dependencies (except Google Fonts)
- Deployed via GitHub Actions (`.github/workflows/deploy.yml`) using the official Pages actions

## Conventions

- **CSS**: 2-space indent, starts with `* { box-sizing: border-box; }`, use CSS custom properties for theming
- **JS**: 2-space indent, `<script type="module">`, no indent at first level inside the script tag
- **Fonts**: Helvetica/Arial/sans-serif for headings; IBM Plex Mono for body/mono text
- **Headings**: Sentence case
- **Inputs/textareas**: 16px font size minimum
- **Theme**: Auto dark/light via `prefers-color-scheme` media query — no toggle button
- **Colors**: Light (`--bg: #faf8f4`, `--text: #151513`, `--accent: #2956c1`) / Dark (`--bg: #1a1917`, `--text: #e8e6e1`, `--accent: #5b9fd4`)

## Verification

```bash
bash scripts/screenshot.sh
```
