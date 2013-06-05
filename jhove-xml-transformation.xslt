<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:jhove="http://hul.harvard.edu/ois/xml/ns/jhove">
<xsl:template match="jhove:jhove">
	<html>
		<body style="font-family: arial; background: 101010; color: #E8E8E8">
			<h2>JHOVE Status Output</h2>
			<table style="border-collapse:collapse; border: 1px solid black; font-size: 12px; background: 404040; color: #E8E8E8">
				<tr> 
					<th style="border: 1px solid black; padding: 4px;">Path</th>
					<th style="border: 1px solid black; padding: 4px;">Format</th>
					<th style="border: 1px solid black; padding: 4px;">Module</th>
					<th style="border: 1px solid black; padding: 4px;">Status</th>
				</tr>
				<xsl:for-each select="jhove:repInfo" >
				<xsl:sort select="jhove:status"/>
				<xsl:choose>
					<xsl:when test="jhove:status = 'Well-Formed'">
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: 3366FF; color: #F8F8F8">
								<xsl:value-of select="jhove:status"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="jhove:status = 'Well-Formed and valid'">
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: 3366FF; color: #F8F8F8">
								<xsl:value-of select="jhove:status"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="jhove:status = 'Well-formed, but not valid'">
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: 990099; color: #F8F8F8">
								<xsl:value-of select="jhove:status"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="jhove:status = 'Not well-formed'">
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: FF0000; color: #FFFFFF">
								<xsl:value-of select="jhove:status"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="jhove:status = 'Unknown'">
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: FF9900; color: #000000">
								<xsl:value-of select="jhove:status"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<xsl:apply-templates select="@uri"/>
							<xsl:apply-templates select="jhove:format"/>
							<xsl:apply-templates select="jhove:sigMatch/jhove:module"/>
							<td style="border: 1px solid black; padding: 4px; background: #FFFF00; color: #000000">
								<xsl:value-of select="jhove:status"/> &#160; &#160; <i>*unrecognized status*</i> &#160; &#160; 
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:for-each>
			</table>
		</body>
	</html>
</xsl:template>

<xsl:template match="@uri">
	<td style="border: 1px solid black; padding: 4px">
		<xsl:value-of select="."/>
	</td>
</xsl:template>

<xsl:template match="jhove:format">
	<td style="border: 1px solid black; padding: 4px">
		<xsl:value-of select="."/>
	</td>
</xsl:template>

<xsl:template match="jhove:sigMatch/jhove:module">
	<td style="border: 1px solid black; padding: 4px">
		<xsl:value-of select="."/>
	</td>
</xsl:template>

<!-- JHOVE Status Element JHOVE: XmlHandler.java
		Well-Formed
		Well-Formed and valid
		Well-Formed, but not valid
		Not well-formed
		Unknown
-->

</xsl:stylesheet>
