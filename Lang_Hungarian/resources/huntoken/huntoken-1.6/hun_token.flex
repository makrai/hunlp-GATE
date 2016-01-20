%option noyywrap

/* hun_token - sz�ra bont�, �s ny�lttokenoszt�ly-felismer� lexikai elemz� */
/* 2003 (c) N�meth L�szl� <nemethl@gyorsposta.hu> */

/****************************************************************************************/
/* �llapotok */

%s S SENTENCE_BEGIN SENTENCE_END OPEN_BEGIN SFX SFX_K SFX_E SFX_J SFX_END SFX_NOT

/****************************************************************************************/
/*  Makr�defin�ci�k									*/

/* HTML 4.0 ISO 8859-1 karakterentit�sok, amelyek el�fordulhatnak a szavakban */

LATIN1 "&Agrave;"|"&Atilde;"|"&Aring;"|"&AElig;"|"&Egrave;"|"&Ecirc;"|"&Igrave;"|"&Iuml;"|"&ETH;"|"&Ntilde;"|"&Ograve;"|"&Oslash;"|"&Ugrave;"|"&THORN;"|"&agrave;"|"&atilde;"|"&aring;"|"&aelig;"|"&egrave;"|"&ecirc;"|"&igrave;"|"&iuml;"|"&eth;"|"&ntilde;"|"&ograve;"|"&oslash;"|"&ugrave;"|"&thorn;"|"&yuml;"

/* HTML 4.0 ISO szimb�lum karakterentit�sok */
/* XXX t�zszeres�re n�veli a flex forr�st �s a ford�t�si id�t a szimb�lumok kezel�se, */
/* de a sz�r� hat�konys�ga nem cs�kken */

SYMBOLS "&pi;"

/* |"&fnof;"|"&Alpha;"|"&Beta;"|"&Gamma;"|"&Delta;"|"&Epsilon;"|"&Zeta;"|"&Eta;"|"&Theta;"|"&Iota;"|"&Kappa;"|"&Lambda;"|"&Mu;"|"&Nu;"|"&Xi;"|"&Omicron;"|"&Pi;"|"&Rho;"|"&Sigma;"|"&Tau;"|"&Upsilon;"|"&Phi;"|"&Chi;"|"&Psi;"|"&Omega;"|"&alpha;"|"&beta;"|"&gamma;"|"&delta;"|"&epsilon;"|"&zeta;"|"&eta;"|"&theta;"|"&iota;"|"&kappa;"|"&lambda;"|"&mu;"|"&nu;"|"&xi;"|"&omicron;"|"&pi;"|"&rho;"|"&sigmaf;"|"&sigma;"|"&tau;"|"&upsilon;"|"&phi;"|"&chi;"|"&psi;"|"&omega;"|"&thetasym;"|"&upsih;"|"&piv;"|"&bull;"|"&hellip;"|"&prime;"|"&Prime;"|"&oline;"|"&frasl;"|"&weierp;"|"&image;"|"&real;"|"&trade;"|"&alefsym;"|"&larr;"|"&uarr;"|"&rarr;"|"&darr;"|"&harr;"|"&crarr;"|"&lArr;"|"&uArr;"|"&rArr;"|"&dArr;"|"&hArr;"|"&forall;"|"&part;"|"&exist;"|"&empty;"|"&nabla;"|"&isin;"|"&notin;"|"&ni;"|"&prod;"|"&sum;"|"&minus;"|"&lowast;"|"&radic;"|"&prop;"|"&infin;"|"&ang;"|"&and;"|"&or;"|"&cap;"|"&cup;"|"&int;"|"&there4;"|"&sim;"|"&cong;"|"&asymp;"|"&ne;"|"&equiv;"|"&le;"|"&ge;"|"&sub;"|"&sup;"|"&nsub;"|"&sube;"|"&supe;"|"&oplus;"|"&otimes;"|"&perp;"|"&sdot;"|"&lceil;"|"&rceil;"|"&lfloor;"|"&rfloor;"|"&lang;"|"&rang;"|"&loz;"|"&spades;"|"&clubs;"|"&hearts;"|"&diams;") */

/*  WORDCHARS: A szavak az ISO-8859-2 bet�i mellett sz�mokat, pontot,			*/
/*  paragrafus-, fok-, sz�zal�k- �s k�t�jelet, valamint HTML entit�sk�nt megadva	*/
/*  nagyk�t�jelet (&ndash;), valamint kvirtm�nuszt (&mdash;) tartalmazhatnak,		*/
/*  tov�bb� bet�szerepre nem vizsg�lt decim�lis UNICODE entit�st (p�ld�ul &345;).	*/
/*  Az ISO-8859-2 bet�i a locale csomag alapj�n automatikusan lettek kiv�logatva.	*/
/*  Tov�bbi inform�ci�k: man iso-8859-2.									*/

/* fok, �s sz�zal�kjel kiv�ve */

WORDCHARS ({LATIN1}|[a-zA-Z������������������\-_/�0-9���������������������������������������������������������������]|"&ndash;"|"&mdash;"|"&"[0-9]+";"?)

/* bet�karakterek a fok, sz�zal�kjel, �s k�t�jel kiv�tel�vel */

LETTERS   ({LATIN1}|[a-zA-Z������������������\\/�0-9���������������������������������������������������������������]|"&ndash;"|"&mdash;"|"&"[0-9]+";"?)

/* mint az el�z�, sz�mok �s perjel n�lk�l */

LETTERS2 ([a-zA-Z�����������������ۧ���������������������������������������������������������������]|"&ndash;"|"&mdash;"|"&"[0-9]+";"?)

/* nem sz�karakter */
NONWORDCHAR ([^a-zA-Z������������������\-.�%�0-9���������������������������������������������������������������])

/* egyszer� mondathat�rok, kiv�ve a sz�n bel�li pont */
BOUNDARY ([.?!])

/* mondathat�r ut�n j�het� z�r� id�z�jelek. */
ENDQUOPAR ("\""|"&rdquo""r"?";"?|"&laquo;"|"&quot;"|"''"|"'"|")"|"]"){BOUNDARY}*

/* sz�k�z */

SPACE " "

SP_TEL ({SPACE}|"-")

/* Tartom�nyn�v */
/* Megengedj�k a magyar �kezetes bet�ket is. (Az �jabb szabv�nyok Unicode-ot is.) */

DOMAIN ([a-zA-Z������������������\-0-9_]+".")+([a-zA-Z������������������])+

DOMAIN2 ([a-zA-Z������������������\-0-9_]+"."?)+

SDOMAIN (".hu"|".HU"|".org"|".ORG"|".com"|".COM"|".net"|".NET"|".info"|".INFO"|".edu"|".EDU"|".gov"|".GOV"|".mil"|".MIL")

/* IP sz�m */

IP ([0-9]{1,3}"."){3}[0-9]{1,3}

/* �tvonal �llom�nyrendszerben */

PATH (([A-Z]":""\\"?|[a-z]":\\")|([A-Z]":""\\"?|"/"|"\\\\"|[a-z]":\\")((".""."*[\\/])|(({LETTERS}|[.~_*])({LETTERS}|[\-.~_*])*({LETTERS}|"*")+[\\/]*))+)

/* protokollazonos�t� */

PROTOKOLL [a-zA-Z������������������]+"://""/"*

/* kiterjeszt�sek */

EXT (".")[a-zA-Z]{1,4}

EXT_TEXT "txt"|"TXT"|"pdf"|"PDF"|"ps"|"PS"|"htm"|"HTM"|"html"|"HTML"|"xml"|"XML"
EXT_PIC "jpg"|"JPG"|"jpeg"|"JPEG"|"gif"|"GIF"|"png"|"PNG"|"bmp"|"BMP"|"tif"|"TIF"|"tiff"|"TIFF"
EXT_AUDIO "wav"|"WAV"|"mp3"|"MP3"|"ogg"|"OGG"|".au"|".AU"|"mid"|"MID"
EXT_VIDEO "mpeg"|"MPEG"|"avi"|"AVI"|"asf"|"ASF"
EXT_ARCHIV "tar"|"TAR"|"zip"|"ZIP"|"gz"|"GZ"|"bz2"|"BZ2"|"tgz"|"TGZ"|"rar"|"RAR"|"ace"|"ACE"
EXT_DOS "exe"|"EXE"|"com"|"COM"|"bat"|"BAT"|"ini"|"INI"|"dll"|"DLL"|".bak"|".BAK"|"sys"|"SYS"
EXT_MS "rtf"|"RTF"|"doc"|"DOC"|"dot"|"DOT"|"xsl"|"XSL"|"ppt"|"PPT"
EXT_UNIX "so"|"SO"|"."[1-9]|".old"|".OLD"|"orig"|"ORIG"
EXT_PRG ".c"|".C"|".h"|".H"|"pas"|"PAS"|"bas"|"BAS"|"cpp"|"CPP"|".o"|".O"|"asm"|"ASM"|"pl"|"py"|"php"|"PHP"|"php3"|"PHP3"|"php4"|"PHP4"|"asp"|"ASP"

EXT_BASE ({EXT_TEXT}|{EXT_PIC}|{EXT_AUDIO}|{EXT_VIDEO}|{EXT_ARCHIV}|{EXT_DOS}|{EXT_MS}|{EXT_UNIX}|{EXT_PRG})("."{EXT_ARCHIV})?

/* �ra */

HOUR (([0-1]?[0-9])|([2]?[0-4]))
HOUR2 (([0-1][0-9])|([2][0-4]))

/* perc */

MIN [0-5]?[0-9]
MIN2 [0-5][0-9]

/* h�nap r�mai sz�mmal */

MONTH_ROMAN ([VX]?"I"{1,3}|"I"?[VX])

/* sz�k�z�kkel, vagy - helyesen - sp�ciummal tagolt sz�mok, pl. 12 000 */

NUMSPACE [0-9]{1,3}(({SPACE}|"&thinsp;")[0-9]{3})+

/* ponttal tagolt sz�mok, pl. 12.000 */

NUMDOT [0-9]{1,3}("."[0-9]{3})+

NUMDIGIT ([0-9]+",")?[0-9]+

NUMSPACEDIGIT {NUMSPACE}(","{NUMSPACE})?

NUMDOTDIGIT {NUMDOT}","([0-9]{1,3}|{NUMDOT})

NUM [+-]?([0-9]+|{NUMDIGIT}|{NUMSPACEDIGIT}|{NUMDOTDIGIT})

NUMRANGE {NUM}(("-""-"?|"&mdash;"|"&ndash;"){NUM})?

/* fontosabb SI m�rt�kegys�gek */

SI ("m"[2-3]?|[AbBNVWJgl]|"Pa")

/* egy�b m�rt�kegys�gek */

NSI ("bar"|"l"|"t"|"h"|"min"|"�C"|"ha")

/* m�rt�kegys�gek */

MEASURE ((([pn]|"&mu;"|[mcdkMGT])?{SI})|{NSI})

/* formula */

FORMULA ("="|"sin"|"cos"|"tg"|"log"|"ln"|{SYMBOLS})
NUMSIGN [-+(0-9[\](){}%]*[a-z]{FORMULA}*[()[\]{}0-9%]*
OPERATOR [-+/*=]

/* k�zpontoz�s */

/* &lsquor; - k�ls� nyit� id�z�jel */
/* &rdquo; vagy &rdquor; - k�ls� z�r� id�z�jel */
/* &raquo; - bels� nyit� id�z�jel */
/* &laquo; - bels� z�r� id�z�jel */
/* &hellip; - h�rom pont */
/* &ndash; - gondolatjel v. nagyk�t�jel */
/* XXX &mdash; - kvirtm�nusz (hiba, ha magyar sz�vegben el�fordul) */
/* a kisk�t�jel (-) gondolatjelk�nt val� haszn�lata szint�n hiba  */

PUNCT ([.,;?!()[\]{}:"'\-]|"&lsquor;"|"&ldquor;"|"&rdquo""r"?";"?|"&raquo;"|"&laquo;"|"&hellip;"|"..."|"&ndash;"|"&mdash;"|"&gt;"|"&lt"";")

PUNCT2 ([.,;?!()[\]{}:"'\-&\n])

WORDSPLIT (" "|{PUNCT2})

/* HTML numerikus entit�s */

HTMLNUM "&#"([0-9]+|[xX][0-9a-fA-F]+)";"?

/* mosolyjel (smiley) */

SMILEY ([:;B]"-"[)(]+)

	/* kimenet form�tuma */

	#define FORMAT_UJ "<w>%s%s\n<anav>\n<msd><lemma>%s</lemma><mscat>[%s]</mscat></msd>\n</anav>\n"
	#define FORMAT_UJV "</w>\n"
	#define FORMAT_ANAUJ "<w>%s%s\n<anav>\n<msd><lemma>%s</lemma><mscat>[%s]</mscat></msd>\n</anav>\n"
	#define FORMAT_ANAV "<anav>\n<msd><lemma>%s</lemma><mscat>[%s]</mscat></msd>\n</anav>\n"
	#define FORMAT2 "<w>%s\n</w>\n"
	#define FORMAT3 "<w>%s%s\n</w>\n"

	/* k�t�jelezett szavak elemz�s�hez */
	#define OTHER_WORD_SIGN '!'

	#define OPEN "O---sn------" // alap�rtelmezett MSD k�d msd v�ltoz� inicializ�s�ra
	char msd[13]; // MSD k�d t�rol�s�ra
	char tok[BUFSIZ]; // token t�rol�s�ra
	char sfx[BUFSIZ]; // szuffixum t�rol�s�ra
	int abort_formula = 0; // formula �rv�nytelen�t�s�re
	int abort_slashdot = 0; // macska-/kutyavil�g felismer�s�re

	// felsorol�s a t�bb kateg�ri�ba besorolhat� tokenek kezel�s�hez
	enum { NORMAL, HOUR_DOT_MIN, NUM_DOT_NUM, MON_SLASH_DAY, HOUR_COLON_MIN,
	NUM_COLON_NUM, MON_DASH_DAY, NUM_DASH_NUM, PATH_OR_WEB, NUM_WORD,
	NUM_SLASH_NUM, PATH_OR_IDENT, NUM_LETTER };
	
	// el�z� felsorol�s �rt�keit veszi fel
	int multitoken;

/****************************************************************************************/
/*  Szab�lyok										*/
%%

	/********************************************************************************/
	/* Mondatok felismer�se, feldolgoz� �llapotba (S) l�p�s                         */

<INITIAL>^"<s>" {
	printf("%s", yytext);
	strcpy(msd, OPEN);
	multitoken = NORMAL;
	abort_slashdot = 0;
	BEGIN(SENTENCE_BEGIN);
}

<SENTENCE_BEGIN>[^\n]*"\n" {
        /* mondat k�l�n ki�r�sa */
	printf("%s", yytext);
	yyless(0);
	BEGIN(S);
}

	/********************************************************************************/
	/* 1. z = rossz helyes�r�s� magyar szavak */

	/********************************************************************************/
	/* 2. m(inor/orpheme) = a sz�n�l kisebb tokenek, pl.: A -s�g k�pz� */
	/* 6. h(yphen) = Az el�z�be nem tartoz�, k�t�jellel kezd�d� vagy */
	/* v�gz�d� tokenek. */
	
	/* BE: <s>-nak, -jai�rt, -magyar, bel- */

	/* KI: <s>-nak, -jai�rt, -magyar, bel- */
	
	/* KI: <w>-nak */
	/* KI: <anav> */
	/* KI: <msd><lemma></lemma><mscat>[Om--sg]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>-jai�rt */
	/* KI: <anav> */
	/* KI: <msd><lemma></lemma><mscat>[Om--pc---s3]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>-magyar */
	/* KI: <anav> */
	/* KI: <msd><lemma>-magyar</lemma><mscat>[Oh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>bel- */
	/* KI: <anav> */
	/* KI: <msd><lemma>bel-</lemma><mscat>[Oh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>("-s"[��]"g"|"-"[ght][ae]"t"|"-j"[ae]|"-and�"|"-end�"|"-bb"|"-csk"[ae]|"-zik") {
		msd[1] = 'm';
		tok[0] = '\0';
		strcpy(sfx, yytext);
		BEGIN(SFX);
}	

	/* k�l�nv�lt -e k�rd�sz� nem kap O-s k�dot */

	/* BE: <s>-e */

	/* KI: <s>-e */
	
	/* KI: <w>-e */
	/* KI: </w> */
	/* KI:  */

<S>"-e" {
	printf(FORMAT2,yytext);
}

	/* egy�b toldal�kok keres�se */

<S>"-"[a-zA-Z������������������]+ {
		msd[1] = 'm';
		tok[0] = '\0';
		yyless(1);
		strcpy(sfx, "-");
		BEGIN(SFX);
}	

	/********************************************************************************/
	/* 3. idegen szavak (k�l�n sz�r�vel, pl. MySpell idegen nyelv� - magyar sz�t�rak */

	/********************************************************************************/
	/* 4. e = elektronikus mail c�mek, webhelyek, sz�m�t�g�pes �tvonal */

	/* Legfels� tartom�nyn�v */

	/* BE: <s>.edu .HU */

	/* KI: <s>.edu .HU */

	/* KI: <w>.edu */
	/* KI: <anav> */
	/* KI: <msd><lemma>.edu</lemma><mscat>[Oeo-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.HU */
	/* KI: <anav> */
	/* KI: <msd><lemma>.HU</lemma><mscat>[Oeo-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>({SDOMAIN}|"."[a-zA-Z][a-zA-Z]) {
		/* legfels� tartom�nyn�v */
		open_begin('e', 'o');
}

	/* BE: <s>red-stars.com */

	/* KI: <s>red-stars.com */

	/* KI: <w>red-stars.com */
	/* KI: <anav> */
	/* KI: <msd><lemma>red-stars.com</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>http://www.valami.com */

	/* KI: <s>http://www.valami.com */
	
	/* KI: <w>http://www.valami.com */
	/* KI: <anav> */
	/* KI: <msd><lemma>http://www.valami.com</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>{LETTERS}{WORDCHARS}*{SDOMAIN} {
		/* legfels� tartom�nyn�v */
		open_begin('e', 'w');
}
	/* Legfels� tartom�nyn�v */

	/* BE: <s>valami.comr�l */

	/* KI: <s>valami.comr�l */

	/* KI: <w>valami.comr�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>valami.comr�l</lemma><mscat>[Oep-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>valami.comr�l</lemma><mscat>[Oew-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([hH][tT][tT][pP]"://""/"*)?([wW][wW][wW]".")?([a-zA-Z0-9][-a-zA-Z0-9]*|[a-zA-Z0-9])?{SDOMAIN}{LETTERS}{2,} {
		/* nem k�t�jeles toldal�kkal rendelkez� webhely */
		int i;
		msd[1] = 'e';
		msd[2] = 'p';
		msd[4] = '?';
		msd[5] = '?';
		for (i = 11; msd[i] == '-'; i--);
		msd[i + 1] = '\0';
		printf(FORMAT_ANAUJ, yytext, "", yytext, msd);
		msd[2] = 'w';		
		printf(FORMAT_ANAV, yytext, msd);
		printf(FORMAT_UJV);
	}

	/* URL */

	/* Legfels� tartom�nyn�v */

	/* BE: <s>valami.hu-r�l */

	/* KI: <s>valami.hu-r�l */

	/* KI: <w>valami.hu-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>valami.hu</lemma><mscat>[Oew-sh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>http://valami.hu, www.valami.hu/dinnye.html */

	/* KI: <s>http://valami.hu, www.valami.hu/dinnye.html */

	/* KI: <w>http://valami.hu */
	/* KI: <anav> */
	/* KI: <msd><lemma>http://valami.hu</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>www.valami.hu/dinnye.html */
	/* KI: <anav> */
	/* KI: <msd><lemma>www.valami.hu/dinnye.html</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[hH][tT][tT][pP]"://""/"*{LETTERS}({WORDCHARS}+|[-.%?])* {
		open_begin('e', 'w');
	}


([wW][wW][wW]|[wW][3])"."({DOMAIN2}|{IP})?(":"[0-9]{1,4})?({PATH}|"/")? {
		/* webhely */
		open_begin('e', 'w');
	}


	/* BE: <s>http://www.valami.com/ */

	/* KI: <s>http://www.valami.com/ */
	
	/* KI: <w>http://www.valami.com/ */
	/* KI: <anav> */
	/* KI: <msd><lemma>http://www.valami.com/</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>http://777sms.com:80 */

	/* KI: <s>http://777sms.com:80 */

	/* KI: <w>http://777sms.com:80 */
	/* KI: <anav> */
	/* KI: <msd><lemma>http://777sms.com:80</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>http://777sms.com:80</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>ftp://127.0.0.1:911/Pr�ba/ez-is/macska.jpeg */

	/* KI: <s>ftp://127.0.0.1:911/Pr�ba/ez-is/macska.jpeg */

	/* KI: <w>ftp://127.0.0.1:911/Pr�ba/ez-is/macska.jpeg */
	/* KI: <anav> */
	/* KI: <msd><lemma>ftp://127.0.0.1:911/Pr�ba/ez-is/macska.jpeg</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>ftp://127.0.0.1:911/Pr�ba/ez-is/macska.jpeg</lemma><mscat>[Oew-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */
	
<S>{PROTOKOLL}({DOMAIN}|{IP})?(":"[0-9]{1,4})?({PATH}|"/")? {
		multitoken = PATH_OR_WEB;
		open_begin('e', 'p');
	}

	/* Perjel nem gy�k�rk�nyvt�r, hanem csak sz� */
	
	/* BE: <s>/ */

	/* KI: <s>/ */

	/* KI: <w>/ */
	/* KI: </w> */
	/* KI:  */

<S>"/" {
	printf(FORMAT2,yytext);
}

	/* sz�m �s bet� sorsz�m is lehet (b�r nem helyes) */

	/* BE: <s>2.b */

	/* KI: <s>2.b */

	/* KI: <w>2.b */
	/* KI: <anav> */
	/* KI: <msd><lemma>2.b</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>2.b</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+"."[a-zA-Z] { 
		multitoken = PATH_OR_IDENT;
		open_begin('e', 'p');
	}

	/* BE: <s>3a */

	/* KI: <s>3a */

	/* KI: <w>3a */
	/* KI: <anav> */
	/* KI: <msd><lemma>3a</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>3a</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+[a-zA-Z] { 
		multitoken = NUM_LETTER;
		open_begin('n', 'f');
	}

	/* BE: <s>paprika.comot */

	/* KI: <s>paprika.comot */

	/* KI: <w>paprika.comot */
	/* KI: <anav> */
	/* KI: <msd><lemma>paprika.comot</lemma><mscat>[Oep-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>paprika.comot</lemma><mscat>[Oew-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */


<S>{LETTERS}+{SDOMAIN} { 
		multitoken = PATH_OR_WEB;
		open_begin('e', 'p');
	}

<S>{DOMAIN}{SDOMAIN} {
		multitoken = PATH_OR_WEB;
		open_begin('e', 'p');
}

<S>{DOMAIN}{SDOMAIN}{LETTERS2}+ {
		multitoken = PATH_OR_WEB;
		open_begin('e', 'p');
		msd[4] = '?';
		msd[5] = '?';
}

	/* BE: <s>C: c:\ */

	/* KI: <s>C: c:\ */

	/* KI: <w>C: */
	/* KI: <anav> */
	/* KI: <msd><lemma>C:</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>c:\ */
	/* KI: <anav> */
	/* KI: <msd><lemma>c:\</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>C:\DINNYE\MACSKA.JPG */

	/* KI: <s>C:\DINNYE\MACSKA.JPG */

	/* KI: <w>C:\DINNYE\MACSKA.JPG */
	/* KI: <anav> */
	/* KI: <msd><lemma>C:\DINNYE\MACSKA.JPG</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>\\SZERVER\SZOLGALTATAS$ */

	/* KI: <s>\\SZERVER\SZOLGALTATAS$ */

	/* KI: <w>\\SZERVER\SZOLGALTATAS$ */
	/* KI: <anav> */
	/* KI: <msd><lemma>\\SZERVER\SZOLGALTATAS$</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>/etc/.././home/ */

	/* KI: <s>/etc/.././home/ */

	/* KI: <w>/etc/.././home/ */
	/* KI: <anav> */
	/* KI: <msd><lemma>/etc/.././home/</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>mailto:Macska.Kati@valahol.hu */

	/* KI: <s>mailto:Macska.Kati@valahol.hu */

	/* KI: <w>mailto:Macska.Kati@valahol.hu */
	/* KI: <anav> */
	/* KI: <msd><lemma>mailto:Macska.Kati@valahol.hu</lemma><mscat>[Oem-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>mailto:Macska.Kati@valahol.hur�l */

	/* KI: <s>mailto:Macska.Kati@valahol.hur�l */

	/* KI: <w>mailto:Macska.Kati@valahol.hur�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>mailto:Macska.Kati@valahol.hur�l</lemma><mscat>[Oem-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>{DOMAIN}({PATH}"$"?|"/")? { 
		if (abort_slashdot) {
			abort_slashdot = 0;
			yyless(1);
			printf("<c>/</c>\n");
		} else {
			open_begin('e', 'p');
		}
	}

<S>{DOMAIN}?(":"[0-9]{1,4})?({PATH}"$"?|"/") { 
		open_begin('e', 'p');
	}

<S>("mailto:")?([a-zA-Z������������������\-.]+"@")({DOMAIN}|{IP})?[a-z]*{SDOMAIN} {
		/* e-mail, tartom�nyn�v, IP-c�m */
		open_begin('e', 'm');
	}

<S>("mailto:")?([a-zA-Z������������������\-.]+"@")*({DOMAIN}) {
		/* e-mail, tartom�nyn�v */
		open_begin('e', 'm');
		msd[4] = '?';
		msd[5] = '?';		
	}

	/* BE: <s>ADMIN$ */

	/* KI: <s>ADMIN$ */

	/* KI: <w>ADMIN$ */
	/* KI: <anav> */
	/* KI: <msd><lemma>ADMIN$</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[A-Z]+"$" {
		/* Windows h�l�zati szolg�ltat�s */
		open_begin('e', 'p');
}

	/* �nmagukban el�fordul� kiterjeszt�sek */

	/* BE: <s>txt .AVI .bmp.zip */

	/* KI: <s>txt .AVI .bmp.zip */

	/* KI: <w>txt */
	/* KI: </w> */
	/* KI: <w>.AVI */
	/* KI: <anav> */
	/* KI: <msd><lemma>.AVI</lemma><mscat>[Oee-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.bmp.zip */
	/* KI: <anav> */
	/* KI: <msd><lemma>.bmp.zip</lemma><mscat>[Oee-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>"."{EXT_BASE} {
		/* kiterjeszt�s */
		open_begin('e', 'e');
	}

	/* *.doc, *.* alakok */

	/* BE: <s>*.doc *.* */

	/* KI: <s>*.doc *.* */

	/* KI: <w>*.doc */
	/* KI: <anav> */
	/* KI: <msd><lemma>*.doc</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>*.* */
	/* KI: <anav> */
	/* KI: <msd><lemma>*.*</lemma><mscat>[Oep-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>"*."({EXT_BASE}|"*") {
		/* kiterjeszt�s */
		open_begin('e', 'p');
	}

	/********************************************************************************/
	/* 5. index? Trade Mark/Registered Trade Mark */

<S>{WORDCHARS}+([\231\256]|"&reg"";"|"&2122"";") {
		open_begin('d', '-');
}

	/********************************************************************************/
	/* 6. n(umber) = sz�mok */

	/********************************************************************************/
	/* a) sporteredm�ny */

	/* BE: <s>1:20:36.7, 4:01,95 */

	/* KI: <s>1:20:36.7, 4:01,95 */

	/* KI: <w>1:20:36.7 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:20:36.7</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>4:01,95 */
	/* KI: <anav> */
	/* KI: <msd><lemma>4:01,95</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>(({HOUR}":")*{MIN}":")+{MIN}[,.][0-9]?[0-9] {
		/* a) sporteredm�ny */
		open_begin('n', 'r');
	}

	/* sporteredm�ny, ar�ny �s �ra:perc */

	/* BE: <s>1:35 */

	/* KI: <s>1:35 */

	/* KI: <w>1:35 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:35</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:35</lemma><mscat>[Onq-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:35</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:35</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>{HOUR}":"{MIN2} {
		/* a) ido */
		multitoken = HOUR_COLON_MIN;
		open_begin('n', 't');
	}

	/* sporteredm�ny, �s ar�ny */

	/* BE: <s>1:3 */

	/* KI: <s>1:3 */

	/* KI: <w>1:3 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:3</lemma><mscat>[Onq-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:3</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1:3</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+":"[0-9]+ {
		/* a) sporteredm�ny �s ar�ny */
		multitoken = NUM_COLON_NUM;
		open_begin('n', 'q');
}

	/* sporteredm�ny, h�nap-nap */

	/* BE: <s>10-12 */

	/* KI: <s>10-12 */

	/* KI: <w>10-12 */
	/* KI: <anav> */
	/* KI: <msd><lemma>10-12</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>10-12</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>10-12</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([0][0-9]|[1][0-2])"-"([0-2][0-9]|[3][0-1]) {
		/* c) d�tum k�t�jelekkel */
		multitoken = MON_DASH_DAY;
		open_begin('n', 't');
	}

	/* BE: <s>1-3 */

	/* KI: <s>1-3 */

	/* KI: <w>1-3 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1-3</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>1-3</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+"-"[0-9]+ {
		/* a) sporteredm�ny �s ar�ny */
		multitoken = NUM_DASH_NUM;
		open_begin('n', 'r');
}

	/* BE: <s>0&ndash;5 */

	/* KI: <s>0&ndash;5 */

	/* KI: <w>0&ndash;5 */
	/* KI: <anav> */
	/* KI: <msd><lemma>0&ndash;5</lemma><mscat>[Onr-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* ha baloldalt 0, vagy jobb oldalt 0, vagy 1 (tipikusan foci) */

<S>([0]("-"|"&ndash;"|"&mdash;")[0-9]+|[0-9]+("-"|"&ndash;"|"&mdash;")[01]) {
		/* a) sporteredm�ny */
		open_begin('n', 'r');
	}


	/********************************************************************************/
	/* el�jeles sz�mok */
	
	/* Az el�jelek ut�ni sz�m lehet k�z�kkel tagolt */

	/* BE: <s>-23,12, +12 500, +12.500.000 */

	/* KI: <s>-23,12, +12 500, +12.500.000 */

	/* KI: <w>-23,12 */
	/* KI: <anav> */
	/* KI: <msd><lemma>-23,12</lemma><mscat>[Ons-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>+12 500 */
	/* KI: <anav> */
	/* KI: <msd><lemma>+12 500</lemma><mscat>[Ons-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>+12.500.000 */
	/* KI: <anav> */
	/* KI: <msd><lemma>+12.500.000</lemma><mscat>[Ons-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[+-][0-9]+([.,][0-9]+)? {
		/* b) el�jeles sz�m */
		open_begin('n', 's');
	}

<S>[+-]{NUMSPACE}([.,]{NUMSPACE})? {
		/* b) el�jeles sz�m k�z�kkel */
		open_begin('n', 's');
	}

<S>[+-]{NUMDOT}(","{NUMDOT})? {
		/* b) el�jeles sz�m ponttal hat�rolva */
		open_begin('n', 's');
	}

	/********************************************************************************/
	/* a) id� */

	/* BE: <s>10.35 */

	/* KI: <s>10.35 */

	/* KI: <w>10.35 */
	/* KI: <anav> */
	/* KI: <msd><lemma>10.35</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>10.35</lemma><mscat>[Ond-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>10.35</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>{HOUR}"."{MIN2} {
		/* a) ido */
		multitoken = HOUR_DOT_MIN;
		open_begin('n', 't');
	}

<S>{HOUR}":"{MIN2}":"{MIN2} {
		/* a) ido */
		open_begin('n', 't');
	}

	/********************************************************************************/
	/* d�tumok */
	
	/* BE: <s>2003. 01. 06., 2003-01-06 */

	/* KI: <s>2003. 01. 06., 2003-01-06 */

	/* KI: <w>2003. 01. 06. */
	/* KI: <anav> */
	/* KI: <msd><lemma>2003. 01. 06.</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>2003-01-06 */
	/* KI: <anav> */
	/* KI: <msd><lemma>2003-01-06</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([12]?[0-9]{3}". ")?[01]?[0-9]". "[0-3]?[0-9]"."{WORDSPLIT} {
		/* c) m�gsem d�tum */
                yyless(yyleng - 1);
		open_begin('n', 't');
	}

<S>([12]?[0-9]{3}". ")?[01]?[0-9]". "[0-3]?[0-9]"-" {
		/* c) d�tum */
                yyless(yyleng - 1);
		open_begin('n', 't');
	}

<S>([12]?[0-9]{3}"-")[01]?[0-9]"-"[0-3]?[0-9] {
		/* c) d�tum k�t�jelekkel */
		open_begin('n', 't');
	}

	/* BE: <s>2003. I. 06., IV. 12. */

	/* KI: <s>2003. I. 06., IV. 12. */

	/* KI: <w>2003. I. 06. */
	/* KI: <anav> */
	/* KI: <msd><lemma>2003. I. 06.</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>IV. 12. */
	/* KI: <anav> */
	/* KI: <msd><lemma>IV. 12.</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([12]?[0-9]{3}". ")?{MONTH_ROMAN}". "[0-3]?[0-9]"."{WORDSPLIT} {
		/* c) d�tum */
		yyless(yyleng - 1);
		open_begin('n', 't');
	}

<S>([12]?[0-9]{3}". ")?{MONTH_ROMAN}". "[0-3]?[0-9]"-" {
		/* c) d�tum */
		yyless(yyleng - 1);
		open_begin('n', 't');
        }
	
<S>([12]?[0-9]{3}". "){MONTH_ROMAN}"." {
		/* c) d�tum */
		open_begin('n', 't');
	}

	/********************************************************************************/
	/* XXX hib�s: k�z n�lk�li �s idegen d�tumle�r�s */

	/* BE: <s>2003.01.06., IV.12., 05/12, 2003/05/12 */

	/* KI: <s>2003.01.06., IV.12., 05/12, 2003/05/12 */

	/* KI: <w>2003.01.06. */
	/* KI: <anav> */
	/* KI: <msd><lemma>2003.01.06.</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>IV.12. */
	/* KI: <anav> */
	/* KI: <msd><lemma>IV.12.</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>05/12 */
	/* KI: <anav> */
	/* KI: <msd><lemma>05/12</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>05/12</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>2003/05/12 */
	/* KI: <anav> */
	/* KI: <msd><lemma>2003/05/12</lemma><mscat>[Ont-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([12]?[0-9]{3}".")[01]?[0-9]"."[0-3]?[0-9]"." {
		/* c) d�tum */
		open_begin('n', 't');
	}

<S>[01][0-9]"."[0-3][0-9]"." {
		/* c) d�tum */
		open_begin('n', 't');
	}

<S>([12]?[0-9]{3}".")?{MONTH_ROMAN}(".")[0-3]?[0-9]"." {
		/* c) d�tum */
		open_begin('n', 't');
	}

<S>([12]?[0-9]{3}"/")[01]?[0-9]"/"[0-3]?[0-9] {
		/* c) d�tum */
		open_begin('n', 't');
	}

<S>[01][0-9]"/"[0-3][0-9] {
		/* c) d�tum */
		multitoken = MON_SLASH_DAY;
		open_begin('n', 't');
	}

	/* <S>([12]?[0-9]{3}"/")?{MONTH_ROMAN}"/"[0-3]?[0-9] { */
		/* c) d�tum */
	/*	open_begin('n', 't'); */
	/* } */

	/********************************************************************************/
	/* pontot tartalmaz� sz�mok */

	/* azonos�t� �s sz�m is lehet */
	
	/* BE: <s>25.3 */

	/* KI: <s>25.3 */

	/* KI: <w>25.3 */
	/* KI: <anav> */
	/* KI: <msd><lemma>25.3</lemma><mscat>[Ond-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>25.3</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+"."[0-9]+ {
		/* d) pontot tartalmaz� sz�m */
		multitoken = NUM_DOT_NUM;
		open_begin('n', 'd');
	}

	/* �r�sm� r�sze (azonos�t�) */

	/* BE: <s>1.1.2. 1.3.128-b�l */

	/* KI: <s>1.1.2. 1.3.128-b�l */

	/* KI: <w>1.1.2. */
	/* KI: <anav> */
	/* KI: <msd><lemma>1.1.2.</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>1.3.128-b�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>1.3.128</lemma><mscat>[Oi--se]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* k�tjegy� sz�mok ponttal elv�lasztva, utols� h�romjegy� is lehet */
	/* null�val nem kezd�dhet */

<S>[1-9]([0-9])?"."([0-9]{1,2}".")*[0-9]{1,3}"."? {
		/* d) fejezet �s szakasz azonos�t� */
		open_begin('i', '-');
	}

	/* egy�b pontot tartalmaz� sz�mok */
	
	/* BE: <s>133.000.000 */

	/* KI: <s>133.000.000 */

	/* KI: <w>133.000.000 */
	/* KI: <anav> */
	/* KI: <msd><lemma>133.000.000</lemma><mscat>[Ond-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([0-9]+".")+[0-9]+ {
		/* d) pontot tartalmaz� sz�m */
		open_begin('n', 'd');
	}

	/* BE: <s>123.45/67. */

	/* KI: <s>123.45/67. */

	/* KI: <w>123.45/67. */
	/* KI: <anav> */
	/* KI: <msd><lemma>123.45/67.</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([a-zA-Z0-9]+".")+[0-9]+"/"[a-z0-9]+"."? {
		/* d) pontot ls perjelet tartalmaz� azonos�t� */
		open_begin('i', '-');
	}

	/********************************************************************************/
	/* tizedest�rtek �s t�sz�mnevek */

	/* BE: <s>0,99 133,000 */

	/* KI: <s>0,99 133,000 */

	/* KI: <w>0,99 */
	/* KI: </w> */
	/* KI: <w>133,000 */
	/* KI: </w> */
	/* KI:  */

<S>{NUMDIGIT} {
		/* d) tizedest�rt �s eg�sz sz�mok */
		open_begin('c', '-');
		msd[0] = 'M';
	}

	/* BE: <s>1,5-2,5, 1-2,5, 1,5-2 */

	/* KI: <s>1,5-2,5, 1-2,5, 1,5-2 */

	/* KI: <w>1,5-2,5 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1,5-2,5</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>1-2,5 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1-2,5</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>1,5-2 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1,5-2</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([0-9]+",")*[0-9]+("-"|"&ndash;")[0-9]+","[0-9]+ {
		open_begin('n', 'f');
	}

<S>[0-9]+","[0-9]+("-"|"&ndash;")([0-9]+",")*[0-9]+ {
		open_begin('n', 'f');
	}



	/********************************************************************************/
	/* sorsz�mok: 15.-r�l, 2002-2003. */

	/* BE: <s>2002-2003., 15.-r�l  */

	/* KI: <s>2002-2003., 15.-r�l  */

	/* KI: <w>2002-2003. */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>15.-r�l */
	/* KI: </w> */
	/* KI:  */

<S>(([0-9]+",")?[0-9]+("-"|"&ndash;"|"&mdash;"))?([0-9]+",")?[0-9]+"." {
		open_begin('c', '-');
		msd[0] = 'M';
	}

	/********************************************************************************/
	/* % jelet tartalmaz� sz�m */

	/* BE: <s>-0,99% 133,000%-kal 10-20%-kal */

	/* KI: <s>-0,99% 133,000%-kal 10-20%-kal */

	/* KI: <w>-0,99% */
	/* KI: <anav> */
	/* KI: <msd><lemma>-0,99%</lemma><mscat>[Onp-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>133,000%-kal */
	/* KI: <anav> */
	/* KI: <msd><lemma>133,000%</lemma><mscat>[Onp-si]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>10-20%-kal */
	/* KI: <anav> */
	/* KI: <msd><lemma>10-20%</lemma><mscat>[Onp-si]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[%/��] {
	printf(FORMAT2, yytext);
}

<S>[+-]?([0-9]+[-])?[0-9]+(","[0-9]+)?" "?"%-a" {
		/* d) sz�zal�k -a toldal�kkal */
                yyless(yyleng - 2);
		open_begin('n', 'p');
	}

<S>[+-]?([0-9]+[-])?[0-9]+(","[0-9]+)?" "?"%" {
		/* d) sz�zal�k */
		open_begin('n', 'p');
	}

<S>[+-]?[0-9]+("."[0-9]+)?" "?"%-a" {
		/* d) sz�zal�k, XXX hib�s a tizedespont haszn�lata, -a toldal�kkal */
                yyless(yyleng - 2);
		open_begin('n', 'p');
	}

<S>[+-]?[0-9]+("."[0-9]+)?" "?"%" {
		/* d) sz�zal�k, XXX hib�s a tizedespont haszn�lata */
		open_begin('n', 'p');
	}

	/********************************************************************************/
	/* fokjelet tartalmaz� token */

	/* BE: <s>5�, �C */

	/* KI: <s>5�, �C */

	/* KI: <w>5� */
	/* KI: <anav> */
	/* KI: <msd><lemma>5�</lemma><mscat>[Ong-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>�C */
	/* KI: </w> */
	/* KI:  */

<S>"�"[CF] {
		printf(FORMAT2, yytext);
	}

<S>[+-]?[0-9]*(","[0-9]+)?"�" {
		/* d) sz�zal�k */
		open_begin('n', 'g');
	}

<S>[+-]?[0-9]*("."[0-9]+)?"�" {
		/* d) sz�zal�k XXX hib�s a tizedespont haszn�lata */
		open_begin('n', 'g');
	}

	/********************************************************************************/
	/* &yen tartalm� sz�veg */

	/* BE: <s>600&yen;2400 */

	/* KI: <s>600&yen;2400 */

	/* KI: <w>600&yen;2400 */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+"&yen;"[0-9]+ {
	printf(FORMAT2,yytext);
}

	/********************************************************************************/
	/* sz�k�z�kkel tagolt sz�m */

	/* BE: <s>12 500,1 231, 12.500,12  */

	/* KI: <s>12 500,1 231, 12.500,12  */

	/* KI: <w>12 500,1 231 */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>12.500,12 */
	/* KI: </w> */
	/* KI:  */

<S>{NUMSPACEDIGIT} {
		/* sz�k�z�kkel tagolt sz�m */
		open_begin('c', '-');
		msd[0] = 'M';
		msd[6] = 'd';
	}

<S>{NUMDOTDIGIT} {
		/* pontokkal tagolt sz�m */
		open_begin('c', '-');
		msd[0] = 'M';
		msd[6] = 'd';
	}

	/********************************************************************************/
	/* sz�m �s t�sz�mn�v */

	/* BE: <s>63 milli�, 23 ezerr�l, 3 ezret, 23 milli�rdosnak, 1,5-2,5 milli�t */

	/* KI: <s>63 milli�, 23 ezerr�l, 3 ezret, 23 milli�rdosnak, 1,5-2,5 milli�t */

	/* KI: <w>63 milli� */
	/* KI: <anav> */
	/* KI: <msd><lemma>63 milli�</lemma><mscat>[Mc--snd]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>23 ezerr�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>23 ezer</lemma><mscat>[Mc--shd]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>3 ezret */
	/* KI: <anav> */
	/* KI: <msd><lemma>3 ezret</lemma><mscat>[Mc--??d]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>23 */
	/* KI: </w> */
	/* KI: <w>milli�rdosnak */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>1,5-2,5 milli�t */
	/* KI: <anav> */
	/* KI: <msd><lemma>1,5-2,5 milli�</lemma><mscat>[Mc--sad]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>{NUMRANGE}" "("milli�s"|"milli�rdos"|"billi�s"|"trilli�s") {
		/* sz�tv�lasztjuk */
		int i;
		for (i = yyleng; yytext[i] != ' '; i--);
		yyless(i);
		open_begin('c', '-');
		msd[0] = 'M';
		BEGIN(SFX_END);
	}

<S>{NUMRANGE}" "("ezerszer"|"milli�szor"|"milli�rdszor"|"billi�szor"|"trilli�szor") {
		/* sz�m �s t�sz�mn�v */
		msd[1] = 'c';
		sfx[0] = '\0';
		msd[0] = 'M';
		multitoken= NUM_WORD;
		strcpy(tok, yytext);
		BEGIN(SFX_END);
	}

<S>{NUMRANGE}" "("ezret") {
		/* sz�m �s t�sz�mn�v */
		msd[1] = 'c';
		sfx[0] = '\0';
		msd[0] = 'M';
		msd[4] = '?';
		msd[5] = '?';
		msd[6] = 'd';
		multitoken= NUM_WORD;
		strcpy(tok, yytext);
		BEGIN(SFX_END);
	}

<S>{NUMRANGE}" "("ezerszeres"|"milli�szoros"|"milli�rdszoros"|"billi�szoros"|"trilli�szoros"){WORDCHARS} {
		/* sz�m �s t�sz�mn�v */
		msd[1] = 'c';
		sfx[0] = '\0';
		msd[0] = 'M';
		multitoken= NUM_WORD;
		msd[4] = '?';
		msd[5] = '?';
		msd[6] = 'd';
		yyless(yyleng - 1);
		strcpy(tok, yytext);
		BEGIN(SFX);
	}

<S>{NUMRANGE}" "("ezredik"|"milliomodik"|"milli�rdodik"|"billiomodik"|"trilliomodik"){WORDCHARS} {
		/* sz�m �s t�sz�mn�v */
		msd[1] = 'o';
		sfx[0] = '\0';
		msd[0] = 'M';
		multitoken= NUM_WORD;
		msd[4] = '?';
		msd[5] = '?';
		msd[6] = 'd';
		yyless(yyleng - 1);
		strcpy(tok, yytext);
		BEGIN(SFX);
	}

<S>{NUMRANGE}" "("ezer"|"milli�"|"milli�rd"|"billi�"|"trilli�"){WORDCHARS} {
		/* sz�m �s t�sz�mn�v */
		msd[1] = 'c';
		sfx[0] = '\0';
		msd[0] = 'M';
		multitoken= NUM_WORD;
		msd[4] = 's';
		msd[5] = 'n';
		msd[6] = 'd';
		yyless(yyleng - 1);
		strcpy(tok, yytext);
		BEGIN(SFX);
	}

<S>{NUMRANGE}" "("ezer"|"milli�"|"milli�rd"|"billi�"|"trilli�"). {
		/* sz�m �s t�sz�mn�v */
		yyless(yyleng - 1);
		open_begin('c', '-');
		multitoken= NUM_WORD;
		msd[4] = 's';
		msd[5] = 'n';
		msd[6] = 'd';
		msd[0] = 'M';
		BEGIN(SFX_END);
	}

	/********************************************************************************/
	/* ar�ny */

	/* BE: <s>1645kJ/1000g 1645 kJ/100 g */

	/* KI: <s>1645kJ/1000g 1645 kJ/100 g */

	/* KI: <w>1645kJ/1000g */
	/* KI: <anav> */
	/* KI: <msd><lemma>1645kJ/1000g</lemma><mscat>[Onq-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>1645 kJ/100 g */
	/* KI: <anav> */
	/* KI: <msd><lemma>1645 kJ/100 g</lemma><mscat>[Onq-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */
	
<S>[0-9]+" "?{MEASURE}" "?"/"" "?[0-9]*" "?{MEASURE} {
	if (abort_formula == 1) {
		abort_formula = 0;
		REJECT;
	} else {
		open_begin('n','q');
	}
}

<S>[0-9]+" "?{MEASURE}" "?"/"" "?[0-9]*" "?{MEASURE}{LETTERS}+ {
	abort_formula = 1;
	REJECT;
}

	/********************************************************************************/
	/* m�ret */

	/* BE: <s>800x600, 12&times; 1x2x3x4 */

	/* KI: <s>800x600, 12&times; 1x2x3x4 */

	/* KI: <w>800x600 */
	/* KI: <anav> */
	/* KI: <msd><lemma>800x600</lemma><mscat>[Onm-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>12&times; */
	/* KI: <anav> */
	/* KI: <msd><lemma>12&times;</lemma><mscat>[Onm-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>1x2x3x4 */
	/* KI: <anav> */
	/* KI: <msd><lemma>1x2x3x4</lemma><mscat>[Onm-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+("x"|"&times;")([0-9]+)? {
		/* sz�k�z�kkel tagolt sz�m */
		open_begin('n', 'm');
	}

<S>[0-9]+(("x"|"&times;")([0-9]+))+ {
		/* sz�k�z�kkel tagolt sz�m */
		open_begin('n', 'm');
	}

	/**********************/
	/* formula az azonos�t�k ut�n */

	/********************************************************************************/
	/* 7. azonos�t�k */

	/* szabv�ny jelzete (www.mszt.hu) */
	/* MSZ 11434:1996, MSZ EN ISO 30011-2:1993, MSZ EN 456-1, */
	/* MSZ IEC 745-2-13, MSZ-05-96.0820, DIN 345, EN 3434-34) */
	/* MSZ-09-10.0346:1990, MSZ-09 KGST 2345:1980 */

	/* BE: <s>MSZ EN ISO 30011-2:1993, MSZ-09-10.0346:1990 */

	/* KI: <s>MSZ EN ISO 30011-2:1993, MSZ-09-10.0346:1990 */

	/* KI: <w>MSZ EN ISO 30011-2:1993 */
	/* KI: <anav> */
	/* KI: <msd><lemma>MSZ EN ISO 30011-2:1993</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>MSZ-09-10.0346:1990 */
	/* KI: <anav> */
	/* KI: <msd><lemma>MSZ-09-10.0346:1990</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */


"MSZ"(" EN"|" ENV"|" HD"|" ETS"|" I-ETS"|" ISO"|" ISO/IEC"|"-"[0-17]|"K"|"KGST"){0,2}" "?[-0-9:.]*[0-9]+([-0-9:.]*[0-9]+)* {
		open_begin('i', '-');
}

("DIN"|"EN"|"ENV"|"HD"|"ETS"|"I-ETS"|"ISO"|"ISO/IEC"|"K")" "?[-0-9:.]*[0-9]+([-0-9:.]*[0-9]+)* {
		open_begin('i', '-');
}

	/* ISBN azonos�t� */
	
	/* BE: <s>ISBN 0-7201-2270-8 */

	/* KI: <s>ISBN 0-7201-2270-8 */

	/* KI: <w>ISBN 0-7201-2270-8 */
	/* KI: <anav> */
	/* KI: <msd><lemma>ISBN 0-7201-2270-8</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

"ISBN "[0-9]+[ -][0-9]+[ -][0-9]+[ -][0-9]+ {
		open_begin('i', '-');
}


	/* sz�m-perjel-sz�m */

	/* BE: <s>5/4, 5/4-�t */

	/* KI: <s>5/4, 5/4-�t */

	/* KI: <w>5/4 */
	/* KI: <anav> */
	/* KI: <msd><lemma>5/4</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>5/4</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>5/4-�t */
	/* KI: <anav> */
	/* KI: <msd><lemma>5/4</lemma><mscat>[Oi--sa-----s]</mscat></msd> */
	/* KI: </anav> */
	/* KI: <anav> */
	/* KI: <msd><lemma>5/4</lemma><mscat>[Onf-??]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

[0-9]+"/"[0-9]+ {
		multitoken = NUM_SLASH_NUM;
		open_begin('i', '-');
}

	/* (k�t�jelet, vagy k�t�jeleket) sz�mokat tartalmaz� azonos�t� */

	/* BE: <s>M5, TU&ndash;154 */

	/* KI: <s>M5, TU&ndash;154 */

	/* KI: <w>M5 */
	/* KI: <anav> */
	/* KI: <msd><lemma>M5</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>TU&ndash;154 */
	/* KI: <anav> */
	/* KI: <msd><lemma>TU&ndash;154</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>45654/1994/3., */

	/* KI: <s>45654/1994/3., */

	/* KI: <w>45654/1994/3. */
	/* KI: <anav> */
	/* KI: <msd><lemma>45654/1994/3.</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI:  */

	/* azonos�t� */

	
{LETTERS}+((""|"-"|"&ndash;")[0-9]+)+{LETTERS}*"."? {
		if (yytext[0] == '/') {
		    REJECT;
		} else {
		    open_begin('i', '-');
		}
}

	/* XXX hib�s azonos�t� kvirtm�nusszal */

{LETTERS}+("&mdash;")[0-9]+{LETTERS}* {
		open_begin('i', '-');
}

	/* 1/a, 1/A. */

	/* BE: <s>1/A, 41/J., */

	/* KI: <s>1/A, 41/J., */

	/* KI: <w>1/A */
	/* KI: <anav> */
	/* KI: <msd><lemma>1/A</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>41/J. */
	/* KI: <anav> */
	/* KI: <msd><lemma>41/J.</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI:  */

<S>[0-9]+"/"[a-zA-Z]"."? {
		open_begin('i', '-');
	}

	/* III/1 */

	/* BE: <s>III/1 */

	/* KI: <s>III/1 */

	/* KI: <w>III/1 */
	/* KI: <anav> */
	/* KI: <msd><lemma>III/1</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[iIvVxXlLcCdDmM]+"/"[0-9]+"."? {
		open_begin('i', '-');
	}

	/* IV/c, IV/C */

	/* BE: <s>IV/c */

	/* KI: <s>IV/c */

	/* KI: <w>IV/c */
	/* KI: <anav> */
	/* KI: <msd><lemma>IV/c</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[iIvVxXlLcCdDmM]+"/"[a-zA-Z]"."? {
		open_begin('i', '-');
	}

	/* 2000/45. */

	/* BE: <s>2000/45.-r�l */

	/* KI: <s>2000/45.-r�l */

	/* KI: <w>2000/45.-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>2000/45.</lemma><mscat>[Oi--sh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+"/"[0-9]+"." {
		open_begin('i', '-');
	}

	/* telefonsz�mok */

	/* BE: <s>06 (20) 477-4917, 47-55-45/25-r�l */

	/* KI: <s>06 (20) 477-4917, 47-55-45/25-r�l */

	/* KI: <w>06 (20) 477-4917 */
	/* KI: <anav> */
	/* KI: <msd><lemma>06 (20) 477-4917</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>47-55-45/25-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>47-55-45/25</lemma><mscat>[Oi--sh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]{3}"-"[0-9]{3,4} {
		/* i) magyar telefonsz�m 345-345, 567-3452 */
		open_begin('i', '-');
	}

<S>(("06"|"+"?"36"){SP_TEL}?)?("("[0-9][0-9]?")"{SP_TEL}?)?("1-")?[0-9]{3}"-"[0-9]{3,4}("/"[0-9]+)? {
		/* i) magyar telefonsz�m 345-345, 567-3452 */
		open_begin('i', '-');
	}

<S>(("06"|"+"?"36"){SP_TEL}?)?("("[0-9][0-9]?")"{SP_TEL}?)?("1-")?[0-9]{2}"-"[0-9]{2}"-"[0-9]{2}("/"[0-9]+)? {
		/* i) magyar telefonsz�m 34-45-34 */
		open_begin('i', '-');
	}

	/* egyn�l t�bb k�t�jelet tartalmaz� azonos�t�k */
	
	/* BE: <s>21559468-1-06 */

	/* KI: <s>21559468-1-06 */

	/* KI: <w>21559468-1-06 */
	/* KI: <anav> */
	/* KI: <msd><lemma>21559468-1-06</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */
	
<S>([0-9]+"-"){2,}[0-9]+ {
		open_begin('i', '-');
	}

	/* sz�mok �s nagybet�k (pl. alv�zsz�m) */
	
	/* BE: <s>JA51BF26X5H345328 */

	/* KI: <s>JA51BF26X5H345328 */

	/* KI: <w>JA51BF26X5H345328 */
	/* KI: <anav> */
	/* KI: <msd><lemma>JA51BF26X5H345328</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[A-Z]*([0-9]+[A-Z]+)+[0-9]* {
		open_begin('i', '-');
	}

	/* sz�mok �s nagybet�k legal�bb k�t perjellel */
	
	/* BE: <s>BDE/2000/01/0983/0010 */

	/* KI: <s>BDE/2000/01/0983/0010 */

	/* KI: <w>BDE/2000/01/0983/0010 */
	/* KI: <anav> */
	/* KI: <msd><lemma>BDE/2000/01/0983/0010</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([-0-9A-Z]+"/"){2,}[-0-9A-Z]*[0-9A-Z]+ {
		open_begin('i', '-');
	}

	/* sz�mok, bet�k legal�bb egy ponttal */
	
	/* BE: <s>802.11b */

	/* KI: <s>802.11b */

	/* KI: <w>802.11b */
	/* KI: <anav> */
	/* KI: <msd><lemma>802.11b</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>([0-9A-Za-z]+".")+[0-9a-zA-Z]*[0-9a-zA-Z]+ {
		open_begin('i', '-');
	}

	/* bet�k, �vsz�m ponttal */

	/* BE: <s>BH1992., */

	/* KI: <s>BH1992., */

	/* KI: <w>BH1992. */
	/* KI: <anav> */
	/* KI: <msd><lemma>BH1992.</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI:  */

<S>{LETTERS2}+[12][90][0-9][0-9]"." {
		open_begin('i', '-');
	}

	/* iii) */
	
	/* BE: <s>iii) */

	/* KI: <s>iii) */

	/* KI: <w>iii) */
	/* KI: <anav> */
	/* KI: <msd><lemma>iii)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[iIvVxX]+")" {
		open_begin('i', '-');
	}

	/* (iii) */
	
	/* BE: <s>(iii) */

	/* KI: <s>(iii) */

	/* KI: <w>(iii) */
	/* KI: <anav> */
	/* KI: <msd><lemma>(iii)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>"("[iIvVxX]+")" {
		open_begin('i', '-');
	}


	/* a), A) */
	
	/* BE: <s>a), ( A ) */

	/* KI: <s>a), ( A ) */

	/* KI: <w>a) */
	/* KI: <anav> */
	/* KI: <msd><lemma>a)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>( A ) */
	/* KI: <anav> */
	/* KI: <msd><lemma>( A )</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>[0-9a-zA-Z]" "?")" {
		open_begin('i', '-');
	}

<S>"("[0-9b-zB-Z]")" {
		open_begin('i', '-');
	}

<S>"("" "[a-zA-Z]" "?")" {
		open_begin('i', '-');
	}

<S>"("" "?[a-zA-Z]" "")" {
		open_begin('i', '-');
	}

<S>"("" "[0-9]+" "?")" {
		open_begin('i', '-');
	}

<S>"("" "?[0-9]+" "")" {
		open_begin('i', '-');
	}

	/* a n�vel�k k�l�n kezel�se */

<S>"(a)" {
		printf("<c>(</c>\n<w>a\n</w>\n<c>)</c>\n");
	}

<S>"(A)" {
		printf("<c>(</c>\n<w>A\n</w>\n<c>)</c>\n");
	}

	/* (iii)-(viii) */
	
	/* BE: <s>(iii)-(viii) */

	/* KI: <s>(iii)-(viii) */

	/* KI: <w>(iii)-(viii) */
	/* KI: <anav> */
	/* KI: <msd><lemma>(iii)-(viii)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>"("" "?[iIvVxX]+" "?")"(" "?"-"" "?|" "?"&ndash;"" "?)"("" "?[iIvVxX]+" "?")" {
		open_begin('i', '-');
	}

	/* a)-d) */
	
	/* BE: <s>a)-d)] */

	/* KI: <s>a)-d)] */

	/* KI: <w>a)-d) */
	/* KI: <anav> */
	/* KI: <msd><lemma>a)-d)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>]</c> */
	/* KI:  */

<S>[a-zA-Z]" "?")"(" "?"-"" "?|" "?"&ndash;"" "?)[a-zA-D]" "?")" {
		open_begin('i', '-');
	}

<S>[a-zA-Z]" "?")"(" "?"-"" "?|" "?"&ndash;"" "?)[a-zA-D]" "?")"[\]}] {
                yyless(yyleng - 1);
		open_begin('i', '-');
	}

	/* XXX hib�san kvirtm�nusszal */

<S>"("" "?[iIvVxX]+" "?")"(" "?"&mdash;"" "?)"("[iIvVxX]+" "?")" {
		open_begin('i', '-');
	}

	/* (1)-(4) */
	
	/* BE: <s>(1)-(4) */

	/* KI: <s>(1)-(4) */

	/* KI: <w>(1)-(4) */
	/* KI: <anav> */
	/* KI: <msd><lemma>(1)-(4)</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<S>"("" "?[0-9a-zA-Z]+" "?")"(" "?"-"" "?|" "?"&ndash;"" "?)"("" "?[0-9a-zA-Z]+" "?")" {
		open_begin('i', '-');
	}

	/* XXX hib�san kvirtm�nusszal */

<S>"("" "?[0-9a-zA-Z]+" "?")"(" "?"&mdash;"" "?)"("" "?[0-9a-zA-Z]+" "?")" {
		open_begin('i', '-');
	}

	/********************************************************************************/
	/* formula */

	/* BE: <s>2r&pi;, 2 * 2 = 4, (a+b)(a-b), 36-os */

	/* KI: <s>2r&pi;, 2 * 2 = 4, (a+b)(a-b), 36-os */

	/* KI: <w>2r&pi; */
	/* KI: <anav> */
	/* KI: <msd><lemma>2r&pi;</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>2 * 2 = 4 */
	/* KI: <anav> */
	/* KI: <msd><lemma>2 * 2 = 4</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>(a+b)(a-b) */
	/* KI: <anav> */
	/* KI: <msd><lemma>(a+b)(a-b)</lemma><mscat>[Onf-sn]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */	
	/* KI: <w>36-os */
	/* KI: </w> */
	/* KI:  */

<S>[0-9]+{NUMSIGN} {
		/* i) k�plet */
		if (abort_formula) {
			//abort_formula = 0;
			REJECT;
		} else {
			open_begin('n', 'f');
		}
	}

<S>(({NUMSIGN}|[0-9]+"%"?)({SPACE}{OPERATOR}{SPACE}({NUMSIGN}|[0-9]+"%"?))+)+ {
		/* i) k�plet */
		if (abort_formula) {
			abort_formula = 0;
			REJECT;
		} else {
			open_begin('n', 'f');
		}
	}

<S>(({NUMSIGN}|[0-9]+"%"?)({OPERATOR}({NUMSIGN}|[0-9]+"%"?))+)+ {
		/* i) k�plet */
		if (abort_formula) {
			abort_formula = 0;
			REJECT;
		} else {
			open_begin('n', 'f');
		}
	}

	/* ,,k�plet'' folytat�dik, pl. 456-612-r�l */

<S>(({NUMSIGN}|[0-9]+"%"?)({SPACE}{OPERATOR}{SPACE}({NUMSIGN}|[0-9]+"%"?))+)+{LETTERS}+ {
		/* i) k�plet */
		abort_formula = 1;
		REJECT;
	}

<S>(({NUMSIGN}|[0-9]+"%"?)({OPERATOR}({NUMSIGN}|[0-9]+"%"?))+)+{LETTERS}+ {
		/* i) k�plet */
		abort_formula = 1;
		REJECT;
	}


	/********************************************************************************/
	/* Id�z�jelezett �s toldal�kolt sz�vegek (c�mek, stb). */

	/* BE: <s>Az "�me, h�t megleltem haz�mat"-ban �rta. */

	/* KI: <s>Az "�me, h�t megleltem haz�mat"-ban �rta. */

	/* KI: <w>Az */
	/* KI: </w> */
	/* KI: <w>"�me, h�t megleltem haz�mat"-ban */
	/* KI: </w> */
	/* KI: <w>�rta */
	/* KI: </w> */
	/* KI: <c>.</c> */
	/* KI:  */

<S>("\""|"&ldquor;")[^ \n]([^&"\n]|"&"[^lr]|"&"[a-z][^d])+("\""|"&rdquo""r"?";"?)"-"{WORDCHARS}+ {
	printf(FORMAT2, yytext);
}

<S>("&raquo;")[^ \n]([^&"\n]|"&"[^lr]|"&"[a-z][^da]|"&"[a-z][a-z][^q])+("&laquo;")"-"{WORDCHARS}+ {
	printf(FORMAT2, yytext);
}

	/********************************************************************************/
	/* XXX mosolyjel (smiley) */

	/* BE: <s>:-) */

	/* KI: <s>:-) */

	/* KI: <c>:-)</c> */
	/* KI:  */

<S>{SMILEY} {
	printf("<c>%s</c>\n", yytext);
	}

	/********************************************************************************/
	/* �r�sjelek */

	/* BE: <s>"!"&ldquor; */

	/* KI: <s>"!"&ldquor; */

	/* KI: <c>"</c> */
	/* KI: <c>!</c> */
	/* KI: <c>"</c> */
	/* KI: <c>&ldquor;</c> */
	/* KI:  */


<S>{PUNCT} {
	/* �r�sjelek */
	printf("<c>%s</c>\n", yytext);
	abort_slashdot = 0;
	}

	/* sz�k�z�k t�rl�se */

	/********************************************************************************/
	/* sz�k�z�k t�rl�se */	

<S>{SPACE}

	/********************************************************************************/
	/* Stb... */

	/* BE: <s>Stb... stb... */

	/* KI: <s>Stb... stb... */

	/* KI: <w>Stb. */
	/* KI: </w> */
	/* KI: <c>...</c> */
	/* KI: <w>stb. */
	/* KI: </w> */
	/* KI: <c>...</c> */
	/* KI:  */

<S>[Ss]"tb..." {
	/* Stb... */
	char c[10];
	yyless(yyleng - 3);
	strncpy(c, yytext, yyleng);
	c[yyleng] = '.';
	c[yyleng + 1] = '\0';	
	printf(FORMAT2, c);
}

	/********************************************************************************/
	/* A mondat v�gi pontok �r�sjelek, kiv�ve ha a mondat v�gi sz� a ,,stb.'' */

	/* BE: <s>Pl. nagy. */

	/* KI: <s>Pl. nagy. */

	/* KI: <w>Pl. */
	/* KI: </w> */
	/* KI: <w>nagy */
	/* KI: </w> */
	/* KI: <c>.</c> */
	/* KI:  */

	/* BE: <s>stb. */

	/* KI: <s>stb. */

	/* KI: <w>stb. */
	/* KI: </w> */
	/* KI:  */

	/* BE: <s>stb.) */

	/* KI: <s>stb.) */

	/* KI: <w>stb. */
	/* KI: </w> */
	/* KI: <c>)</c> */
	/* KI:  */

<S>{LETTERS2}+"."{1,3}{ENDQUOPAR}?"\n" {
	BEGIN(SENTENCE_END);
	yyless(0);

}

<SENTENCE_END>[Ss]"tb..." {
	char c[10];
	yyless(yyleng - 3);
	strncpy(c, yytext, yyleng);
	c[yyleng] = '.';
	c[yyleng + 1] = '\0';	
	printf(FORMAT2, c);
	BEGIN(S);
}

<SENTENCE_END>{WORDCHARS}*"." {
	if (strcmp(yytext, "stb.") != 0) {
		yyless(yyleng - 1);
	}
	printf(FORMAT2, yytext);
	BEGIN(S);
}

	/********************************************************************************/
	/* szavak h�rom ponttal */

	/* BE: <s>J�... Is.... */

	/* KI: <s>J�... Is.... */

	/* KI: <w>J� */
	/* KI: </w> */
	/* KI: <c>...</c> */
	/* KI: <w>Is. */
	/* KI: </w> */
	/* KI: <c>...</c> */
	/* KI:  */


<S>{WORDCHARS}+"..." {
	/* szavak h�rom ponttal */
	yyless(yyleng - 3);
	printf(FORMAT2, yytext);
}

<S>{WORDCHARS}+"...." {
	/* szavak n�gy ponttal */
	yyless(yyleng - 3);
	printf(FORMAT2, yytext);
}

	/********************************************************************************/
	/* nagybet�k pontokkal */

	/* BE: <s>S.M.A.R.T. */

	/* KI: <s>S.M.A.R.T. */

	/* KI: <w>S.M.A.R.T. */
	/* KI: </w> */
	/* KI:  */

<S>([A-Z]"."){2,}{WORDCHARS}* {
	printf(FORMAT2, yytext);
}

	/* k�t�jelre v�gz�d� szavak */

	/********************************************************************************/
	/* -e k�rd�sz� lev�laszt�sa */

	/* BE: <s>Lakik-e? */

	/* KI: <s>Lakik-e? */

	/* KI: <w>Lakik */
	/* KI: </w> */
	/* KI: <w>-e */
	/* KI: </w> */
	/* KI: <c>?</c> */
	/* KI:  */

<S>{WORDCHARS}+"-e" {
	/* egy�b, k�s�bb feldolgozand� szavak �s -e k�rd�sz� */
	/* XXX Voltaire-e, 27-e, itt nem mindig k�rd�sz� az -e */
	yytext[yyleng - 2] = '\0';
	printf(FORMAT2, yytext);
	printf(FORMAT2, "-e");
}

	/* Ha folytat�dik az -e, akkor nem k�rd�sz� */

	/* BE: <s>7-es */

	/* KI: <s>7-es */

	/* KI: <w>7-es */
	/* KI: </w> */
	/* KI:  */

<S>{WORDCHARS}+"-e"{WORDCHARS}+ {
	/* -e*-ra v�gz�d�, k�s�bb feldolgozand� szavak */
	printf(FORMAT2, yytext);
}

        /********************************************************************************/
        /* HTML Unicode numerikus entit�sok (ezek nincsenek �talak�tva) */

	/* BE: <s>&#8222; */

	/* KI: <s>&#8222; */

	/* KI: <w>&#8222; */
	/* KI: </w> */
	/* KI:  */

<S>{HTMLNUM} {
	printf(FORMAT2, yytext);
}

	/********************************************************************************/
	/* 6. k�t�jelre v�gz�d� szavak */

	/* BE: <s>bel-, Dinnye-domb- */

	/* KI: <s>bel-, Dinnye-domb- */

	/* KI: <w>bel- */
	/* KI: <anav> */
	/* KI: <msd><lemma>bel-</lemma><mscat>[Oh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>Dinnye-domb- */
	/* KI: <anav> */
	/* KI: <msd><lemma>Dinnye-domb-</lemma><mscat>[Oh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */


<S>{LETTERS}+"-"{NONWORDCHAR}"/"  {
	/* k�t�jel + perjel (macska-/kutyavil�g) */
		abort_slashdot = 1;
		REJECT;
}

<S>{LETTERS}+"-"({LETTERS2}+"-")*{NONWORDCHAR}  {
	/* k�t�jelre v�gz�d� szavak */
			if (yytext[yyleng-1] == '/') {
				abort_slashdot = 1;
			}
			yyless(yyleng - 1);
			msd[0] = 'O';
			msd[1] = 'h';
			msd[2] = '\0';
			printf(FORMAT_UJ, yytext, "", yytext, msd);
			printf(FORMAT_UJV);
}

	/********************************************************************************/
	/* %, � toldal�kolva */

	/* BE: <s>�-sal */

	/* KI: <s>�-sal */

	/* KI: <w>�-sal */
	/* KI: </w> */
	/* KI:  */

<S>[%�]"-"{LETTERS2}+ {
	printf(FORMAT2, yytext);
}

	/********************************************************************************/
	/* k�s�bb feldolgozand� szavak */

	/* BE: <s>Moli&egrave;re-r�l besz�lj! */

	/* KI: <s>Moli&egrave;re-r�l besz�lj! */

	/* KI: <w>Moli&egrave;re-r�l */
	/* KI: </w> */
	/* KI: <w>besz�lj */
	/* KI: </w> */
	/* KI: <c>!</c> */
	/* KI:  */

	/* BE: <s>CD-ROM-okr�l */

	/* KI: <s>CD-ROM-okr�l */

	/* KI: <w>CD-ROM-okr�l */
	/* KI: </w> */
	/* KI:  */

<S>{LETTERS}+".\n" {
	/* egy�b szavak */
        yyless(yyleng-2);
	open_begin(OTHER_WORD_SIGN,'-');
	}

<S>{LETTERS2}+"."[^\n] {
	/* egy�b szavak */
        yyless(yyleng-1);
	open_begin(OTHER_WORD_SIGN,'-');
	}

<S>{LETTERS}+ {
	/* egy�b szavak */
	open_begin(OTHER_WORD_SIGN,'-');
	}

	/* BE: <s>X.25-r�l */

	/* KI: <s>X.25-r�l */

	/* KI: <w>X.25-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>X.25</lemma><mscat>[Oi--sh]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI:  */

<S>{LETTERS}+"."[0-9]+ {
	/* bet�.sz�m */
	open_begin(OTHER_WORD_SIGN,'-');
	}

	/********************************************************************************/
	/* Z�r�jeles r�szeket tartalmaz� szavak */

	/* BE: <s>(Ki)ad�s fizess(en) k�nyv(ek)et? */

	/* KI: <s>(Ki)ad�s fizess(en) k�nyv(ek)et? */

	/* KI: <w>(Ki)ad�s */
	/* KI: </w> */
	/* KI: <w>fizess(en) */
	/* KI: </w> */
	/* KI: <w>k�nyv(ek)et */
	/* KI: </w> */
	/* KI: <c>?</c> */
	/* KI:  */

<S>("("{WORDCHARS}+")"){WORDCHARS}+ {
	/* Z�r�jeles r�szeket tartalmaz� szavak */
	printf(FORMAT2, yytext);
	}

<S>{WORDCHARS}+("("{WORDCHARS}+")"){WORDCHARS}* {
	/* Z�r�jeles r�szeket tartalmaz� szavak */
	printf(FORMAT2, yytext);
	}

	/********************************************************************************/
	/* & jelet tartalmaz� nagybet�s sz�k */

	/* BE: <s>AT&T */

	/* KI: <s>AT&T */

	/* KI: <w>AT&T */
	/* KI: </w> */
	/* KI:  */

<S>[A-Z]+"&"[A-Z]+ {
	printf(FORMAT2, yytext);
	}

	/********************************************************************************/
	/* aposztr�fot tartalmaz� szavak */

	/* BE: <s>don't */

	/* KI: <s>don't */

	/* KI: <w>don't */
	/* KI: </w> */
	/* KI:  */


<S>{LETTERS}+"'"{LETTERS}+ {
	printf(FORMAT2, yytext);
	}

	/********************************************************************************/
	/* Mondat v�ge */
	
<S>"\n" {
	ECHO;
	BEGIN(INITIAL);
}

	/********************************************************************************/
	/* Kimaradt entit�sok */

<S>"&"[a-zA-Z]+";"? {
	printf(FORMAT2, yytext);
}
	/********************************************************************************/
	/* Kimaradt karakterek (pl. plusz jel, &, stb. */

<S>. {
	printf(FORMAT2, yytext);
}

	/********************************************************************************/
	/* Ny�lt token ut�n k�t�jelezett toldal�k vizsg�lata */

<OPEN_BEGIN>"-" {
	strcat(sfx, yytext);
	BEGIN(SFX);
}

	/********************************************************************************/
	/* K�t�jelet �s sz�mokat is tartalmaz� tokenek */

	/* BE: <s>A-B100, A-B100-r�l */

	/* KI: <s>A-B100, A-B100-r�l */

	/* KI: <w>A-B100 */
	/* KI: <anav> */
	/* KI: <msd><lemma>A-B100</lemma><mscat>[Oi--sn]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI: <w>A-B100-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>A-B100-r�l</lemma><mscat>[Oi--??]</mscat></msd> */
	/* KI: </anav> */	
	/* KI: </w> */
	/* KI:  */

	/* nem k�t�jelre v�gz�d� */

	<OPEN_BEGIN>"-"({LETTERS}|"."|[-0-9])*[-0-9]+({LETTERS}|"."|[-0-9])*"-"{LETTERS2}+ {
	    multitoken = NORMAL;
	    strcat(tok, yytext);
	    msd[0] = 'O';
	    msd[1] = 'i';
            msd[2] = '-';
	    msd[4] = '?';
	    msd[5] = '?';
	    sfx[0] = '\0';
	    BEGIN(SFX_END);
	}

	<OPEN_BEGIN>"-"({LETTERS}|"."|[-0-9])*[0-9]+({LETTERS}|"."|[-0-9])* {
	    multitoken = NORMAL;
	    strcat(tok, yytext);
	    msd[0] = 'O';
	    msd[1] = 'i';
	    sfx[0] = '\0';
	    BEGIN(SFX_END);
	}

	/********************************************************************************/
	/* ponttal kezd�d� */

	/* BE: <s>.bash_rc, .dinnye.macska.25 */

	/* KI: <s>.bash_rc, .dinnye.macska.25 */

	/* KI: <w>.bash_rc */
	/* KI: <anav> */
	/* KI: <msd><lemma>.bash_rc</lemma><mscat>[Oep]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */	
	/* KI: <c>,</c> */
	/* KI: <w>.dinnye.macska.25 */
	/* KI: <anav> */
	/* KI: <msd><lemma>.dinnye.macska.25</lemma><mscat>[Oep]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */		
	/* KI:  */

<S>("."({LETTERS}|"_")+)+ {
		/* egy�b �tvonal */
		open_begin('e', 'p');
		msd[4] = '-';
		msd[5] = '-';
}

	/********************************************************************************/
	/* t�bbes sz�m, birtokt�bbes�t� jel */

	/* BE: <s>.hu-r�l .hu-i .hu-ir�l .hu-nkr�l .hu-inkr�l .hu-�r�l .hu-�ir�l .hu-ink�r�l .hu-ink�ir�l */

	/* KI: <s>.hu-r�l .hu-i .hu-ir�l .hu-nkr�l .hu-inkr�l .hu-�r�l .hu-�ir�l .hu-ink�r�l .hu-ink�ir�l */
	/* KI: <w>.hu-r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-sh]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-i */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-pn---s3]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-ir�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-ph---s3]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-nkr�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-sh---p1]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-inkr�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-ph---p1]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-�r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-sh-----s]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-�ir�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-sh-----p]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-ink�r�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-ph---p1s]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI: <w>.hu-ink�ir�l */
	/* KI: <anav> */
	/* KI: <msd><lemma>.hu</lemma><mscat>[Oeo-ph---p1p]</mscat></msd> */
	/* KI: </anav> */
	/* KI: </w> */
	/* KI:  */

<SFX>([oe�a]"k"|"�k") {
	msd[4] = 'p';
	strcat(sfx,yytext);
	BEGIN(SFX_K);
}

	/********************************************************************************/
	/* I/3. birtokos szem�lyjelet megel�legezz�k */

<SFX>"i" {
	msd[4] = 'p';
	msd[9] = 's';
	msd[10] = '3';
	strcat(sfx,yytext);
	BEGIN(SFX_K);
}

<SFX>("j"?[ae]?"i"("�k")?) {
	msd[4] = 'p';
	msd[9] = 's';
	msd[10] = '3';
	strcat(sfx,yytext);
	BEGIN(SFX_K);
}

	/********************************************************************************/
	/* Birtokos szem�lyragok */
	
<SFX,SFX_K>[oe�a]"m" {
	msd[9] = 's';
	msd[10] = '1';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX,SFX_K>[ae]"d" {
	msd[9] = 's';
	msd[10] = '2';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX,SFX_K>("j"?[ae�]|"j�") {
	msd[9] = 's';
	msd[10] = '3';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX,SFX_K>[u�]?"nk" {
	msd[9] = 'p';
	msd[10] = '1';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX,SFX_K>"t"[oe�]"k" {
	msd[9] = 'p';
	msd[10] = '2';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX,SFX_K>"j"?[u�]"k" {
	msd[9] = 'p';
	msd[10] = '3';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

<SFX_K>"k" {
	msd[9] = 'p';
	msd[10] = '3';
	strcat(sfx,yytext);
	BEGIN(SFX_J);
}

	/* Birtokjel */

<SFX,SFX_K,SFX_J>"�i" {
	msd[11] = 'p';
	strcat(sfx,yytext);
	BEGIN(SFX_E);
}

<SFX,SFX_K,SFX_J>"�" {
	msd[11] = 's';
	strcat(sfx,yytext);
	BEGIN(SFX_E);
}

	/********************************************************************************/
	/* Esetragok */

<SFX,SFX_K,SFX_E,SFX_J>[oe�a]?"t" {
	msd[5] = 'a';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"n"[ae]"k" {
	msd[5] = 'g'; // XXX lehet d is!
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>([bcdfghjklmnprstvz]|"cs"|"dzs"|"gy"|"ly"|"ny"|"sz"|"ty"|"zs")[ae]"l" {
	msd[5] = 'i';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"b"[ae] {
	msd[5] = 'x';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"b"[ae]"n" {
	msd[5] = '2';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"b"[��]"l" {
	msd[5] = 'e';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"h"[oe�]"z" {
	msd[5] = 't';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"n"[��]"l" {
	msd[5] = 'x';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"t"[��]"l" {
	msd[5] = 'b';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"r"[ae] {
	msd[5] = '2';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>[oe�]?"n" {
	msd[5] = 'p';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"r"[��]"l" {
	msd[5] = 'h';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"ig" {
	msd[5] = '9';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>[u�]"l" {
	msd[5] = 'w';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>("k�nt"|"k�pp"("en")?) {
	msd[5] = 'f';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"kor" {
	msd[5] = 'm';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"�rt" {
	msd[5] = 'c';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"st"[u�]"l" {
	msd[5] = 'q';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>([bcdfghjklmnprsvz]|"cs"|"dzs"|"gy"|"ly"|"ny"|"sz"|"ty"|"zs")[��] {
	msd[5] = 'y';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"nk�nt" {
	msd[5] = 'u';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<SFX,SFX_K,SFX_E,SFX_J>"szor" {
	msd[5] = '6';
	strcat(sfx,yytext);
	BEGIN(SFX_END);
}

<OPEN_BEGIN,SFX_K,SFX_E,SFX_J,SFX_END>"\n" {
	int i;
	if ((msd[1] == OTHER_WORD_SIGN) || (msd[0] != 'O')) {
		if (multitoken == NUM_WORD) {
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
		} else {
    			printf(FORMAT3, tok, sfx);
		}
	} else {
		for (i = 11; msd[i] == '-'; i--);
		msd[i + 1] = '\0';
		if (multitoken != NORMAL) {
			printf(FORMAT_ANAUJ, tok, sfx, tok, msd);
			print_ana();		    
		} else {
			printf(FORMAT_UJ, tok, sfx, tok, msd);
				}
		printf(FORMAT_UJV);
	}
	strcpy(msd, OPEN);
	multitoken = NORMAL;
	yyless(0);
	BEGIN(INITIAL);
}

<SFX,SFX_K,SFX_E,SFX_J,SFX_END>{WORDCHARS} {
	strcat(sfx, yytext);
	BEGIN(SFX_NOT);
}

<OPEN_BEGIN,SFX_K,SFX_E,SFX_J,SFX_END>. {
	int i;
	if ((msd[1] == OTHER_WORD_SIGN) || (msd[0] != 'O')) {
		if (multitoken == NUM_WORD) {
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
		} else {
    			printf(FORMAT3, tok, sfx);
		}
	} else {
		for (i = 11; msd[i] == '-'; i--);
		msd[i + 1] = '\0';
		if (multitoken != NORMAL) {
			printf(FORMAT_ANAUJ, tok, sfx, tok, msd);
			print_ana();		    
		} else {
			printf(FORMAT_UJ, tok, sfx, tok, msd);
				}
		printf(FORMAT_UJV);
	}
	strcpy(msd, OPEN);
	multitoken = NORMAL;
	yyless(0);
	BEGIN(S);
}

<SFX_END,SFX_NOT>{WORDCHARS}+ {
	strcat(sfx, yytext);
	if (multitoken == NUM_WORD) {
			int i;
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
	} else {
	    if (tok[0] == '\0') {
			msd[1] = 'h';
			msd[2] = '\0';
			printf(FORMAT_UJ, tok, sfx, sfx, msd);
			printf(FORMAT_UJV);

	    } else {
			printf(FORMAT3, tok, sfx);
	    }
	}

	multitoken = NORMAL;
	BEGIN(S);
}

<SFX,SFX_K,SFX_E,SFX_J,SFX_END>[^\n] {
	if (multitoken == NUM_WORD) {
			int i;
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
	} else {
	    printf(FORMAT3, tok, sfx);
	}
	yyless(0);
	multitoken = NORMAL;
	BEGIN(S);
}

	/* BE: <s>Hogue-t, */

	/* KI: <s>Hogue-t, */

	/* KI: <w>Hogue-t */
	/* KI: </w> */
	/* KI: <c>,</c> */
	/* KI:  */

<SFX_NOT>[^\n] {
	if (multitoken == NUM_WORD) {
			int i;
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
	} else {
	    if (tok[0] == '\0') {
			msd[1] = 'h';
			msd[2] = '\0';
			printf(FORMAT_UJ, tok, sfx, sfx, msd);
			printf(FORMAT_UJV);
	    } else {
			printf(FORMAT3, tok, sfx);
			yyless(0);
	    }
	}
	yyless(0);
	BEGIN(S);
}

<SFX_NOT>"\n" {
	if (multitoken == NUM_WORD) {
			int i;
			for (i = 11; msd[i] == '-'; i--);
			msd[i + 1] = '\0';
			printf(FORMAT_UJ, tok, sfx, tok, msd);
			printf(FORMAT_UJV);			
	} else {
	    if (tok[0] == '\0') {
			msd[1] = 'h';
			msd[2] = '\0';
			printf(FORMAT_UJ, tok, sfx, sfx, msd);
			printf(FORMAT_UJV);
	    } else {
			printf(FORMAT3, tok, sfx);
	    }
	}
	yyless(0);
	BEGIN(INITIAL);
}


%%
/* 
 * Ny�lt oszt�lyba tartoz� token ment�se, majd k�t�jelezett toldal�k keres�se
 */
int open_begin(int msd1, int msd2)
{
		msd[1] = msd1;
		msd[2] = msd2;
		sfx[0] = '\0';
		if (strlen(yytext) < BUFSIZ) {
			strcpy(tok, yytext);
		} else {
			strcpy(tok,"ERROR: TOO LONG TOKEN!");
		}
		BEGIN(OPEN_BEGIN);
}

int print_ana()
{
		switch (multitoken) {
			case HOUR_DOT_MIN: // 10.32
				msd[2] = 'd';
				printf(FORMAT_ANAV, tok, msd);
			case MON_SLASH_DAY: // 01/06
			case NUM_DOT_NUM:  // 80.5
				msd[1] = 'i';
				msd[2] = '-';
				printf(FORMAT_ANAV, tok, msd);
				break;
			case HOUR_COLON_MIN:  // 1:10
				msd[2] = 'q';
				printf(FORMAT_ANAV, tok, msd);
			case NUM_COLON_NUM:  // 1:6
				msd[2] = 'r';
				printf(FORMAT_ANAV, tok, msd);
				msd[2] = 'f';
				printf(FORMAT_ANAV, tok, msd);
				break;
			case MON_DASH_DAY: // 10-15
				msd[2] = 'r';
				printf(FORMAT_ANAV, tok, msd);
			case NUM_DASH_NUM: // 1-3
				msd[2] = 'f';
				printf(FORMAT_ANAV, tok, msd);
				break;
			case PATH_OR_WEB: // valami.comr�l
				msd[2] = 'w';
				printf(FORMAT_ANAV, tok, msd);
				break;
			case NUM_LETTER: // 2a
			case PATH_OR_IDENT: // 1.a-r�l
				msd[1] = 'i';
				msd[2] = '-';
				printf(FORMAT_ANAV, tok, msd);
				break;
			case NUM_SLASH_NUM: // 3/4
				msd[1] = 'n';
				msd[2] = 'f';
                                if ((strlen(msd)>=12) && (msd[11] == 's')) {
				    msd[4] = '?';
				    msd[5] = '?';
                                    msd[6] = '\0';
                                }
				printf(FORMAT_ANAV, tok, msd);
				break;
		}		
}
