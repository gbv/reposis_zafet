<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">
    <div id="header_box" class="container">
      <div class="row">
        <div class="col-12 col-sm-6 order-2 order-sm-1">
          <div class="project_logo_box">
            <a href="https://www.hdba.de/" class="project_logo_link--header">
              <img src="{$WebApplicationBaseURL}images/logos/logo_hdba.svg" alt="HdBA Logo" />
              <img src="{$WebApplicationBaseURL}images/logos/logo_text.svg" alt="HdBA Slogan" />
            </a>
          </div>
        </div>
        <div class="col order-1 order-sm-2 mb-3 mb-sm-0">
          <div class="mir-prop-nav">
            <nav>
              <ul class="navbar-nav ml-auto flex-row">
                <xsl:call-template name="mir.loginMenu" />
                <xsl:call-template name="mir.languageMenu" />
              </ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav">
      <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light">
          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav-collapse-box"
            aria-controls="mir-main-nav-collapse-box"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div id="mir-main-nav-collapse-box" class="collapse navbar-collapse mir-main-nav__entries">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'brand'" />
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='collections']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
            <form
              action="{$WebApplicationBaseURL}servlets/solr/find"
              class="searchfield_box form-inline my-2 my-lg-0"
              role="search">
              <input
                name="condQuery"
                placeholder="{document('i18n:mir.navsearch.placeholder')/i18n/text()}"
                class="form-control mr-sm-2 search-query"
                id="searchInput"
                type="text"
                aria-label="Search" />
              <xsl:choose>
                <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
                  <input name="owner" type="hidden" value="createdby:*" />
                </xsl:when>
                <xsl:when test="not($CurrentUser='guest')">
                  <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                </xsl:when>
              </xsl:choose>
              <button type="submit" class="btn btn-primary my-2 my-sm-0">
                <i class="fas fa-search"></i>
              </button>
            </form>
          </div>
        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="footer-top">
      <div class="container ">
        <div class="row">
          <div class="col">
            <a href="https://www.hdba.de/" class="project_logo_link--footer">
              <img src="{$WebApplicationBaseURL}images/logos/logo_hdba.svg" alt="HdBA Logo" />
              <img src="{$WebApplicationBaseURL}images/logos/logo_text.svg" alt="HdBA Slogan" />
            </a>
          </div>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="project-footer-menu">
        <div class="container">
          <div class="row">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3 order-2 order-sm-2 mt-3 mt-sm-0">
              <ul class="nav flex-column flex-md-row flex-lg-column">
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
              </ul>
            </div>
            <div class="col-12 col-sm-6 col-md-8 col-lg-9 order-1 order-sm-2">
              <p>
                Das Repositorium open HdBA stellt die Publikationen der Hochschule als Open Access im Volltext und mit
                Hochschulbibliographie zur Verfügung. Die Publikationen sind für Suchmaschinen, Datenbanken und
                archivierende Institutionen zugänglich und können zuverlässig zitiert werden. Damit möchte die HdBA
                ihren Beitrag zum freien Zugang zu wissenschaftlichen Erkenntnissen leisten.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />
    <xsl:variable name="menuItem" select="$loaded_navigation_xml/menu[@id=$menuID]/item" />
    <xsl:variable name="activeClass">
      <xsl:choose>
        <xsl:when test="$menuItem/@href = $browserAddress">
          <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <li class="nav-item {$activeClass}">
      <xsl:variable name="fullUrl">
        <xsl:call-template name="resolveFullUrl">
          <xsl:with-param name="link" select="$menuItem/@href" />
        </xsl:call-template>
      </xsl:variable>
      <a id="{$menuID}" href="{$fullUrl}" class="nav-link">
        <xsl:apply-templates select="$menuItem" mode="linkText" />
      </a>
    </li>
  </xsl:template>

  <xsl:template name="resolveFullUrl">
    <xsl:param name="link" />
    <xsl:param name="appBaseUrl" select="$WebApplicationBaseURL" />
    <xsl:choose>
      <xsl:when test="starts-with($link,'http:')
                      or starts-with($link,'https:')
                      or starts-with($link,'mailto:')
                      or starts-with($link,'ftp:')">
        <xsl:value-of select="$link" />
      </xsl:when>
      <xsl:when test="starts-with($link,'/')">
        <xsl:choose>
          <xsl:when test="substring($appBaseUrl, string-length($appBaseUrl), 1) = '/'">
            <xsl:value-of
              select="concat(substring($appBaseUrl, 1, string-length($appBaseUrl) - 1), $link)" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($appBaseUrl, $link)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="substring($appBaseUrl, string-length($appBaseUrl), 1) = '/'">
            <xsl:value-of select="concat($appBaseUrl, $link)" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($appBaseUrl, '/', $link)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="document('version:full')/version/text()" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
