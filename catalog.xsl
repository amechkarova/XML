<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
<xsl:output method="xml" version="1.0" indent="yes"/>

<xsl:template match="/">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<fo:layout-master-set>
		<fo:simple-page-master master-name="page"
			page-height="29.7cm" 
            page-width="21cm"
            margin-top="1cm" 
            margin-bottom="2cm" 
            margin-left="2.5cm" 
            margin-right="2.5cm"
		
		>
			<fo:region-body margin-top="3cm"/>
			<fo:region-before extent="3cm"/>
            <fo:region-after extent="1.5cm"/>
		</fo:simple-page-master>
	</fo:layout-master-set>
	<fo:page-sequence master-reference="page">
		<fo:flow flow-name="xsl-region-body">
			<xsl:for-each select="/catalog/regions/region">
				<fo:block space-before="7mm" space-after="7mm" font-size="19pt">
				
					Region: <xsl:value-of select="name"/>
				
				</fo:block>
				<xsl:variable name="ID" select="@id"/>
				<fo:block font-size="14pt" font-family="verdana" space-before="5mm" space-after="5mm">
					<xsl:for-each select="/catalog/wineries/winery">
						<xsl:variable name="regID" select="@region_id"/>
						<xsl:if test="$ID=$regID">

							<fo:block font-size="16pt" color="black" space-before="5mm" space-after="5mm" font-style="italic" font-weight="bold" start-indent="0cm"> 
								<xsl:value-of select="name"/>
								<fo:external-graphic src="{unparsed-entity-uri(@logo)}" content-width="150" content-height="150" margin-right="1000"/>
							</fo:block>
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic"> 
								Established: <xsl:value-of select="year"/>
								Location: <xsl:value-of select="location"/>
							</fo:block>
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic"> 
								Vineyards: <xsl:value-of select="vineyards"/>
							</fo:block>
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic">				
								Owners:
								<xsl:for-each select="owner">
									<xsl:value-of select="."/>
									<xsl:if test="not(position()=last())">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</fo:block>
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic">
								Wine Makers: 
								<xsl:for-each select="wine_maker">					
									<xsl:value-of select="."/>
									<xsl:if test="not(position()=last())">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</fo:block>
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic">
								Brands: 
								<xsl:for-each select="brand">					
									<xsl:value-of select="."/>
									<xsl:if test="not(position()=last())">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</fo:block>
							
							<xsl:if test="branch">
								<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic">
									<xsl:for-each select="branch">					
										<fo:block>
											Branch: <xsl:value-of select="."/>
										</fo:block>
										<xsl:if test="not(position()=last())">
											<xsl:text xml:space="preserve">&#10;</xsl:text>
										</xsl:if>
									</xsl:for-each>
								</fo:block>
							</xsl:if>
							
							<fo:block font-size="10pt" color="black" space-before="5mm" space-after="5mm" font-style="italic"> 
								<xsl:if test="annual_production">
								Annual production: <xsl:value-of select="annual_production"/>
								</xsl:if>
							</fo:block>	
							<fo:external-graphic src="{unparsed-entity-uri(@image)}" content-width="150" content-height="150"/>			
							<xsl:variable name="id" select="@id"/>
							<xsl:for-each select="/catalog/wines/wine">
								<xsl:variable name="winery_id" select="@winery_id"/>
								<xsl:variable name="wineryBranch_id" select="substring-before(@winery_id,' ')"/>
								<xsl:if test="$id=$winery_id or $id=$wineryBranch_id">
									<xsl:call-template name="name_colour"/>
									
									<fo:block space-after="0.5em">
										
										<fo:block> 
											<fo:external-graphic src="{unparsed-entity-uri(@image)}" width="9.5cm" height="7.5cm" content-width="8.5cm" content-height="7.5cm" text-align="left"/>
											<fo:block text-align="right" margin-top="-5.5cm">
												Year: <xsl:value-of select="year"/>
											</fo:block>
											<fo:block text-align="right">
												Price: <xsl:value-of select="price"/>
											</fo:block>
											<fo:block text-align="right">
												Variety: <xsl:value-of select="variety"/>
											</fo:block>
											<fo:block text-align="right" margin-bottom="3.5cm">
												Colour: <xsl:value-of select="colour"/>
											</fo:block>
										</fo:block>
										
										
									</fo:block>
									
									<xsl:call-template name="description_colour"/>
									
								</xsl:if>
							</xsl:for-each>	
						</xsl:if>
					</xsl:for-each>
				</fo:block>
			</xsl:for-each>	
		</fo:flow>
	</fo:page-sequence>
</fo:root>
</xsl:template>

<xsl:template name="name_colour">
	<xsl:choose>
		<xsl:when test="colour='red'">
			<fo:block font-size="16pt" color="red" space-before="10mm">
				<xsl:value-of select="@name"/>
			</fo:block>
		</xsl:when>
		<xsl:when test="colour='rose'">
			<fo:block font-size="16pt" color="pink" space-before="10mm">
				<xsl:value-of select="@name"/>
			</fo:block>
		</xsl:when>
		<xsl:when test="colour='white'">
			<fo:block font-size="16pt" color="orange" space-before="10mm">
				<xsl:value-of select="@name"/>
			</fo:block>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="description_colour">
	<xsl:choose>
		<xsl:when test="colour='red'">
			<fo:block start-indent="0mm" text-indent="1em" font-size="16pt" color="red">
				<xsl:value-of select="description"/>
			</fo:block>
		</xsl:when>
		<xsl:when test="colour='rose'">
			<fo:block start-indent="0mm" text-indent="1em" font-size="16pt" color="pink">
				<xsl:value-of select="description"/>
			</fo:block>
		</xsl:when>
		<xsl:when test="colour='white'">
			<fo:block start-indent="0mm" text-indent="1em" font-size="16pt" color="orange">
				<xsl:value-of select="description"/>
			</fo:block>
		</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>