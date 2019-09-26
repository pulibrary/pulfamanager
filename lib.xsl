<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib"
   xmlns:eac="urn:isbn:1-931666-33-4"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="2.0">

   <xsl:strip-space elements="*"/>

   <!--+
       | Substitutions.
       +-->

   <xsl:variable name="repo-codes">
     <repo code="eng">Technical and Scientific Reports</repo>
     <repo code="lae">Latin American Ephemera Collections</repo>
     <repo code="cotsen">Cotsen Children's Library</repo>
     <repo code="mss">Manuscripts Division</repo>
     <repo code="publicpolicy">Public Policy Papers</repo>
     <repo code="univarchives">Princeton University Archives</repo>
     <repo code="rarebooks">Rare Book Division</repo>
     <repo code="ga">Graphic Arts Collection</repo>
   </xsl:variable>

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

   <xsl:variable name="language-codes">
     <lang code="aar">Afar</lang>
         <lang code="aa">Afar</lang>
         <lang code="abk">Abkhazian</lang>
         <lang code="ab">Abkhazian</lang>
         <lang code="ace">Achinese</lang>
         <lang code="ach">Acoli</lang>
         <lang code="ada">Adangme</lang>
         <lang code="ady">Adyghe or Adygei</lang>
         <lang code="afa">Afro-Asiatic (Other)</lang>
         <lang code="afh">Afrihili</lang>
         <lang code="afr">Afrikaans</lang>
         <lang code="af">Afrikaans</lang>
         <lang code="ain">Ainu</lang>
         <lang code="aka">Akan</lang>
         <lang code="ak">Akan</lang>
         <lang code="akk">Akkadian</lang>
         <lang code="alb">Albanian</lang>
         <lang code="sqi">Albanian</lang>
         <lang code="sq">Albanian</lang>
         <lang code="ale">Aleut</lang>
         <lang code="alg">Algonquian languages</lang>
         <lang code="alt">Southern Altai</lang>
         <lang code="amh">Amharic</lang>
         <lang code="am">Amharic</lang>
         <lang code="ang">English, Old (ca.450-1100)</lang>
         <lang code="anp">Angika</lang>
         <lang code="apa">Apache languages</lang>
         <lang code="ara">Arabic</lang>
         <lang code="ar">Arabic</lang>
         <lang code="arc">Aramaic</lang>
         <lang code="arg">Aragonese</lang>
         <lang code="an">Aragonese</lang>
         <lang code="arm">Armenian</lang>
         <lang code="hye">Armenian</lang>
         <lang code="hy">Armenian</lang>
         <lang code="arn">Mapudungun or Mapuche</lang>
         <lang code="arp">Arapaho</lang>
         <lang code="art">Artificial (Other)</lang>
         <lang code="arw">Arawak</lang>
         <lang code="asm">Assamese</lang>
         <lang code="as">Assamese</lang>
         <lang code="ast">Asturian or Bable</lang>
         <lang code="ath">Athapascan languages</lang>
         <lang code="aus">Australian languages</lang>
         <lang code="ava">Avaric</lang>
         <lang code="av">Avaric</lang>
         <lang code="ave">Avestan</lang>
         <lang code="ae">Avestan</lang>
         <lang code="awa">Awadhi</lang>
         <lang code="aym">Aymara</lang>
         <lang code="ay">Aymara</lang>
         <lang code="aze">Azerbaijani</lang>
         <lang code="az">Azerbaijani</lang>
         <lang code="bad">Banda languages</lang>
         <lang code="bai">Bamileke languages</lang>
         <lang code="bak">Bashkir</lang>
         <lang code="ba">Bashkir</lang>
         <lang code="bal">Baluchi</lang>
         <lang code="bam">Bambara</lang>
         <lang code="bm">Bambara</lang>
         <lang code="ban">Balinese</lang>
         <lang code="baq">Basque</lang>
         <lang code="eus">Basque</lang>
         <lang code="eu">Basque</lang>
         <lang code="bas">Basa</lang>
         <lang code="bat">Baltic (Other)</lang>
         <lang code="bej">Beja</lang>
         <lang code="bel">Belarusian</lang>
         <lang code="be">Belarusian</lang>
         <lang code="bem">Bemba</lang>
         <lang code="ben">Bengali</lang>
         <lang code="bn">Bengali</lang>
         <lang code="ber">Berber (Other)</lang>
         <lang code="bho">Bhojpuri</lang>
         <lang code="bih">Bihari</lang>
         <lang code="bh">Bihari</lang>
         <lang code="bik">Bikol</lang>
         <lang code="bin">Bini or Edo</lang>
         <lang code="bis">Bislama</lang>
         <lang code="bi">Bislama</lang>
         <lang code="bla">Siksika</lang>
         <lang code="bnt">Bantu (Other)</lang>
         <lang code="bos">Bosnian</lang>
         <lang code="bs">Bosnian</lang>
         <lang code="bra">Braj</lang>
         <lang code="bre">Breton</lang>
         <lang code="br">Breton</lang>
         <lang code="btk">Batak languages</lang>
         <lang code="bua">Buriat</lang>
         <lang code="bug">Buginese</lang>
         <lang code="bul">Bulgarian</lang>
         <lang code="bg">Bulgarian</lang>
         <lang code="bur">Burmese</lang>
         <lang code="mya">Burmese</lang>
         <lang code="my">Burmese</lang>
         <lang code="byn">Blin or Bilin</lang>
         <lang code="cad">Caddo</lang>
         <lang code="cai">Central American Indian (Other)</lang>
         <lang code="car">Galibi Carib</lang>
         <lang code="cat">Catalan or Valencian</lang>
         <lang code="ca">Catalan or Valencian</lang>
         <lang code="cau">Caucasian (Other)</lang>
         <lang code="ceb">Cebuano</lang>
         <lang code="cel">Celtic (Other)</lang>
         <lang code="cha">Chamorro</lang>
         <lang code="ch">Chamorro</lang>
         <lang code="chb">Chibcha</lang>
         <lang code="che">Chechen</lang>
         <lang code="ce">Chechen</lang>
         <lang code="chg">Chagatai</lang>
         <lang code="chi">Chinese</lang>
         <lang code="zho">Chinese</lang>
         <lang code="zh">Chinese</lang>
         <lang code="chk">Chuukese</lang>
         <lang code="chm">Mari</lang>
         <lang code="chn">Chinook jargon</lang>
         <lang code="cho">Choctaw</lang>
         <lang code="chp">Chipewyan</lang>
         <lang code="chr">Cherokee</lang>
         <lang code="chu">Church Slavic or Old Slavonic or Church Slavonic or Old Bulgarian or Old Church Slavonic</lang>
         <lang code="cu">Church Slavic or Old Slavonic or Church Slavonic or Old Bulgarian or Old Church Slavonic</lang>
         <lang code="chv">Chuvash</lang>
         <lang code="cv">Chuvash</lang>
         <lang code="chy">Cheyenne</lang>
         <lang code="cmc">Chamic languages</lang>
         <lang code="cop">Coptic</lang>
         <lang code="cor">Cornish</lang>
         <lang code="kw">Cornish</lang>
         <lang code="cos">Corsican</lang>
         <lang code="co">Corsican</lang>
         <lang code="cpe">Creoles and pidgins, English based (Other)</lang>
         <lang code="cpf">Creoles and pidgins, French-based (Other)</lang>
         <lang code="cpp">Creoles and pidgins, Portuguese-based (Other)</lang>
         <lang code="cre">Cree</lang>
         <lang code="cr">Cree</lang>
         <lang code="crh">Crimean Tatar or Crimean Turkish</lang>
         <lang code="crp">Creoles and pidgins (Other)</lang>
         <lang code="csb">Kashubian</lang>
         <lang code="cus">Cushitic (Other)</lang>
         <lang code="cze">Czech</lang>
         <lang code="ces">Czech</lang>
         <lang code="cs">Czech</lang>
         <lang code="dak">Dakota</lang>
         <lang code="dan">Danish</lang>
         <lang code="da">Danish</lang>
         <lang code="dar">Dargwa</lang>
         <lang code="day">Land Dayak languages</lang>
         <lang code="del">Delaware</lang>
         <lang code="den">Slave (Athapascan)</lang>
         <lang code="dgr">Dogrib</lang>
         <lang code="din">Dinka</lang>
         <lang code="div">Divehi or Dhivehi or Maldivian</lang>
         <lang code="dv">Divehi or Dhivehi or Maldivian</lang>
         <lang code="doi">Dogri</lang>
         <lang code="dra">Dravidian (Other)</lang>
         <lang code="dsb">Lower Sorbian</lang>
         <lang code="dua">Duala</lang>
         <lang code="dum">Dutch, Middle (ca.1050-1350)</lang>
         <lang code="dut">Dutch or Flemish</lang>
         <lang code="nld">Dutch or Flemish</lang>
         <lang code="nl">Dutch or Flemish</lang>
         <lang code="dyu">Dyula</lang>
         <lang code="dzo">Dzongkha</lang>
         <lang code="dz">Dzongkha</lang>
         <lang code="efi">Efik</lang>
         <lang code="egy">Egyptian (Ancient)</lang>
         <lang code="eka">Ekajuk</lang>
         <lang code="elx">Elamite</lang>
         <lang code="eng">English</lang>
         <lang code="en">English</lang>
         <lang code="enm">English, Middle (1100-1500)</lang>
         <lang code="epo">Esperanto</lang>
         <lang code="eo">Esperanto</lang>
         <lang code="est">Estonian</lang>
         <lang code="et">Estonian</lang>
         <lang code="ewe">Ewe</lang>
         <lang code="ee">Ewe</lang>
         <lang code="ewo">Ewondo</lang>
         <lang code="fan">Fang</lang>
         <lang code="fao">Faroese</lang>
         <lang code="fo">Faroese</lang>
         <lang code="fat">Fanti</lang>
         <lang code="fij">Fijian</lang>
         <lang code="fj">Fijian</lang>
         <lang code="fil">Filipino or Pilipino</lang>
         <lang code="fin">Finnish</lang>
         <lang code="fi">Finnish</lang>
         <lang code="fiu">Finno-Ugrian (Other)</lang>
         <lang code="fon">Fon</lang>
         <lang code="fre">French</lang>
         <lang code="fra">French</lang>
         <lang code="fr">French</lang>
         <lang code="frm">French, Middle (ca.1400-1600)</lang>
         <lang code="fro">French, Old (842-ca.1400)</lang>
         <lang code="frr">Northern Frisian</lang>
         <lang code="frs">Eastern Frisian</lang>
         <lang code="fry">Western Frisian</lang>
         <lang code="fy">Western Frisian</lang>
         <lang code="ful">Fulah</lang>
         <lang code="ff">Fulah</lang>
         <lang code="fur">Friulian</lang>
         <lang code="gaa">Ga</lang>
         <lang code="gay">Gayo</lang>
         <lang code="gba">Gbaya</lang>
         <lang code="gem">Germanic (Other)</lang>
         <lang code="geo">Georgian</lang>
         <lang code="kat">Georgian</lang>
         <lang code="ka">Georgian</lang>
         <lang code="ger">German</lang>
         <lang code="deu">German</lang>
         <lang code="de">German</lang>
         <lang code="gez">Geez</lang>
         <lang code="gil">Gilbertese</lang>
         <lang code="gla">Gaelic or Scottish Gaelic</lang>
         <lang code="gd">Gaelic or Scottish Gaelic</lang>
         <lang code="gle">Irish</lang>
         <lang code="ga">Irish</lang>
         <lang code="glg">Galician</lang>
         <lang code="gl">Galician</lang>
         <lang code="glv">Manx</lang>
         <lang code="gv">Manx</lang>
         <lang code="gmh">German, Middle High (ca.1050-1500)</lang>
         <lang code="goh">German, Old High (ca.750-1050)</lang>
         <lang code="gon">Gondi</lang>
         <lang code="gor">Gorontalo</lang>
         <lang code="got">Gothic</lang>
         <lang code="grb">Grebo</lang>
         <lang code="grc">Greek, Ancient (to 1453)</lang>
         <lang code="gre">Greek, Modern (1453-)</lang>
         <lang code="ell">Greek, Modern (1453-)</lang>
         <lang code="el">Greek, Modern (1453-)</lang>
         <lang code="grn">Guarani</lang>
         <lang code="gn">Guarani</lang>
         <lang code="gsw">Swiss German or Alemannic</lang>
         <lang code="guj">Gujarati</lang>
         <lang code="gu">Gujarati</lang>
         <lang code="gwi">Gwich'in</lang>
         <lang code="hai">Haida</lang>
         <lang code="hat">Haitian or Haitian Creole</lang>
         <lang code="ht">Haitian or Haitian Creole</lang>
         <lang code="hau">Hausa</lang>
         <lang code="ha">Hausa</lang>
         <lang code="haw">Hawaiian</lang>
         <lang code="heb">Hebrew</lang>
         <lang code="he">Hebrew</lang>
         <lang code="her">Herero</lang>
         <lang code="hz">Herero</lang>
         <lang code="hil">Hiligaynon</lang>
         <lang code="him">Himachali</lang>
         <lang code="hin">Hindi</lang>
         <lang code="hi">Hindi</lang>
         <lang code="hit">Hittite</lang>
         <lang code="hmn">Hmong</lang>
         <lang code="hmo">Hiri Motu</lang>
         <lang code="ho">Hiri Motu</lang>
         <lang code="hsb">Upper Sorbian</lang>
         <lang code="hun">Hungarian</lang>
         <lang code="hu">Hungarian</lang>
         <lang code="hup">Hupa</lang>
         <lang code="iba">Iban</lang>
         <lang code="ibo">Igbo</lang>
         <lang code="ig">Igbo</lang>
         <lang code="ice">Icelandic</lang>
         <lang code="isl">Icelandic</lang>
         <lang code="is">Icelandic</lang>
         <lang code="ido">Ido</lang>
         <lang code="io">Ido</lang>
         <lang code="iii">Sichuan Yi</lang>
         <lang code="ii">Sichuan Yi</lang>
         <lang code="ijo">Ijo languages</lang>
         <lang code="iku">Inuktitut</lang>
         <lang code="iu">Inuktitut</lang>
         <lang code="ile">Interlingue</lang>
         <lang code="ie">Interlingue</lang>
         <lang code="ilo">Iloko</lang>
         <lang code="ina">Interlingua (International Auxiliary Language Association)</lang>
         <lang code="ia">Interlingua (International Auxiliary Language Association)</lang>
         <lang code="inc">Indic (Other)</lang>
         <lang code="ind">Indonesian</lang>
         <lang code="id">Indonesian</lang>
         <lang code="ine">Indo-European (Other)</lang>
         <lang code="inh">Ingush</lang>
         <lang code="ipk">Inupiaq</lang>
         <lang code="ik">Inupiaq</lang>
         <lang code="ira">Iranian (Other)</lang>
         <lang code="iro">Iroquoian languages</lang>
         <lang code="ita">Italian</lang>
         <lang code="it">Italian</lang>
         <lang code="jav">Javanese</lang>
         <lang code="jv">Javanese</lang>
         <lang code="jbo">Lojban</lang>
         <lang code="jpn">Japanese</lang>
         <lang code="ja">Japanese</lang>
         <lang code="jpr">Judeo-Persian</lang>
         <lang code="jrb">Judeo-Arabic</lang>
         <lang code="kaa">Kara-Kalpak</lang>
         <lang code="kab">Kabyle</lang>
         <lang code="kac">Kachin or Jingpho</lang>
         <lang code="kal">Kalaallisut or Greenlandic</lang>
         <lang code="kl">Kalaallisut or Greenlandic</lang>
         <lang code="kam">Kamba</lang>
         <lang code="kan">Kannada</lang>
         <lang code="kn">Kannada</lang>
         <lang code="kar">Karen languages</lang>
         <lang code="kas">Kashmiri</lang>
         <lang code="ks">Kashmiri</lang>
         <lang code="kau">Kanuri</lang>
         <lang code="kr">Kanuri</lang>
         <lang code="kaw">Kawi</lang>
         <lang code="kaz">Kazakh</lang>
         <lang code="kk">Kazakh</lang>
         <lang code="kbd">Kabardian</lang>
         <lang code="kha">Khasi</lang>
         <lang code="khi">Khoisan (Other)</lang>
         <lang code="khm">Central Khmer</lang>
         <lang code="km">Central Khmer</lang>
         <lang code="kho">Khotanese</lang>
         <lang code="kik">Kikuyu or Gikuyu</lang>
         <lang code="ki">Kikuyu or Gikuyu</lang>
         <lang code="kin">Kinyarwanda</lang>
         <lang code="rw">Kinyarwanda</lang>
         <lang code="kir">Kirghiz or Kyrgyz</lang>
         <lang code="ky">Kirghiz or Kyrgyz</lang>
         <lang code="kmb">Kimbundu</lang>
         <lang code="kok">Konkani</lang>
         <lang code="kom">Komi</lang>
         <lang code="kv">Komi</lang>
         <lang code="kon">Kongo</lang>
         <lang code="kg">Kongo</lang>
         <lang code="kor">Korean</lang>
         <lang code="ko">Korean</lang>
         <lang code="kos">Kosraean</lang>
         <lang code="kpe">Kpelle</lang>
         <lang code="krc">Karachay-Balkar</lang>
         <lang code="krl">Karelian</lang>
         <lang code="kro">Kru languages</lang>
         <lang code="kru">Kurukh</lang>
         <lang code="kua">Kuanyama or Kwanyama</lang>
         <lang code="kj">Kuanyama or Kwanyama</lang>
         <lang code="kum">Kumyk</lang>
         <lang code="kur">Kurdish</lang>
         <lang code="ku">Kurdish</lang>
         <lang code="kut">Kutenai</lang>
         <lang code="lad">Ladino</lang>
         <lang code="lah">Lahnda</lang>
         <lang code="lam">Lamba</lang>
         <lang code="lao">Lao</lang>
         <lang code="lo">Lao</lang>
         <lang code="lat">Latin</lang>
         <lang code="la">Latin</lang>
         <lang code="lav">Latvian</lang>
         <lang code="lv">Latvian</lang>
         <lang code="lez">Lezghian</lang>
         <lang code="lim">Limburgan or Limburger or Limburgish</lang>
         <lang code="li">Limburgan or Limburger or Limburgish</lang>
         <lang code="lin">Lingala</lang>
         <lang code="ln">Lingala</lang>
         <lang code="lit">Lithuanian</lang>
         <lang code="lt">Lithuanian</lang>
         <lang code="lol">Mongo</lang>
         <lang code="loz">Lozi</lang>
         <lang code="ltz">Luxembourgish or Letzeburgesch</lang>
         <lang code="lb">Luxembourgish or Letzeburgesch</lang>
         <lang code="lua">Luba-Lulua</lang>
         <lang code="lub">Luba-Katanga</lang>
         <lang code="lu">Luba-Katanga</lang>
         <lang code="lug">Ganda</lang>
         <lang code="lg">Ganda</lang>
         <lang code="lui">Luiseno</lang>
         <lang code="lun">Lunda</lang>
         <lang code="luo">Luo (Kenya and Tanzania)</lang>
         <lang code="lus">Lushai</lang>
         <lang code="mac">Macedonian</lang>
         <lang code="mkd">Macedonian</lang>
         <lang code="mk">Macedonian</lang>
         <lang code="mad">Madurese</lang>
         <lang code="mag">Magahi</lang>
         <lang code="mah">Marshallese</lang>
         <lang code="mh">Marshallese</lang>
         <lang code="mai">Maithili</lang>
         <lang code="mak">Makasar</lang>
         <lang code="mal">Malayalam</lang>
         <lang code="ml">Malayalam</lang>
         <lang code="man">Mandingo</lang>
         <lang code="mao">Maori</lang>
         <lang code="mri">Maori</lang>
         <lang code="mi">Maori</lang>
         <lang code="map">Austronesian (Other)</lang>
         <lang code="mar">Marathi</lang>
         <lang code="mr">Marathi</lang>
         <lang code="mas">Masai</lang>
         <lang code="may">Malay</lang>
         <lang code="msa">Malay</lang>
         <lang code="ms">Malay</lang>
         <lang code="mdf">Moksha</lang>
         <lang code="mdr">Mandar</lang>
         <lang code="men">Mende</lang>
         <lang code="mga">Irish, Middle (900-1200)</lang>
         <lang code="mic">Mi'kmaq or Micmac</lang>
         <lang code="min">Minangkabau</lang>
         <lang code="mis">Miscellaneous languages</lang>
         <lang code="mkh">Mon-Khmer (Other)</lang>
         <lang code="mlg">Malagasy</lang>
         <lang code="mg">Malagasy</lang>
         <lang code="mlt">Maltese</lang>
         <lang code="mt">Maltese</lang>
         <lang code="mnc">Manchu</lang>
         <lang code="mni">Manipuri</lang>
         <lang code="mno">Manobo languages</lang>
         <lang code="moh">Mohawk</lang>
         <lang code="mol">Moldavian</lang>
         <lang code="mo">Moldavian</lang>
         <lang code="mon">Mongolian</lang>
         <lang code="mn">Mongolian</lang>
         <lang code="mos">Mossi</lang>
         <lang code="mul">Multiple languages</lang>
         <lang code="mun">Munda languages</lang>
         <lang code="mus">Creek</lang>
         <lang code="mwl">Mirandese</lang>
         <lang code="mwr">Marwari</lang>
         <lang code="myn">Mayan languages</lang>
         <lang code="myv">Erzya</lang>
         <lang code="nah">Nahuatl languages</lang>
         <lang code="nai">North American Indian</lang>
         <lang code="nap">Neapolitan</lang>
         <lang code="nau">Nauru</lang>
         <lang code="na">Nauru</lang>
         <lang code="nav">Navajo or Navaho</lang>
         <lang code="nv">Navajo or Navaho</lang>
         <lang code="nbl">Ndebele, South or South Ndebele</lang>
         <lang code="nr">Ndebele, South or South Ndebele</lang>
         <lang code="nde">Ndebele, North or North Ndebele</lang>
         <lang code="nd">Ndebele, North or North Ndebele</lang>
         <lang code="ndo">Ndonga</lang>
         <lang code="ng">Ndonga</lang>
         <lang code="nds">Low German or Low Saxon or German, Low or Saxon, Low</lang>
         <lang code="nep">Nepali</lang>
         <lang code="ne">Nepali</lang>
         <lang code="new">Nepal Bhasa or Newari</lang>
         <lang code="nia">Nias</lang>
         <lang code="nic">Niger-Kordofanian (Other)</lang>
         <lang code="niu">Niuean</lang>
         <lang code="nno">Norwegian Nynorsk or Nynorsk, Norwegian</lang>
         <lang code="nn">Norwegian Nynorsk or Nynorsk, Norwegian</lang>
         <lang code="nob">Bokmål, Norwegian or Norwegian Bokmål</lang>
         <lang code="nb">Bokmål, Norwegian or Norwegian Bokmål</lang>
         <lang code="nog">Nogai</lang>
         <lang code="non">Norse, Old</lang>
         <lang code="nor">Norwegian</lang>
         <lang code="no">Norwegian</lang>
         <lang code="nso">Pedi or Sepedi or Northern Sotho</lang>
         <lang code="nub">Nubian languages</lang>
         <lang code="nwc">Classical Newari or Old Newari or Classical Nepal Bhasa</lang>
         <lang code="nya">Chichewa or Chewa or Nyanja</lang>
         <lang code="ny">Chichewa or Chewa or Nyanja</lang>
         <lang code="nym">Nyamwezi</lang>
         <lang code="nyn">Nyankole</lang>
         <lang code="nyo">Nyoro</lang>
         <lang code="nzi">Nzima</lang>
         <lang code="oci">Occitan (post 1500) or Provençal</lang>
         <lang code="oc">Occitan (post 1500) or Provençal</lang>
         <lang code="oji">Ojibwa</lang>
         <lang code="oj">Ojibwa</lang>
         <lang code="ori">Oriya</lang>
         <lang code="or">Oriya</lang>
         <lang code="orm">Oromo</lang>
         <lang code="om">Oromo</lang>
         <lang code="osa">Osage</lang>
         <lang code="oss">Ossetian or Ossetic</lang>
         <lang code="os">Ossetian or Ossetic</lang>
         <lang code="ota">Turkish, Ottoman (1500-1928)</lang>
         <lang code="oto">Otomian languages</lang>
         <lang code="paa">Papuan (Other)</lang>
         <lang code="pag">Pangasinan</lang>
         <lang code="pal">Pahlavi</lang>
         <lang code="pam">Pampanga</lang>
         <lang code="pan">Panjabi or Punjabi</lang>
         <lang code="pa">Panjabi or Punjabi</lang>
         <lang code="pap">Papiamento</lang>
         <lang code="pau">Palauan</lang>
         <lang code="peo">Persian, Old (ca.600-400 B.C.)</lang>
         <lang code="per">Persian</lang>
         <lang code="fas">Persian</lang>
         <lang code="fa">Persian</lang>
         <lang code="phi">Philippine (Other)</lang>
         <lang code="phn">Phoenician</lang>
         <lang code="pli">Pali</lang>
         <lang code="pi">Pali</lang>
         <lang code="pol">Polish</lang>
         <lang code="pl">Polish</lang>
         <lang code="pon">Pohnpeian</lang>
         <lang code="por">Portuguese</lang>
         <lang code="pt">Portuguese</lang>
         <lang code="pra">Prakrit languages</lang>
         <lang code="pro">Provençal, Old (to 1500)</lang>
         <lang code="pus">Pushto</lang>
         <lang code="ps">Pushto</lang>
         <lang code="que">Quechua</lang>
         <lang code="qu">Quechua</lang>
         <lang code="raj">Rajasthani</lang>
         <lang code="rap">Rapanui</lang>
         <lang code="rar">Rarotongan or Cook Islands Maori</lang>
         <lang code="roa">Romance (Other)</lang>
         <lang code="roh">Romansh</lang>
         <lang code="rm">Romansh</lang>
         <lang code="rom">Romany</lang>
         <lang code="rum">Romanian</lang>
         <lang code="ron">Romanian</lang>
         <lang code="ro">Romanian</lang>
         <lang code="run">Rundi</lang>
         <lang code="rn">Rundi</lang>
         <lang code="rup">Aromanian or Arumanian or Macedo-Romanian</lang>
         <lang code="rus">Russian</lang>
         <lang code="ru">Russian</lang>
         <lang code="sad">Sandawe</lang>
         <lang code="sag">Sango</lang>
         <lang code="sg">Sango</lang>
         <lang code="sah">Yakut</lang>
         <lang code="sai">South American Indian (Other)</lang>
         <lang code="sal">Salishan languages</lang>
         <lang code="sam">Samaritan Aramaic</lang>
         <lang code="san">Sanskrit</lang>
         <lang code="sa">Sanskrit</lang>
         <lang code="sas">Sasak</lang>
         <lang code="sat">Santali</lang>
         <lang code="scc">Serbian</lang>
         <lang code="srp">Serbian</lang>
         <lang code="sr">Serbian</lang>
         <lang code="scn">Sicilian</lang>
         <lang code="sco">Scots</lang>
         <lang code="scr">Croatian</lang>
         <lang code="hrv">Croatian</lang>
         <lang code="hr">Croatian</lang>
         <lang code="sel">Selkup</lang>
         <lang code="sem">Semitic (Other)</lang>
         <lang code="sga">Irish, Old (to 900)</lang>
         <lang code="sgn">Sign Languages</lang>
         <lang code="shn">Shan</lang>
         <lang code="sid">Sidamo</lang>
         <lang code="sin">Sinhala or Sinhalese</lang>
         <lang code="si">Sinhala or Sinhalese</lang>
         <lang code="sio">Siouan languages</lang>
         <lang code="sit">Sino-Tibetan (Other)</lang>
         <lang code="sla">Slavic (Other)</lang>
         <lang code="slo">Slovak</lang>
         <lang code="slk">Slovak</lang>
         <lang code="sk">Slovak</lang>
         <lang code="slv">Slovenian</lang>
         <lang code="sl">Slovenian</lang>
         <lang code="sma">Southern Sami</lang>
         <lang code="sme">Northern Sami</lang>
         <lang code="se">Northern Sami</lang>
         <lang code="smi">Sami languages (Other)</lang>
         <lang code="smj">Lule Sami</lang>
         <lang code="smn">Inari Sami</lang>
         <lang code="smo">Samoan</lang>
         <lang code="sm">Samoan</lang>
         <lang code="sms">Skolt Sami</lang>
         <lang code="sna">Shona</lang>
         <lang code="sn">Shona</lang>
         <lang code="snd">Sindhi</lang>
         <lang code="sd">Sindhi</lang>
         <lang code="snk">Soninke</lang>
         <lang code="sog">Sogdian</lang>
         <lang code="som">Somali</lang>
         <lang code="so">Somali</lang>
         <lang code="son">Songhai languages</lang>
         <lang code="sot">Sotho, Southern</lang>
         <lang code="st">Sotho, Southern</lang>
         <lang code="spa">Spanish or Castilian</lang>
         <lang code="es">Spanish or Castilian</lang>
         <lang code="srd">Sardinian</lang>
         <lang code="sc">Sardinian</lang>
         <lang code="srn">Sranan Tongo</lang>
         <lang code="srr">Serer</lang>
         <lang code="ssa">Nilo-Saharan (Other)</lang>
         <lang code="ssw">Swati</lang>
         <lang code="ss">Swati</lang>
         <lang code="suk">Sukuma</lang>
         <lang code="sun">Sundanese</lang>
         <lang code="su">Sundanese</lang>
         <lang code="sus">Susu</lang>
         <lang code="sux">Sumerian</lang>
         <lang code="swa">Swahili</lang>
         <lang code="sw">Swahili</lang>
         <lang code="swe">Swedish</lang>
         <lang code="sv">Swedish</lang>
         <lang code="syr">Syriac</lang>
         <lang code="tah">Tahitian</lang>
         <lang code="ty">Tahitian</lang>
         <lang code="tai">Tai (Other)</lang>
         <lang code="tam">Tamil</lang>
         <lang code="ta">Tamil</lang>
         <lang code="tat">Tatar</lang>
         <lang code="tt">Tatar</lang>
         <lang code="tel">Telugu</lang>
         <lang code="te">Telugu</lang>
         <lang code="tem">Timne</lang>
         <lang code="ter">Tereno</lang>
         <lang code="tet">Tetum</lang>
         <lang code="tgk">Tajik</lang>
         <lang code="tg">Tajik</lang>
         <lang code="tgl">Tagalog</lang>
         <lang code="tl">Tagalog</lang>
         <lang code="tha">Thai</lang>
         <lang code="th">Thai</lang>
         <lang code="tib">Tibetan</lang>
         <lang code="bod">Tibetan</lang>
         <lang code="bo">Tibetan</lang>
         <lang code="tig">Tigre</lang>
         <lang code="tir">Tigrinya</lang>
         <lang code="ti">Tigrinya</lang>
         <lang code="tiv">Tiv</lang>
         <lang code="tkl">Tokelau</lang>
         <lang code="tlh">Klingon or tlhIngan-Hol</lang>
         <lang code="tli">Tlingit</lang>
         <lang code="tmh">Tamashek</lang>
         <lang code="tog">Tonga (Nyasa)</lang>
         <lang code="ton">Tonga (Tonga Islands)</lang>
         <lang code="to">Tonga (Tonga Islands)</lang>
         <lang code="tpi">Tok Pisin</lang>
         <lang code="tsi">Tsimshian</lang>
         <lang code="tsn">Tswana</lang>
         <lang code="tn">Tswana</lang>
         <lang code="tso">Tsonga</lang>
         <lang code="ts">Tsonga</lang>
         <lang code="tuk">Turkmen</lang>
         <lang code="tk">Turkmen</lang>
         <lang code="tum">Tumbuka</lang>
         <lang code="tup">Tupi languages</lang>
         <lang code="tur">Turkish</lang>
         <lang code="tr">Turkish</lang>
         <lang code="tut">Altaic (Other)</lang>
         <lang code="tvl">Tuvalu</lang>
         <lang code="twi">Twi</lang>
         <lang code="tw">Twi</lang>
         <lang code="tyv">Tuvinian</lang>
         <lang code="udm">Udmurt</lang>
         <lang code="uga">Ugaritic</lang>
         <lang code="uig">Uighur or Uyghur</lang>
         <lang code="ug">Uighur or Uyghur</lang>
         <lang code="ukr">Ukrainian</lang>
         <lang code="uk">Ukrainian</lang>
         <lang code="umb">Umbundu</lang>
         <lang code="und">Undetermined</lang>
         <lang code="urd">Urdu</lang>
         <lang code="ur">Urdu</lang>
         <lang code="uzb">Uzbek</lang>
         <lang code="uz">Uzbek</lang>
         <lang code="vai">Vai</lang>
         <lang code="ven">Venda</lang>
         <lang code="ve">Venda</lang>
         <lang code="vie">Vietnamese</lang>
         <lang code="vi">Vietnamese</lang>
         <lang code="vol">Volapük</lang>
         <lang code="vo">Volapük</lang>
         <lang code="vot">Votic</lang>
         <lang code="wak">Wakashan languages</lang>
         <lang code="wal">Walamo</lang>
         <lang code="war">Waray</lang>
         <lang code="was">Washo</lang>
         <lang code="wel">Welsh</lang>
         <lang code="cym">Welsh</lang>
         <lang code="cy">Welsh</lang>
         <lang code="wen">Sorbian languages</lang>
         <lang code="wln">Walloon</lang>
         <lang code="wa">Walloon</lang>
         <lang code="wol">Wolof</lang>
         <lang code="wo">Wolof</lang>
         <lang code="xal">Kalmyk or Oirat</lang>
         <lang code="xho">Xhosa</lang>
         <lang code="xh">Xhosa</lang>
         <lang code="yao">Yao</lang>
         <lang code="yap">Yapese</lang>
         <lang code="yid">Yiddish</lang>
         <lang code="yi">Yiddish</lang>
         <lang code="yor">Yoruba</lang>
         <lang code="yo">Yoruba</lang>
         <lang code="ypk">Yupik languages</lang>
         <lang code="zap">Zapotec</lang>
         <lang code="zen">Zenaga</lang>
         <lang code="zha">Zhuang or Chuang</lang>
         <lang code="za">Zhuang or Chuang</lang>
         <lang code="znd">Zande languages</lang>
         <lang code="zul">Zulu</lang>
         <lang code="zu">Zulu</lang>
         <lang code="zun">Zuni</lang>
         <lang code="zxx">No linguistic content</lang>
         <lang code="nqo">N'Ko</lang>
         <lang code="zza">Zaza or Dimili or Dimli or Kirdki or Kirmanjki or Zazaki</lang>
   </xsl:variable>


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

   <xsl:function name="lib:repo-code-to-label" as="xs:string?">
     <xsl:param name="code" as="xs:string"/>
     <xsl:value-of select="$repo-codes/repo[@code=$code]"/>
   </xsl:function>


   <xsl:function name="lib:repo-code-to-citation" as="xs:string?">
      <xsl:param name="code" as="xs:string"/>
      <xsl:value-of select="$citation-codes/repo[@code=$code]"/>
   </xsl:function>


   <xsl:function name="lib:physloc-repo-to-route" as="xs:string?">
      <xsl:param name="code" as="xs:string"/>
      <xsl:value-of select="$physloc-codes/repo[@code=$code]"/>
   </xsl:function>


   <xsl:function name="lib:physloc-code-to-label" as="xs:string?">
     <xsl:param name="code" as="xs:string"/>
     <xsl:value-of select="$location-codes/loc[@code=$code]"/>
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

   <xsl:function name="lib:lang-code-to-label" as="xs:string?">
     <xsl:param name="lang" as="xs:string?"/>
     <xsl:value-of select="$language-codes/lang[@code=$lang]"/>
   </xsl:function>

   <!--+
       | Defaults to creator, which probably makes the most sense for archives.
       +-->
   <xsl:function name="lib:role-code-to-uri" as="xs:string">
      <xsl:param name="code" as="xs:string?"/>
      <xsl:variable name="uri" as="xs:string?" select="$lib:role-lookup//role[code eq $code]/uri"/>
      <xsl:choose>
         <xsl:when test="$uri">
            <xsl:value-of select="$uri"/>
         </xsl:when>
         <xsl:otherwise>http://id.loc.gov/vocabulary/relators/cre</xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <xsl:variable name="lib:role-lookup" as="element()">
      <roles>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/act</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Actor</label>
            <code>act</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/adp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Adapter</label>
            <code>adp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/anl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Analyst</label>
            <code>anl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/anm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Animator</label>
            <code>anm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ann</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Annotator</label>
            <code>ann</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/app</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Applicant</label>
            <code>app</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/arc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Architect</label>
            <code>arc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/arr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Arranger</label>
            <code>arr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/acp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Art copyist</label>
            <code>acp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/art</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Artist</label>
            <code>art</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ard</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Artistic director</label>
            <code>ard</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/asg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Assignee</label>
            <code>asg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/asn</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Associated name</label>
            <code>asn</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/att</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Attributed name</label>
            <code>att</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/auc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Auctioneer</label>
            <code>auc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aut</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author</label>
            <code>aut</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aqt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author in quotations or text extracts</label>
            <code>aqt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aft</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author of afterword, colophon, etc.</label>
            <code>aft</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aud</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author of dialog</label>
            <code>aud</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aui</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author of introduction, etc.</label>
            <code>aui</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/aus</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Author of screenplay, etc.</label>
            <code>aus</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ant</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Bibliographic antecedent</label>
            <code>ant</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bnd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Binder</label>
            <code>bnd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bdd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Binding designer</label>
            <code>bdd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/blw</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Blurb writer</label>
            <code>blw</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bkd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Book designer</label>
            <code>bkd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bkp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Book producer</label>
            <code>bkp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bjd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Bookjacket designer</label>
            <code>bjd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bpd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Bookplate designer</label>
            <code>bpd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/bsl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Bookseller</label>
            <code>bsl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cll</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Calligrapher</label>
            <code>cll</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ctg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Cartographer</label>
            <code>ctg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cns</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Censor</label>
            <code>cns</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/chr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Choreographer</label>
            <code>chr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cng</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Cinematographer</label>
            <code>cng</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cli</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Client</label>
            <code>cli</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/clb</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Collaborator</label>
            <code>clb</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/col</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Collector</label>
            <code>col</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/clt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Collotyper</label>
            <code>clt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/clr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Colorist</label>
            <code>clr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cmm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Commentator</label>
            <code>cmm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cwt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Commentator for written text</label>
            <code>cwt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/com</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Compiler</label>
            <code>com</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cpl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Complainant</label>
            <code>cpl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cpt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Complainant-appellant</label>
            <code>cpt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cpe</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Complainant-appellee</label>
            <code>cpe</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cmp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Composer</label>
            <code>cmp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cmt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Compositor</label>
            <code>cmt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ccp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Conceptor</label>
            <code>ccp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cnd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Conductor</label>
            <code>cnd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/con</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Conservator</label>
            <code>con</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/csl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Consultant</label>
            <code>csl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/csp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Consultant to a project</label>
            <code>csp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cos</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestant</label>
            <code>cos</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cot</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestant-appellant</label>
            <code>cot</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/coe</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestant-appellee</label>
            <code>coe</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cts</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestee</label>
            <code>cts</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ctt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestee-appellant</label>
            <code>ctt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cte</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contestee-appellee</label>
            <code>cte</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ctr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contractor</label>
            <code>ctr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ctb</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Contributor</label>
            <code>ctb</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cpc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Copyright claimant</label>
            <code>cpc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cph</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Copyright holder</label>
            <code>cph</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/crr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Corrector</label>
            <code>crr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/crp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Correspondent</label>
            <code>crp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cst</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Costume designer</label>
            <code>cst</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cov</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Cover designer</label>
            <code>cov</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cre</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Creator</label>
            <code>cre</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/cur</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Curator of an exhibition</label>
            <code>cur</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dnc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Dancer</label>
            <code>dnc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dtc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Data contributor</label>
            <code>dtc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dtm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Data manager</label>
            <code>dtm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dte</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Dedicatee</label>
            <code>dte</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dto</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Dedicator</label>
            <code>dto</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dfd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Defendant</label>
            <code>dfd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dft</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Defendant-appellant</label>
            <code>dft</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dfe</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Defendant-appellee</label>
            <code>dfe</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dgg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Degree grantor</label>
            <code>dgg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dln</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Delineator</label>
            <code>dln</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dpc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Depicted</label>
            <code>dpc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dpt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Depositor</label>
            <code>dpt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dsr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Designer</label>
            <code>dsr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/drt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Director</label>
            <code>drt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dis</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Dissertant</label>
            <code>dis</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dbp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Distribution place</label>
            <code>dbp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dst</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Distributor</label>
            <code>dst</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dnr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Donor</label>
            <code>dnr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/drm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Draftsman</label>
            <code>drm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/dub</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Dubious author</label>
            <code>dub</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/edt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Editor</label>
            <code>edt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/elg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Electrician</label>
            <code>elg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/elt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Electrotyper</label>
            <code>elt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/eng</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Engineer</label>
            <code>eng</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/egr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Engraver</label>
            <code>egr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/etr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Etcher</label>
            <code>etr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/evp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Event place</label>
            <code>evp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/exp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Expert</label>
            <code>exp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/fac</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Facsimilist</label>
            <code>fac</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/fld</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Field director</label>
            <code>fld</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/flm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Film editor</label>
            <code>flm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/fpy</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>First party</label>
            <code>fpy</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/frg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Forger</label>
            <code>frg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/fmo</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Former owner</label>
            <code>fmo</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/fnd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Funder</label>
            <code>fnd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/gis</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Geographic information specialist</label>
            <code>gis</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/hnr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Honoree</label>
            <code>hnr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/hst</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Host</label>
            <code>hst</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ilu</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Illuminator</label>
            <code>ilu</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ill</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Illustrator</label>
            <code>ill</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ins</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Inscriber</label>
            <code>ins</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/itr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Instrumentalist</label>
            <code>itr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ive</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Interviewee</label>
            <code>ive</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ivr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Interviewer</label>
            <code>ivr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/inv</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Inventor</label>
            <code>inv</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lbr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Laboratory</label>
            <code>lbr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ldr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Laboratory director</label>
            <code>ldr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/led</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Lead</label>
            <code>led</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lsa</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Landscape architect</label>
            <code>lsa</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/len</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Lender</label>
            <code>len</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lil</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelant</label>
            <code>lil</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lit</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelant-appellant</label>
            <code>lit</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lie</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelant-appellee</label>
            <code>lie</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lel</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelee</label>
            <code>lel</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/let</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelee-appellant</label>
            <code>let</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lee</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Libelee-appellee</label>
            <code>lee</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lbt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Librettist</label>
            <code>lbt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lse</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Licensee</label>
            <code>lse</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lso</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Licensor</label>
            <code>lso</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lgd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Lighting designer</label>
            <code>lgd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ltg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Lithographer</label>
            <code>ltg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/lyr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Lyricist</label>
            <code>lyr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mfr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Manufacturer</label>
            <code>mfr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mrb</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Marbler</label>
            <code>mrb</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mrk</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Markup editor</label>
            <code>mrk</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mdc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Metadata contact</label>
            <code>mdc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mte</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Metal-engraver</label>
            <code>mte</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mod</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Moderator</label>
            <code>mod</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mon</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Monitor</label>
            <code>mon</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mcp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Music copyist</label>
            <code>mcp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/msd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Musical director</label>
            <code>msd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/mus</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Musician</label>
            <code>mus</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/nrt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Narrator</label>
            <code>nrt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/opn</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Opponent</label>
            <code>opn</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/orm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Organizer of meeting</label>
            <code>orm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/org</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Originator</label>
            <code>org</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/oth</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Other</label>
            <code>oth</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/own</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Owner</label>
            <code>own</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ppm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Papermaker</label>
            <code>ppm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pta</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Patent applicant</label>
            <code>pta</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pth</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Patent holder</label>
            <code>pth</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pat</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Patron</label>
            <code>pat</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prf</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Performer</label>
            <code>prf</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pma</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Permitting agency</label>
            <code>pma</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pht</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Photographer</label>
            <code>pht</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ptf</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Plaintiff</label>
            <code>ptf</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ptt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Plaintiff-appellant</label>
            <code>ptt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pte</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Plaintiff-appellee</label>
            <code>pte</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/plt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Platemaker</label>
            <code>plt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Printer</label>
            <code>prt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pop</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Printer of plates</label>
            <code>pop</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Printmaker</label>
            <code>prm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Process contact</label>
            <code>prc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pro</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Producer</label>
            <code>pro</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pmm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Production manager</label>
            <code>pmm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Production personnel</label>
            <code>prd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/prg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Programmer</label>
            <code>prg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pdr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Project director</label>
            <code>pdr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pfr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Proofreader</label>
            <code>pfr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pup</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Publication place</label>
            <code>pup</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pbl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Publisher</label>
            <code>pbl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/pbd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Publishing director</label>
            <code>pbd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ppt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Puppeteer</label>
            <code>ppt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rcp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Recipient</label>
            <code>rcp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rce</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Recording engineer</label>
            <code>rce</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/red</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Redactor</label>
            <code>red</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ren</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Renderer</label>
            <code>ren</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rpt</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Reporter</label>
            <code>rpt</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rps</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Repository</label>
            <code>rps</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rth</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Research team head</label>
            <code>rth</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rtm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Research team member</label>
            <code>rtm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/res</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Researcher</label>
            <code>res</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rsp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Respondent</label>
            <code>rsp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rst</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Respondent-appellant</label>
            <code>rst</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rse</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Respondent-appellee</label>
            <code>rse</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rpy</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Responsible party</label>
            <code>rpy</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rsg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Restager</label>
            <code>rsg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rev</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Reviewer</label>
            <code>rev</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/rbr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Rubricator</label>
            <code>rbr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sce</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Scenarist</label>
            <code>sce</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sad</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Scientific advisor</label>
            <code>sad</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/scr</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Scribe</label>
            <code>scr</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/scl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Sculptor</label>
            <code>scl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/spy</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Second party</label>
            <code>spy</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sec</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Secretary</label>
            <code>sec</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/std</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Set designer</label>
            <code>std</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sgn</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Signer</label>
            <code>sgn</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sng</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Singer</label>
            <code>sng</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sds</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Sound designer</label>
            <code>sds</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/spk</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Speaker</label>
            <code>spk</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/spn</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Sponsor</label>
            <code>spn</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/stm</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Stage manager</label>
            <code>stm</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/stn</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Standards body</label>
            <code>stn</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/str</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Stereotyper</label>
            <code>str</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/stl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Storyteller</label>
            <code>stl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/sht</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Supporting host</label>
            <code>sht</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/srv</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Surveyor</label>
            <code>srv</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/tch</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Teacher</label>
            <code>tch</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/tcd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Technical director</label>
            <code>tcd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/ths</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Thesis advisor</label>
            <code>ths</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/trc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Transcriber</label>
            <code>trc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/trl</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Translator</label>
            <code>trl</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/tyd</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Type designer</label>
            <code>tyd</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/tyg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Typographer</label>
            <code>tyg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/uvp</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>University place</label>
            <code>uvp</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/vdg</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Videographer</label>
            <code>vdg</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/voc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Vocalist</label>
            <code>voc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/wit</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Witness</label>
            <code>wit</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/wde</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Wood-engraver</label>
            <code>wde</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/wdc</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Woodcutter</label>
            <code>wdc</code>
         </role>
         <role>
            <uri>http://id.loc.gov/vocabulary/relators/wam</uri>
            <ns>http://id.loc.gov/vocabulary/relators/</ns>
            <label>Writer of accompanying material</label>
            <code>wam</code>
         </role>
      </roles>
   </xsl:variable>
</xsl:stylesheet>
