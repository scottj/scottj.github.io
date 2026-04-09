#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."
sed -e '/<?xml-stylesheet/d' -e '/xmlns:friendly/d' -e '/<friendly:/d' -e 's|<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"$|<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">|' sitemap.xml > sitemap-dumbed-down-for-google.xml
