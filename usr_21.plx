*usr_21.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			       Tam i z Powrotem


Ten rozdział wyjaśnia sprawy związane z użyciem innych programów z Vima.
Zarówno przez wykonywanie programów z Vima jak i opuszczenie go, i powrót
później. W drugiej części opisane są sposoby zapamiętania stanu Vima
i przywrócenia jego.

|21.1|	Zawieś i przywróć
|21.2|	Wykonywanie poleceń powłoki
|21.3|	Zapamiętywanie informacji; viminfo
|21.4|	Sesje (session)
|21.5|	Widoki (view)
|21.6|	Modelines

 Następny rozdział: |usr_22.txt|  Znajdywanie plików do edycji
Poprzedni rozdział: |usr_20.txt|  Linia poleceń dla power-users
       Spis treści: |usr_toc.txt|

==============================================================================
*21.1*	Zawieś i przywróć

Tak jak większość programów uniksowych Vim może być zawieszony przez CTRL-Z.
Przerywa to działanie Vima i przywraca powłokę z której startował. Możesz
wykonać dowolne polecenia dopóki się nie znudzisz. Potem przywracasz Vima
poleceniem "fg". >

	CTRL-Z
	{dowolna sekwencja poleceń powłoki}
	fg

Jesteś w tym samym miejscu, w którym opuściłeś Vima, nic się nie zmieniło.
Jeśli CTRL-Z nie działa można użyć ":suspend".
Nie zapomnij przywrócić Vima do pierwszego planu, w innym wypadku możesz
stracić swoje zmiany!

Takie działanie wspierają tylko Uniksy. W innych systemach Vim rozpocznie
powłokę dla ciebie.  Możesz w niej wykonywać polecenia powłoki. Ale jest to
nowa powłoka, nie ta z której zaczynałeś.
   Jeśli używasz GUI, nie możesz wrócić do powłoki, z której Vim startował. CTRL-Z
zminimalizuje okno.

==============================================================================
*21.2*	Wykonywanie poleceń powłoki

Do wykonania pojedynczego polecenia powłoki z Vima służy ":!{polecenie}". Na
przykład, by zobaczyć zawartość bieżącego katalogu: >

	:!ls
	:!dir

Pierwsze jest dla Uniksa, drugie dla MS-Windows.
   Vim wykona program. Kiedy program się skończy zobaczysz prośbę o wciśnięcie
<Enter>. Pozwala to na spojrzenie na wynik polecenia przed powrotem do tekstu,
który edytowałeś.
   "!" jest używany w innych miejscach gdzie wykonuje się zewnętrzny program.
Spójrzmy na przegląd:

	:!{program}		wywołuje {program}
	:r !{program}		wywołuje {program} i wczytuje wynik do pliku
	:w !{program}		wywołuje {program} i wysyła tekst jako wejście
	:[range]!{program}	filtruje tekst przez {program}

Zauważ, że obecność zasięgu przed "!{program}" powoduje duże zmiany. Bez tego
program jest wykonywany normalnie; z zasięgiem określona liczba linii jest
filtrowana przez program.

Możliwe jest wykonywanie całego szeregu programów w ten sposób. Ale powłoka
jest w tym o wiele lepsza. Możesz ją wywołać: >

	:shell

Działa podobnie do CTRL-Z (zawieszenie Vima). Różnica polega na tym, że
zaczyna się nową sesję powłoki.

Używając GUI powłoka będzie używać okna Vima do wprowadzania danych i ich
prezentowania. Jednak Vim nie jest emulatorem terminala i nie będzie działać
idealnie. Jeśli masz problemy spróbuj przełączyć opcję 'guipty'. Jeśli nadal
nie działa wystarczająco dobrze, rozpocznij nowy terminal by tam uruchomić
powłokę. Na przykład tak: >

	:!xterm&

==============================================================================
*21.3*	Zapamiętywanie informacji; viminfo

Po jakimś czasie pracy w Vimie będziesz miał tekst w rejestrach, zakładki
w różnych plikach, historię linii komend wypełnioną starannie skonstruowanymi
poleceniami. Kiedy wyjdziesz z Vima wszystko zostanie stracone. Ale możesz to
odzyskać!

Plik viminfo służy do przechowywania informacji o statusie:

	Historii linii komend i wyszukiwania
	Tekstu w rejestrach
	Zakładek w różnych plikach
	Listy buforów
	Zmiennych globalnych

Za każdym razem kiedy wychodzisz z Vima, przechowa on te informacje w pliku
viminfo. Kiedy Vim jest wywoływany, plik viminfo jest odczytywany i informacje
przywracane.

Opcja 'viminfo' jest ustawiona domyślnie do przywracania ograniczonej liczby
informacji. Możesz ją ustawić, by zapamiętywała więcej: >

	:set viminfo=łańcuch

Łańcuch określa co ma zostać zachowane. Składnią jest symbol opcji
i następujący po nim argument. Pary opcja/argument są odzielone przecinkami.
   Spójrzmy jak możesz budować swoją własną opcję 'viminfo'. Najpierw: opcja
' określa dla ilu plików możesz przechowywaś zakładki (a-z). Wybierz okrągłą
liczbę (na przykład 1000). Twoje polecenie wygląda teraz tak: >

	:set viminfo='1000

Opcja f kontroluje czy przechowywać zakładki globalne (A-Z i 0-9). Jeśli opcja
jest równa 0 żadne nie będą przechowywane. Jeśli 1, lub nie określileś opcji
f, zakładki będą przechowywane. Ponieważ chcesz mieć tę możliwość, 'viminfo'
równa jest: >

	:set viminfo='1000,f1

Opcja " określa ile linii może zostać zachowanych dla każdego z rejestrów.
Domyślnie wszystkie linie są zachowywane, jeśli 0 nic nie jest zachowywane. By
uniknąć dodawania tysięcy linii do pliku viminfo (mogą one nigdy nie być
wykorzystane, a będą spowalniały start Vima) używasz maksymalnie 500 linii: >

	:set viminfo='1000,f1,\"500
<
	Note:
	Ponieważ znak " zaczyna polecenie musi być poprzedzony backslashem.

Inne opcje:
	:	liczba linii do zachowania z historii linii poleceń
	@	liczba linii do zachowania z historii linii input
	/	liczba linii do zachowania z historii wyszukiwania
	r	removable media, dla nich nie będą zachowywane żadne zakładki
		(może być użyte kilka razy)
	!	zmienne globalne, które zaczynają się wielką literą i nie
		zawierają małych liter
	h	wyłącz podświetlanie 'hlsearch' podczas startu
	%	lista buforów (przywracana tylko wtedy kiedy Vim startuje bez
		nazw plików jako argumentów)
	c	konwertuj tekst używając 'encoding'
	n	nazwa używana dla pliku viminfo (musi być to ostatnia opcja)

Zobacz opcję 'viminfo' i |viminfo-file| by uzyskać więcej informacji.

Jeśli masz uruchomione kilka sesji Vima, ostatnia z której będziesz wychodził
zachowa swoje dane, może to spowodować nadpisanie wcześniej zapamiętanych
informacji. Każdy element może zostać zapamiętany tylko raz.


POWRÓT TAM GDZIE BYŁEŚ

Jesteś w połowie edycji pliku i czas wyjechać na wakacje. Wychodzisz z Vima
i jedziesz się bawić zapominając wszystko o pracy. Po kilku tygodniach
zaczynasz Vima i wpisujesz: >

	'0

I jesteś dokładnie tam gdzie opuściłeś Vima. Możesz kontynuować pracę.
   Vim tworzy zakładkę za każdym razem kiedy opuszczasz Vima. Ostatnią jest
'0. Pozycja, która wskazywała '0 staje się '1, '1 staje się '2, itd. Zakładka
'9 jest stracona.
   Polecenie ":marks" pokazuje gdzie '0 do '9 cię zabiorą.


PRZENIEŚ INFORMACJĘ Z JEDNEGO VIMA DO DRUGIEGO

Możesz użyć poleceń ":wviminfo" i ":rviminfo" do zachowania i przywrócenia
informacji nie wyłączając Vima. Użyteczne przy wymianie zawartości rejestrów
pomiędzy dwiema sesjami Vima. W pierwszym Vimie: >

	:wviminfo! ~/tmp/viminfo

A w drugim: >

	:rviminfo! ~/tmp/viminfo

Oczywiście "w" oznacza "write", a "r" "read".
   Znak ! służy w ":wviminfo" do pełnego nadpisania istniejącego pliku. Jeśli
zostanie pominięty, a plik istnieje, informacja jest dołączona do pliku.
   W ":rviminfo" znak ! oznacza, że wszystkie dane mają być wykorzystane,
a istniejące nadpisane. Bez ! tylko dane, które nie istniały zostaną
użyte.
   Powyższe polecenia mogą być też użyte do zapisania informacji i ich użycia
później. Możesz stworzyć katalog pełen plików viminfo, każdy zawierający
informacje dotyczący innych rzeczy.

==============================================================================
*21.4*	Sesje (session)

Przypuśćmy, że długo pracowałeś i nadszedł koniec dnia. Chcesz skończyć,
a następnego dnia podjąć pracę gdzie ją skończyłeś. Możesz to zrobić
zapamiętując sesję i przywracając ją później.
   Sesja Vima zawiera wszystkie informacje o tym co edytujesz. W tym: listę
plików, layout okna, zmienne globalne, opcje i wiele innych. (Co jest
zapamiętywane kontroluje opcja 'sessionoptions' opisana poniżej.)
   Następujące polecenie tworzy plik sesji: >

	:mksession vimbook.vim

Później, jeśli chcesz przywrócić tę sesję: >

	:source vimbook.vim

Jeśli startujesz Vima i chcesz przywrócić od razu określoną sesję możesz użyć
do tego celu polecenia: >

	vim -S vimbook.vim

Mówi ono Vimowi, żeby wczytał plik vimbook.vim przy starcie. 'S' oznacza sesję
(w ten sposób możesz wczytać dowolny skrypt Vima, dlatego równie dobrze może
to oznaczać "source").

Okna, które były otwarte, zostaną przywrócone, w tej samej pozycji i wielkości
jak przed zapisaniem sesji. Mapowania i wartości opcji są takie jak przedtem.
   Co dokładnie jest przywrócone zależy od opcji 'sessionoptions'. Domyślną
wartością jest "blank,buffers,curdir,folds,help,options,winsize".

	blank		trzymaj puste okna
	buffers		wszystkie bufory, nie tylko widoczne
	curdir		bieżący katalog
	folds		fałdy, także ręczne
	help		okno pomocy
	options		wszystkie opcje i mapowania
	winsize		wymiary okien

Dostosuj je do swoich upodobań. Na przykład by przywrócić rozmiar okna Vima
użyj: >

	:set sessionoptions+=resize


SESJA TU, SESJA TAM

Oczywistym sposobem użycia sesji jest praca nad różnymi projektami. Przypuśćmy,
że przechowujesz pliki sesji w katalogu "~/.vim". Obecnie pracujesz nad
projektem "sekret", ale musisz zacząć pracować nad projekem "nudny": >

	:wall
	:mksession! ~/.vim/sekret.vim
	:source ~/.vim/nudny.vim

Najpierw ":wall", żeby zapisać wszystkie zmodyfikowane pliki. Później bieżąca
sesja jest zachowana ":mksession!". To nadpisuje poprzednią sesję. Następnym
razem kiedy załadujesz sesję "sekret" możesz kontynuować gdzie skończyłeś.
A na końcu ładujesz nową sesję "nudny".

Kiedy otworzysz okna pomocy, podzielisz i zamkniesz różne okna, i w ogóle
pomieszasz layout okna, możesz wrócić do ostatnio zachowanej sesji: >

	:source ~/.vim/nudny.vim

Dlatego masz całkowitą kontrolę zależnie od tego czy chcesz kontynuować
później tam gdzie jesteś teraz, zachowując bieżące ustawienia sesji, czy
zachowując plik sesji jako punkt startowy.
   Innym sposobem użycia sesji jest stworzenie layoutu okna, który lubisz
i zachowanie go w sesji. Później możesz do niego wrócić kiedy tylko zechcesz.
   Na przykład to jest miły wygląd okna:

	+----------------------------------------+
	|	       VIM - główny plik pomocy  |
	|					 |
	|Poruszanie się: Użyj klawiszy strzalek l|
	|help.txt================================|
	|explorer   |				 |
	|katalog    |~				 |
	|katalog    |~				 |
	|plik	    |~				 |
	|plik	    |~				 |
	|plik	    |~				 |
	|plik	    |~				 |
	|~/=========|[No File]===================|
	|					 |
	+----------------------------------------+

Jest tu okno pomocy na górze, tak że możesz czytać ten tekst. Wąskie pionowe
oko po lewej zawiera eksplorera plików. Jest to wtyczka do Vima, która pokazuje
zawartość katalogu. Możesz tam wybrać plik do edycji. Więcej o tym w następnym
rozdziale.
   Stwórz coś takiego w dopiero co otwartym Vimie: >

	:help
	CTRL-W w
	:vertical split ~/

Możesz trochę zmienić rozmiar okien. Zachowaj sesję: >
>
	:mksession ~/.vim/mój.vim

Teraz możesz wywołać Vima z tym layoutem: >

	vim -S ~/.vim/mój.vim

Wskazówka: Żeby otworzyć plik jaki zobaczyłeć w oknie eksplorera w pustym
oknie, przenieś kursor na nazwę pliku i wciśnij "O". Dwukrotne kliknięcie
myszą zrobi to samo.


UNIX I MS-WINDOWS

Niektórzy ludzie muszą pracować w systemach MS-Windows jednego dnia, a na
Uniksach innego. Jeśli jesteś jednym z nich, rozważ dodanie "slash" i "unix"
do 'sessionoptions'. Pliki sesji będą zapisane w formacie, który będzie mógł
być użyty na obu systemach. To polecenie, które należy umieścić w pliku vimrc:
>
	:set sessionoptions+=unix,slash

Vim użyje formatu Unix ponieważ Vim na MS-Windows może czytać i zapisywać
pliki uniksowe, ale Vim na Uniksa nie może czytać formatów MS-Windows
w plikach sesji. Podobnie, Vim MS-Windows rozumie nazwy plików z / do
oddzielenia nazw, ale Vim Unix nie rozumie \.


SESJE I VIMINFO

Sesje przechowują wiele rzeczy, ale nie pozycje zakładek, zawartość rejestrów
i historię linii poleceń. Do tego potrzebujesz pliku viminfo.
   W większości sytuacji będziesz chciał użyć sesji oddzielnie od viminfo.
Przełączasz się na inną sesję, ale zatrzymujesz historię linii poleceń. Albo
yankujesz tekst do rejestrów w jednej sesji, a umieszczasz go z powrotem
w innej.
   Możesz też chcieć zatrzymać informację razem z sesją. Musisz to zrobić
samemu. Przykład: >

	:mksession! ~/.vim/sekret.vim
	:wviminfo! ~/.vim/sekret.viminfo

A przywracasz to: >

	:source ~/.vim/sekret.vim
	:rviminfo! ~/.vim/sekret.viminfo

==============================================================================
*21.5*	Widoki (view)

Sesja przechowuje wygląd całego Vima. Kiedy chcesz zachować właściwości
jednego okna użyj widoku.
   Zastosowaniem dla widoku jest sytuacja kiedy chcesz edytować plik
w specyficzny sposób. Na przykład, masz numerowanie linii dzięki opcji
'number' i zdefiniowane kilka fałd. Tak jak z sesjami, możesz zapamiętać
widok z pliku i przywrócić go później. Właściwie, kiedy zachowujesz sesję,
zachowuje ona widok każdego okna.
   Są dwa podstawowe sposoby użycia widoków. Pierwszy to pozwolenie by Vim
nadał nazwę plikowi widoku. Możesz później przywrócić widok edytując ten sam
plik. By zachować widok dla bieżącego okna: >

	:mkview

Vim zdecyduje gdzie przechowywać widok. Kiedy później będziesz edytować ten
sam plik dostaniesz widok z powrotem poleceniem: >

	:loadview

Łatwe, prawda?
   Teraz chcesz zobaczyć plik bez włączonej opcji 'number', lub z wszystkimi
zwinięciami otwartymi. Ustawiasz opcje jak chcesz i zapamiętujesz ten widok: >

	:mkview 1

Oczywiście ładujesz go: >

	:loadview 1

Teraz możesz przełączać się między dwoma widokami pliku używając ":loadview"
z lub bez argumentu "1".
   Możesz w ten sposób zachować do 10 widoków tego samego pliku, jeden
nienumerowany i 9 ponumerowanych od 1 do 9.


WIDOK Z NAZWĄ

Drugim sposobem jest przechowanie widoku w pliku z wybraną nazwą. Taki widok
może być załadowany podczas edycji innego pliku. Vim przełączy wtedy edycję na
plik określony w widoku. Wygodne przy szybkim przełączaniu się do edycji
innego pliku z wszyskimi zapamiętanymi opcjami.
   Na przykład, żeby zachować widok bieżącego pliku: >

	:mkview ~/.vim/main.vim

Możesz go przywrócić: >

	:source ~/.vim/main.vim

==============================================================================
*21.6*	Modelines

Podczas edycji pliku, być może chcesz ustawić opcje specyficznie dla
tego pliku. Wpisywanie tych poleceń za każdym razem jest nudne. Użycie sesji
lub widoków dla edycji pliku nie działa jeśli pracuje się nad plikiem w kilka
osób.
   Rozwiązaniem tej sytuacji jest dodanie modeline. Jest to linia tekstu,
która przekazuje Vimowi wartości opcji, które mają być użyte tylko w tym
pliku.
   Typowym przykładem jest program C gdzie robisz indentację o wielokrotności
4 spacji. Wymaga to ustawienia opcji 'shiftwidth' na 4. Robi to linia:

	/* vim:set shiftwidth=4: */ ~

Umieść ją jako jedną z pięciu pierwszych lub pięciu ostatnich linii w pliku.
Kiedy będziesz edytował ten plik zobaczysz, że opcja 'shiftwidth' zostanie
ustawiona na cztery. Edytując inny plik zostanie ustawiona na domyślną wartość
osiem.
   Dla niektórych plików modeline dobrze pasuje do nagłówka, dla plików
tekstowych i innych gdzie modeline może zostać pomylona z normalną zawartością
umieść ją na końcu pliku.

Opcja 'modelines' kontroluje ile linii na początku i końcu każdego pliku
będzie skanowanych na zawartość modeline. Żeby sprawdzał po dziesięć linii: >

	:set modelines=10

Opcja 'modeline' może być też użyta do całkowitego wyłączenia skanowania. Zrób
to kiedy pracujesz jako root, albo nie ufasz plikom, które otwierasz: >

	:set nomodeline

Format modeline jest taki:

	dowolny tekst vim:set {option}={value} ... : dowolny tekst ~

"dowolny tekst" pokazuje, że możesz umieścić dowolny tekst przed i po
fragmencie, który zostanie użyty przez Vima. Pozwala to na upodobnienie go do
komentarza, tak jak było pokazane powyżej między /* i */.
   Część " vim:" służy Vimowi do rozpoznania modeline. Musi być biały znak
przed "vim" albo "vim" musi być na początku linii. Użycie czegoś takiego jak
"gvim:" nie będzie działać.
   Część między dwukropkami to polecenie ":set". Działa tak samo jak wpisanie
polecenia ":set", z wyjątkiem tego, że musisz użyć backslasha przed
dwukropkiem (w innym wypadku zostanie potraktowany jako koniec modeline).

Inny przykład:

	// vim:set textwidth=72 dir=c\:\tmp:  use c:\tmp here ~

Zauważ dodatkowy backslash przed pierwszym dwukropkiem, tak więc jest on
włączony do polecenia ":set". Tekst po drugim dwukropku jest ignorowany
i można tam umieśćić uwagę.

Więcej szczegółów jest tu: |modeline|.

==============================================================================

Następny rozdział: |usr_22.txt|  Znajdywanie plików do edycji

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
