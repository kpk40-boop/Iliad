<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:variable name="chart-width" select="750"/>
    <xsl:variable name="chart-height" select="400"/>
    <xsl:variable name="margin" select="50"/>
    <xsl:variable name="bar-width" select="15"/>
    <xsl:variable name="inner-spacing" select="1"/>
    <xsl:variable name="num-bars-per-group" select="5"/>
    <xsl:variable name="group-width" select="$num-bars-per-group * $bar-width + ($num-bars-per-group - 1) * $inner-spacing"/>
    <xsl:variable name="group-spacing" select="200"/>
    <xsl:variable name="legend-x" select="$chart-width + 20"/>
    
    <xsl:variable name="groups" select="('Butler: Man', 'Butler: Husband', 'Wilson: Man', 'Wilson: Husband', 'Wilson: Ambiguous', 'Greek: Man',
        'Greek: Husband', 'Greek: Ambiguous')"/>
    <xsl:variable name="colors" select="('#4D89Bo', '#937449', '#9D8C71', '#BBB093', '#AA633F', '#C8A55F', '#BEB4A7', '#9F8771')"/>
    
    <xsl:template match="/">
        <xsl:variable name="all-counts" select="//count"/>
        
        <xsl:variable name="max-count" select="max($all-counts)"/>
        
        <xsl:variable name="scale-y" 
            select="($chart-height - 2 * $margin) div $max-count"/>
        
        <svg width="{$chart-width + 250}" height="{$chart-height}" viewBox="0 0 {$chart-width + 250} {$chart-height}">
            <title>Comparative Word Choice: Butler vs. Wilson vs. Greek</title>
            
            <xsl:call-template name="draw-axes">
                <xsl:with-param name="max-count" select="$max-count"/>
            </xsl:call-template>
            
            <xsl:apply-templates select="comparison-analysis/character">
                <xsl:with-param name="max-count" select="$max-count"/>
                <xsl:with-param name="scale-y" select="$scale-y"/>
            </xsl:apply-templates>
            
            <xsl:call-template name="draw-legend"/>
            
        </svg>
        
    </xsl:template>
    
    <xsl:template match="character">
        <xsl:param name="max-count"/>
        <xsl:param name="scale-y"/>
        <xsl:variable name="char-index" select="position()"/>
        
        <xsl:variable name="base-x" 
            select="$margin + 50 + ($char-index - 1) * $group-spacing"/>
        
        <text x="{$base-x + ($group-width div 2)}" y="{$chart-height - $margin + 20}" 
            font-family="sans-serif" font-size="14" font-weight="bold" text-anchor="middle">
            <xsl:value-of select="@name"/>
        </text>
        
        <xsl:for-each select="version">
            <xsl:variable name="composite-key" select="concat(@name, ': ', @word-choice)"/>
            <xsl:variable name="count" select="count"/>
            
            <xsl:variable name="group-pos" select="index-of($groups, $composite-key)"/>
            
            <xsl:if test="$group-pos">
                <xsl:variable name="color" select="$colors[$group-pos]"/>
                
                <xsl:variable name="bar-x" 
                    select="$base-x + (($group-pos - 1) * ($bar-width + $inner-spacing))"/>
                <xsl:variable name="bar-height" select="$count * $scale-y"/>
                <xsl:variable name="bar-y" 
                    select="$chart-height - $margin - $bar-height"/>
                
                <xsl:if test="$count > 0">
                    <rect x="{$bar-x}" y="{$bar-y}" 
                        width="{$bar-width}" height="{$bar-height}" fill="{$color}"/>
                </xsl:if>
                
                <xsl:if test="$count > 0">
                    <text x="{$bar-x + ($bar-width div 2)}" y="{$bar-y - 5}" 
                        text-anchor="middle" font-family="sans-serif" font-size="11">
                        <xsl:value-of select="$count"/>
                    </text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template name="draw-axes">
        <xsl:param name="max-count"/>
        
        <xsl:variable name="num-ticks" select="xs:integer(round($max-count)) + 1"/>
        
        <line x1="{$margin}" y1="{$margin}" x2="{$margin}" y2="{$chart-height - $margin}" 
            stroke="black" stroke-width="1"/>
        
        <line x1="{$margin}" y1="{$chart-height - $margin}" x2="{$chart-width - $margin}" 
            y2="{$chart-height - $margin}" stroke="black" stroke-width="1"/>
        
        <xsl:for-each select="1 to $num-ticks">
            <xsl:variable name="y-value" select="current() - 1"/>
            <xsl:variable name="y-pos" 
                select="$chart-height - $margin - (($y-value) div $max-count * ($chart-height - 2 * $margin))"/>
            
            <line x1="{$margin - 5}" y1="{$y-pos}" x2="{$margin}" y2="{$y-pos}" stroke="black"/>
            
            <text x="{$margin - 10}" y="{$y-pos + 4}" text-anchor="end" font-family="sans-serif" font-size="12">
                <xsl:value-of select="current() - 1"/>
            </text>
        </xsl:for-each>
        
        <text x="10" y="{$chart-height div 2}" 
            transform="rotate(-90 10 {$chart-height div 2})" 
            text-anchor="middle" font-family="sans-serif" font-size="16">
            Count
        </text>
    </xsl:template>
    
    <xsl:template name="draw-legend">
        <text x="{$legend-x}" y="50" font-family="sans-serif" font-size="16" font-weight="bold">Legend</text>
        
        <xsl:for-each select="$groups">
            <xsl:variable name="i" select="position()"/>
            <xsl:variable name="color" select="$colors[$i]"/>
            <xsl:variable name="y-pos" select="75 + ($i * 30)"/>
            
            <rect x="{$legend-x}" y="{$y-pos - 10}" width="20" height="20" fill="{$color}"/>
            
            <text x="{$legend-x + 25}" y="{$y-pos + 5}" font-family="sans-serif" font-size="14">
                <xsl:value-of select="."/>
            </text>
        </xsl:for-each>
    </xsl:template>
    
    
    
</xsl:stylesheet>