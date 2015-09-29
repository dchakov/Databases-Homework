<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <body>
        <h2>Students</h2>
        <xsl:for-each select="students/student">
          <ul>
            <li>
              Name: <xsl:value-of select="name"/>
            </li>
            <li>
              <xsl:value-of select="birth_day"/>
            </li>
            <li>
              <xsl:value-of select="phone"/>
            </li>
            <li>
              <xsl:value-of select="email"/>
            </li>
            <li>
              <xsl:value-of select="course"/>
            </li>
            <li>
              <xsl:value-of select="specialty"/>
            </li>
            <li>
              <xsl:value-of select="faculty_number"/>
            </li>
            <li>
              Exams
              <xsl:for-each select="exams/exam">
                <ul>
                  <li>
                    <xsl:value-of select="exam_name"/>
                  </li>
                  <li>
                    Tutor
                    <ul>
                      <li>
                        <xsl:value-of select="tutor/tutor_name"/>
                      </li>
                      <li>
                        <xsl:value-of select="tutor/endorsments"/>
                      </li>
                    </ul>
                  </li>
                  <li>
                    <xsl:value-of select="score"/>
                  </li>
                  <li>
                    <xsl:value-of select="exam_date"/>
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
