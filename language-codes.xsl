<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:lib="http://findingaids.princeton.edu/pulfa/2/lib"
   xmlns:eac="urn:isbn:1-931666-33-4"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="2.0">

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

   <xsl:function name="lib:lang-code-to-label" as="xs:string?">
      <xsl:param name="lang" as="xs:string?"/>
      <xsl:value-of select="$language-codes/lang[@code=$lang]"/>
   </xsl:function>   
</xsl:stylesheet>
