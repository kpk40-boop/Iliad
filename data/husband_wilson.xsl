<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="html"/>
   <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>"The Iliad" by Emily Wilson (excerpts)</title>
                <xsl:apply-templates></xsl:apply-templates>
            </head>
            <body>
                <xsl:apply-templates select="//p"/>
            </body>
            <hr/>   
        </html>
    </xsl:template>
    <xsl:template match="character">
       <h1><xsl:value-of select="@name"/></h1>
        <ul>
            <li>
                <xsl:apply-templates select="scroll"/>
            </li>
        </ul>

    </xsl:template>
    <xsl:template match="li">
        <li>
            <xsl:apply-templates select="text"/>
        </li>
    </xsl:template>
</xsl:stylesheet>