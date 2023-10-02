<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="edu-brick">
		<xsl:param name="lang" select="//fl-languages/current-language/@language" />

		<article>
			<xsl:attribute name="class">brick <xsl:apply-templates select="category/item" /></xsl:attribute>
			<xsl:choose>
				<xsl:when test="../section/@handle = 'lessons'">
					<xsl:call-template name="lesson" />
				</xsl:when>
				<xsl:when test="../section/@handle = 'lessons-aid'">
					<xsl:call-template name="aid" />
				</xsl:when>
				<xsl:when test="../section/@handle = 'edu-games'">
					<xsl:call-template name="games" />
				</xsl:when>
				<xsl:when test="../section/@handle = 'edu-workshops'">
					<xsl:call-template name="workshops" />
				</xsl:when>
				<xsl:when test="../section/@handle = 'edu-lectures'"> <!-- na stronie Dorośli i młodzież (adults.xsl) -->
					<xsl:call-template name="lectures" />
				</xsl:when>
			</xsl:choose>
		</article>

	</xsl:template>

	<xsl:template match="category/item">
		<xsl:text> </xsl:text><xsl:value-of select="@handle" />
	</xsl:template>

	<xsl:template name="lesson">

		<a href="{$root}/{title/@lang}/{//dictionary/entry/word[@handle-pl = 'edukacja']}/przedszkola-i-szkoly/{title/@handle}">
			<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
			<!--<p class="category">Edukacja</p>-->
			<!--<xsl:apply-templates select="./date" />-->
			<!--<xsl:copy-of select="lead/node()" />-->
		</a>
	</xsl:template>

	<xsl:template name="aid">
		<a href="{$root}/{title/@lang}/{//dictionary/entry/word[@handle-pl = 'edukacja']}/materialy-edukacyjne/{title/@handle}">
			<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
			<!--<p class="category">Edukacja</p>-->
			<!--<xsl:apply-templates select="./date" />-->
			<!--<xsl:copy-of select="lead/node()" />-->
		</a>
	</xsl:template>

	<xsl:template name="games">
		<a href="{$root}/{title/@lang}/{//dictionary/entry/word[@handle-pl = 'edukacja']}/gry-edukacyjne/{title/@handle}">
			<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
			<!--<p class="category">Edukacja</p>-->
			<!--<xsl:apply-templates select="./date" />-->
			<!--<xsl:copy-of select="lead/node()" />-->
		</a>
	</xsl:template>

	<xsl:template name="workshops">
		<a href="{$root}/{title/@lang}/{//dictionary/entry/word[@handle-pl = 'edukacja']}/dzieci-i-rodzice/{title/@handle}">
			<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
			<p class="category">Edukacja</p>
			<!--<xsl:apply-templates select="../section" />-->
			<xsl:apply-templates select="./date" />
			<xsl:copy-of select="lead/node()" />
			<xsl:apply-templates select="cover-image" />
		</a>
	</xsl:template>

	<xsl:template name="lectures">
		<a href="{$root}/{title/@lang}/{//dictionary/entry/word[@handle-pl = 'edukacja']}/dorosli-i-mlodziez/{title/@handle}">
			<h1 class="donthyphenate"><xsl:value-of select="title" /></h1>
			<p class="category">Edukacja</p>
			<xsl:apply-templates select="./date" />
			<xsl:copy-of select="lead/node()" />
			<xsl:apply-templates select="cover-image" />
		</a>
	</xsl:template>

	<xsl:template match="edu-workshops/section">
		<p class="category"><xsl:value-of select="." /></p>
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
		</div>
	</xsl:template>

	<xsl:template match="cover-image">
		<img src="{$root}/image/post-thumbnail{@path}/{filename}" />
	</xsl:template>

</xsl:stylesheet>
