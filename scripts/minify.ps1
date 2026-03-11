Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Push-Location "$PSScriptRoot/.."
try {
    bunx html-minifier-terser `
        --collapse-boolean-attributes `
        --collapse-inline-tag-whitespace `
        --collapse-whitespace `
        --decode-entities `
        --minify-css true `
        --minify-js true `
        --remove-attribute-quotes `
        --remove-comments `
        --remove-empty-attributes `
        --remove-redundant-attributes `
        --remove-script-type-attributes `
        --remove-style-link-type-attributes `
        --sort-attributes `
        --sort-class-name `
        --trim-custom-fragments `
        --use-short-doctype `
        --process-conditional-comments `
        -o index.html `
        src/index.html
} finally {
    Pop-Location
}
