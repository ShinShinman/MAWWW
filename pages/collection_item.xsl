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
<xsl:include href="../utilities/_image-header.xsl"/>
<xsl:include href="../utilities/_collection-header.xsl"/>
<xsl:include href="../utilities/_lightbox.xsl"/>

<xsl:template match="data">
	<section class="coll collection-item">
		<xsl:call-template name="collection-header" />
		<xsl:apply-templates select="collection-item-2/item" />
	</section>
	<div class="lightbox">
		<button class="icon close">×</button>
		<div class="swiper-lightbox">
			<div class="swiper-wrapper">
				<xsl:apply-templates select="collection-item-2/item/obrazy/item" mode="lightbox" />
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="collection-nav/page">
	<li>
		<a href="{$root}/{//fl-languages/current-language/@handle}/{//plh-page/page/item[@lang = //fl-languages/current-language/@handle]/@handle}/{item[@lang = //fl-languages/current-language/@handle]/@handle}/">
			<xsl:value-of select="item[@lang = //fl-languages/current-language/@handle]" />
		</a>
	</li>
</xsl:template>

<xsl:template match="collection-item-2/item">
	<article>
		<xsl:choose>
			<xsl:when test="//current-language/@handle = 'pl'">
				<h1 class="donthyphenate object-name"><xsl:value-of select="nazwa-obiektu" /></h1>
			</xsl:when>
			<xsl:otherwise>
				<h1 class="donthyphenate object-name"><xsl:value-of select="nazwa-obiektu-tlumaczenie/item/nazwa-obiektu" /></h1>
			</xsl:otherwise>
		</xsl:choose>
		<h2 class="donthyphenate"><xsl:apply-templates select="architekci/item/autorzy/architekt" /></h2>
		<h3><xsl:value-of select="datowanie" /></h3>

		<div class="swiper-container">
			<div class="swiper-wrapper">
				<xsl:apply-templates select="obrazy/item" />
			</div>
			<!-- Przewijanie galerii -->
			<!-- Nie działa z ligtboxem -->
			<!-- <xsl:if test="count(obrazy/item) > 1">
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
			</xsl:if> -->
		</div>
		<xsl:if test="count(obrazy/item) > 1">
			<div class="swiper-pagination"><span class="bullet" /></div>
		</xsl:if>

		<xsl:apply-templates select="audiodeskrypcja/data" />

		<ul class="project-description donthyphenate">
			<li><strong><xsl:value-of select="miejscowosc" /></strong></li>
			<li><xsl:value-of select="adres" /><span class="cyrillic"><xsl:text> </xsl:text><xsl:value-of select="adres-cyrylica" /></span></li>
			<ul class="project-details">
				<xsl:choose>
					<xsl:when test="//current-language/@handle = 'pl'">
						<li><xsl:value-of select="zawartosc-projektu" /></li>
						<li><xsl:value-of select="uwagi" /></li>
					</xsl:when>
					<xsl:otherwise>
						<li><xsl:value-of select="zawartosc-projektu-tlumaczenie/item/zawartosc-projektu" /></li>
						<li><xsl:value-of select="uwagi-tlumaczenie/item/uwagi" /></li>
					</xsl:otherwise>
				</xsl:choose>
			</ul>
			<ul class="project-details">
				<li class="label"><span><xsl:value-of select="//dictionary//word[@handle-en = 'inventory-number']" /></span></li>
				<li class="signature"><xsl:value-of select="sygnatura" /></li>
				<li><xsl:apply-templates select="tworzywo-link/item" /></li>
				<li><xsl:apply-templates select="technika-link/item" /></li>
				<li><xsl:value-of select="wymiary" /></li>
			</ul>
		</ul>
	</article>
</xsl:template>

<xsl:template match="architekci/item/autorzy/architekt">
	<xsl:value-of select="." />
	<xsl:if test="../../following-sibling::*"><xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="audiodeskrypcja/data">
	<div class="audio">
		<audio controls="">
			<source src="http://ma.wroc.pl/workspace/t.php?link={asset-url}" type="audio/wav" />
			<p>Ta przeglądarka nie obsługuje elementu audio. <a href="{full-url}">Link do pliku dźwiekowego</a>.</p>
		</audio>
		<!-- <a href="{$workspace}/t.php?link={asset-url}" target="_blank" class="audio-link">
			<svg x="0px" y="0px" viewBox="0 0 12 12" enable-background="new 0 0 12 12">
				<g>
					<polygon points="10.7,10.7 1.3,10.7 1.3,1.3 4.2,1.3 4.2,0 0,0 0,12 12,12 12,7.8 10.7,7.8 	"/>
					<polygon points="6,0 6,1.3 9.7,1.3 5.5,5.5 6.5,6.5 10.7,2.3 10.7,6 12,6 12,0 	"/>
				</g>
			</svg>
		</a> -->
	</div>
</xsl:template>

<xsl:template match="tworzywo-link/item">
	<xsl:choose>
		<xsl:when test="//current-language/@handle = 'pl'">
			<xsl:value-of select="tworzywo/tworzywo" />
			<xsl:if test="./following-sibling::*"><xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="tworzywo/tlumaczenie/item/tworzywo" />
			<xsl:if test="./following-sibling::*"><xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="technika-link/item">
	<xsl:choose>
		<xsl:when test="//current-language/@handle = 'pl'">
			<xsl:value-of select="technika/technika" />
			<xsl:if test="./following-sibling::*"><xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="technika/tlumaczenie/item/technika" />
			<xsl:if test="./following-sibling::*"><xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="obrazy/item">
	<xsl:variable name="width" select="floor(obraz/width div (obraz/height div 540))" />
	<div class="swiper-slide">
		<img src="http://ma.wroc.pl/workspace/t.php?link={obraz/data/thumbnails/item[key='collection-item']/relative-url}"
			srcset="http://ma.wroc.pl/workspace/t.php?link={obraz/data/thumbnails/item[key='collection-item']/relative-url},
							http://ma.wroc.pl/workspace/t.php?link={obraz/data/thumbnails/item[key='collection-item_x2']/relative-url} 2x,
							http://ma.wroc.pl/workspace/t.php?link={obraz/data/thumbnails/item[key='collection-item_x3']/relative-url} 3x"
			data-src="{$workspace}/images/blank.gif"
			width="{$width}" height="540" data-test="{$width}">
			<xsl:attribute name="alt">
				<xsl:apply-templates select="." mode="alt" />
			</xsl:attribute>
		</img>
	</div>
</xsl:template>

<xsl:template match="obrazy/item" mode="lightbox">
	<div class="swiper-slide">
		<div class="swiper-zoom-container">
			<img src="http://ma.wroc.pl/workspace/t.php?link={obraz/data/asset-url}" 
				loading="lazy"
				class="swiper-lazy">
				<!-- <xsl:attribute name="alt">
					<xsl:apply-templates select="." mode="alt" />
				</xsl:attribute> -->
			</img>
			<div class="swiper-lazy-preloader swiper-lazy-preloader-white"></div>
		</div>
	</div>
</xsl:template>

<xsl:template match="obrazy/item" mode="alt">
	<xsl:variable name="autorzy">
		<xsl:apply-templates select="//architekci/item/autorzy/architekt" />
	</xsl:variable>
	<xsl:value-of select="concat($autorzy, '; ', ../../nazwa-obiektu, '; ', ../../datowanie)" />
</xsl:template>

<!-- <xsl:template match="collection-related-items">
	<section class="relaed-items">
		<h1><xsl:value-of select="//dictionary//word[@handle-en = 'related-items']" /></h1>
		<div class="bricks-container">
			<xsl:apply-templates select="//collection-related-items/entry[not(signature = //collection-item/entry/signature)]" />
		</div>
	</section>
</xsl:template>

<xsl:template match="collection-related-items/entry">
	<xsl:call-template name="collection-brick" />
</xsl:template> -->

<xsl:template match="data" mode="ma-button">
	<xsl:value-of select="concat($root, '/', //current-language/@handle, '/')" />
</xsl:template>

<xsl:template name="language-button">
	<xsl:param name="lang" />
	<xsl:variable name="sig">
		<xsl:if test="$signature">
			<xsl:value-of select="$signature" /><xsl:text>/</xsl:text>
		</xsl:if>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$lang = 'pl'">
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/{$sig}" class="icon">E</a>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$root}/{//supported-languages/item[@handle != //current-language/@handle]/@handle}/{//plh-page/page/item[@lang != //current-language/@handle]/@handle}/{//plh-page/page/page/item[@lang != //current-language/@handle]/@handle}/{$sig}" class="icon">P</a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="data" mode="js">
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	<script>
		$(function() {
			MA.stickyNavSetup({backgroundColor: 'transparent'});
			MA.api.setNavBackground('.offset');

			var viewPortWidth = document.documentElement.clientWidth;
			var swiperSlides = $('.swiper-container .swiper-slide');
			var smallScreen = (<xsl:text disable-output-escaping="yes">viewPortWidth &lt; 770</xsl:text>) ? true : false;

			var swiperOptions = {
				<!-- zoom: true, -->
				speed: 500,
				slidesPerView: 'auto',
				spaceBetween: 30,
				centerInsufficientSlides: true,
				on: {
					click: lightbox
				}
			};

			<xsl:call-template name="lightbox-js" />

			if(<xsl:text disable-output-escaping="yes">(swiperSlides.length &gt; 1) &amp;&amp; !smallScreen</xsl:text>) {
				$.extend(swiperOptions,
					{
						<!-- slidesOffsetBefore: (<xsl:text disable-output-escaping="yes">viewPortWidth &lt; 1132</xsl:text>) ? 150 : 250, -->
						<!-- loop: true, -->
						<!-- navigation: {
							nextEl: '.swiper-button-next',
							prevEl: '.swiper-button-prev',
						}, -->
						pagination: {
							el: '.swiper-pagination',
							clickable: true
						}
					}
				);
			}
			var gallery = new Swiper('.swiper-container', swiperOptions);
			<!-- Poniższy fragment odpowiada za blokowanie pobierania obrazków -->
			<!-- $('.swiper-slide img').bind('contextmenu', function(e) {
				return false;
			}); -->
			<!-- END -->

			<!-- Dodaje base64 src w galerii -->
			<!-- $('.coll .swiper-slide img').each(function(i, el) {
				const img = $(this);
				const imgID = `/ma-kolekcja/${$(el).data('src').split('ma-kolekcja/').pop()}`;
				const fetchURL = `<xsl:value-of select="$root" />/collection/image/?img=${imgID}`;
				$.get(fetchURL, function(data) {
					img.attr('src', data);
				})
			}) -->

			var lazyImgs = $('img.lazy');
			lazyImgs.lazyload({
				threshold: 1000,
				failure_limit : 1000
			});

			const objectName = document.querySelector('.object-name');
			objectName.innerHTML = MA.api.ziomy(objectName.innerText);

		});

		$(window).load(function() {
			MA.iS();
		});
	</script>
	<xsl:call-template name="collection-header-js" />
</xsl:template>

<xsl:template match="data" mode="meta-tags">
	<meta name="test" content="" />
	<link href="https://fonts.googleapis.com/css?family=Roboto:500" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</xsl:template>

</xsl:stylesheet>
