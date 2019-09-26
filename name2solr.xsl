<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ead="urn:isbn:1-931666-22-9"
   xmlns:eac="urn:isbn:1-931666-33-4" xmlns:local="local.uri" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:pulfa="http://library.princeton.edu/pulfa"
   xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

   <xsl:import href="lib.xsl"/>

   <xsl:param name="base-uri" as="xs:string" select="'http://findingaids.princeton.edu'"/>

   <xsl:output indent="yes" method="xml"/>

   <!-- <xsl:include href="lib.xsl"/> -->

   <!-- TODO: dates -->

   <xsl:template match="/" as="element()">
      <add allowDups="false">
         <xsl:apply-templates select="eac:eac-cpf"/>
      </add>
   </xsl:template>

   <xsl:template match="eac:eac-cpf" as="element()">
      <doc>
         <field name="set">names</field>
         <xsl:apply-templates select="eac:control"/>
         <xsl:apply-templates select="eac:cpfDescription"/>
      </doc>
   </xsl:template>

   <xsl:template match="eac:control" as="element()+">
      <field name="id">
         <xsl:value-of select="eac:recordId"/>
      </field>
      <field name="uri">
         <xsl:value-of select="concat($base-uri, '/names/', eac:recordId)"/>
      </field>
   </xsl:template>

   <xsl:template match="eac:cpfDescription">
      <xsl:apply-templates select="eac:identity"/>
      <xsl:apply-templates select="eac:description"/>
      <xsl:apply-templates select="eac:relations"/>
   </xsl:template>

   <xsl:template match="eac:identity" as="element()+">
      <field name="type">
         <xsl:value-of select="eac:entityType"/>
      </field>
      <field name="pref-eac-name-entry">
         <xsl:choose>
            <xsl:when test="exists(eac:nameEntry[eac:authorizedForm])">
               <xsl:value-of select="lib:format-eac-name(eac:nameEntry[eac:authorizedForm][1])"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="lib:format-eac-name(eac:nameEntry[1])"/>
               <xsl:if test="following-sibling::eac:description/eac:existDates"><xsl:text>, </xsl:text>
                  <xsl:choose>
                     <xsl:when test="following-sibling::eac:description/eac:existDates/eac:dateRange">
                        <xsl:value-of select="following-sibling::eac:description/eac:existDates/eac:fromDate"/><xsl:text>-</xsl:text><xsl:value-of select="following-sibling::eac:description/eac:existDates/eac:toDate"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="following-sibling::eac:description/eac:existDates/eac:date"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </field>
      <!-- and all forms go in the index -->
      <xsl:for-each select="eac:nameEntry">
         <field name="eac-name-entry">
            <xsl:value-of select="lib:format-eac-name(current())"/>
         </field>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="eac:description">
      <xsl:apply-templates select="eac:occupations"/>

      <field name="bioghist">
         <xsl:for-each select="eac:biogHist">
            <xsl:variable name="value">
               <xsl:apply-templates/>
            </xsl:variable>
            <xsl:value-of select="normalize-space($value)"/>
         </xsl:for-each>
      </field>
   </xsl:template>

   <xsl:template match="eac:occupations">
      <xsl:apply-templates select="eac:occupation"/>
   </xsl:template>

   <xsl:template match="eac:occupation">
      <field name="occu-f">
         <xsl:value-of select="eac:term"/>
      </field>
      <field name="occupation">
         <xsl:variable name="value">
            <xsl:apply-templates select="eac:term"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="eac:descriptiveNote"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="eac:citation"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="eac:placeEntry"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="eac:dateRange|eac:date|eac:dateSet" mode="string"/>
         </xsl:variable>
         <xsl:value-of select="normalize-space($value)"/>
      </field>
   </xsl:template>

<!--   <xsl:template match="eac:biogHist">
      <field name="bioghist">
         <xsl:variable name="value">
            <xsl:apply-templates/>
         </xsl:variable>
         <xsl:value-of select="normalize-space($value)"/>
      </field>
   </xsl:template>-->

   <xsl:template match="eac:chronList">
      <xsl:apply-templates select="eac:chronItem"/>
   </xsl:template>

   <xsl:template match="eac:chronItem">
      <xsl:value-of separator=" ">
         <xsl:apply-templates select="eac:event|eac:placeEntry"/>
      </xsl:value-of>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="eac:dateRange|eac:date|eac:dateSet" mode="string"/>
      <xsl:text> </xsl:text>
   </xsl:template>


   <xsl:template match="eac:relations">
      <xsl:if test="eac:resourceRelation[@xlink:role eq 'image/jpeg']">
         <field name="eac-img-url">
            <xsl:value-of select="eac:resourceRelation[@xlink:role eq 'image/jpeg']/@xlink:href"/>
         </field>
      </xsl:if>
   </xsl:template>

   <!-- overide imports -->
   <xsl:template match="eac:p">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="eac:abstract">
      <xsl:apply-templates/>
   </xsl:template>




</xsl:stylesheet>
