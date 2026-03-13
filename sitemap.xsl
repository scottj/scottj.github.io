<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:friendly="http://scottj.info/schemas/friendly">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Sitemap — scottj.info</title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin=""/>
        <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;600&amp;display=swap" rel="stylesheet"/>
        <style>
          :root {
            --bg: #faf8f4;
            --text: #151513;
            --accent: #2956c1;
            --border: #dbd6cc;
            --card: #fff;
          }
          @media (prefers-color-scheme: dark) {
            :root {
              --bg: #1a1917;
              --text: #e8e6e1;
              --accent: #5b9fd4;
              --border: #2e2d29;
              --card: #232220;
            }
          }
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body {
            font-family: 'IBM Plex Mono', monospace;
            background: var(--bg);
            color: var(--text);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
          }
          main {
            max-width: 480px;
            width: 100%;
            padding: clamp(2rem, 5vw, 6rem);
          }
          h1 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
          }
          ul {
            list-style: none;
          }
          li + li {
            margin-top: 0.75rem;
          }
          a {
            color: var(--accent);
            text-decoration: none;
          }
          a:hover {
            text-decoration: underline;
          }
        </style>
      </head>
      <body>
        <main>
          <h1>Sitemap</h1>
          <ul>
            <xsl:for-each select="sitemap:urlset/sitemap:url">
              <li>
                <a href="{sitemap:loc}">
                  <xsl:choose>
                    <xsl:when test="friendly:name">
                      <xsl:value-of select="friendly:name"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="sitemap:loc"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
