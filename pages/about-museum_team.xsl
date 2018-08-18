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

<xsl:template match="data">
	<section class="museum team">
		<header>
			<h1><a href="{$root}/{//fl-languages/current-language/@handle}/{//plh-page/page/item[@lang = //fl-languages/current-language/@handle]/@handle}"><xsl:value-of select="//plh-page/page/item[@lang = //fl-languages/current-language/@handle]" /></a></h1>
			<ul class="inline-list">
				<xsl:apply-templates select="//museum-nav/page" />
			</ul>
		</header>
		<article>
			<h1><xsl:value-of select="//plh-page/page/page/item[@lang = //current-language/@handle]" /></h1>
			<xsl:apply-templates select="//team-divisions/entry" />
		</article>
	</section>
</xsl:template>

<xsl:template match="team-divisions/entry">
	<xsl:variable name="division" select="division/@handle" />
	<h2 class="div-button donthyphenate" data-div="{division/@handle}"><xsl:value-of select="division" /></h2>
	<div class="division {division/@handle}">
		<xsl:apply-templates select="//team/entry[division/item/division/@handle = $division]" />
	</div>
</xsl:template>

<xsl:template match="team/entry">
	<h3><xsl:value-of select="name" /></h3>
	<ul>
		<li><xsl:value-of select="job" /></li>
		<li><xsl:value-of select="telephone" /></li>
		<li><a href="mailto:{email}"><xsl:value-of select="email" /></a></li>
	</ul>
</xsl:template>

<xsl:template match="museum-nav/page">
	<li>
		<a href="{$root}/{//fl-languages/current-language/@handle}/{//plh-page/page/item[@lang = //fl-languages/current-language/@handle]/@handle}/{item[@lang = //fl-languages/current-language/@handle]/@handle}">
			<xsl:value-of select="item[@lang = //fl-languages/current-language/@handle]" />
		</a>
	</li>
</xsl:template>

<xsl:template match="data" mode="ma-button">
	<xsl:value-of select="concat($root, '/', //current-language/@handle, '/')" />
</xsl:template>

<xsl:template name="language-button">
	<xsl:param name="lang" />
	<xsl:choose>
		<xsl:when test="$lang = 'pl'">
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/" class="icon">E</a>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/" class="icon">P</a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="data" mode="js">
	<script>
		$(function() {
			MA.stickyNavSetup({backgroundColor: 'white'});
			
			//Rozwijana lista -> struktura organizacyjna
			var divButtons = $(".div-button")
			divButtons.click(function(e){
				$("."+$(this).data("div")).slideToggle();
			})
		});
	</script>
</xsl:template>

</xsl:stylesheet>