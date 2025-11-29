<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method= "xml" indent="yes"/>
    
    <xsl:variable name="man_height" as="xs:double" select="300"/>
    <xsl:variable name="spacing" as= "xs:double" select="100"/>
    <xsl:variable name= "max_width" as="xs:double" select= "($spacing) * count(//man[@character])"/>
    
    <xsl:template match= "/">
        <svg viewbox= "0 -300 50 300"></svg>
            <xsl:apply-templates select= "//man"/>
        
   
        
    </xsl:template>
    
    <xsl:template match= "man">
        
        
    </xsl:template>
    
    
</xsl:stylesheet>