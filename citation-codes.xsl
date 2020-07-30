<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib"
   xmlns:eac="urn:isbn:1-931666-33-4"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="2.0">

   <xsl:variable name="citation-codes">
     <repo code="eng">Technical and Scientific Reports, Engineering Library</repo>
     <repo code="lae">Latin American Ephemera Collections</repo>
     <repo code="cotsen">Cotsen Children's Library, Department of Rare Books and Special Collections</repo>
     <repo code="mss">Manuscripts Division, Department of Rare Books and Special Collections</repo>
     <repo code="publicpolicy">Public Policy Papers, Department of Rare Books and Special Collections</repo>
     <repo code="univarchives">Princeton University Archives, Department of Rare Books and Special Collections</repo>
     <repo code="rarebooks">Rare Book Division, Department of Rare Books and Special Collections</repo>
     <repo code="ga">Graphic Arts Collection, Department of Rare Books and Special Collections</repo>
   </xsl:variable>
   
   <xsl:function name="lib:repo-code-to-citation" as="xs:string?">
      <xsl:param name="code" as="xs:string"/>
      <xsl:value-of select="$citation-codes/repo[@code=$code]"/>
   </xsl:function>   
</xsl:stylesheet>
