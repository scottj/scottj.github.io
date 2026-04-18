Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Push-Location "$PSScriptRoot/.."
try {
    function Invoke-Minify {
        param([string]$Source, [string]$Output)
        bunx html-minifier-terser `
            --collapse-boolean-attributes `
            --collapse-whitespace `
            --decode-entities `
            --minify-css true `
            --minify-js '{"module":true}' `
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
            -o $Output `
            $Source
    }

    Invoke-Minify src/index.html index.html
    Invoke-Minify src/sitemap.html sitemap.html
} finally {
    Pop-Location
}
