*usr_30.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			       Edycja programów


Vim posiada wiele poleceń, które pomagają w pisaniu programów komputerowych.
Skompiluj program i skocz do błędów. Automatycznie ustaw wcięcia dla wielu
języków i formatuj komentarze.

|30.1|	Kompilacja
|30.2|	Wcięcia w plikach C
|30.3|	Automatyczne wcięcia
|30.4|	Inne wcięcia
|30.5|	Tabulatory i spacje
|30.6|	Formatowanie komentarzy

 Następny rozdział: |usr_31.txt|  Eksploracja GUI
Poprzedni rozdział: |usr_29.txt|  Poruszanie się po programach
       Spis treści: |usr_toc.txt|

==============================================================================
*30.1*	Kompilacja

Vim posiada zestaw poleceń zwany "quickfix". Pozwala on na kompilację programu
z wewnątrz Vima i później przejście przez wygenerowane błędy i poprawienie
ich. Możesz potem przekompilowywać i poprawić nowe błędy jakie się będą
pojawiały dopóki twój program nie skompiluje się bezbłędnie.

To polecenie wykonuje program "make" (z dowolnymi argumentami jakie podasz)
i przechwytuje wyniki: >

	:make {argumenty}

Jeśli zostały wygenerowane błędy są one przechwycone i edytor umieszcza cię
tam gdzie wystąpił pierwszy błąd.
   Spójrzmy na przykładową sesję ":make". (Typowa sesja :make generuje o wiele
więcej błędów i mniej głupich.) Po wpisaniu ":make" ekran wygląda tak:

	:!make | &tee /tmp/vim215953.err ~
	gcc -g -Wall -o prog main.c sub.c ~
	main.c: In function 'main': ~
	main.c:6: too many arguments to function 'do_sub' ~
	main.c: At top level: ~
	main.c:10: parse error before '}' ~
	make: *** [prog] Error 1 ~

	2 returned ~
	"main.c" 11L, 111C ~
	(3 of 6): too many arguments to function 'do_sub' ~
	Hit ENTER or type command to continue ~

Z tego wynika, że masz błędy w pliku "main.c". Kiedy wciśniesz <Enter> Vim
pokaże plik "main.c", z kursorem umieszczonym na linii 6 - pierwszej linii
z błędem. Nie musisz określać pliku lub numeru linii, Vim wie gdzie skoczyć
patrząc po komunikatach błędów.

		+---------------------------------------------------+
		|int main()					    |
		|{						    |
		|	int i=3;				    |
      kursor -> |	do_sub("foo");				    |
		|	++i;					    |
		|	return (0);				    |
		|}						    |
		|}						    |
		| ~						    |
		|(3 of 12): too many arguments to function 'do_sub' |
		+---------------------------------------------------+

Następne polecenie wykona skok do miejsca następnego błędu: >

	:cnext

Vim skacze do linii 10, ostatniej linii w pliku, gdzie jest dodatkowy '}'.
   Jeśli nie ma wystarczającej ilości miejsca, Vim skraca komunikat. Żeby
zobaczyć całą wiadomość użyj: >

	:cc

Przegląd wszystkich komunikatów zobaczyć można dzięki poleceniu ":clist".
Wynik wygląda tak: >

	:clist
<	3 main.c: 6:too many arguments to function 'do_sub' ~
	5 main.c: 10:parse error before '}' ~

Wylistowane są tylko linie gdzie Vim rozpoznaje nazwę pliku i numer linii.
Przyjmuje on, że tylko takie są interesujące, a reszta to tylko nudne
komunikaty. Czasami jednak nierozpoznane linie zawierają coś co chcesz
zobaczyć. Na przykład wyjście z linkera o niezdefiniowanych funkcjach. Żeby
zobaczyć wszystkie wiadomości dodaj "!" do polecenia: >

	:clist!
<	1 gcc -g -Wall -o prog main.c sub.c ~
	2 main.c: In function 'main': ~
	3 main.c:6: too many arguments to function 'do_sub' ~
	4 main.c: At top level: ~
	5 main.c:10: parse error before '}' ~
	6 make: *** [prog] Error 1 ~

Vim podświetli bieżący błąd. By przejść do poprzedniego błędu, użyj: >

	:cprevious

Innymi poleceniami do poruszania się po liście błędów:

	:cfirst		do pierszego błędu
	:clast		do ostatniego błędu
	:cc 3		do błędu nr 3


INNE KOMPILATORY

Nazwa programu do wykonania przy użyciu polecenia ":make" jest zdefiniowana
przy pomocy opcji 'makeprg'. Zazwyczaj jest to "make", ale użytkownicy Visual
C++ powinni ustawić ją na "nmake" przez wydanie polecenia: >

	:set makeprg=nmake

Możesz także włączyć argumenty do opcji. Znaki specjalne (oraz spacje) muszą
być poprzedzone backslashem. Przykład: >

	:set makeprg=nmake\ -f\ project.mak

Do definicji możesz włączyć specjalne słowa Vima. % jest rozwinięte w nazwę
bieżącego pliku. Tak więc jeśli wykonasz polecenie: >

	:set makeprg=make\ %

edytując main.c, ":make" wykona: >

	make main.c

To nie jest zbyt użyteczne, więc musisz trochę poprawić polecenie i użyć
modyfikatora :r (root): >

	:set makeprg=make\ %:r.o

Teraz wykonywane jest polecenie: >

	make main.o

Więcej o tych modyfikatorach: |filename-modifiers|.


STARE LISTY BŁĘDÓW

Przypuśćmy, że kompilujesz program poleceniem ":make". Jest ostrzeżenie
w jednym pliku i komunikat o błędzie w innym. Poprawiasz błąd i używasz
":make", żeby sprawdzić czy błąd naprawdę został naprawiony. Teraz chcesz
sprawdzić jeszcze raz ostrzeżenie. Nie pokazuje się w ostatniej liście błędów
ponieważ plik z ostrzeżeniem nie został ponownie skompilowany. Możesz wrócić
do poprzedniej listy błędów: >

	:colder

Potem użyj ":clist" i ":cc {nr}", żeby skoczyć do miejsca z błędem.
   W przód, do nowszej listy błędów: >

	:cnewer

Vim zapamiętuje do dziesięciu list błędów.


PRZEŁĄCZANIE KOMPILATORÓW

Musisz przekazać Vimowi jakiego formatu komunikatu błędów będzie używał twój
kompilator. Robi to opcja 'errorformat'. Składnia tej opcji jest dość
skomplikowana i może być dostosowana do prawie każdego kompilatora.
Objaśnienia znajdziesz tu: |errorformat|.

Możesz używać róznych kompilatorów. Ustawienie za każdym razem 'makeprg',
a zwłaszcza 'errorformat' nie jest łatwe. Vim oferuje prostą metodę. Na
przykład, żeby przełączyć się na używanie kompilatora Microsoft Visual C++: >

	:compiler msvc

To polecenie znajdzie skrypt Vima dla kompilatora "msvc" i ustawi odpowiednie
opcje.
   Możesz napisać swoje własne kompilatory. Zobacz |write-compiler-plugin|.


PRZEKIEROWANIE WYJŚCIA

Polecenie ":make" przekierowuje wyjście wykonywanego programu do pliku błędu.
Szczegóły zależą od wielu rzeczy takich jak 'shell'. Jeśli twoje ":make" nie
przechwytuje wyjścia, sprawdź opcje 'makeef' i 'shellpipe'. Opcje
'shellquote' i 'shellxquote' także mogą mieć znaczenie.

W przypadku jeśli nie możesz zmusić ":make" do przekierowania pliku za ciebie
alternatywą jest możliwość kompilacji programu w innym oknie i skierowanie
wyjścia do pliku. Vim odczyta później ten plik tak: >

	:cfile {nazwa_pliku}

Skakanie do błędów będzie działać tak samo jak w przypadku polecenia ":make".

==============================================================================
*30.2*	Wcięcia w plikach C

Program jest o wiele łatwiejszy do zrozumienia jeśli linie zostały odpowiednio
wcięte. Vim oferuje wiele sposobów, żeby robić to mniejszym wysiłkiem.
   Dla programów C ustaw opcję 'cindent'. Vim sporo wie o programowaniu
w C i będzie się starał, żeby to zrobić wszystko za ciebie. Ustaw opcję
'shiftwidth' na ilość spacji jakie mają stanowić głębszy poziom. Cztery spacje
działają OK. Jedno polecenie ":set" wystarczy: >

	:set cindent shiftwidth=4

Z tak ustawionymi opcjami kiedy wpiszesz coś takiego jak "if (x)", następna
linia zostanie automatycznie wcięta o jeden poziom.

					    if (flag)
	Automatyczne wcięcie   --->		do_the_work();
	Automatyczne wsunięcie <--	    if (other_flag) {
	Automatyczne wcięcie   --->		do_file();
	utrzymaj wcięcie			do_some_more();
	Automatyczne wsunięcie <-- 	    }

Kiedy wpiszesz coś w nawiasach klamrowych ({}), tekst zostanie wcięty na
początku i wsunięty na końcu. Zlikwidowanie wcięcia zostanie przeprowadzone po
wpisaniu '}' ponieważ Vim nie może wiedzieć co zamierzałeś wpisać.

Ubocznym efektem automatycznej indentacji jest to, że pomaga wcześniej wyłapać
błędy w kodzie. Kiedy wpiszesz }, żeby zakończyć funkcję, a automatyczna
indentacja daje większe wcięcie niż się spodziewałeś oznacza to, że gdzieś
brakuje }. Użyj komendy "%" do znalezienia, które { paruje }.
   Brakujące ) i ; także powodują ekstra wcięcie. Dlatego jeśli dostałeś
więcej znaków odstępu niż się spodziewałeś, sprawdź to co już wpisałeś.

Kiedy masz kod, który został źle sformatowany lub wprowadziłeś lub usunąłeś
wiersze musisz musisz poprawić indentację. Robi to operator "=". Najprostszą
formą jest: >

	==

Przeprowadza indentację bieżącej linii. Tak jak z wszystkimi operatorami są
trzy sposoby jego użycia. W trybie Visual "=" działa na wybranych liniach.
Użytecznym obiektem tekstowym jest "a{". Wybiera bieżący blok {}. Stąd, żeby
przeprowadzić reindentację bieżącego bloku kodu: >

	=a{

Jeśli masz naprawdę żle sformatowany kod możesz przeformatować cały plik: >

	gg=G

Nie rób tego jednak na plikach, w których indentacja została zrobiona ręcznie.
Automatyczna indentacja działa dobrze, ale w niektórych sytuacjach możesz
nie chcieć jej użyć.


STYL INDENTACJI

Różni ludzie mają różne style indentacji. Domyślnie Vim robi całkiem dobrą
robotę indentując w ten sam sposób w jaki robi to 90% programistów. Są jednak
różne style. Jeśli więc chcesz możesz ustalić styl indentacji opcją
'cinoptions'.
   Domyślnie 'cinoptions' jest pusta i Vim używa domyślnego stylu. Możesz
dodać różne przedmioty jeśli chcesz robić coś inaczej. Na przykład, żeby
nawiasy klamrowe były umieszczone tak:

	if (flag) ~
	  { ~
	    i = 8; ~
	    j = 0; ~
	  } ~

Użyj polecenia: >

	:set cinoptions+={2

Jest jeszcze wiele podobnych opcji. Zobacz |cinoptions-values|.

==============================================================================
*30.3*	Automatyczne wcięcia

Zapewne nie chcesz włączać ręcznie opcji 'cindent' za każdym razem jak
edytujesz plik C. W ten sposób zrobisz to automatycznie: >

	:filetype indent on

To polecenie robi o wiele więcej niż włączenie 'cindent' dla plików C. Przede
wszystkim umożliwia detekcję typu pliku. To jest to samo co przy podświetlaniu
składni.
   Kiedy jest już znany typ pliku, Vim szuka pliku indentacji dla tego typu
pliku. Dystrybucja Vima posiada kilka takich plików dla różnych języków
programowania. Plik indentacji powinien przygotować automatyczne formatowanie
specyficzne dla tego pliku.

Jeśli nie chcesz automatycznej indentacji, możesz ją wyłączyć: >

	:filetype indent off

Jeśli nie lubisz indentacji dla tego typu pliku, możesz wyłączyć ją tylko dla
niego. Stwórz plik z tylko jedną linijką: >

	:let b:did_indent = 1

Wystarczy go teraz zapisać z określoną nazwą:

	{katalog}/indent/{typ-pliku}.vim

{typ-pliku} jest nazwą typu pliku, taką jak "cpp" lub "java". Możesz zobaczyć
nazwę jaką Vim wykrył dzięki temu poleceniu: >

	:set filetype

W tym pliku wynikiem jest:

	filetype=help ~

Użyłbyś więc "help" jako {typ-pliku}.
   {katalog} to twój katalog runtime. Spójrz na wynik polecenia: >

	set runtimepath

Użyj teraz pierwszego katalogu, nazwy przed pierwszym przecinkiem. Dlatego
jeśli wynik wygląda tak:

	runtimepath=~/.vim,/usr/local/share/vim/vim60/runtime,~/.vim/after ~

Użyjesz "~/.vim" na {katalog}. Ostateczna nazwa pliku to:

	~/.vim/indent/help.vim ~

Zamiast wyłączania indentacji możesz naposać swój własny plik indentacji. Jak
to robić wyjaśnione jest tu: |indent-expression|.

==============================================================================
*30.4*	Inne wcięcia

Najprostszą formą autmatycznej indentacji jest opcja 'autoindent'. Używa ona
wcięcia z poprzedniej linii. Odrobinę sprytniejsza jest opcja 'smartindent'.
Użyteczna dla języków dla których nie ma pliku indentacji. 'smartindent' nie
jest tak dobra jak 'cindent', ale lepsza od 'autoindent'.
   Z ustawionym 'smartindent' dodawane jest wcięcie dla każdego { i usuwane
dla }. Dodatkowy poziom będzie dodany dla słów z opcji 'cinwords'. Linie,
które zaczynają się na # są traktowane specjalnie: całe wcięcie jest usuwane.
Dzięki temu wszystkie dyrektywy preprocesora zaczynają się w pierwszej
kolumnie. Indentacja jest odzyskiwana w następnej linii.


POPRAWIANIE WCIĘĆ

Kiedy używasz 'autoindent' lub 'smartindent', żeby uzyskać wcięcie poprzedniej
linii będziesz wiele razy musiał dodać lub usunąć jedną wartość 'shiftwidth'.
Szybkim sposobem jest użycie komend CTRL-D i CTRL-T w trybie Insert.
   Na przykład piszesz skrypt powłoki, który ma wyglądać tak:

	if test -n a; then ~
	   echo a ~
	   echo "-------" ~
	fi ~

Zacznij ustawiając opcje: >

	:set autoindent shiftwidth=3

Wpisujesz pierwszą linię, <Enter> i zaczynasz drugą:

	if test -n a; then ~
	echo ~

Potrzebujesz wciąć tę linię. Wydaj polecenie CTRL-T. Rezultat:

	if test -n a; then ~
	   echo ~

Polecenie CTRL-T w trybie Insert dodaje jedną wartość 'shiftwidth' do wcięcia,
nieważne w którym miejscu linii jesteś.
   Kontynuujesz pisanie w drugiej linii, <Enter> i trzecia linia. Teraz
wcięcie jest OK. <Enter> i ostatnia linia. Widzisz teraz to:

	if test -n a; then ~
	   echo a ~
	   echo "-------" ~
	   fi ~

Żeby usunąć niepotrzebne wcięcie w ostatniej linii wciśnij CTRL-D. Komenda
usuwa jedną wartość 'shiftwidth' z wcięcia, nieważne gdzie jesteś w linii.
   Kiedy jesteś w trybie Normal, możesz użyć ">>" i "<<" do przesuwania linii.
">" i "<" są operatorami dlatego masz zazwyczaj trzy sposoby do określenia
linii, które chcesz przesunąć. Użyteczną kombinacją jest: >

	>i{

Dodaje to jedno wcięcie do bieżącego bloku linii, wewnątrz {}. Linie
z { i } pozostają niezmodyfikowane. ">a{" włącza je. W tym przykładzie kursor
jest na "printf":

	oryginalny tekst	po ">i{"		po ">a{"

	if (flag)		if (flag)		if (flag) ~
	{			{			    { ~
	printf("yes");		    printf("yes");	    printf("yes"); ~
	flag = 0;		    flag = 0;		    flag = 0;  ~
	}			}			    } ~

==============================================================================
*30.5*	Tabulatory i spacje

'tabstop' jest domyślnie ustawiony na osiem. Chociaż możesz to zmienić, szybko
wpadniesz w kłopoty. Inne programy nie będą wiedziały jakiej wartości będziesz
używał. Prawdopodobnie używają domyślnej wartości osiem i niespodziewanie twój
tekst będzie wyglądał całkiem inaczej. Także większość drukarek używa stałej
wartości tabulacji - 8. Dlatego najlepiej zostawić 'tabstop' w spokoju. (Jeśli
edytujesz plik, który został napisany z inną wartością tabulacji zobacz |25.3|
jak to naprawić.)
   Indentacja linii w programie, używając wielokrotności ośmiu spacji szybko
sprawia, że dochodzisz do prawej krawędzi okna. Jedna spacja nie zapewnia
wystarczającej różnicy wizualnej. Dużo ludzi woli używać czterech spacji jako
dobrego kompromisu.
   Ponieważ <Tab> jest równy ośmiu spacjom, a chcesz używać wcięć cztero
spacjowych nie możez użyć znaku <Tab> do robienia wcięć. Są dwa sposoby:

1.  Użyj mieszaniny znaków <Tab> i spacji. Ponieważ <Tab> zabiera miejsce
    ośmiu spacji masz mnie znaków w pliku. Wciśnięcie <Tab> jest szybsze od
    ośmiu spacji. Usuwanie także działa szybciej.

2.  Używaj tylko spacji. Unikasz w ten sposób problemów z programami, które
    używają innej wartości tabstop.

Na szczęście Vim wspiera obie te metody.


SPACJE I TABULATORY

Jeśli używasz kombinacji znaków spacji i tabulatora, edytuj normalnie. Vim
domyślnie robi dobrą robotę w takim wypadku.
   Możesz uczynić swoje życie odrobinę łatwiejszym ustawiając opcję
'softtabstop'. Opcja ta mówi Vimowi, żeby <Tab> wyglądał i zachowywał się
jakby tabulacja była ustawiona na wartość 'softtabstop', ale używa kombinacji
znaków tabulacji i spacji.
   Po tym jak wykonasz następujące polecenie, za każdym razem jak wciśniesz
klawisz <Tab> kursor przeniesie się do następnej 4-kolumnowej strefy: >

	:set softtabstop=4

Kiedy zaczynasz w pierwszej kolumnie i wciśniesz <Tab> zostaną wstawione
4 spacje. Za drugim razem Vim zabierze 4 spacje i wstawi <Tab> (zabierając cię
do 8 kolumny). Vim używa tak dużo <Tab> jak to możliwe, a resztę wypełnia
spacjami.
   Usuwanie działa odwrotnie. <BS> zawsze usunie liczbę określoną
w 'softtabstop'. Później <Tab> jest użyte tyle razy ile to możliwe, a spacje
wypełnią resztę.
   Tabelka pokaże co się dzieje wciskając kilka razy <Tab>, a potem <BS>. "."
oznacza spację, a "------>" <Tab>.

	wpisz			  rezultat ~
	<Tab>			  ....
	<Tab><Tab>		  ------->
	<Tab><Tab><Tab>		  ------->....
	<Tab><Tab><Tab><BS>	  ------->
	<Tab><Tab><Tab><BS><BS>   ....

Innym wyjściem jest użycie opcji 'smarttab'. Kiedy jest ustawiona Vim używa
'shiftwidth' dla <Tab> użytego do indentacji i prawdziwego <Tab> kiedy użyty
po pierwszym nie białym znaku. Niestety <BS> nie pracuje tak jak
z 'softtabstop'.


TYLKO SPACJE

Jeśli absolutnie nie chcesz znaków tabulacji w pliku możesz ustawić opcję
'expandtab': >

	:set expandtab

Kiedy ta opcja jest ustawiona klawisz <Tab> wstawia serię spacji. Dostajesz tę
samą ilość znaków odstępu jakby został wstawiony znak <Tab>, ale nie ma
prawdziwego <Tab> w pliku.
   Klawisz <BS> usunie każdą spację oddzielnie. Stąd po wpisaniu jednego <Tab>
musisz wcisnąć osiem razy <BS> do usunięcia go. Jeśli chodzi o usuwanie
wcięcia CTRL-D będzie o wiele szybsze.


ZAMIANA TABULATORÓW NA SPACJE (I Z POWROTEM)

Ustawienie 'expandtab' nie działa na istniejące znaki <Tab>. Innymi słowy
jakiekolwiek znaki <Tab> w pliku nimi pozostają. Jeśli chcesz zamienić <Tab>
w spacje użyj polecenia ":retab". Wydaj polecenia: >

	:set expandtab
	:%retab

Teraz Vim zmieni wszystkie wcięcia ze znaków <Tab> w spacje. Jednak wszystkie
znaki <Tab>, które występowały po znaku nie-odstępu są zachowane. Jeśli chcesz
by także one zostały zmienione dodaj !: >

	:%retab!

Jest to odrobinę niebezpieczne ponieważ może zmienić także <Tab> wewnątrz
łańcucha. Żeby sprawdzić czy takie istnieją użyj: >

	/"[^"\t]*\t[^"]*"

Zalecane jest nie używanie twardych znaków <Tab> w łańcuchu znaków. Zamień je
na "\t", żeby uniknąć kłopotów.

Inny sposób działa równie dobrze: >

	:set noexpandtab
	:%retab!

==============================================================================
*30.6*	Formatowanie komentarzy

Jedną ze wspaniałych rzeczy w Vimie jest to, że rozumie komentarze. Możesz
poprosić Vima, żeby sformatował komentarz i zrobi to odpowiednio.
   Przypuśćmy, na przykład, że masz następujący komentarz:

	/* ~
	 * To jest test~
	 * formatowania tekstu~
	 */ ~

Prosisz Vima aby to sformatował przez umieszczenie kursora na początku
komentarza i wpisanie: >

	gq]/

"gq" jest operatorem formatowania tekstu. "]/" jest ruchem, który przeniesie
cię do końca komentarza. Rezultat:

	/* ~
	 * To jest test formatowania tekstu~
	 */ ~

Zauważ, że Vim odpowiednio potraktował początek każdej linii.
  Innym wyjściem jest zaznaczenie tekstu, który ma być sformatowany w trybie
Visual i wpisanie "gq".

Żeby dodać nową linię do komentarza, umieść kursor na środkowej linii
i wciśnij "o". Rezultat powinien wyglądać tak:

	/* ~
	 * To jest test formatowania tekstu~
	 * ~
	 */ ~

Vim automatycznie umieści tam gwiazdkę i spację. Możesz teraz wpisywać tekst
komentarza. Kiedy stanie się on dłuższy niż 'textwidth', Vim złamie linię.
I znowu gwiazdka jest umieszczona automatycznie:

	/* ~
	 * To jest test formatowania tekstu~
	 * Wpisanie większej ilości tekstu spowoduje, że~
	 * Vim złamie linię~
	 */ ~

Aby to działało parę flag musi być obecnych w 'formatoptions':

	r	wprowadź gwiazdkę po <Enter> w trybie Insert
	o	wprowadź gwiazdkę po "o" lub "O" w trybie Normal
	c	złam tekst komentarza odpowiednio do 'textwidth'

Zobacz |fo-table|, żeby dowiedzieć się więcej o flagach.


DEFINIOWANIE KOMENTARZA

Opcja 'comments' definiuje jak powinny wyglądać komentarze. Vim rozróżnia
komentarze jednoliniowe od komentarzy, które mają inny początek, środek
i koniec.
   Wiele jednoliniowych komentarzy zaczyna się określonym znakiem. W C++
używany jest //, w plikach Makefile #, w skrypatch Vima ". Na przykład, żeby
Vim rozumiał komentarze C++: >

	:set comments=://

Dwukropek oddziela flagę tematu od tekstu przez który komentarz jest
rozpoznawany. Ogólną formą atomu w 'comments' jest:

	{flagi}:{tekst}

Część {flagi} może być pusta, tak jak w tym przypadku.
   Kilka atomów może być łączonych, oddzielanych przecinkami. Pozwala to na
rozpoznawanie różnych typów komentarzy w tym samym czasie. Weźmy na przykład
edycję e-maili. Kiedy odpowiadamy, tekst, który napisali inni jest poprzedzony
">" lub "!". Będzie działało to polecenie: >

	:set comments=n:>,n:!

Są dwa atomy, jeden dla komentarzy zaczynających się ">" i jeden dla
komentarzy zaczynających się "!". Oba używają flagi "n". Oznacza to, że te
komentarze mogą się zagnieżdżać czyli linia zaczynająca się ">" może mieć inny
komentarz po ">". Pozwala to na formatowanie wiadomości takiej jak:

	> ! Widziałeś tę stronę?~
	> ! Wygląda naprawdę świetnie.~
	> Nie lubię jej kolorów~
	> są naprawdę straszne.~
	Jaki jest URL omawianej~
	strony?~

Spróbuj ustawić 'textwidth' na inną wartość, np.: 80 i sformatuj tekst przez
zaznaczenie w trybie Visual i wpisanie "gq". Rezultatem będzie:

	> ! Widziałeś tę stronę? Wygląda naprawdę świetnie.~
	> Nie lubię jej kolory są naprawdę straszne.~
	Jaki jest URL omawianej strony?~

Zauważ, że Vim nie przeniósł tekstu z jednego typu komentarza do innego. "Nie"
w drugiej linii dałoby się umieścić na końcu pierwszej, ale ponieważ ta linia
zaczyna się "> !", a druga tylko ">" Vim wie, że jest to inny typ komentarza.


TRZYCZĘŚCIOWY KOMENTARZ

Komentarz C zaczyna się "/*", ma "*" w środku i "*/" na końcu. Odpowiednia
wartość w 'comments' wygląda tak: >

	:set comments=s1:/*,mb:*,ex:*/

Początek jest definiowany przez "s1:/*". "s" oznacza start trzyczęściowego
komentarza. Dwukropek oddziela flagę od tekstu przez jaki komentarz jest
rozpoznawany: "/*". Jest jedna flaga: "1". Mówi ona Vimowi, że środkowa część
ma offset jednej spacji.
   Środkowa część "mb:*" zaczyna się "m", która wskazuje, że jest to środkowa
część (ang. middle). Flaga "b" oznacza, że musi być odstęp po tekście. W innym
przypadku Vim mógłby uznać tekst jak "*pointer" także za środek komentarza.
   Końcowa część to "ex:*/". "e" to koniec (ang. end). Flaga "x" ma specjalne
znaczenie. Oznacza ona, że po tym jak Vim automatycznie wprowadzi gwiazdkę,
wpisanie "/" usunie dodatkową spację.

Więcej szczegółów w |format-comments|.

==============================================================================

Następny rozdział: |usr_31.txt|  Eksploracja GUI

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
