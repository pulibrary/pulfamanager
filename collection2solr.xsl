<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ead="urn:isbn:1-931666-22-9"
   xmlns:local="local.uri" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:pulfa="http://library.princeton.edu/pulfa"
   xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

   <xsl:param name="base-uri" as="xs:string" select="'http://findingaids.princeton.edu'"/>

   <xsl:strip-space elements="*"/> <!--minimize file bloat-->

   <xsl:output indent="yes"/>

   <xsl:include href="lib.xsl"/>

   <xsl:template match="/" as="element()">
      <add allowDups="false">
         <xsl:apply-templates select="pulfa:records"/>
         <!--+
             | We'll have a component as the root when we're only looking at one
             | record. This is really just for debugging.
             +-->
         <xsl:apply-templates select="ead:c"/>
      </add>
   </xsl:template>

   <xsl:template match="pulfa:records">
      <xsl:apply-templates select="ead:archdesc"/>
      <xsl:apply-templates select="ead:c"/>
   </xsl:template>

   <!--+
       | ead:archdesc and ead:c
       +-->

   <xsl:template match="ead:archdesc|ead:c">
      <doc>
         <field name="set">collections</field>
         <xsl:apply-templates select="pulfa:context/pulfa:uri"/>
         <!-- only one of the following two will match -->
         <xsl:choose>
            <xsl:when test="self::ead:c">
               <xsl:apply-templates select="@id" mode="id"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/ead:eadid" mode="id"/>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/pulfa:collection-creators"/>
         <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/ead:unittitle"/>
         <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/pulfa:uri"/>
         <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/ead:eadid"/>
         <xsl:apply-templates select="pulfa:context/pulfa:collectionInfo/ead:sponsor"/>
         <xsl:apply-templates select="@level"/>

         <xsl:apply-templates select="ead:did"/>

         <xsl:apply-templates select="ead:odd"/>

         <xsl:apply-templates select="ead:bioghist"/>

         <xsl:apply-templates select="ead:controlaccess"/>

         <xsl:apply-templates select="ead:index"/>

         <xsl:apply-templates select="ead:descgrp"/>
         <!--+
             | Each of the following is either a child of ead:c or a child of
             | ead:descgrp under ead:archdesc
             +-->
         <xsl:if test="self::ead:c">
            <xsl:apply-templates select="ead:accessrestrict"/>
            <xsl:apply-templates select="ead:altformavail"/>
            <xsl:apply-templates select="ead:arrangement"/>
            <xsl:apply-templates select="ead:bibliography"/>
            <xsl:apply-templates select="ead:custodhist"/>
            <xsl:apply-templates select="ead:note"/>
            <xsl:apply-templates select="ead:originalsloc"/>
            <xsl:apply-templates select="ead:phystech"/>
            <xsl:apply-templates select="ead:processinfo"/>
            <xsl:apply-templates select="ead:relatedmaterial"/>
            <xsl:apply-templates select="ead:scopecontent"/>
            <xsl:apply-templates select="ead:separatedmaterial"/>
            <xsl:apply-templates select="ead:userestrict"/>
         </xsl:if>

      </doc>
   </xsl:template>

   <xsl:template match="ead:descgrp">
      <!-- DACS 3 -->
      <xsl:apply-templates select="ead:arrangement"/>
      <xsl:apply-templates select="ead:scopecontent"/>
      <!-- DACS 4 -->
      <xsl:apply-templates select="ead:accessrestrict"/>
      <xsl:apply-templates select="ead:userestrict"/>
      <xsl:apply-templates select="ead:otherfindaid"/>
      <xsl:apply-templates select="ead:phystech"/>
      <!-- DACS 5 -->
      <xsl:apply-templates select="ead:accruals"/>
      <xsl:apply-templates select="ead:acqinfo"/>
      <xsl:apply-templates select="ead:appraisal"/>
      <xsl:apply-templates select="ead:custodhist"/>
      <!-- DACS 6 -->
      <xsl:apply-templates select="ead:altformavail"/>
      <xsl:apply-templates select="ead:originalsloc"/>
      <xsl:apply-templates select="ead:relatedmaterial"/>
      <xsl:apply-templates select="ead:separatedmaterial"/>
      <!-- DACS 7 -->
      <xsl:apply-templates select="ead:bibliography"/>
      <xsl:apply-templates select="ead:note"/>
      <xsl:apply-templates select="ead:prefercite"/>
      <xsl:apply-templates select="ead:processinfo"/>
   </xsl:template>



   <xsl:template match="@id[parent::ead:c]" mode="id" as="element()">
      <field name="id">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <xsl:template match="@level" as="element()">
      <field name="type">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <xsl:template match="pulfa:uri[parent::pulfa:context]" as="element()">
      <field name="uri">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <xsl:template match="pulfa:uri[parent::pulfa:collectionInfo]" as="element()">
      <!-- we need this so that we can delete all records associated with a collection -->
      <field name="collection-uri">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <!--<xsl:template match="ead:unitid[parent::pulfa:collectionInfo]" as="element()">-->
   <xsl:template match="ead:eadid" as="element()">
      <!-- we need this for sorting and so that we can delete all records associated with a collection -->
      <field name="collection-callno">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:unittitle[parent::pulfa:collectionInfo]" as="element()">
      <!-- we need this so that we can delete all records associated with a collection -->
      <field name="coll-f">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:sponsor[parent::pulfa:collectionInfo]" as="element()">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="pulfa:collection-creators[parent::pulfa:collectionInfo]" as="element()*">
      <xsl:for-each select="ead:*">
         <field name="coll-creator">
            <xsl:value-of select="normalize-space(current())"/>
         </field>
      </xsl:for-each>
   </xsl:template>


   <!--+
       | ead:did
       +-->

   <xsl:template match="ead:did">
      <xsl:apply-templates select="ead:unittitle"/>
      <xsl:apply-templates select="ead:origination"/>
      <xsl:call-template name="do-unitdate"/>

      <xsl:apply-templates select="ead:container"/>
      <xsl:apply-templates select="ead:physdesc"/>
      <xsl:apply-templates select="ead:physloc"/>
      <xsl:apply-templates select="ead:langmaterial"/>
      <xsl:apply-templates select="ead:repository"/>
      <!-- <xsl:if test="ead:dao[@xlink:role eq 'http://www.loc.gov/METS/' or ends-with(@xlink:href, '.pdf')]">-->
      <xsl:if test="ead:dao[contains(@xlink:href, 'http')]">
         <field name="has-digital-content">true</field>
      </xsl:if>
      <field name="container">
         <xsl:value-of>
            <xsl:for-each select="ead:container">
               <!-- <xsl:value-of select="lib:capitalize-first(@type)"/> -->
               <xsl:value-of select="@type"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="current()"/>
               <xsl:if test="position() ne last()">, </xsl:if>
            </xsl:for-each>
         </xsl:value-of>
      </field>
      <xsl:apply-templates select="ead:abstract"/>
   </xsl:template>

   <xsl:template match="ead:odd" as="element()">
      <field name="keyword">
         <xsl:value-of select="*"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:eadid" mode="id" as="element()">
      <field name="id">
         <xsl:value-of select="current()"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:unittitle" as="element()+">
      <xsl:if test="ancestor::ead:c">
         <!-- we don't want to just repeat the collection level title -->
         <field name="context-title">
            <xsl:variable name="ancestors">
               <xsl:value-of separator=". " select="reverse(ancestor::ead:c[last()]/pulfa:context//(pulfa:crumb|pulfa:collectionInfo/ead:unittitle))"/>
            </xsl:variable>
            <xsl:value-of select="normalize-space(concat($ancestors, '. ', current()))"/>
         </field>
      </xsl:if>
      <xsl:variable name="level" as="xs:string" select="(ancestor::ead:c|ancestor::ead:archdesc)[1]/@level"/>
      <field name="{concat($level, '-title')}">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
      <field name="title-sort">
         <xsl:value-of select="if(@altrender) then @altrender else (normalize-space(current()))"/>
      </field>
      <xsl:if test="not(preceding-sibling::ead:unittitle)">
         <field name="title-disp">
            <xsl:value-of select="normalize-space(current())"/>
         </field>
      </xsl:if>
   </xsl:template>

   <xsl:template match="ead:repository" as="element()+">
      <xsl:variable name="level" as="xs:string" select="(ancestor::ead:c|ancestor::ead:archdesc)[1]/@level"/>
      <field name="repository">
         <xsl:value-of select="@id"/>
      </field>
      <field name="repo-f">
         <xsl:value-of select="lib:repo-code-to-label(@id)"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:origination[not(preceding-sibling::ead:origination)]" as="element()*">
      <field name="creator-disp">
         <xsl:value-of select="normalize-space(*[1])"/>
      </field>
      <xsl:next-match/>
   </xsl:template>

   <xsl:template match="ead:origination" as="element()*">
      <xsl:for-each select="*">
         <field name="creator">
            <xsl:value-of select="normalize-space(current())"/>
         </field>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="ead:container">
      <field name="container">
         <xsl:value-of select="concat(@type, ' ', current())"/>
      </field>
   </xsl:template>

   <xsl:template name="do-unitdate">
      <!-- match="ead:unitdate">-->

      <xsl:choose>
         <xsl:when test="ead:unitdate[@type='inclusive'] and count(ead:unitdate[@type='inclusive']) = 1">
            <field name="date-disp">
               <xsl:value-of select="concat(ead:unitdate[@type='inclusive'], ' (inclusive)')"/>
            </field>
            <xsl:variable name="norm-tokens" as="xs:string*" select="tokenize(ead:unitdate[@type='inclusive']/@normal, '/')"/>
            <field name="earliest-date">
               <xsl:value-of select="$norm-tokens[1]"/>
            </field>
            <field name="latest-date">
               <xsl:value-of select="$norm-tokens[last()]"/>
            </field>
         </xsl:when>
         <xsl:when test="ead:unitdate and count(ead:unitdate) = 1">
            <field name="date-disp">
               <xsl:value-of select="concat(ead:unitdate, if (ead:unitdate/@type) then concat(' (', ead:unitdate/@type, ') ') else ())"/>
            </field>
            <xsl:variable name="norm-tokens" as="xs:string*" select="tokenize(ead:unitdate/@normal, '/')"/>
            <field name="earliest-date">
               <xsl:value-of select="$norm-tokens[1]"/>
            </field>
            <field name="latest-date">
               <xsl:value-of select="$norm-tokens[last()]"/>
            </field>
         </xsl:when>
         <xsl:when test="not(ead:unitdate)"/>
         <xsl:otherwise>
            <!-- if there are multiple dates, choose the absolute earliest and absolute latest -->
            <field name="date-disp">
               <xsl:value-of select="string-join(ead:unitdate, ', ')"/>
            </field>
            <field name="earliest-date">
               <xsl:value-of select="min(for $d in ead:unitdate[@normal] return xs:dateTime(tokenize($d/@normal, '/')[1]))"/>
            </field>
            <field name="latest-date">
               <xsl:value-of select="max(for $d in ead:unitdate[@normal] return xs:dateTime(tokenize($d/@normal, '/')[last()]))"/>
            </field>

         </xsl:otherwise>
      </xsl:choose>



   </xsl:template>


   <xsl:template match="ead:physdesc" as="element()*">
      <xsl:if test="ead:extent">
         <field name="extent">
            <xsl:value-of select="string-join(ead:extent, ', ')"/>
         </field>
      </xsl:if>
      <xsl:apply-templates select="ead:dimensions"/>
      <xsl:apply-templates select="ead:physfacet"/>
   </xsl:template>


   <xsl:template match="ead:dimensions">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:physfacet">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!-- we might want this to be boostable? -->
   <xsl:template match="ead:physloc">
      <field name="keyword">
         <xsl:value-of select="lib:physloc-code-to-label(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:langmaterial">
      <xsl:for-each select="ead:language">
         <field name="lang-f">
            <xsl:choose>
               <xsl:when test="@langcode">
                  <xsl:value-of select="lib:lang-code-to-label(@langcode)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="current()"/>
               </xsl:otherwise>
            </xsl:choose>
         </field>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="ead:abstract" as="element()">
      <field name="abstract">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!--+
       | Begin other (i.e. non-ead:did) children of ead:archdesc or ead:c
       +-->

   <xsl:template match="ead:bioghist" as="element()">
      <field name="bioghist">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>


   <!-- DACS 3 -->
   <xsl:template match="ead:scopecontent" as="element()">
      <field name="scope-content">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:arrangement" as="element()*">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!-- DACS 4 -->

   <xsl:template match="ead:accessrestrict">
      <field name="accessrestrict">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:otherfindaid">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:phystech">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:userestrict">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>


   <!-- DACS 5 -->
   <xsl:template match="ead:acqinfo" as="element()">
      <field name="acqinfo">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:accruals">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:appraisal">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:custodhist">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!-- DACS 6 -->
   <xsl:template match="ead:altformavail">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:originalsloc">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:relatedmaterial">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:separatedmaterial">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!-- DACS 7 -->
   <xsl:template match="ead:prefercite">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:processinfo">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:bibliography">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:note">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <!--+
       | ead:controlaccess
       +-->
   <xsl:template match="ead:controlaccess">
      <xsl:apply-templates select="ead:corpname"/>
      <xsl:apply-templates select="ead:famname"/>
      <xsl:apply-templates select="ead:genreform"/>
      <xsl:apply-templates select="ead:geogname"/>
      <xsl:apply-templates select="ead:occupation"/>
      <xsl:apply-templates select="ead:persname"/>
      <xsl:apply-templates select="ead:subject"/>
      <xsl:apply-templates select="ead:title"/>
   </xsl:template>

   <xsl:template match="ead:corpname|ead:famname|ead:geogname|ead:persname" as="element()+">

      <field name="pc-su-f">
         <xsl:value-of select="lib:normalize-subject-heading(current())"/>
      </field>

      <xsl:variable name="dash-tokens" as="xs:string+" select="tokenize(lib:normalize-subject-heading(current()),  '\-{2}')"/>
      <xsl:for-each select="$dash-tokens">
         <xsl:choose>
            <xsl:when test="position() = 1">
               <field name="subject-name">
                  <xsl:value-of select="normalize-space(current())"/>
               </field>
            </xsl:when>
            <xsl:when test="lib:is-date-subdivision(current())"/>
            <xsl:otherwise>
               <field name="subject-topic">
                  <xsl:value-of select="normalize-space(current())"/>
               </field>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="ead:occupation|ead:subject|ead:title[parent::ead:origination]" as="element()+">
      <field name="pc-su-f">
         <xsl:value-of select="lib:normalize-subject-heading(current())"/>
      </field>

      <xsl:variable name="dash-tokens" as="xs:string+" select="tokenize(lib:normalize-subject-heading(current()), '\-{2}')"/>
      <xsl:for-each select="$dash-tokens">
         <!-- Try to catch a few more names by looking at the second token split
              on spaces (i.e., second word). If it's capitalized it's probably a
              name. Catches "United States", most importantly, but will never be
              perfect. -->
         <xsl:variable name="words" as="xs:string+" select="tokenize(lib:strip-punctuation(current()), '\s')"/>
         <xsl:choose>
            <xsl:when test="exists($words[2]) and matches($words[2], '^\p{Lu}')">
               <field name="subject-name">
                  <xsl:value-of select="normalize-space(current())"/>
               </field>
            </xsl:when>
            <xsl:when test="lib:is-date-subdivision(current())"/>
            <xsl:otherwise>
               <field name="subject-topic">
                  <xsl:value-of select="normalize-space(current())"/>
               </field>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="ead:subject[@source eq 'local' and @encodinganalog='690']">
      <field name="topic">
         <xsl:value-of select="@authfilenumber"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:genreform" as="element()+">
      <field name="pc-su-f">
         <xsl:value-of select="lib:normalize-subject-heading(current())"/>
      </field>
      <field name="genre">
         <xsl:value-of select="lib:normalize-subject-heading(current())"/>
      </field>
   </xsl:template>



   <!--+
       | ead:index
       +-->
   <xsl:template match="ead:index">
      <xsl:apply-templates select="ead:indexentry"/>
   </xsl:template>

   <xsl:template match="ead:indexentry">
      <xsl:apply-templates select="ead:name" mode="index"/>
      <xsl:apply-templates select="ead:persname" mode="index"/>
      <xsl:apply-templates select="ead:namegrp/ead:corpname" mode="index"/>
      <xsl:apply-templates select="ead:title" mode="index"/>
      <xsl:apply-templates select="ead:subject" mode="index"/>
      <!-- recursive -->
      <xsl:apply-templates select="ead:indexentry"/>
   </xsl:template>

   <xsl:template match="ead:name" mode="index">
      <field name="name">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:persname" mode="index">
      <field name="name">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:corpname" mode="index">
      <field name="name">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:subject" mode="index">
      <field name="keyword">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>

   <xsl:template match="ead:title" mode="index">
      <field name="index-title">
         <xsl:value-of select="normalize-space(current())"/>
      </field>
   </xsl:template>




</xsl:stylesheet>
