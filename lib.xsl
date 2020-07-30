<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib"
   xmlns:eac="urn:isbn:1-931666-33-4"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="2.0">


   <!--+
        | Capitalizes the string passed as the only param.
        +-->
   <xsl:function name="lib:capitalize-first" as="xs:string">
      <xsl:param name="string" as="xs:string"/>
      <xsl:variable name="first" select="upper-case(substring($string,1, 1))" as="xs:string"/>
      <xsl:variable name="rest" select="substring($string, 2)" as="xs:string"/>
      <xsl:value-of select="concat($first, $rest)"/>
   </xsl:function>

   <!--+
        | Capitalizes each word the string passed as the onll param.
        +-->
   <xsl:function name="lib:capitalize-each" as="xs:string">
      <xsl:param name="string" as="xs:string"/>
      <xsl:value-of>
         <xsl:for-each select="tokenize($string, ' ')">
            <xsl:value-of select="concat(lib:capitalize-first(.), ' ')"/>
         </xsl:for-each>
      </xsl:value-of>
   </xsl:function>

   <xsl:function name="lib:normalize-subject-heading" as="xs:string">
      <xsl:param name="input-heading" as="item()"/>
      <xsl:variable name="no-stop">
         <xsl:choose>
            <xsl:when test="matches($input-heading, '\p{Lu}\.$')">
               <xsl:value-of select="$input-heading"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="lib:strip-stop($input-heading)"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:value-of select="replace($no-stop, '\s?(\-{2}|–)\s?', '--')"/>
   </xsl:function>

   <xsl:function name="lib:normalize-subject-heading-old" as="xs:string">
      <xsl:param name="input-heading" as="item()"/>
      <xsl:variable name="no-stop" as="xs:string" select="if (not(matches($input-heading, '\p{Lu}\.$'))) then lib:strip-stop($input-heading) else $input-heading"/>
      <xsl:value-of select="replace($no-stop, '\s?(\-{2}|–)\s?', '--')"/>
   </xsl:function>

   <xsl:function name="lib:strip-punctuation">
      <xsl:param name="input" as="item()"/>
      <xsl:value-of select="normalize-space(replace($input, '\p{P}+', ' '))"/>
   </xsl:function>

   <!--+
      | Strip any trailing punctuation or spaces. Be careful with this: it
      | doesn't know abbreviations. Trailing quotes (",',’, ”) are kept.
      +-->
   <xsl:function name="lib:strip-stop" as="xs:string?">
      <xsl:param name="string" as="xs:string"/>
      <xsl:variable name="normalized" select="normalize-space($string)"/>
      <xsl:choose>
         <xsl:when test="ends-with($normalized, '.')">
            <xsl:value-of select="substring($normalized, 1, string-length($normalized) - 1)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$normalized"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <xsl:function name="lib:escape-email" as="xs:string">
      <xsl:param name="addy"/>
      <xsl:value-of select="replace(replace($addy, '@', ' [at] '), '\.', ' [dot] ')"/>
   </xsl:function>


   <!-- This lives here because it uses the date* templates. Should probably be a regular match template -->
   <!-- RH on 10/31/2013: changed useDates to existDates for display -->
   <xsl:function name="lib:format-eac-name" as="xs:string">
      <xsl:param name="nameEntry" as="element()"/>
      <xsl:variable name="value">
         <xsl:value-of>
            <xsl:value-of select="$nameEntry/eac:part"/>
            <xsl:choose>
               <xsl:when test="$nameEntry/ancestor::eac:identity/following-sibling::eac:description/eac:existDates/eac:dateRange">
                  <xsl:text>, </xsl:text>
                  <xsl:apply-templates select="$nameEntry/../following-sibling::eac:description/eac:existDates/eac:dateRange" mode="string"/>
               </xsl:when>
               <xsl:when test="$nameEntry/ancestor::eac:identity/following-sibling::eac:description/eac:existDates/eac:date">
                  <xsl:text>, </xsl:text>
                  <xsl:apply-templates select="$nameEntry/ancestor::eac:identity/following-sibling::eac:description/eac:existDates/eac:date" mode="string"/>
               </xsl:when>
               <!--+
                   | No support for dateSet wrt names yet..not sure how it would be used.
                   | http://www3.iath.virginia.edu/eac/cpf/tagLibrary/cpfTagLibrary.html#d1e2484
                   +-->
            </xsl:choose>
         </xsl:value-of>
      </xsl:variable>
      <xsl:choose>
         <!-- no trailing stop if we end with punctuation -->
         <xsl:when test="matches($value, '\p{P}$')">
            <xsl:value-of select="normalize-space($value)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="concat(normalize-space($value), '.')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <!--
      Using this to matches a date plus (optionally) B.C. or A.D.:
      \d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?

      Still need a list for unspecified starting or ending date
      (occurs only for geological periods):

      Devonian
      Jurassic
   -->
   <xsl:function name="lib:is-date-subdivision" as="xs:boolean">
      <xsl:param name="token" as="xs:string"/>
      <xsl:variable name="token" as="xs:string" select="normalize-space($token)"/>
      <xsl:choose>
         <!--+
             | Unspecified starting date:
             | To 400
             | To 1800
             | To 333 B.C.
             +-->
         <xsl:when test="matches($token,'^[Tt]o\s\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!--+
             | Unspecified ending AND Single date without explanatory words:
             | 1989-
             | 1929
             +-->
         <xsl:when test="matches($token,'^\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?\-?$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!--+
             | Specific century or centuries:
             | 17th century
             | 15th-18th centuries
             +-->
         <xsl:when test="matches($token,'^(\d{1,2}[snrt][tdh][-\s]){1,2}[cC]entur(y|ies)$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!--+
             | Specific date spans with explanatory words:
             | Renaissance, 1450-1600
             | George V, 1910-1936
             +-->
         <xsl:when test="matches($token,'^.+,\s\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?\s?\-?\s?\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!--+
             | Specific date spans without explanatory words:
             | 500-1400
             | 1789-1945
             | 221 B.C.-960 A.D.
             +-->
         <xsl:when test="matches($token,'^\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?\s?\-?\s?\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!--+
             | Single date with explanatory words:
             | Edward VIII, 1936
             | American Invasion, 1989
             +-->
         <xsl:when test="matches($token,'^.+,\s\d{1,4}((\s[Bb]\.[Cc]\.)|(\s[Aa]\.[Dd]\.))?$')">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="false()"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   
</xsl:stylesheet>
