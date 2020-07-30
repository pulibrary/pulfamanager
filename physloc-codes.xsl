<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib"
   xmlns:eac="urn:isbn:1-931666-33-4"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="2.0">

  <xsl:variable name="location-codes">
    <loc code="cotsen">Firestone Library</loc>
    <loc code="ex">Firestone Library</loc>
    <loc code="gax">Firestone Library</loc>
    <loc code="ga">Firestone Library</loc>
    <loc code="mss">Firestone Library</loc>
    <loc code="njpg">Firestone Library</loc>
    <loc code="thx">Firestone Library</loc>
    <loc code="wa">Firestone Library</loc>
    <loc code="hsvc">Firestone Library</loc>
    <loc code="hsvg">Firestone Library</loc>
    <loc code="hsvm">Firestone Library</loc>
    <loc code="hsvr">Firestone Library</loc>
    <loc code="mudd">Mudd Manuscript Library</loc>
    <loc code="rcppa">ReCAP</loc>
    <loc code="rcppf">ReCAP</loc>
    <loc code="rcpph">ReCAP</loc>
    <loc code="rcpxc">ReCAP</loc>
    <loc code="rcpxg">ReCAP</loc>
    <loc code="rcpxm">ReCAP</loc>
    <loc code="rcpxr">ReCAP</loc>
    <loc code="flm">Firestone Library</loc>
    <loc code="st">Engineering Library</loc>
    <loc code="anxb">Annex B</loc>
    <loc code="ppl">Plasma Physics Library</loc>
  </xsl:variable>

   <xsl:variable name="physloc-codes">
     <repo code="eng">Engineering Library</repo>
     <repo code="lae">RBSC</repo>
     <repo code="mss">RBSC</repo>
     <repo code="cotsen">RBSC</repo>
     <repo code="rarebooks">RBSC</repo>
     <repo code="ga">RBSC</repo>
     <repo code="publicpolicy">MUDD</repo>
     <repo code="univarchives">MUDD</repo>
   </xsl:variable>

   <xsl:function name="lib:physloc-repo-to-route" as="xs:string?">
      <xsl:param name="code" as="xs:string"/>
      <xsl:value-of select="$physloc-codes/repo[@code=$code]"/>
   </xsl:function>
  
  <xsl:function name="lib:physloc-code-to-label" as="xs:string?">
    <xsl:param name="code" as="xs:string"/>
    <xsl:value-of select="$location-codes/loc[@code=$code]"/>
  </xsl:function>
</xsl:stylesheet>
