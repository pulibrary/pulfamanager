<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns="urn:isbn:1-931666-22-9"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ead="urn:isbn:1-931666-22-9"
   xmlns:local="local.uri" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:pulfa="http://library.princeton.edu/pulfa" xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

   <xsl:param name="base-uri" as="xs:string" select="'http://findingaids.princeton.edu'"/>
   <xsl:param name="scope" as="xs:string" select="'source'"/>
   <xsl:param name="component-id" as="xs:string?"/>

   <!-- send trace messages to wrapper.log ? -->
   <xsl:variable name="DEBUG" as="xs:boolean" select="false()"/>
   <!-- used to detemine whether a container element represents a range -->
   <xsl:variable name="CONTAINER_RANGE_REGEX" as="xs:string" select="'\s?\-\s?|\s+to\s+|\s?,\s?'"/>
   <!-- default index date -->
   <xsl:variable name="DEFAULT_DATE" select="xs:dateTime('0001-01-01T00:00:00Z')" as="xs:dateTime"/>


   <xsl:output indent="no"/>	<!--remove indentation to reduce file bloat-->
   <xsl:strip-space elements="*"/>

   <xsl:variable name="address"
      select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:address/ead:addressline[1]"/>
   <xsl:variable name="repository" select="lower-case(/ead:ead/ead:archdesc/ead:did/ead:repository)"/>
   <xsl:variable name="repoId" as="xs:string"
      select="/ead:ead/ead:archdesc/ead:did/ead:repository/@id"/>
   <xsl:variable name="eadid" select="normalize-space(/ead:ead/ead:eadheader/ead:eadid)"/>
   <xsl:variable name="collunitid1"
      select="normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1])"/>
   <xsl:variable name="origination" select="/ead:ead/ead:archdesc/ead:did/ead:origination[1]"/>
   <xsl:variable name="originationlabel"
      select="/ead:ead/ead:archdesc/ead:did/ead:origination[1]/@label"/>
   <xsl:variable name="qual-component-id" as="xs:string"
      select="if ($component-id) then $component-id else $eadid"/>
   <xsl:variable name="containermap"
      select="//ead:did[ead:container]/concat(./ead:container[1]/@type,./ead:container[1],./ead:container[2][not(contains(lower-case(@type),'reel'))]/@type,./ead:container[2][not(contains(lower-case(@type),'reel'))],'#')"/>

   <xsl:template match="/" mode="#all">
      <xsl:choose>
         <xsl:when test="$component-id">
            <xsl:apply-templates select=".//ead:c[@id eq $component-id]"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates select="ead:ead"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="ead:ead" as="element()" mode="#all">
      <xsl:choose>
         <xsl:when test="$scope eq 'source'">
            <ead xmlns="urn:isbn:1-931666-22-9" xmlns:xlink="http://www.w3.org/1999/xlink"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:schemaLocation="urn:isbn:1-931666-22-9 http://www.loc.gov/ead/ead.xsd"
               audience="external">
               <xsl:copy-of select="*"/>
            </ead>
         </xsl:when>
         <xsl:when test="$scope eq 'set'">
            <pulfa:records xmlns="urn:isbn:1-931666-22-9">
               <xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
               <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>
               <xsl:apply-templates select="ead:archdesc"/>
            </pulfa:records>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates select="ead:archdesc"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="ead:dsc" mode="#all">
      <dsc>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates select="ead:c" mode="#current"/>
      </dsc>
   </xsl:template>

<!-- Saxon says this is refundant with the above -->
<!--   <xsl:template match="ead:dsc" mode="record">
      <dsc>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates select="ead:c" mode="record"/>
      </dsc>
   </xsl:template>-->

   <!--
      This predicate waas on ead:c before the data was cleaned up.
      [@level= ('otherlevel', 'item') or exists(ead:c) or
      exists(ead:did[ead:unitid|ead:dao|ead:daogrp|ead:container]) or
      exists(ead:dao) or
      count(*) > 3] -->
   <xsl:template
      match="ead:archdesc|ead:dsc[@type='combined']//ead:c[@level= ('otherlevel', 'item') or exists(ead:c) or
      exists(ead:did) or exists(ead:dao) or
      count(*) > 3] "
      as="element()*">
      <xsl:choose>
         <xsl:when test="$scope eq 'source'">
            <xsl:copy-of select="current()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{local-name()}" namespace="urn:isbn:1-931666-22-9"
               exclude-result-prefixes="#all">
               <xsl:namespace name="xlink">http://www.w3.org/1999/xlink</xsl:namespace>
               <xsl:namespace name="xsi">http://www.w3.org/2001/XMLSchema-instance</xsl:namespace>
               <xsl:namespace name="pulfa">http://library.princeton.edu/pulfa</xsl:namespace>
               <xsl:copy-of select="@*"/>
               <xsl:variable name="uniq-id" as="xs:string?"
                  select="if (@id) then tokenize(@id, '_')[last()] else ()"/>
               <pulfa:context>
                  <pulfa:uri>
                     <xsl:value-of
                        select="concat($base-uri, '/collections/', $eadid, if ($uniq-id) then concat('/', $uniq-id) else ())"
                     />
                  </pulfa:uri>
                  <xsl:call-template name="do-breadcrumbs"/>
                  <xsl:call-template name="do-collectionInfo"/>

                  <xsl:if test="self::ead:c">
                     <xsl:call-template name="do-request"/>
                  </xsl:if>
               </pulfa:context>

               <xsl:apply-templates select="ead:did"/>

               <xsl:copy-of
                  select="*[not(self::ead:did or self::ead:dsc or self::ead:c or self::ead:controlaccess)]"/>

               <xsl:if test="not(ead:accessrestrict)">
                  <xsl:call-template name="do-accessrestrict"/>
               </xsl:if>

               <xsl:call-template name="do-controlaccess"/>

               <xsl:for-each select="ead:dsc[@type='combined']">
                  <xsl:apply-templates select="current()" mode="record"/>
               </xsl:for-each>

               <xsl:for-each select="ead:c">
                  <xsl:apply-templates select="current()" mode="record"/>
               </xsl:for-each>

               <!--<xsl:for-each select=".[not(ead:c)]">
                  <dsc type='combined'>
                     <xsl:apply-templates select="current()" mode="record"/>
                  </dsc>
               </xsl:for-each>-->

               <!--<xsl:for-each select="ead:did/ancestor::ead:c[../ead:c[1]]">
                  <foo>
                  <xsl:apply-templates select="current()" mode="record"/>
                  </foo>
               </xsl:for-each>-->


               <!--<xsl:for-each select="ead:dsc[@type='othertype']">
                  <xsl:apply-templates select="current()" mode="record"/>
               </xsl:for-each>-->

               <xsl:copy-of select="/ead:ead//ead:dsc[@type='othertype']"/>

            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>


      <xsl:if test="$scope eq 'set'">
         <xsl:apply-templates select="ead:dsc/ead:c"/>
         <xsl:apply-templates select="ead:c"/>
      </xsl:if>

   </xsl:template>

   <!-- copies all of the elements of a c except its child c -->
   <!--   <xsl:template
      match="ead:c[@level= ('otherlevel', 'item') or exists(ead:c) or
      exists(ead:did[ead:unitid|ead:dao|ead:daogrp|ead:container]) or
      exists(ead:dao) or
      count(*) > 3]"
      as="element()*" mode="record">-->
   <xsl:template match="ead:c" as="element()*" mode="record">

      <xsl:element name="{local-name()}" namespace="urn:isbn:1-931666-22-9"
         exclude-result-prefixes="#all">
         <xsl:attribute name="hasChildComponents" select="exists(ead:c)"/>

         <xsl:copy-of select="@*"/>

         <xsl:variable name="uniq-id" as="xs:string?"
            select="if (@id) then tokenize(@id, '_')[last()] else ()"/>
         <pulfa:context>
            <pulfa:uri>
               <xsl:value-of
                  select="concat($base-uri, '/collections/', $eadid, if ($uniq-id) then concat('/', $uniq-id) else ())"
               />
            </pulfa:uri>
            <xsl:if test="self::ead:c">
               <xsl:call-template name="do-request"/>
            </xsl:if>
         </pulfa:context>
         <xsl:apply-templates select="ead:did" mode="record"/>

         <xsl:copy-of select="*[not(self::ead:did or self::ead:c)]"/>

      </xsl:element>

   </xsl:template>


   <xsl:template match="ead:did" mode="record">
      <did>
         <xsl:copy-of select="@*"/>
         <xsl:call-template name="do-dates"/>
         <xsl:copy-of select="*[not(self::ead:unitdate)]"/>
      </did>
   </xsl:template>


   <xsl:template match="ead:did">
      <did>
         <xsl:copy-of select="@*"/>
         <xsl:call-template name="do-title"/>
         <xsl:call-template name="do-origination"/>
         <xsl:call-template name="do-dates"/>
         <xsl:call-template name="do-language"/>
         <xsl:call-template name="do-physloc"/>
         <xsl:call-template name="do-repository"/>

         <xsl:copy-of
            select="*[not(self::ead:controlaccess or
                          self::ead:langmaterial or
                          self::ead:unitdate or
                          self::ead:unittitle or
                          self::ead:origination or
                          self::ead:physloc or
                          self::ead:repository)]"/>

      </did>
   </xsl:template>

   <xsl:template name="do-collectionInfo">
      <pulfa:collectionInfo>
         <pulfa:ARK>
            <xsl:value-of select="/ead:ead/ead:eadheader/ead:eadid/@url"/>
         </pulfa:ARK>
         <pulfa:uri>
            <xsl:value-of select="concat($base-uri, '/collections/', $eadid)"/>
         </pulfa:uri>
         <xsl:if test="self::ead:c">
            <pulfa:collection-creators>
               <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:origination[1]/*"/>
            </pulfa:collection-creators>
         </xsl:if>
         <xsl:if
            test="self::ead:archdesc and /ead:ead[1]/ead:eadheader[1]/ead:filedesc[1]/ead:titlestmt[1]/ead:sponsor">
            <xsl:copy-of
               select="/ead:ead[1]/ead:eadheader[1]/ead:filedesc[1]/ead:titlestmt[1]/ead:sponsor"/>
         </xsl:if>
         <xsl:copy-of select="/ead:ead[1]/ead:eadheader[1]/ead:eadid"/>
         <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:unittitle"/>
         <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:unitid"/>
         <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:unitdate"/>
         <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:physdesc[1]/ead:extent"/>
      </pulfa:collectionInfo>
   </xsl:template>


   <xsl:template name="do-language">
      <xsl:choose>
         <xsl:when test="ead:langmaterial">
            <xsl:copy-of select="ead:langmaterial"/>
         </xsl:when>
         <xsl:when test="ancestor::ead:c[ead:did/ead:langmaterial]">
            <xsl:copy-of
               select="ancestor::ead:c[ead:did/ead:langmaterial][1]/ead:did/ead:langmaterial"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="/ead:ead/ead:archdesc/ead:did/ead:langmaterial"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="ead:container" as="xs:string" mode="designation">
      <xsl:value-of>
         <xsl:value-of select="normalize-space(@type)"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="current()"/>
      </xsl:value-of>
   </xsl:template>


   <!-- TODO: will need enhancement to resolve codes to text -->
   <xsl:template name="do-physloc">
      <!-- context is ead:did -->
      <xsl:choose>
         <xsl:when test="ead:physloc">
            <xsl:copy-of select="ead:physloc"/>
         </xsl:when>
         <xsl:when test="ancestor::ead:c[ead:did/ead:physloc]">
            <xsl:copy-of select="ancestor::ead:c[ead:did/ead:physloc][1]/ead:did/ead:physloc"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:physloc"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- TODO: will need enhancement to resolve codes to text -->
   <xsl:template name="do-repository">
      <!-- context is ead:did -->
      <xsl:choose>
         <xsl:when test="ead:repository">
            <xsl:copy-of select="ead:repository"/>
         </xsl:when>
         <xsl:when test="ancestor::ead:c[ead:did/ead:repository]">
            <xsl:copy-of select="ancestor::ead:c[ead:did/ead:repository][1]/ead:did/ead:repository"
            />
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="/ead:ead[1]/ead:archdesc[1]/ead:did[1]/ead:repository"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="do-controlaccess" as="element()">
      <!-- context is c -->
      <controlaccess>
         <xsl:copy-of select="ead:controlaccess/*"/>
         <!-- RH edit 10/18/2012 -->
         <!--<xsl:copy-of select="ancestor::ead:archdesc/ead:controlaccess/ead:subject[@encodinganalog eq '690']"/>-->
      </controlaccess>

   </xsl:template>



   <xsl:template name="do-accessrestrict" as="element()+">
      <xsl:choose>
         <xsl:when test="ead:accessrestrict">
            <xsl:copy-of select="ead:accessrestrict"/>
         </xsl:when>
         <xsl:when test="exists(ancestor::ead:c/ead:accessrestrict)">
            <xsl:copy-of select="ancestor::ead:c[ead:accessrestrict][1]/ead:accessrestrict"/>
         </xsl:when>
         <xsl:when test="//ead:descgrp[@id eq 'dacs4']/ead:accessrestrict">
            <xsl:copy-of select="//ead:descgrp[@id eq 'dacs4']/ead:accessrestrict"/>
         </xsl:when>
         <xsl:otherwise>
            <accessrestrict>
               <p>No access restrictions have been specified.</p>
            </accessrestrict>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template name="do-origination" as="element()*">
      <xsl:copy-of select="ead:origination"/>
   </xsl:template>


   <xsl:function name="local:quantmat-from-range" as="xs:string">
      <xsl:param name="container" as="element()"/>
      <xsl:variable name="container-tokens" as="xs:string+"
         select="tokenize($container, $CONTAINER_RANGE_REGEX)"/>

      <xsl:value-of>
         <xsl:choose>
            <xsl:when
               test="every $token in $container-tokens satisfies $token castable as xs:integer">
               <xsl:variable name="unit-ints" as="xs:integer+"
                  select="for $t in $container-tokens return xs:integer($t)"/>
               <xsl:value-of select="max($unit-ints) - min($unit-ints) + 1"/>
            </xsl:when>
            <xsl:otherwise>Multiple</xsl:otherwise>
         </xsl:choose>

         <xsl:value-of select="concat(' ', $container/@type)"/>
         <xsl:value-of select="if (matches($container/@type, 'Box', 'i')) then 'es' else 's'"/>
      </xsl:value-of>
   </xsl:function>



   <xsl:function name="local:attempt-year-from-string" as="xs:string*">
      <xsl:param name="string" as="xs:string"/>
      <xsl:variable name="fourdigitchunks" as="xs:integer*">
         <xsl:analyze-string select="$string" regex="\d{{4}}">
            <xsl:matching-substring>
               <xsl:if test="current() castable as xs:gYear">
                  <xsl:value-of select="xs:integer(current())"/>
               </xsl:if>
            </xsl:matching-substring>
         </xsl:analyze-string>
      </xsl:variable>
      <xsl:value-of select="$fourdigitchunks[. gt 0999 and . lt  2015]"/>
   </xsl:function>

   <xsl:template name="do-title" as="element()+">
      <xsl:choose>
         <xsl:when test="ead:unittitle">
            <xsl:copy-of select="ead:unittitle"/>
         </xsl:when>
         <xsl:when test="ead:unitdate">
            <unittitle>
               <xsl:value-of
                  select="string-join(for $d in ead:unitdate return normalize-space($d), ', ')"/>
            </unittitle>
         </xsl:when>
         <xsl:otherwise>
            <unittitle>Untitled</unittitle>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template as="element()+" name="do-dates">
      <!-- context is ead:did -->
      <!-- puts solr-normalized dates in @normal, looks down, then up -->
      <xsl:choose>
         <!-- self -->
         <xsl:when test="ead:unitdate">
            <xsl:apply-templates select="ead:unitdate"/>
         </xsl:when>
         <!-- min and max years of below -->
         <xsl:when
            test="parent::ead:c//descendant::ead:c[ead:did/ead:unitdate[matches(., '\d{3,4}')]]">
            <xsl:variable name="earliest">
               <xsl:variable name="all-early" as="xs:string*">
                  <xsl:for-each select="parent::ead:c//descendant::ead:c/ead:did/ead:unitdate">
                     <xsl:variable name="first-token" select="normalize-space(tokenize(., '\-')[1])"/>
                     <xsl:if
                        test="$first-token castable as xs:integer and matches(normalize-space($first-token), '^\d{3,4}$')">
                        <xsl:value-of select="xs:integer(normalize-space($first-token))"/>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:variable>
               <xsl:value-of select="min($all-early)"/>
            </xsl:variable>

            <xsl:variable name="latest">
               <xsl:variable name="all-late" as="xs:string*">
                  <xsl:for-each select="parent::ead:c//descendant::ead:c/ead:did/ead:unitdate">
                     <xsl:variable name="last-token"
                        select="normalize-space(tokenize(., '\-')[last()])"/>
                     <xsl:if
                        test="$last-token castable as xs:integer and matches(normalize-space($last-token), '^\d{3,4}$')">
                        <xsl:value-of select="xs:integer(normalize-space($last-token))"/>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:variable>

               <xsl:value-of select="max($all-late)"/>
            </xsl:variable>

            <unitdate>
               <xsl:attribute name="normal">
                  <xsl:value-of
                     select="local:normalize-date($earliest, $qual-component-id, false())"/>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="local:normalize-date($latest, $qual-component-id, true())"/>
               </xsl:attribute>
               <xsl:choose>
                  <xsl:when test="$earliest = $latest">
                     <xsl:value-of select="$earliest"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="concat($earliest, '-', $latest)"/>
                  </xsl:otherwise>
               </xsl:choose>
            </unitdate>
         </xsl:when>
         <xsl:otherwise>
            <!-- Look up -->
            <xsl:apply-templates
               select="(ancestor::ead:archdesc[ead:did/ead:unitdate]|ancestor::ead:c[ead:did/ead:unitdate])[last()]/ead:did/ead:unitdate">
               <xsl:with-param name="add-circa"
                  select="(ancestor::ead:archdesc[ead:did/ead:unitdate]|ancestor::ead:c[ead:did/ead:unitdate])[last()]/ead:did/ead:unitdate != ('undated')"
               />
            </xsl:apply-templates>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="ead:unitdate" as="element()">
      <xsl:param name="add-circa" as="xs:boolean" select="false()"/>
      <unitdate>
         <xsl:copy-of select="@*[not(local-name() eq 'normal')]"/>
         <xsl:choose>
            <xsl:when test="@normal and not(contains(@normal, '/'))">
               <xsl:attribute name="normal">
                  <xsl:value-of>
                     <xsl:value-of
                        select="local:normalize-date(@normal, $qual-component-id, false())"/>
                     <xsl:text>/</xsl:text>
                     <xsl:value-of
                        select="local:normalize-date(@normal, $qual-component-id, true())"/>
                  </xsl:value-of>
               </xsl:attribute>
            </xsl:when>
            <xsl:when test="contains(@normal, '/')">
               <xsl:variable name="norm-tokens" as="xs:string+" select="tokenize(@normal, '/')"/>
               <xsl:attribute name="normal">
                  <xsl:value-of>
                     <xsl:value-of
                        select="local:normalize-date($norm-tokens[1], $qual-component-id, false())"/>
                     <xsl:text>/</xsl:text>
                     <xsl:value-of
                        select="local:normalize-date($norm-tokens[2], $qual-component-id, true())"/>
                  </xsl:value-of>
               </xsl:attribute>
            </xsl:when>
            <xsl:when test="matches(current(), '\d{4}')">
               <xsl:variable name="extracted-years" as="xs:string*"
                  select="local:attempt-year-from-string(current()/string())"/>
               <xsl:attribute name="normal">
                  <xsl:value-of>
                     <xsl:value-of
                        select="local:normalize-date($extracted-years[1], $qual-component-id, true())"/>
                     <xsl:text>/</xsl:text>
                     <xsl:choose>
                        <xsl:when test="$extracted-years[2]">
                           <xsl:value-of
                              select="local:normalize-date($extracted-years[2], $qual-component-id, true())"
                           />
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of
                              select="local:normalize-date($extracted-years[1], $qual-component-id, true())"
                           />
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:value-of>
               </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="normal">
                  <xsl:value-of select="concat($DEFAULT_DATE, '/', $DEFAULT_DATE)"/>
               </xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:if test="$add-circa">circa </xsl:if>
         <xsl:value-of select="normalize-space()"/>
      </unitdate>
   </xsl:template>


   <!--+
      | Try to get dates to 1995-12-31T23:59:59Z, which is Solr's requirement
      +-->
   <xsl:function name="local:normalize-date" as="xs:dateTime">
      <xsl:param name="src-date" as="item()"/>
      <xsl:param name="doc-id" as="item()"/>
      <xsl:param name="round-up" as="xs:boolean"/>
      <xsl:variable name="src-date" as="xs:string" select="xs:string($src-date)"/>
      <xsl:variable name="_time" as="xs:string" select="'T00:00:00Z'"/>
      <xsl:variable name="_high-time" as="xs:string" select="'T23:59:59Z'"/>
      <!--<xsl:variable name="_high-day" as="xs:string" select="concat('-31', $_time)"/>-->
      <xsl:choose>
         <xsl:when test="$src-date castable as xs:gYear">
            <xsl:choose>
               <xsl:when test="$round-up">
                  <xsl:value-of select="xs:dateTime(concat($src-date, '-12-31', $_high-time))"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="xs:dateTime(concat($src-date, '-01-01', $_time))"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="$src-date castable as xs:gYearMonth">
            <xsl:choose>
               <xsl:when test="$round-up">
                  <xsl:variable name="month" as="xs:integer"
                     select="xs:integer(tokenize($src-date, '\-')[2])"/>
                  <xsl:choose>
                     <!-- leap year, yeah yeah -->
                     <xsl:when test="$month = 2">
                        <xsl:value-of select="xs:dateTime(concat($src-date, '-28', $_high-time))"/>
                     </xsl:when>
                     <xsl:when test="$month = (4,6,9,11)">
                        <xsl:value-of select="xs:dateTime(concat($src-date, '-30', $_high-time))"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="xs:dateTime(concat($src-date, '-31', $_high-time))"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="xs:dateTime(concat($src-date, '-01', $_time))"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="$src-date castable as xs:date">
            <xsl:value-of select="xs:dateTime(concat($src-date, $_time))"/>
         </xsl:when>
         <xsl:when test="matches($src-date, '^\d{3}$')">
            <xsl:choose>
               <xsl:when test="$round-up">
                  <xsl:value-of select="xs:dateTime(concat('0', $src-date, '-12-31', $_high-time))"
                  />
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="xs:dateTime(concat('0', $src-date,  '-01-01', $_time))"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="matches($src-date, '^\d{4}\-\d{2}\-\d{2}:T\d{2}:\d{2}:\d{2}Z$')">
            <xsl:value-of select="xs:dateTime($src-date)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message terminate="no">
               <xsl:text>Date </xsl:text>
               <xsl:value-of select="$src-date"/>
               <xsl:text> in </xsl:text>
               <xsl:value-of select="$doc-id"/>
               <xsl:text> could not be indexed. It must match "YYYY", "YYYY-MM", or "YYYY-MM-DD".</xsl:text>
               <xsl:text> The sort, earliest, and latest dates for this record will be "0001-01-01"</xsl:text>
               <xsl:text> until this is fixed.</xsl:text>
            </xsl:message>
            <xsl:value-of select="$DEFAULT_DATE"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>


   <xsl:template name="do-breadcrumbs" as="element()?">
      <xsl:variable name="crumbs" as="element()*">
         <xsl:for-each select="ancestor::ead:c">
            <xsl:variable name="id-no-callno" select="substring-after(@id, '_')"/>
            <pulfa:crumb uri="{concat($base-uri, '/collections/', $eadid, '/', $id-no-callno)}">
               <xsl:copy-of select="@level"/>
               <xsl:value-of select="normalize-space(ead:did/ead:unittitle)"/>
            </pulfa:crumb>
         </xsl:for-each>
      </xsl:variable>
      <xsl:if test="$crumbs">
         <pulfa:breadcrumbs>
            <xsl:copy-of select="$crumbs"/>
         </pulfa:breadcrumbs>
      </xsl:if>
   </xsl:template>


   <xsl:template match="*" mode="#all"/>


   <xsl:template name="do-request" as="element()">
      <!-- Don's logic...leaving as-s for now -->
      <xsl:choose>
         <xsl:when test="./@level='otherlevel'">
            <pulfa:request>
               <xsl:attribute name="type">
                  <xsl:text>single</xsl:text>
               </xsl:attribute>
               <xsl:value-of select="normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1])"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="normalize-space(../descendant::ead:unitid[1])"/>
            </pulfa:request>
         </xsl:when>
         <xsl:when test="exists(./ead:did/ead:container)">
            <pulfa:request>
               <xsl:attribute name="type">
                  <xsl:text>single</xsl:text>
               </xsl:attribute>
               <xsl:value-of select="normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1])"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="normalize-space(./ead:did/ead:container[1]/@type)"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="normalize-space(./ead:did/ead:container[1])"/>
            </pulfa:request>
         </xsl:when>
         <xsl:when
            test="not(exists(./ead:did/ead:container))
            and exists(./ead:did/ead:unitid[not(./@id='component')])">
            <pulfa:request>
               <xsl:attribute name="type">
                  <xsl:text>single</xsl:text>
               </xsl:attribute>
               <xsl:if test="exists(./descendant::*/ead:container)">
                  <xsl:value-of
                     select="./descendant::*[exists(./ead:did/ead:container)][1]/descendant::ead:container[1]/@type"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of
                     select="./descendant::*[exists(./ead:did/ead:container)][1]/descendant::ead:container[1]"
                  />
               </xsl:if>
               <xsl:if test="not(exists(./descendant::*/ead:container))">
                  <xsl:for-each select="./ead:did/ead:unitid[not(./@id='component')][1]">
                     <xsl:text>Item </xsl:text>
                     <xsl:value-of select="normalize-space(.)"/>
                     <xsl:for-each
                        select="../ead:did/ead:unitid[not(./@id='component')][position()>1]">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="normalize-space(.)"/>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:if>
            </pulfa:request>
         </xsl:when>
         <xsl:when
            test="not(exists(./ead:did/ead:container))
            and not(exists(./ead:did/ead:unitid)) and
            not(exists(./descendant::*/ead:did/ead:container)) and
            not(exists(./descendant::*/ead:did/ead:unitd))
            and          not(exists(*/*/descendant-or-self::ead:extref))">
            <pulfa:request>
               <xsl:attribute name="type">
                  <xsl:text>single</xsl:text>
               </xsl:attribute>
               <xsl:text>Consult staff to request material</xsl:text>
            </pulfa:request>
         </xsl:when>
         <xsl:when
            test="./@level='item' and
            not(exists(descendant::ead:unitid)) and
            not(exists(./ead:did/ead:container))">
            <pulfa:request>
               <xsl:attribute name="type">
                  <xsl:text>single</xsl:text>
               </xsl:attribute>
               <xsl:value-of select="normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1])"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="normalize-space(ead:unittitle)"/>
            </pulfa:request>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="exists(./descendant::ead:container)">
                  <pulfa:request>
                     <xsl:attribute name="type">
                        <xsl:if
                           test="not(./descendant::ead:container[1] =
                           ./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1])">
                           <xsl:text>multiple</xsl:text>
                        </xsl:if>
                        <xsl:if
                           test="./descendant::ead:container[1] =
                           ./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1]">
                           <xsl:text>single</xsl:text>
                        </xsl:if>
                     </xsl:attribute>
                     <xsl:choose>
                        <xsl:when
                           test="not(./descendant::ead:did[exists(./ead:container)][1]/ead:container[1]
                           =
                           ./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1])">
                           <xsl:choose>
                              <xsl:when
                                 test="(number(./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1])-number(./descendant::ead:did[exists(./ead:container)][1]/ead:container[1]))=(count(distinct-values(./descendant::*/ead:container[position()=1]))-1)">
                                 <xsl:text>This </xsl:text>
                                 <xsl:value-of select="./@level"/>
                                 <xsl:text> is contained in </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:container[1]/@type)"/>
                                 <xsl:text> </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:container[1])"/>
                                 <xsl:text> - </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1]/@type)"/>
                                 <xsl:text> </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:did[exists(./ead:container)][last()]/ead:container[1])"/>
                                 <xsl:text> of the collection</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:text>This </xsl:text>
                                 <xsl:value-of select="./@level"/>
                                 <xsl:text> is contained in multiple </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(lower-case(./descendant::ead:did[exists(./ead:container[1])][last()]/ead:container[1]/@type))"/>
                                 <xsl:if
                                    test="contains(./descendant::ead:did[exists(./ead:container[1])][last()]/ead:container[1]/@type,'ox')">
                                    <xsl:text>e</xsl:text>
                                 </xsl:if>
                                 <xsl:text>s</xsl:text>
                                 <xsl:text> </xsl:text>
                                 <xsl:text>of the collection starting with </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:container[1]/@type)"/>
                                 <xsl:text> </xsl:text>
                                 <xsl:value-of
                                    select="normalize-space(./descendant::ead:did[exists(./ead:container)][1]/ead:container[1])"
                                 />
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:text>. See finding aid for this collection to request specific </xsl:text>
                           <xsl:value-of
                              select="normalize-space(lower-case(./descendant::ead:container[1]/@type))"/>
                           <xsl:choose>
                              <xsl:when test="contains(./descendant::ead:container[1]/@type,'ox')">
                                 <xsl:text>es</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:text>s</xsl:text>
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:text>.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of
                              select="normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1])"/>
                           <xsl:text> </xsl:text>
                           <xsl:value-of
                              select="normalize-space(./descendant::ead:container[1]/@type)"/>
                           <xsl:text> </xsl:text>
                           <xsl:value-of select="normalize-space(./descendant::ead:container[1])"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </pulfa:request>
               </xsl:when>
               <xsl:when
                  test="not(exists(./descendant::ead:did/ead:container))
                  and exists(./descendant::*/ead:unitid)">
                  <pulfa:request>
                     <xsl:attribute name="type">
                        <xsl:text>multiple</xsl:text>
                     </xsl:attribute>
                     <xsl:value-of
                        select="normalize-space(./descendant::*[exists(./ead:did/ead:unitid)][1]/ead:did/ead:unitid)"/>
                     <xsl:text> - </xsl:text>
                     <xsl:value-of
                        select="normalize-space(./descendant::*[exists(./ead:did/ead:unitid)][last()]/ead:did/ead:unitid)"
                     />
                  </pulfa:request>
               </xsl:when>
               <xsl:when
                  test="./@level='item' and
                  not(exists(descendant::ead:unitid)) and
                  not(exists(./ead:did/ead:container))">
                  <pulfa:request>
                     <xsl:attribute name="type">
                        <xsl:text>single</xsl:text>
                     </xsl:attribute>
                     <xsl:value-of select="normalize-space(descendant::ead:unittitle)"/>
                  </pulfa:request>
               </xsl:when>
               <xsl:otherwise>
                  <pulfa:request>
                     <xsl:attribute name="type">
                        <xsl:text>single</xsl:text>
                     </xsl:attribute>
                     <xsl:text>Consult staff to request material</xsl:text>
                  </pulfa:request>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
