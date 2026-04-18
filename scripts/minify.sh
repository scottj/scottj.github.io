#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

minify() {
  bunx html-minifier-terser \
    --collapse-boolean-attributes \
    --collapse-whitespace \
    --decode-entities \
    --minify-css true \
    --minify-js '{"module":true}' \
    --remove-attribute-quotes \
    --remove-comments \
    --remove-empty-attributes \
    --remove-redundant-attributes \
    --remove-script-type-attributes \
    --remove-style-link-type-attributes \
    --sort-attributes \
    --sort-class-name \
    --trim-custom-fragments \
    --use-short-doctype \
    --process-conditional-comments \
    -o "$2" \
    "$1"
}

minify src/index.html index.html
minify src/sitemap.html sitemap.html
