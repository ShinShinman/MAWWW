<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#x00A0;">
	<!ENTITY copy   "&#169;">
	<!ENTITY ndash "&#8211;">
	<!ENTITY thinsp "&#8201;">
	<!ENTITY amp "&#038;">
	<!ENTITY hellip "&#8230;">
	<!ENTITY bull "&#8226;">
	<!ENTITY lsaqua "&#8249;">
	<!ENTITY rsaqua "&#8250;">
	<!ENTITY larr "&#8592;">
	<!ENTITY rarr "&#8594;">
	<!ENTITY lsaquo "&#8249;">
	<!ENTITY rsaquo "&#8250;">
	<!ENTITY percent "&#37;">
	<!ENTITY gt "&#37;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:include href="../utilities/_edu-brick.xsl"/>
<xsl:include href="../utilities/_edu-nav.xsl"/>

<xsl:template match="data">
	<!--<xsl:apply-templates select="edu-adults/entry" />
	<xsl:apply-templates select="edu-lectures" />-->


	<xsl:choose>
		<xsl:when test="$title">
			<xsl:if test="edu-lecture/error">
				<script>
					window.location.replace('<xsl:value-of select="$root"/>/error/');
				</script>
			</xsl:if>
			<xsl:apply-templates select="edu-lecture/entry" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="edu-adults/entry" />
		</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="edu-lectures" />
</xsl:template>

<xsl:template match="edu-lecture/entry">
	<section class="single-lesson">
		<header class="donthyphenate">
			<ul class="category-list">
				<xsl:apply-templates select="category/item" />
			</ul>
			<h1><xsl:value-of select="title" /></h1>
			<xsl:apply-templates select="subtitle" />
			<h3 class="date"><xsl:copy-of select="date/p/node()" /></h3>
		</header>
		<article>
			<xsl:copy-of select="article/node()" />
		</article>
	</section>
</xsl:template>

<xsl:template match="category/item">
	<li><a href="#"><span class="{category/@handle}"><xsl:value-of select="category" /></span></a></li>
</xsl:template>

<xsl:template match="subtitle">
	<h2><xsl:value-of select="." /></h2>
</xsl:template>

<xsl:template match="edu-adults/entry">
	<section class="edu">
		<header>
			<a href="{$root}/{//fl-languages/current-language/@handle}/{//plh-page/page/item[@lang = //fl-languages/current-language/@handle]/@handle}"><h1><xsl:value-of select="//plh-page/page/item[@lang = //fl-languages/current-language/@handle]" /></h1></a>
			<ul class="inline-list">
				<xsl:apply-templates select="//edu-nav/page" />
			</ul>
		</header>
		<article>
			<h1><xsl:copy-of select="title/p/node()" /></h1>
			<xsl:copy-of select="article/node()" />
		</article>
	</section>
</xsl:template>

<xsl:template match="edu-nav/page">
	<xsl:call-template name="edu-nav" />
</xsl:template>

<xsl:template match="edu-lectures">
	<section class="edu-items">
		<header>
			<h1><xsl:value-of select="//dictionary/entry/word[@handle-pl = 'najblizsze-wyklady-i-spotkania']" /></h1> <!-- Tu jest nagłówek -->
			<!-- <xsl:choose>
				<xsl:when test="entry">
					<ul class="edu-categories filters">
						<li class="label"><xsl:value-of select="//dictionary/entry/word[@handle-pl = 'filtry']" />:</li>
						<xsl:apply-templates select="//edu-lectures-categories/entry" />
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<p><xsl:value-of select="//dictionary/entry/word[@handle-pl = 'brak-aktualnych-wykladow']" /></p>
				</xsl:otherwise>
			</xsl:choose> -->
			<xsl:if test="not(entry)">
				<p><xsl:value-of select="//dictionary/entry/word[@handle-pl = 'brak-aktualnych-wykladow']" /></p>
			</xsl:if>
		</header>
		<div class="bricks-container">
			<xsl:apply-templates select="./entry[title/@handle != $title]" />
		</div>
	</section>
</xsl:template>

<xsl:template match="edu-lectures-categories/entry">
	<li class="{category/@handle-pl}"><a href="javascript:void(0)" data-filter="{category/@handle}"><xsl:value-of select="category" /></a><a href="javascript:void(0)" class="clear-filter icons">X</a></li>
</xsl:template>

<xsl:template match="edu-lectures/entry">
	<xsl:call-template name="edu-brick" /> <!-- Edytować utilities/edu-brick .xls -->
</xsl:template>

<xsl:template match="data" mode="ma-button">
	<xsl:choose>
		<xsl:when test="$title">
			<xsl:value-of select="concat($root, '/', //current-language/@handle, '/', //plh-page/page/item[@lang = //current-language/@handle]/@handle, '/', //plh-page/page/page/item[@lang = //current-language/@handle]/@handle, '/')" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($root, '/', //current-language/@handle, '/')" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="language-button">
	<xsl:param name="lang" />
	<xsl:choose>
		<xsl:when test="$lang = 'pl'">
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/{//edu-lecture/entry/title/@handle-en}" class="icon">E</a>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/{//edu-lecture/entry/title/@handle-pl}" class="icon">P</a>
		</xsl:otherwise>
	</xsl:choose>
	<!--
	<xsl:param name="lang" />
	<xsl:choose>
		<xsl:when test="$lang = 'pl'">
			<a href="{$root}/en/education/" class="icon">E</a>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/pl/edukacja/" class="icon">P</a>
		</xsl:otherwise>
	</xsl:choose>
	-->
</xsl:template>

<xsl:template match="data" mode="js">
	<script>
		$(function() {
			MA.stickyNavSetup({backgroundColor: 'white'});
		});
		$(window).load(function() {
			MA.iS();
		});
	</script>
</xsl:template>

</xsl:stylesheet>