<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="#all"
    version="3.0">
    <!-- You have to use the greek xml as the original or "principal" input document when doing the transformation. It won't work otherwise. -->
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Reading View</title>
            </head>
            <body>
                <h1>Reading View</h1>
                <p>
                    <h2>Greek</h2>
                <ol>
                    <xsl:apply-templates select="//u" mode="Greek"/></ol>
                </p>
                <p>
                    <h2>Butler</h2>
                    <ol>
                        <xsl:apply-templates select ="document('iliad_eng_ver.xml')//u" mode = "Butler"/>
                    </ol>
                </p>
                <p>
                    <h2>Wilson</h2>
                    <ol>
                        <xsl:apply-templates select ="document('Wilson_man_husband.xml')//*:u" mode="Wilson"/>
                    </ol>
                    <!-- As you'll notice above and below, I used *:U for the Wilson doc. This is because, as I found out after some internet/ai use, our documents and xslt are in the tei namespace
                    while the wilson doc is not. To rectify this, we use *: to tell the xslt to look for an element called u, regardless of the samespace.-->
                </p>
            </body>
        </html>
       
        
    </xsl:template>
    <xsl:template match="u" mode="Greek">
        <li id="{position()}"><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="u" mode="Butler">
        <li id="{position()}"><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="*:u" mode="Wilson">
        <li id="{position()}"><xsl:apply-templates/></li>
    </xsl:template>
<!--    <xsl:template match="u" mode="Wilson">
        <li id="{position()}"><xsl:apply-templates/></li>
    </xsl:template>-->
    
    
</xsl:stylesheet>