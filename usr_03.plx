*usr_03.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				Poruszanie się


Zanim wprowadzisz albo usuniesz tekst kursor musi znaleźć się we właściwym
miejscu. Vim ma dużą liczbę poleceń, które służą do umieszczenia kursora tam
gdzie chcesz. Ten rozdział pokazuje jak użyć najczęściej potrzebnych.  Listę
tych komend możesz znaleźć tutaj: |Q_lr|.

|03.1|	Poruszanie się po wyrazach
|03.2|	Przejście do początku lub końca linii
|03.3|	Przejście do znaku
|03.4|	Znajdowanie pary
|03.5|	Przejście do wybranej linii
|03.6|	Gdzie jestem?
|03.7|	Przewijanie
|03.8|	Proste poszukiwania
|03.9|	Proste wzorce poszukiwania
|03.10|	Używanie zakładek

 Następny rozdział: |usr_04.txt|  Małe zmiany
Poprzedni rozdział: |usr_02.txt|  Pierwsze kroki w Vimie
       Spis treści: |usr_toc.txt|

==============================================================================
*03.1*	Poruszanie się po wyrazach

Do przesunięcia kursora o jeden wyraz do przodu należy użyć komendy "w". Tak
jak przy większości komend Vima możesz użyć mnożnika - liczbowego prefiksu
- by przenieść się o kilka wyrazów. Na przykład "3w" przenosi o 3 wyrazy.
Szkic pokazuje jak to się dzieje:

	To jest linia z przykładowym tekstem ~
	     --->----->->------------>
	      w    w   w     4w

Zauważ, że "w" to ruch do początku następnego wyrazu jeśli już jesteś na
początku wyrazu.
   Komenda "b" cofa do początku poprzedniego wyrazu:

	To jest linia z przykładowym tekstem ~
	<--<----<-----<-<------
	  b   b   2b   b    b

Jest także komenda "e", która przenosi kursor do następnego końca wyrazu
i "ge", która przenosi kursor do poprzedniego końca wyrazu:

	To jest linia z przykładowym tekstem ~
	 <-   <---  -->      ------>
	 ge    ge    e          e

Jeśli jesteś w ostatnim wyrazie linii, komenda "w" przeniesie cię do
pierwszego wyrazu w linii następnej. Dzięki temu możesz poruszać się
w akapicie o wiele prędzej niż z "l". "b" robi to samo w odwrotnym kierunku.

Wyraz kończy się znakiem nie należącym do niego, takim jak ".", "-" lub ")".
Można zmienić to co Vim uważa za wyraz modyfikując opcję 'iskeyword'.
   Istnieje też możliwość poruszania się WYRAZAMI oddzielonymi znakami
odstępu. Nie jest to wyraz w zwykłym sensie tego słowa, dlatego użyłem tu
wersalików. Komendy do poruszania się WYRAZAMI są pisane wielkimi literami:

	     ge        b      w                                  e
	   <----      <-     -->                               ----->
    To jest-nowa linia, ze spec/oddzielonymi/wyrazami (i kilka więcej). ~
     <---------- <------     ------------------------->        ------->
	 gE         B                   W                         E

Mieszanka komend pisanych wielką i małą literą umożliwia szybkie poruszanie
się w obrębie akapitu.

==============================================================================
*03.2*	Przejście do początku lub końca linii

Komenda "$" przenosi kursor do końca linii. Jeśli twoja klawiatura ma klawisz
<End> może być wykorzystany do tego samego.

Komenda "^" przeniesie kursor do pierwszego znaku nie będącego białym znakiem.
Komenda "0" (zero) przenosi do pierwszej kolumny linii. Klawisz <Home> robi to
samo. Szkic:

		  ^
	     <------------
	.....To jest linia z przykładowym tekstem ~
	<-----------------   ------------------->
		0		   $

("....." oznaczają białe znaki)

   Komenda "$" może także pobrać liczbę jako argument, tak jak większość
komend ruchu. Jednak przejście do końca linii kilka razy nie ma sensu.
Dlatego edytor przenosi kursor do końca innej linii. Na przykład "1$" przenosi
kursor do końca pierwszej linii (tej, w której się znajdujesz), "2$" do końca
następnej linii, itd.
   Komenda "0" nie pobiera argumentu w postaci liczby ponieważ "0" mogłoby być
częścią liczby. Niespodzianka! Użycie liczby razem z "^" nie daje żadnego
efektu.

==============================================================================
*03.3*	Przejście do znaku

Jedną z najbardziej użytecznych komand jest komenda jednoznakowego
wyszukiwania. Polecenie "fx" szuka w przód linii pojedynczego wystąpienia
znaku x. Wskazówka: "f" oznacza "find" (ang. szukaj).
   Na przykład: jesteś na początku linii. Przypuśćmy, że chcesz dojść do "h"
w "human". Wystarczy, że wydasz polecenie "fh" i kursor znajdzie się na "h":

	To err is human.  To really foul up you need a computer. ~
	---------->--------------->
	    fh		 fy

Szkic pokazuje także, że polecenie "fy" przenosi kursor na koniec słowa
"really".
   Także tu możesz podać mnożnik. Stąd możesz przejść do "l" w "foul" dzięki
"3fl":

	To err is human.  To really foul up you need a computer. ~
		  --------------------->
			   3fl

Komenda "F" szuka w kierunku początku linii:

	To err is human.  To really foul up you need a computer. ~
		  <---------------------
			    Fh

Polecenie "tx" działa tak jak polecenie "fx" z wyjątkiem tego, że zatrzymuje
się jeden znak przed szukanym znakiem. Wskazówka: "t" oznacza "to" (ang. do).
Odwrotną wersją tej komendy jes oczywiście "Tx".

	To err is human.  To really foul up you need a computer. ~
		   <------------  ------------->
			Th		tn

Te cztery polecenia mogą być powtarzane dzięki ";". "," powtarza w odwrotnym
kierunku. Kursor nigdy nie jest przenoszony do innej linii nawet jeśli zdanie
jest kontynuowane.

Czasami zaczynasz poszukiwanie tylko po to by zorientować się, że wybrałeś złe
polecenie. Wpisałeś "f" chcąc szukać do tyłu, ale miałeś na myśli "F". By
przerwać szukanie wciśnij <Esc>. Tak więc "f<Esc>" to zaprzestanie poszukiwań
i nic się nie dzieje. Note: <Esc> przerywa większość operacji, nie tylko
szukanie.

==============================================================================
*03.4*	Znajdywanie pary

Pisząc program często pracujesz z zagnieżdżonymi konstrukcjami (). Komenda "%"
jest wtedy bardzo wygodna: przenosi ona kursor do parującego elementu. Jeśli
kursor jest na "(" zostanie przeniesiony do parującego ")". Jeśli jest na ")"
zostanie przeniesiony do parującego "(".

			    %
			 <----->
		if (a == (b * c) / d) ~
		   <---------------->
			    %

Ten mechanizm działa również dla par [] i {}. (Zachowanie można skonfigurować
używając opcji 'matchpairs'.)

Jeśli kursor nie jest na właściwym znaku, "%" będzie szukał odpowiedniego
znaku do przodu. Dlatego jeśli kursor jest na początku linii poprzedniego
przykładu "%" najpierw znajdzie pierwsze "(" i przeniesie się do parującego
elementu:

		if (a == (b * c) / d) ~
		---+---------------->
			   %

==============================================================================
*03.5*	Przejście do wybranej linii

Jeśli programujesz w C lub C++ z pewnością znasz komunikaty błędów takie jak
ten:

	prog.c:33: j   undeclared (first use in this function) ~

Zawiadamia on, że powinieneś coś poprawić w linii 33. Tylko jak znaleźć linię
33? Jednym ze sposobów jest wykonanie "9999k" by przejść do początku pliku
i "32j" dla zejścia w dół o 32 linie. Nie jest to najlepszy sposób, ale
działa. O wiele lepszym sposobem jest komenda "G". Z mnożnikiem zabierze cię
do żądanej linii. Na przykład "33G" zabiera cię do linii 33. (Lepszy sposób
współpracy z listą błędów kompilatora opisuje |usr_30.txt|, także informacje
o poleceniu ":make".)
   Bez argumentu "G" przenosi kursor do końca pliku. Szybkim sposobem
przejścia do początku pliku jest "gg". "1G" zrobi to samo, ale jest to trochę
więcej pisania.

	    |	pierwszy wiersz pliku  ^
	    |	  tekst tekst tekst    |
	    |	  tekst tekst tekst    |
	    |	  tekst tekst tekst    |  gg
	7G  |	  tekst tekst tekst    |
	    |	  tekst tekst tekst
	    V	  tekst tekst tekst    |
		  tekst tekst tekst    |  G
		  tekst tekst tekst    |
		ostatni wiersz  pliku  V

Innym sposobem by dostać się do określonej linii jest użycie komendy "%"
z mnożnikiem.  Na przykład "50%" przenosi kursor do połowy pliku. "90%" prawie
do samego końca.

Poprzednio założyliśmy, że chcesz przejść do linii w pliku, nieważne czy jest
ona widoczna czy nie. A co jeśli chcesz przejść do jednej z linii, które
widzisz? Szkic pokazuje trzy komendy, których możesz użyć w tym celu:

			+---------------------------+
		H -->	| tekst przykładowy tekst   |
			| przykładowy tekst	    |
			| tekst przykładowy tekst   |
			| przykładowy tekst	    |
		M -->	| tekst przykładowy tekst   |
			| przykładowy tekst	    |
			| tekst przykładowy tekst   |
			| przykładowy tekst	    |
		L -->	| tekst przykładowy tekst   |
			+---------------------------+

Wskazówka: "H" oznacza Home (ang. dom), "M" Middle (ang. środek) i "L" Last
(ang. ostatni)

==============================================================================
*03.6*	Gdzie jestem?

Są trzy sposoby znalezienia odpowiedzi na to pytanie:

1.  Komenda CTRL-G. Otrzymasz taką informację (przyjmując, że opcja 'ruler'
    jest wyłączona):

	"usr_03.txt" line 233 of 650 --35%-- col 45-52~

    Komunikat wyświetla nazwę pliku, który jest edytowany, numer linii gdzie
    znajduje się kursor, całkowitą liczbę linii, procentowe miejsce w pliku
    oraz kolumnę kursora.
       Czasami pojawia się podzielony numer kolumny. Na przykład "col 2-9".
    Oznacza to, że kursor znajduje się na drugim znaku, ale ponieważ znak
    jest tabulatorem zajmującym osiem kolumn, kolumną ekranową jest 9.

2.  Ustawienie opcji 'number'. Będzie ona pokazywała numer linii na początku
    każdej linii: >

	:set number
<
    Wyłącza się ją: >

	:set nonumber
<
    Ponieważ 'number' jest wartością boolowską (logiczną), dodanie "no" na
    początku nazwy wyłącza opcję. Opcje boolowskie mają tylko te dwie
    wartości, mogą być jedynie włączone lub wyłączone.
       Vim ma wiele typów opcji. Obok opcji boolowskich są opcje z wartościami
    numerycznymi i łańcuchami znaków. Zobaczysz jeszcze przykłady ich użycia.

4.  Ustawienie opcji 'ruler'. Będzie ona pokazywała pozycję kursora w prawym
    dolnym rogu okna Vima: >

	:set ruler
<
    Użycie opcji 'ruler' ma tę zaletę, że zajmuje ona niewiele miejsca
    i pozostaje więcej ekranu na tekst.

==============================================================================
*03.7*	Przewijanie

Komenda CTRL-U przewija w dół pół ekranu tekstu. Pomyśl o tym jak o patrzeniu
przez okno na tekst i przemieszczenie okna w górę o połowę jego wysokości.
Okno idzie w górę, czyli do początku tekstu. Nie martw się jeśli masz kłopoty
z zapamiętaniem, który koniec jest górny. Większość użytkowników ma ten
problem.
   Komenda CTRL-D przemieszcza okno o pół ekranu w dół tekstu, inaczej mówiąc
przewija tekst w górę o połowę ekranu.

				       +----------------+
				       | trochę tekstu	|
				       | trochę tekstu	|
				       | trochę tekstu	|
	+---------------+	       | trochę tekstu	|
	| trochę tekstu	|  CTRL-U  --> |		|
	|		|	       | 123456		|
	| 123456	|	       +----------------+
	| 7890		|
	|		|	       +----------------+
	| przykład	|  CTRL-D -->  | 7890		|
	+---------------+	       |		|
				       | przykład	|
				       | przykład	|
				       | przykład	|
				       | przykład	|
				       +----------------+

Jedną linię naraz przewija CTRL-E (w górę) i CTRL-Y (w dół). Pamiętaj: CTRL-E
daje ci jedną linię Ekstra (jeśli używasz MS-kompatybilnych skrótów, CTRL-Y
wykona redo, a nie przewinięcie).

By przewinąć naraz cały ekran (z wyjątkiem dwóch linii) użyj CTRL-F. W drugą
stronę robi to CTRL-B. F oznacza Forward (ang. do przodu), a B Backward (ang.
do tyłu).

Często po przejściu w dół używając wiele razy "j" kursor znajduje się na samym
dole ekranu. Chciałbyś zobaczyć kontekst linii z kursorem. Do tego służy
komenda "zz".

	+------------------+		 +------------------+
	| trochę tekstu	   |		 | trochę tekstu    |
	| trochę tekstu	   |		 | trochę tekstu    |
	| trochę tekstu	   |		 | trochę tekstu    |
	| trochę tekstu	   |   zz  -->	 | linia z kursorem |
	| trochę tekstu	   |		 | trochę tekstu    |
	| trochę tekstu	   |		 | trochę tekstu    |
	| linia z kursorem |		 | trochę tekstu    |
	+------------------+		 +------------------+

Polecenie "zt" umieszcza linię z kursorem na szczycie ekranu ("t" jak top,
ang.  szczyt), a "zb" na dole ("b" jak bottom, ang. dół). Jest jeszcze parę
komend przewijających, zobacz |Q_sc|. By zawsze mieć parę linii kontekstu
wokół kursora ustaw odpowiednio opcję 'scrolloff'.

==============================================================================
*03.8*	Proste poszukiwania

Do znalezienia łańcucha znaków służy polecenie "/łańcuch". By znaleźć słowo
"include", wpisz: >

	/include

Gdy wpiszesz "/" kursor skoczy do ostatniej linii okna Vima tak jak podczas
wydawania poleceń dwukropka. Tam wpisujesz szukane słowo. Możliwe jest użycie
klawisza <BS> do robienia poprawek. Użyj też klawiszy <Left> i <Right> jeśli
to konieczne.
   Wciśnięcie <Enter> wykonuje polecenie.


	Note:
	Znaki .*[]^%/\?~$ mają specjalne znaczenie. Jeśli chcesz ich użyć
	musisz poprzedzić je \. Zobacz poniżej.

By znaleźć kolejne wystąpienia tego samego łańcucha użyj komendy "n".
Ta komenda służy do znalezienia pierwszego #include po kursorze: >

	/#include

I wydaj komendę "n" kilka razy. Zostaniesz przeniesiony do każdego #include
w tekście. Można także użyć mnożnika jeśli wiesz, które kolejne wystąpienie
cię interesuje. "3n" znajduje trzecie wystąpienie. Mnożnik nie działa z "/".

Komenda "?" działa tak samo jak "/", ale szuka do tyłu: >

	?słowo

Komenda "N" powtarza ostatnie wyszukiwanie w odwrotnym kierunku. Dlatego "N"
po komendzie "/" szuka do tyłu (początku pliku), użycie "N" po "?" szuka do
przodu (końca pliku).


IGNOROWANIE WIELKOŚCI ZNAKÓW

Normalnie musisz wpisać dokładnie to czego szukasz. Jeśli nie dbasz
o rozróżnianie wielkich i małych liter w słowie ustaw opcję 'ignorecase': >

	:set ignorecase

Jeśli teraz szukasz "słowa", będą także dopasowane "Słowa" i "SŁOWA". Wielkość
znaków będzie brana pod uwagę po wydaniu polecenia: >

	:set noignorecase


HISTORIA

Przypuśćmy, że wykonałeś trzy poszukiwania: >

	/jeden
	/dwa
	/trzy

Teraz jeśli zaczniesz poszukiwania przez proste "/" i bez wciskania <Enter>.
Jeśli teraz wciśniesz <Up> (klawisz kursora), Vim wstawi "/trzy" do linii
poleceń. Wciśnięcie <Enter> w tym momencie skutkuje w poszukiwaniu "trzy".
Jeśli nie wciśniesz <Enter>, ale znowu <Up> Vim zmieni znak zachęty na "/dwa".
Kolejne <Up> przeniesie cię do "/jeden".
   Możesz też użyć <Down> do poruszania się w historii poleceń w innym
kierunku.

Jeśli wiesz jak zaczynały się poprzednie wzorce wyszukiwania i chcesz je
wykorzystać ponownie wpisz przynajmniej jeden znak zanim naciśniesz <Up>.
W poprzednim przykładzie możesz wpisać "/j<Up>" i Vim wstawi "/jeden" do linii
poleceń.

Polecenia zaczynające się ":" także mają historię. Pozwala to na przywołanie
poprzedniego polecenia i wykonanie go ponownie. Te dwie historie są
niezależne.


POSZUKIWANIE WYRAZU W TEKŚCIE

Przypuśćmy, że masz wyraz "DługaNazwaFunkcji" w tekście i chcesz znaleźć
następne jego wystąpienie. Możesz wpisać "/DługaNazwaFunkcji", ale to jest
dużo pisania. A kiedy zrobisz błąd Vim go nie znajdzie.
   Jest o wiele prostszy sposób: ustaw kursor na wyrazie i użyj komendy "*".
Vim przechwyci wyraz pod kursorem i użyje go jako łańcucha wyszukiwania.
    Komenda "#" robi to samo w drugim kierunku. Możesz użyć mnożnika: "3*"
szuka trzeciego wystąpienia wyrazu pod kursorem.


POSZUKIWANIE CAŁYCH WYRAZÓW

Jeśli wpiszesz "/tu" Vim dopasuje także "tutaj". By znaleźć tylko słowa, które
kończą się na "tu": >

	/tu\>

"\>" jest specjalnym znakiem, który oznacza koniec wyrazu. Podobnie "\<"
dopasowuje początek wyrazu. Tak więc do odszukania słowa "tu": >

	/\<tu\>

To polecenie nie dopasuje "tutaj" lub "kotu". Zauważ, że komendy "*" i "#"
używają symboli początku i końca wyrazu do poszukiwania tylko całych wyrazów
(żeby dopasować tylko fragmenty użyj "g*" lub "g#").


PODŚWIETLANIE DOPASOWAŃ

Podczas edycji programu widzisz zmienną o nazwie "nr". Chcesz sprawdzić gdzie
jeszcze jest użyta. Możesz najść na nią kursorem, użyć "*" i wciskając "n"
przejść przez wszystkie dopasowania.
   Jest inny sposób. Wpisz: >

	:set hlsearch

Jeśli teraz będziesz szukał "nr" Vim podświetli wszystkie dopasowania. Jest to
bardzo wygodny sposób zobaczenia gdzie zmienna jest używana bez potrzeby
wpisywania poleceń.
   Wyłącza się to tak: >

	:set nohlsearch

Potem musisz włączyć znowu tę opcję jeśli chcesz użyć tej opcji do następnego
szukania. Chcąc tylko usunąć podświetlanie, użyj: >

	:nohlsearch

To polecenia nie zmienia opcji, a tylko usuwa podświetlenie. Przy każdym
następnym wyszukiwaniu podświetlanie będzie znowu użyte. Także dla komand "n"
i "N".


DOSTRAJANIE WYSZUKIWANIA

Jest kilka opcji, które zmieniają sposób pracy wyszukiwania. Najważniejsze to:
>
	:set incsearch

Vim będzie pokazywał dopasowanie do łańcucha w czasie wpisywania. Używaj tego
do sprawdzenia czy dobre dopasowanie zostało znalezione. Potem wciśnij <Enter>
by naprawdę skoczyć do miejsca znalezienia łańcucha. Możesz też dalej edytować
szukany łańcuch znaków.
>
	:set nowrapscan

Zatrzymuje wyszukiwanie na końcu pliku, lub jeśli szukasz do tyłu, na jego
początku. Opcja 'wrapscan' jest włączona domyślnie.


INTERMEZZO

Jeśli podobają ci się wspomniane opcje i ustawiasz je za każdym uruchomieniem
Vima, możesz je umieścić w pliku startowym Vima.
   Edytuj plik tak jak wspomniano w |not-compatible|. Albo użyj tego polecenia
by znaleźć jego lokalizację: >

	:scriptnames

Edytuj plik: >

	:edit ~/.vimrc

I dodaj linię z poleceniem ustawiającym opcję tak jakbyś wpisywał ją w Vimie.
Na przykład: >

	Go:set hlsearch<Esc>

"G" przenosi cię do końca pliku. "o" otwiera nową linię, w której wpisujesz
komendę ":set". Kończysz tryb Insert <Esc>. Na koniec zapisujesz plik: >

	ZZ

Jeśli teraz zaczniesz Vima, opcja 'hlsearch' będzie już ustawiona.

==============================================================================
*03.9*	Proste wzorce poszukiwania

Vim używa wyrażeń regularnych do wyszczególnienia czego poszukuje. Wyrażenia
regularne są niesamowicie potężnym i skondensowanym narzędziem do
przedstawienia wzorca wyszukiwania. Niestety, moc kosztuje. Wyrażenia
regularne są trochę skomplikowane.
   W tej sekcji wspomnimy tylko kilka najważniejszych. Więcej o wzorcach
wyszukiwania i komendach w |usr_27.txt|. Pełne wyjaśnienia tu: |pattern|.


POCZĄTEK I KONIEC LINII

Znak ^ oznacza początek linii. Na polskich klawiaturach znajdziesz go nad 6.
Wzorzec "^include" dopasowuje słowo include tylko jeśli znajduje się ono na
początku linii.
   Znak $ oznacza koniec linii. Dlatego "był$" dopasuje słowo był tylko wtedy
jeśli wystąpi ono na końcu linii.

Oznaczmy miejsce gdzie występuje "the" w tym przykładzie znakami "x":

	the solder holding one of the chips melted and the ~
	xxx			  xxx		       xxx

Używając "/the$" znajdziemy:

	the solder holding one of the chips melted and the ~
						       xxx

A z "/^the" znajdziemy:

	the solder holding one of the chips melted and the ~
	xxx

Jeśli wydasz polecenie "/^the$" to dopasuje ono tylko linię, w której znajdzie
się jedynie wyraz "the". Jeśli znajdą się w tej linii znaki odstępu, tak jak
"the ", linia nie zostanie dopasowana.


DOPASOWANIE POJEDYNCZEGO ZNAKU

Znak . (kropka) dopasowuje każdy istniejący znak. Na przykład wzorzec "c.m"
dopasuje łańcuch znaków gdzie pierwszym znakiem jest c, drugim cokolwiek,
a trzecim m. Na przykład:

	We use a computer that became the cummin winter. ~
		 xxx		 xxx	  xxx


DOPASOWANIE ZNAKÓW SPECJALNYCH

Jeśli naprawdę chcesz dopasować kropkę musisz poprzedzić ją backslashem (aka
odwrotny ukośnik, ciach-w-tył) by uniknąć specjalnego znaczenia kropki.
   Szukając "ter." znajdziesz następujące dopasowania:

	We use a computer that became the cummin winter. ~
		      xxxx			    xxxx

Szukając "ter\." tylko to drugie będzie dopasowane.

==============================================================================
*03.10*	Używanie zakładek

Kiedy wykonujesz skok do określonego wiersza komendą "G", Vim zapamiętuje
pozycję sprzed skoku. Ta pozycja jest nazywana zakładką. By wrócić do miejsca
skąd przyszedłeś użyj polecenia: >

	``

"`" to odwrotny cudzysłów (ang. cudzysłów otwierający).
   Po wydaniu tej komendy drugi raz znowu skoczysz z powrotem. Dzieje się tak
ponieważ komenda ` jest skokiem sama w sobie i pozycja przed tym skokiem jest
zapamiętywana.

Ogólnie, za każdym razem kiedy wydasz polecenie, które przeniesie kursor dalej
niż do tej samej linii, jest to przeniesienie nazywane skokiem. Do tego się
zaliczają komendy "/", "n" (nie ma znaczenia jak daleko jest dopasowanie). Ale
nie wyszukiwanie znaków z "fx" i "tx" lub przemieszczenia wyrazowe "w" i "e".
   Tak samo "j" i "k" nie są uważane za skoki. Nawet jeśli używasz mnożnika do
odbycia całkiem dalekiej drogi.

Komenda "``" skacze do przodu i do tyłu, pomiędzy dwoma punktami. Komenda
CTRL-O skacze do starszych pozycji (O jak older - ang. starszy). CTRL-I
skacze do nowszych pozycji (I jest tuż obok O na klawiaturze). Rozważmy taką
sekwencję poleceń: >

	33G
	/^tut
	CTRL-O

Najpierw skaczesz do linii 33, potem szukasz linii, która zaczyna się "tut".
Potem z CTRL-O skaczesz z powrotem do linii 33. Kolejne CTRL-O zabierze cię do
miejsca gdzie zaczynałeś. Jeśli teraz użyjesz CTRL-I skoczysz znów do linii
33. A po kolejnym CTRL-I do dopasowania "tut".


	     |	tekst przykładu   ^	     |
	33G  |	tekst przykładu   |  CTRL-O  | CTRL-I
	     |	tekst przykładu   |	     |
	     V	linia 33 tekst    ^	     V
	     |	tekst przykładu   |	     |
       /^tut |	tekst przykładu   |  CTRL-O  | CTRL-I
	     V	tutaj jesteś      |	     V
		tekst przykładu

	Note:
	CTRL-I to to samo co <Tab>.

Polecenie ":jumps" wyświetli listę pozycji do jakich skakałeś. Ostatnio
używana będzie zaznaczona ">".


NAZWANE ZAKŁADKI

Vim umożliwia wstawienie własnych zakładek do tekstu. Polecenie "ma" zaznacza
miejsce pod kursorem jako zakładkę a (m jak mark, ang. zaznacz). Masz do
dyspozycji 26 zakładek (od a do z) w tekście. Nie możesz ich zobaczyć, to są
tylko pozycje, które Vim pamięta.
   By przejść do zakładki użyj polecenia `{mark}, gdzie "{mark}" to litera
zakładki. Tak więc, żeby przejść do zakładki a: >

	`a

Polecenie 'mark (pojedynczy znak cudzysłowu lub apostrof) przenosi cię do
początku linii zawierającej zakładkę. Różni się tym od `mark, które to
polecenie przenosi do zaznaczonej kolumny.

Zakładki są bardzo użyteczne w czasie pracy nad dwoma związanymi ze sobą
częściami pliku. Przypuśćmy, że masz tekst blisko początku pliku do którego
potrzebujesz zaglądać pracując nad tekstem przy końcu pliku.
   Przejdź do tekstu na początku i umieść tam zakładkę p (początek): >

	mp

Teraz przenieś się do tekstu nad, którym chcesz pracować i ustaw zakładkę
k (koniec): >

	mk

Teraz kiedy chcesz zajrzeć na początek pliku użyj do skoku: >

	'p

Potem możesz użyć '' do skoku z powrotem lub 'k do skoku na koniec pliku.
   p i k nie mają tu żadnego specjalnego znaczenia, po prostu są łatwe do
zapamiętania.

Zawsze możesz użyć tego polecenia by zobaczyć listę zakładek: >

	:marks

Zauważysz tu kilka specjalnych zakładek. Między innymi:

	'	Pozycja kursora przed skokiem
	"	Pozycja kursora podczas ostatniej edycji pliku
	[	Początek ostatniej zmiany
	]	Koniec ostatniej zmiany

==============================================================================

Następny rozdział: |usr_04.txt|  Małe zmiany

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
