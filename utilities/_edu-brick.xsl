<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="edu-brick">
		<xsl:param name="lang" select="//fl-languages/current-language/@language" />

		<article>
			<xsl:attribute name="class">brick<xsl:apply-templates select="category/item" /></xsl:attribute>
			<a>
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="name(..) = 'edu-lessons'">
							<xsl:call-template name="lesson" />
						</xsl:when>
						<xsl:when test="name(..) = 'edu-aid'">
							<xsl:call-template name="aid" />
						</xsl:when>
						<xsl:when test="name(..) = 'edu-games'">
							<xsl:call-template name="games" />
						</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
				<!--<xsl:copy-of select="lead/node()" />-->
			</a>
		</article>

	</xsl:template>

	<xsl:template name="lesson">
		<xsl:value-of select="concat($root, '/', title/@lang, '/', //dictionary/entry/word[@handle-en = $root-page], '/', 'lekcje-muzealne', '/', title/@handle)" />
	</xsl:template>

	<xsl:template name="aid">
		<xsl:value-of select="concat($root, '/', title/@lang, '/', //dictionary/entry/word[@handle-en = $root-page], '/', 'materialy-do-pobrania', '/', title/@handle)" />
	</xsl:template>

	<xsl:template name="games">
		<xsl:value-of select="concat($root, '/', title/@lang, '/', //dictionary/entry/word[@handle-en = $root-page], '/', 'gry', '/', title/@handle)" />
	</xsl:template>

	<xsl:template match="category/item">
		<xsl:text> </xsl:text><xsl:value-of select="category/@handle-pl" />
	</xsl:template>

	<xsl:template match="entry/date">
		<div class="dashed">
			<svg>
				<path d="M0 0 H 300" />
			</svg>
			<xsl:copy-of select="./node()" />
			<svg>
				<path d="M0 0 H 300" />
			</svg>
			<!--<xsl:apply-templates select=".//black" />-->
			<!--
			<xsl:apply-templates select="date[@type = 'exact']" />
			<xsl:apply-templates select="date[@type = 'range']" />
		-->
		</div>
	</xsl:template>

</xsl:stylesheet>