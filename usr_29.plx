*usr_29.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			 Poruszanie się po programach


Twórca Vima jest programistą. Nie jest więc niespodzianką, że Vim zawiera
wiele usprawnień pomagających pisać programy. Skacz, żeby znaleźć gdzie są
identyfikatory zdefiniowane i użyte. Przeglądaj deklaracje w osobnym oknie.
Więcej w następnym rozdziale.

|29.1|	Znaczniki
|29.2|	Okno podglądu
|29.3|	Poruszanie się w programie
|29.4|	Znajdywanie globalnych identyfikatorów
|29.5|	Znajdywanie lokalnych identyfikatorów

 Następny rozdział: |usr_30.txt|  Edycja programów
Poprzedni rozdział: |usr_28.txt|  Zwijanie
       Spis treści: |usr_toc.txt|

==============================================================================
*29.1*	Znaczniki

Co to jest znacznik? To miejsce gdzie identyfikator jest zdefiniowany.
Przykładem mogą być definicje funkcji w programach C i C++. Lista znaczników
jest trzymana w pliku znaczników. Jest on używany przez Vima, żeby skoczyć
bezpośrednio z dowolnego miejsca do znacznika, miejsca gdzie został
zdefiniowany identyfikator.
   Plik znaczników generuje się dla wszystkich plików C w bieżącym katalogu
poleceniem: >

	ctags *.c

"ctags" to osobny program. W większości systemów uniksowych jest on już
zainstalowany. Jeśli jeszcze go nie masz możesz go znaleźć tu:

	http://ctags.sf.net ~

Teraz kiedy jesteś w Vimie i chcesz skoczyć do definicji funkcji możesz
to zrobić wydając polecenie: >

	:tag startlist

To polecenie znajdzie funkcję "startlist" nawet jeśli jest w innym pliku.
   Polecenie CTRL-] skacze do znacznika wyrazu jaki jest pod kursorem. W ten
sposób jest łatwiej eksplorować zakamarki kodu C. Przypuśćmy na przykład, że
jesteś w funkcji "write_block". Możesz zobaczyć, że wywołuje ona "write_line".
Ale co robi "write_line"? Przez umieszczenie kursora na odwołaniu do
"write_line" i wciśnięciu CTRL-] skaczesz do definicji tej funkcji.
   "write_line" wywołuje "write_char". Chcesz się zorientować co robi. Tak
więc umieszczasz kursor nad wywołaniem "write_char" i wciskasz CTRL-]. Teraz
jesteś w definicji "write_char".

	+-------------------------------------+
	|void write_block(char **s; int cnt)  |
	|{				      |
	|   int i;			      |
	|   for (i = 0; i < cnt; ++i)	      |
	|      write_line(s[i);		      |
	|}	    |			      |
	+-----------|-------------------------+
		    |
	     CTRL-] |
		    |	 +----------------------------+
		    +--> |void write_line(char *s)    |
			 |{			      |
			 |   while (*s != 0)	      |
			 |	write_char(*s++);     |
			 |}	  |		      |
			 +--------|-------------------+
				  |
			   CTRL-] |
				  |    +------------------------------------+
				  +--> |void write_char(char c)		    |
				       |{				    |
				       |    putchar((int)(unsigned char)c); |
				       |}				    |
				       +------------------------------------+

Polecenie ":tags" pokazuje listę znaczników, przez które właśnie przeszedłeś:

	:tags
	  # TO tag	   FROM line  in file/text ~
	  1  1 write_line	   8  write_block.c ~
	  2  1 write_char	   7  write_line.c ~
	> ~

Teraz z powrotem. Polecenie CTRL-T wraca do poprzedniego znacznika.
W przykładzie powyżej zabierze cię do funkcji "write_line" w odwołanie do
"write_char".
   To polecenie może pobrać mnożnik, który wskaże jak dużo znaczników wstecz
ma skoczyć. Poszedłeś w przód, a teraz do tyłu. Pójdźmy znowu w przód.
Następne polecenie zabierze cię do znacznika na szczycie listy: >

	:tag

Możesz poprzedzić je mnożnikiem i skoczyć do przodu o tyle znaczników. Na
przykład ":3tag". CTRL-T także może być poprzedzone mnożnikiem.
   Te polecenia pozwalają pójść w dół drzewa wywołań z CTRL-] i z powrotem
z CTRL-T. Użyj ":tags" żeby dowiedzieć się gdzie byłeś.


PODZIAŁ OKNA

Polecenie ":tag" zamienia plik w bieżącym oknie plikiem zawierającym nową
funkcję. Ale przypuśćmy, że chcesz zobaczyć nie tylko starą funkcję, ale
i nową? Możesz podzielić okno używają ":split", a potem ":tag". Vim ma skrót
na oba: >

	:stag nazwa_znacznika

Żeby podzielić bieżące okno i skoczyć do znacznika pod kursorem użyj
polecenia: >

	CTRL-W ]

Jeśli zostanie podany mnożnik, nowe okno będzie na tyle linii wysokie.


WIĘCEJ PLIKÓW ZNACZNIKÓW

Jeśli masz pliki w wielu katalogach możesz stworzyć plik znaczników w każdym
z nich. Vim będzie mógł skakać tylko do znaczników w tym katalogu.
   Żeby znaleźć więcej plików znaczników ustaw opcję 'tags' tak by obejmowała
ona wszystkie odpowiednie pliki znaczników. Przykład: >

	:set tags=./tags,./../tags,./*/tags

Znajduje plik znaczników w tym samym katalogu co bieżący plik, jeden poziom
wyżej i we wszystkich podkatalogach.
   Jest to całkiem spora ilość plików znaczników, ale może nie być
wystarczająca. Na przykład, kiedy edytujesz plik w "~/proj/src", nie
znajdziesz pliku znaczników w "~/proj/sub/tags". Na tę sytuację Vim oferuje
możliwość przeszukiwania całego drzewa katalogów w poszukiwaniu pliku
znaczników. Przykład: >

	:set tags=~/proj/**/tags


JEDEN PLIK ZNACZNIKÓW

Kiedy Vim musi szukać plików znaczników w wielu miejscach możesz usłyszeć
rzężenie dysku. Poszukiwanie jest wolniejsze. W takim wypadku lepiej jest
spędzić trochę czasu na stworzeniu jednego dużego pliku znaczników. Może ci to
zająć noc.
   Wymaga to wspomnianego wyżej programu Exuberant tags. Oferuje on argument
do przeszukania całego drzewa katalogów: >

	cd ~/proj
	ctags -R .

Miłą rzeczą jest to, że Exuberant ctags rozpoznaje różne typy plików. Działa
nie tylko dla programów C i C++, ale także dla Eiffel i nawet skryptów Vima.
Zobacz dokumentację ctags, żeby dostosować go do swoich potrzeb.
   Teraz potrzebujesz tylko przekazać Vimowi gdzie jest twój duży plik
znaczników: >

	:set tags=~/proj/tags


WIELOKROTNE DOPASOWANIE

Kiedy funkcja definiowana jest kilka razy (lub metoda w kilku klasach),
polecenie ":tag" skoczy do pierwszego. Jeśli jest dopasowanie w bieżącym pliku
to będzie użyte pierwsze.
   Możesz teraz skoczyć do innych dopasowań dla tego samego znacznika: >

	:tnext

Powtarzaj to by znaleźć dalsze dopasowania. Jeśli jest ich dużo możesz wybrać
do którego chcesz skoczyć: >

	:tselect tagname

Vim pokaże listę wyboru:

	  # pri kind tag	       file ~
	  1 F	f    mch_init	       os_amiga.c ~
		       mch_init() ~
	  2 F	f    mch_init	       os_mac.c ~
		       mch_init() ~
	  3 F	f    mch_init	       os_msdos.c ~
		       mch_init(void) ~
	  4 F	f    mch_init	       os_riscos.c ~
		       mch_init() ~
	Enter nr of choice (<CR> to abort):  ~

Możesz teraz wprowadzić numer (z pierwszej kolumny) dopasowania do, którego
chcesz skoczyć. Informacja w innych kolumnach daje dobre pojęcie gdzie
dopasowanie jest zdefiniowane.

Do poruszania się pomiędzy pasującymi znacznikami używa się tych poleceń:

	:tfirst			idź do pierwszego dopasowania
	:[count]tprevious	idź do [mnoznik] poprzedniego dopasowania
	:[count]tnext		idź do [mnoznik] następnego dopasowania
	:tlast			idź do ostatniego dopasowania

Domyślną wartością [mnoznika] jest jeden.


ZGADYWANIE NAZW ZNACZNIKÓW

Uzupełnianie linii poleceń to dobry sposób by uniknąć wpisywania długich nazw
znaczników. Wystarczy napisać fragment i wcisnąć <Tab>: >

	:tag write_<Tab>

Uzyskasz piersze dopasowanie. Jeśli nie jest to to czego oczekiwałeś, wciskaj
<Tab> dopóki nie dostaniesz tego.
   Czasami znasz tylko część nazwy funkcji. Albo masz wiele znaczników, które
zaczynają się tak samo lecz kończą inaczej. Wtedy używasz wzorca by znalazł
znacznik.
   Przypuśćmy, że chcesz skoczyć do znacznika, który zawiera "blok". Najpierw
wpisz: >

	:tag /blok

Teraz użyj uzupełniania linii poleceń: wciśnij <Tab>. Vim znajdzie wszystkie
znaczniki, które zawierają "blok" i użyje pierwszego dopasowania.
   "/" przed nazwą znacznika mówi Vimowi, że to co po nim następuje nie jest
dosłowną nazwą znacznika, ale wzorcem. Możesz użyć wszystkich atomów do
wyszukiwania. Na przykład, przypuśćmy, że chcesz znaleźć znacznik, który
zaczyna się na "write_": >

	:tselect /^write_

"^" określa, że znacznik zaczyna się "write". W innym wypadku mogłoby to być
w połowie nazwy znacznika. Podobnie "$" na końcu upewnia, że wzorzec będzie
dopasowany na końcu znacznika.


PRZEGLĄDARKA ZNACZNIKÓW

Ponieważ CTRL-] zabiera cię do definicji identyfikatora pod kursorem możesz
użyć listy identyfikatorów jako spisu treści.
   Najpierw stwórz listę identyfikatorów (wymaga Exuberant ctags): >

	ctags --c-types=f -f functions *.c

Zacznij Vima bez pliku i otwórz ten plik w Vimie, w pionowo podzielonym oknie:
>
	vim
	:vsplit functions

Okno zawiera listę wszystkich funkcji. Jest tam więcej informacji, ale możesz
ją zignorować. Wykonaj ":set ts=99", żeby trochę oczyścić pole.
   W tym oknie zdefiniuj mapowanie: >

	:nmap <buffer> <CR> 0ye<C-W>w:tag <C-R>"<CR>

Przenieś kursor na linię, która zawiera funkcję do której chcesz przejść.
Wciśnij <Enter>. Vim przejdzie do drugiego okna i skoczy do wybranej funkcji.


RÓŻNE

Możesz ustawić 'ignorecase', żeby nie miała znaczenia wielkość liter w nazwach
znaczników.

Opcja 'tagbsearch' mówi czy plik znaczników jest posortowany czy nie.
Domyślnie przyjmuje, że jest posortowany co bardzo przyspiesza wyszukiwanie,
ale nie działa jeśli plik nie jest posortowany.

Opcja 'taglength' może być użyta by przekazać Vimowi liczbę znaczących znaków
w znaczniku.

Jeśli używasz programu SNiFF+ możesz użyć interfejsu Vima do niego |sniff|.
SNiFF+ jest programem komercyjnym.

Cscope jest Wolnym Programem. Nie tylko znajduje miejsce gdzie identyfikator
był zadeklarowany, ale i gdzie był użyty. Zobacz |cscope|.

==============================================================================
*29.2*	Okno podglądu

Kiedy edytujesz kod, który zawiera odwołanie do funkcji musisz znać prawidłowe
argumenty. Żeby wiedzieć jakie wartości przekazać możesz spojrzeć jak funkcja
została zdefiniowana. Mechanizm znaczników bardzo dobrze to robi. Najlepiej by
definicja była pokazana w innym oknie. W tej sytuacji najlepiej użyć okna
podglądu.
   Żeby otworzyć okno podglądu, a wnim funkcję "write_char": >

	:ptag write_char

Vim otworzy okno i skoczy do znacznika "write_char". Później wróci do
początkowej pozycji. Możesz więc kontynuować pisanie bez wydania polecenia
CTRL-W.
   Jeśli nazwa funkcji pojawia się w tekście możesz zobaczyć jej definicję
w oknie podglądu dzięki: >

	CTRL-W }

Istnieje skrypt, który automatycznie pokaże tekst gdzie wyraz pod kursorem
został zdefiniowany. Zobacz |CursorHold-example|

Żeby zamknąć okno podglądu: >

	:pclose

Do edycji określonego pliku w oknie podglądu użyj ":pedit". Może być użyteczne
przy edycji plików nagłówkowych, na przykład: >

	:pedit defs.h

Ostatecznie ":psearch" może być użyte do znalezienia wyrazu w bieżącym pliku
i dowolnym włączanym pliku, i do pokazania dopasowania w oknie podglądu.
Bardzo przydatne w czasie używania funkcji bibliotek, dla których nie masz
pliku znaczników. Przykład: >

	:psearch popen

Pokaże plik "stdio.h" w oknie podglądu z prototypem funkcji popen():

	FILE	*popen __P((const char *, const char *)); ~

Możesz określić wysokość okna podglądu, kiedy jest otwarte, opcją
'previewheight'.

==============================================================================
*29.3*	Poruszanie się po programie

Ponieważ programy są formami strukturalnymi Vim rozpoznaje jego składniki.
Określone polecenia mogą być użyte do poruszania się po nim.
   Programy C często zawierają konstrukty takie jak:

	#ifdef USE_POPEN ~
	    fd = popen("ls", "r") ~
	#else ~
	    fd = fopen("tmp", "w") ~
	#endif ~

Ale o wiele dłuższe i prawdopodobnie zagnieżdżone. Umieść kursor na "#ifdef"
i wciśnij %. Vim skoczy do "#else". Wciśnij znów % i skoczysz do "#endif".
Kolejne % zabierze cię znowu do "#ifdef".
   Kiedy konstrukt jest zagnieżdżony Vim znajdzie pasujące elementy. To dobra
metoda by sprawdzić czy nie zapomniałeś o "#endif".
   Jeśli jesteś gdzieś wewnątrz "#if" - "#endif", możesz skoczyć do początku:
>
	[#

Jeśli nie jesteś za "#if" lub "#ifdef" Vim zapiszczy. Żeby skoczyć naprzód do
następnego "#else" lub "#endif" użyj: >

	]#

Te dwa polecenia omijają wszystkie bloki "#if" - "#endif", które napotkają.
Przykład:

	#if defined(HAS_INC_H) ~
	    a = a + inc(); ~
	#ifdef USE_THEME ~
	    a += 3; ~
	#endif ~
	    set_width(a); ~

Z kursorem na ostatniej linii, "[#" przechodzi do pierwszej linii. Blok
"#ifdef" - "#endif" w środku jest ominięty.


PORUSZANIE SIĘ W BLOKACH KODU

W C bloki kodu są zamknięte w {}. Mogą być całkiem długie. By przejść do
początku zewnętrznego bloku użyj polecenia "[[". "]]" służy do znalezienia
końca. Polecenia te zakładają, że "{" i "}" są w pierwszej kolumnie.
   Polecenie "[{" przenosi do początku bieżącego bloku. Omija pary {} na tym
samym poziomie. "]}" skacze do końca.
   Przykład:

			function(int a)
	   +->		{
	   |		    if (a)
	   |	   +->	    {
	[[ |	   |		for (;;)	       --+
	   |	   |	  +->	{			 |
	   |	[{ |	  |	    foo(32);		 |     --+
	   |	   |   [{ |	    if (bar(a))  --+	 | ]}	 |
	   +--	   |	  +--		break;	   | ]}  |	 |
		   |		}		 <-+	 |	 | ]]
		   +--		foobar(a)		 |	 |
			    }			       <-+	 |
			}				       <-+

Pisząc C++ lub Javę, zewnętrzny blok {} przeznaczony jest dla klasy. Następny
poziom {} dla metody. Kiedy gdzieś wewnątrz klasy użyjesz "[m" kursor skoczy
do poprzedniego początku metody. "]m" skacze do następnego końca metody.

Dodatkowo, "[]" przechodzi do tyłu, do końca funkcji, a "][" przenosi w przód,
do początku funkcji. Koniec funkcji definiowany jest przez "}" w pierwszej
kolumnie.

				int func1(void)
				{
					return 1;
		  +---------->  }
		  |
	      []  |		int func2(void)
		  |	   +->	{
		  |    [[  |		if (flag)
	start	  +--	   +--			return flag;
		  |    ][  |		return 2;
		  |	   +->	}
	      ]]  |
		  |		int func3(void)
		  +---------->	{
					return 3;
				}

Nie zapomnij, że możesz również użyć "%" do poruszania się między parującymi
(), {} i []. Działa również wtedy gdy są oddzielone wieloma liniami.


PORUSZANIE SIĘ W NAWIASACH

Polecenia "[(" i "])" działają podobnie do "[{" i "]}", z wyjątkiem tego, że
działają na parach () zamiast {}.
>
				  [(
<		    <--------------------------------
			      <-------
		if (a == b && (c == d || (e > f)) && x > y) ~
				  -------------->
			  --------------------------------> >
				       ])


PORUSZANIE SIĘ W KOMENTARZACH

By przejść w tył do początku komentarza użyj "[/". W przód, do końca
komentarza przejdziesz dzięki "]/". Działa tylko dla komentarzy /* - */.

	  +->	  +-> /*
	  |    [/ |    * Komentarz o          --+
       [/ |	  +--  * cudownym życiu.	| ]/
	  |	       */		      <-+
	  |
	  +--	       foo = bar * 3;	      --+
						| ]/
		       /* a short comment */  <-+

==============================================================================
*29.4*	Znajdowanie globalnych identyfikatorów

Edytujesz program C i interesuje się czy zmienna została zadeklarowana jako
"int" czy "unsigned". Możesz to szybko sprawdzić poleceniem "[I".
   Przypuśćmy, że kursor jest na wyrazie "column". Wpisz: >

	[I

Vim wyświetli listę pasujących linii jakie może znaleźć. Nie tylko w bieżącym
pliku, ale także w plikach włączanych (i plikach w nich włączanych itd.).
Wynik powinien wyglądać tak:

	structs.h ~
	 1:   29     unsigned     column;    /* column number */ ~

Zaletą w stosunku do używania znaczników lub okna podglądu jest to, że pliki
włączane także są przeszukiwane. W większości przypadków skutkuje to
znalezieniem odpowiedniej deklaracji. Także kiedy plik znaczników jest
przestarzały lub nie masz znaczników dla plików włączanych.
   Musi być jednak spełnionych kilka warunków by "[I" działało. Przede
wszystkim opcja 'include' musi określać jak plik jest włączany. Domyślna
wartość działa dla C i C++. Dla innych języków musisz ją zmienić.


ODNAJDYWANIE PLIKÓW WŁĄCZANYCH

Vim znajdzie pliki włączane w miejscach wyszczególnionych w opcji 'path'.
Jeśli katalogu brak, niektóre pliki włączane mogą nie zostać znalezione.
Możesz to stwierdzić poleceniem: >

	:checkpath

Wylistuje pliki włączane, które nie mogą być znalezione. Także pliki włączane
przez pliki, które nie mogły zostać znalezione. Przykład wyjścia:

	--- Included files not found in path --- ~
	<io.h> ~
	vim.h --> ~
	  <functions.h> ~
	  <clib/exec_protos.h> ~

Plik "io.h" jest włączany w bieżącym pliku, ale nie został znaleziony. "vim.h"
został znaleziony i ":checkpath" wchodzi w ten plik i sprawdza co on włącza.
Pliki "functions.h" i "clib/exec_protos.h" włączane przez "vim.h" nie zostały
znalezione.

	Note:
	Vim nie jest kompilatorem. Nie rozpoznaje "#ifdef". Oznacza to, że
	każde stwierdzenie "#include" jest użyte, nawet po "#if NEVER".

Żeby naprawić pliki, które nie zostały znalezione dodaj katalog do opcji
'path'. Dobrym miejscem do znalezienia plików włączanych jest Makefile. Szukaj
linii, które zawierają "-I", tak jak "-I/usr/local/X11". Ten katalog dodasz: >

	:set path+=/usr/local/X11

Kiedy jest dużo podkatalogów, możesz użyć metaznaku "*". Przykład: >

	:set path+=/usr/*/include

Znajdzie pliki w "/usr/local/include" oraz "/usr/X11/include".

Pracując nad projektem, który zawiera całe drzewo włączanych plików użyj "**".
Szuka w dół we wszystkich podkatalogach. Przykład: >

	:set path+=/projects/invent/**/include

Znajdzie pliki w katalogach:

	/projects/invent/include ~
	/projects/invent/main/include ~
	/projects/invent/main/os/include ~
	itd.

Jest jeszcze więcej możliwości. Sprawdź informację o 'path' w plikach pomocy.
   Jeśli chcesz zobaczyć, które pliki włączane zostały odnalezione użyj
polecenia: >

	:checkpath!

Dostaniesz (bardzo długą) listę plików włączanych, plików które włączają itd.
Żeby skrócić tą listę Vim pokazuje "(Already listed)" dla plików, które były
znalezione wcześniej i nie listuje włączanych plików znowu.


SKOK DO PARY

"[I" pokazuje listę z tylko jedną linią tekstu. Kiedy chcesz uzyskać lepszy
wgląd w pierwszy punkt możesz skoczyć do tej linii poleceniem: >

	[<Tab>

Możesz też użyć "[ CTRL-I", ponieważ CTRL-I to to samo co <Tab>.

Lista, którą wyświetla "[I" ma numer na początku każdej linii. Kiedy chcesz
skoczyć do innego punktu niż pierwszy wpisz najpierw numer: >

	3[<Tab>

Skoczy do trzeciego punktu na liście. Pamiętaj, że możesz użyć CTRL-O do skoku
tam gdzie zacząłeś.


POKREWNE KOMENDY

	[i		pokazuje tylko pierwsze dopasowanie
	]I		pokazuje tylko tematy spod kursora
	]i		pokazuje tylko pierwszy temat spod kursora


ODNAJDYWANIE ZDEFINIOWANYCH IDENTYFIKATORÓW

Polecenie "[I" znajduje dowolny identyfikator. Żeby znaleźć wyłącznie makra,
zdefiniowane "#define" użyj: >

	[D

To polecenie znowu przeszukuje pliki włączane. Opcja 'define' definiuje
linię, która zawiera punkty dla "[D". Możesz to zmienić tak by działało
z innymi językami niż C lub C++.
   Poleceniami pokrewnymi dla "[D" są:

	[d		pokazuje tylko pierwsze dopasowanie
	]D		pokazuje tylko tematy spod kursora
	]d		pokazuje tylko pierwszy temat spod kursora

==============================================================================
*29.5*	Znajdowanie lokalnych identyfikatorów

Polecenie "[I" przeszukuje pliki włączane. Żeby szukać tylko w bieżącym pliku
i skoczyć do pierwszego miejsca gdzie jest użyte słowo pod kursorem: >

	gD

Wskazówka: Goto Definition (idź do definicji). Polecenie to jest bardzo
wygodne przy znalezieniu zmiennej lub funkcji, która została zadeklarowana
lokalnie ("static" w terminologii C). Przykład (kursor na "counter"):

	   +->   static int counter = 0;
	   |
	   |     int get_counter(void)
	gD |     {
	   |	     ++counter;
	   +--	     return counter;
		 }

Można przeszukiwanie ograniczyć nawet bardziej i szukać tylko w bieżącej
funkcji: >

	gd

Wróci do początku bieżącej funkcji i znajdzie pierwsze wystąpienie wyrazu pod
kursorem. Właściwie to szuka w tył pierwszej pustej linii nad "{" w pierwszej
kolumnie. Od tego miejsca szuka identyfikatora w przód. Przykład (kursor na
"idx"):

		int find_entry(char *name)
		{
	   +->	    int idx;
	   |
	gd |	    for (idx = 0; idx < table_len; ++idx)
	   |		if (strcmp(table[idx].name, name) == 0)
	   +--		    return idx;
		}

==============================================================================

Następny rozdział: |usr_30.txt|  Edycja programów

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
