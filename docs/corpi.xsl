<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Test</title>
                <link rel="stylesheet" type="text/css" href="/Users/kosiedoziem/Desktop/Iliad/docs/corpi.css"/>
            </head>
            <body>
                <div class="NavBar">
                    <a href="/Users/kosiedoziem/Desktop/Iliad/docs/index.xhtml">Home</a>
                    <a href="#">About</a>
                    <a href="#">Characters</a>
                    <a href="/Users/kosiedoziem/Desktop/Iliad/docs/corpi.xhtml">Corpi</a>
                    <a href="#">Contact</a>
                </div>
                
                <h1>Depictions of man in the Iliad and what scroll they appear in</h1>
                <xsl:apply-templates select="//body/div/div"/>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="div">
        <h1>
            <xsl:apply-templates select="head"/>
        </h1>
        <div><xsl:apply-templates select="./div/p[man]"/></div>
    </xsl:template>
    
    <xsl:template match="p[man]">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="man">
        <span class="man"><xsl:apply-templates/></span>
    </xsl:template>
    

    

    
</xsl:stylesheet>