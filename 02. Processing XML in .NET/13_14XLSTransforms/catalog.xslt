<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <body>
        <h2>Albums</h2>
          <xsl:for-each select="catalogue/album">
            <ul>
              <li>
                <xsl:value-of select="name"/>
              </li>
              <li>
                <xsl:value-of select="artist"/>
              </li>
              <li>
                <xsl:value-of select="year"/>
              </li>
              <li>
                <xsl:value-of select="producer"/>
              </li>
              <li>
                <xsl:value-of select="price"/>
              </li>
              <li>
                Songs
                <xsl:for-each select="songs/song">
                  <ul>
                    <li>
                      <xsl:value-of select="title"/>
                    </li>
                    <li>
                      <xsl:value-of select="duration"/>
                    </li>
                  </ul>
                </xsl:for-each>
              </li>
            </ul>
          </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
