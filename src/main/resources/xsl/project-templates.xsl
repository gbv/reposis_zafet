<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="index-search-form">
    <form
      id="project-searchMainPage"
      action="../servlets/solr/find"
      class="form-inline backlight"
      role="search">
      <div class="input-group input-group-lg w-100">
        <input
          name="condQuery"
          placeholder="{document('i18n:project.index.search.placeholder.default')/i18n/text()}"
          class="form-control search-query"
          id="project-searchInput"
          type="text" />
        <div class="input-group-append">
          <button type="submit" class="btn btn-primary">
            <i class="fa fa-search"></i>
          </button>
        </div>
      </div>
    </form>
  </xsl:template>

</xsl:stylesheet>
