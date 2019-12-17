*usr_42.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				Dodawanie menu


Już wiesz, że Vim jest bardzo elastyczny. To samo dotyczy menu użytych w GUI.
Możesz definiować własne menu, żeby łatwiej uruchomić pewne pelecenia.  To
oferta dla użytkowników myszy.

|42.1|	Wstęp
|42.2|	Polecenia menu
|42.3|	Różne
|42.4|	Pasek narzędzi i menu kontekstowe

 Następny rozdział: |usr_43.txt|  Typy plików
Poprzedni rozdział: |usr_41.txt|  Pisanie skryptów Vima
       Spis treści: |usr_toc.txt|

==============================================================================
*42.1*	Wstęp

Menu, których używa Vim są zdefiniowane w pliku "$VIMRUNTIME/menu.vim". Jeśli
chcesz dodać własne menu, na początek zajrzyj do tego pliku.
   Do zdefiniowania punktu menu użyj polecenia ":menu". Podstawowa forma to: >

	:menu {punkt-menu} {klawisze}

{punkt-menu} określa gdzie menu ma zostać umieszczone. Typowy {punkt-menu} to
"File.Save", który reprezentuje punkt "Save" w menu "File". Kropki używa się
do oddzielania nazw. Przykład: >

	:menu File.Save  :update<CR>

Polecenie ":update" zapisuje plik jeśli został zmieniony.
   Możesz dodać dodatkowy poziom: "Edit.Settings.Shiftwidth" definiuje podmenu
"Settings" w menu "Edit" i punkt "Shiftwidth". Możesz używać nawet bardziej
zagnieżdżonych podpoziomów. Nie rób ich za dużo, musisz całkiem sporo machać
myszą by się do nich dostać.
   Polecenie ":menu" jest bardzo podobne do polecenia ":map": lewa strona
określa jak punkt jest uruchamiany, a druga jakie znaki mają być wykonane.
{klawisze} to znaki, które są użyte tak jakbyś je właśnie wpisał. Dlatego
w trybie Insert kiedy {klawisze} to zwykły tekst to jest on po prostu wstawiony.


AKCELERATORY

Znaku ampersand (&) używa się do wskazania akceleratora. Możesz na przykład
użyć Alt-F do wybrania "File" i S do "Save". (Pamiętaj, że opcja 'winaltkeys'
może to wyłączyć!). Dlatego {punkt-menu} wygląda tak "&File.&Save". Znaki
akceleratorów będą podkreślone w menu.
   Musisz uważać by każdy znak był użyty tylko raz w menu jako akcelerator.
W innym wypadku nie będziesz wiedział, który z tych dwóch zostanie użyty. Vim
cię o tym nie ostrzeże.


PRIORYTETY

Dokładna definicja punktu File.Save brzmi: >

	:menu 10.340 &File.&Save<Tab>:w  :confirm w<CR>

Numer 10.340 nazywany jest liczbą priorytetu. Używana przez edytor do
zdecydowania gdzie umieścić punkt menu. Pierwsza liczba (10) wskazuje pozycję
na pasku menu. Niżej numerowane menu są umieszczane po lewej, wyżej numerowane
po prawej.
   Priorytety dla standardowych menu:

	  10	20     40     50      60       70		9999

	+------------------------------------------------------------+
	| File	Edit  Tools  Syntax  Buffers  Window		Help |
	+------------------------------------------------------------+

Zauważ, że menu Help ma bardzo wysoki numer, żeby pojawiało się na skraju.
   Drugi numer (340) określa położenie punktu w ramach rozwiniętego menu.
Niższe numery na górze, wyższe na dole.
   Priorytety w menu File:

			+-----------------+
	    10.310	|Open...	  |
	    10.320	|Split-Open...	  |
	    10.325	|New		  |
	    10.330	|Close		  |
	    10.335	|---------------- |
	    10.340	|Save		  |
	    10.350	|Save As...	  |
	    10.400	|---------------- |
	    10.410	|Split Diff with  |
	    10.420	|Split Patched By |
	    10.500	|---------------- |
	    10.510	|Print		  |
	    10.600	|---------------- |
	    10.610	|Save-Exit	  |
	    10.620	|Exit		  |
			+-----------------+

Zauważ, że są odstępy między kolejnymi numerami. Możesz tam wstawić swoje
własne punkty, jeśli naprawdę tego chcesz (często lepiej jest zostawić
standardowe menu w spokoju i dodać własne menu).
   Kiedy tworzysz podmenu możesz dodać dodatkowy ".numer" do priorytetu. W ten
sposób każda nazwa w {punkt-menu} będzie miała swój własny numer priorytetu.


ZNAKI SPECJALNE

{punkt-menu} w tym przykładzie to "&File.&Save<Tab>:w". Pojawia się tu ważna
kwestia: {punkt-menu} musi być jednym słowem. Jeśli chcesz wstawić kropkę,
spację, tabulator do nazwy musisz, albo użyć notacji <> (<Space> lub <Tab> na
przykład), albo użyj backslasha (\) dla uniknięcia specjalnego znaczenia tych
znaków. >

	:menu 10.305 &File.&Do\ It\.\.\. :exit<CR>

Tutaj nazwą menu jest "Do It...", które zawiera spację, a poleceniem jest
":exit<CR>".

Znaku <Tab> w nazwie menu używa się do odzielenia części, która definiuje
nazwę menu od części odpowiedzialnej za podpowiedź dla użytkownika. Część za
<Tab> jest wyrównana do prawej krawędzi menu. W menu File.Save nazwa to
"&File.&Save<Tab>:w". Nazwą menu jest "File.Save", a wskazówka to ":w".


SEPARATORY

Linie oddzielające, używane do grupowania pokrewnych punktów menu mogą być
zdefiniowane przez użycie nazwy, która zaczyna i kończy się "-". Na przykład
"-sep-". Jeśli używasz kilku separatorów nazwy muszą być inne. W innym wypadku
nazwa nie ma znaczenia.
   Polecenie z separatora nigdy nie będzie wykonane, ale musisz jakieś
zdefiniować. Wystarczy zwykły dwukropek: >

	:amenu 20.510 Edit.-sep3- :

==============================================================================
*42.2*	Polecenia menu

Możesz zdefiniować menu, które będą istnieć tylko dla niektórych trybów.
Działa to tak samo jak wariacje polecenia ":map":

	:menu		Normal, Visual i Operator-pending
	:nmenu		Normal
	:vmenu		Visual
	:omenu		Operator-pending
	:menu!		Insert i linia poleceń
	:imenu		Insert
	:cmenu		Linia poleceń
	:amenu		All

Żeby polecenia menu nie były traktowane jako mapowania użyj poleceń
":noremenu", ":nnoremenu", ":anoremenu", itd.


:AMENU

Polecenie ":amenu" jest odrobinę inne. Przyjmuje ono, że {klawisze}, które
podałeś mają być wykonane w trybie Normal. Kiedy Vim jest w trybie Visual lub
Insert w czasie wywołania menu, Vim najpierw wraca do trybu Normal. ":amenu"
wykonuje CTRL-C lub CTRL-O za ciebie. Na przykład, jeśli wydasz takie
polecenie: >

	:amenu  90.100 Mój.Znajdź\ wyraz  *

Wynikiem będą polecenia:

	tryb Normal:		*
	tryb Visual:		CTRL-C *
	tryb Operator-pending:	CTRL-C *
	tryb Insert:		CTRL-O *
	linia poleceń:		CTRL-C *

W przypadku linii poleceń CTRL-C porzuci wszelkie dotychczas wpisane
polecenia. W trybach Visual i Operator-pending CTRL-C zmieni tryb. W trybie
Insert CTRL-O wykona polecenie i powróci do trybu Insert.
   CTRL-O działa tylko na czas jednego polecenia. Jeśli chcesz wydać dwa lub
więcej wstaw je do funkcji i wywołaj ją. Przykład: >

	:amenu  Mój.Następny\ plik  :call <SID>NastepnyPlik()<CR>
	:function <SID>NastepnyPlik()
	:  next
	:  1/^Kod
	:endfunction

To menu przechodzi do następnego pliku w liście argumentów (":next"). Potem
szuka linii zaczynającej się "Kod".
   <SID> przed nazwą funkcji jest numerem identyfikacyjnym skryptu (ID). W ten
sposób funkcja jest lokalna dla bieżącego skryptu Vima. W ten sposób unikniesz
problemów z tą samą nazwą funkcji, ale zdefiniowaną w innym pliku. Zobacz
|<SID>|.


CICHE MENU

Menu wykonuje {klawisze} tak jakbyś je wpisał. Dla komend ":" oznacza to, że
zobaczysz polecenie w linii poleceń. Jeśli jest to długie polecenie pojawi się
prośba o wciśnięcie Enter. Nie jest to zbyt wygodne.
   Żeby tego uniknąć ucisz menu. Robi się to argumentem <silent>. Na przykład
weźmy wezwanie funkcji NastepnyPlik() z poprzedniego przykładu. Kiedy użyjesz tego
menu zobaczysz w linii poleceń:

	:call <SNR>34_NastepnyPlik() ~

Aby tego uniknąć dodaj "<silent>" jako pierwszy argument: >

	:amenu <silent> Mój.Następny\ plik :call <SID>NastepnyPlik()<CR>

Nie używaj "<silent>" zbyt często. Nie jest potrzebne dla krótkich poleceń.
Jeśli robisz menu dla kogoś innego informacja pokazująca się w linii poleceń
może być dla niego wskazówką co mógłby wpisać zamiast używać myszy.


LISTOWANIE MENU

Kiedy polecenie menu jest użyte bez części {klawisze} listuje ono zdefiniowane
menu. Możesz określić {punkt-menu} lub jego część dla wylistowania określonych
menu. Przykład: >

	:amenu

Listuje wszystkie menu. To długa lista! Lepiej określić nazwę menu by otrzymać
krótszą listę: >

	:amenu Edit

Listuje tylko punkty z menu "Edit" dla wszystkich trybów. Aby otrzymać listę
tych punktów menu, które mogą być wykonywane w trybie Insert: >

	:imenu Edit.Undo

Pamiętaj, żeby nazwę wpisać dokładnie. Wielkość liter się liczy, ale "&"
(akceleratory) mogą być pominięte. <Tab> i to co się za nim znajduje może być
pominięte.


USUWANIE MENU

Żeby usunąć menu używa się tego samego polecenia co do listowania, ale
z "menu" zmienionym na "unmenu". Dlatego ":menu" staje się ":unmenu", ":nmenu"
- ":nunmenu" itd. Punkt "Tools.Make" w trybie Insert usuwa się tak: >

	:iunmenu Tools.Make

Możesz usunąć całe menu, razem z wszystkimi punktami używając nazwy menu.
Przykład: >

	:aunmenu Syntax

To polecenie usuwa menu Syntax i wszystkie jego punkty.

==============================================================================
*42.3*	Różne

Możliwa jest zmiana sposobu pojawiania się menu dzięki flagom w 'guioptions'.
Domyślnie wszystkie flagi są włączone. Możesz usunąć flagę tak: >

	:set guioptions-=m
<
	m		Po usunięciu znika pasek menu.

	M		Po usunięciu domyślne menu nie są ładowane.

	g		Po usunięciu nieaktywne punkty menu nie są szare, ale
			kompletnie znikają. (Nie działa we wszystkich
			systemach.)

	t		Po usunięciu menu nie mogą zostać oderwane.

Kropkowana linia na górze menu to nie linia separatora. Kiedy wybierzesz ten
punkt, menu jest "odrywane": pokazuje się w osobnym oknie. Nazywa się je
oderwanym menu. Wygodne kiedy używasz często tego samego menu.

O tłumaczeniu menu zobacz |:menutrans|.

Ponieważ mysz musi być użyta do wybrania menu dobrym pomysłem jest użycie
polecenia ":browse" do wybrania pliku i ":confirm" do okienka dialogowego
w przypadku jeśli bufor zawiera zmiany. Te dwa polecenia można połączyć: >

	:amenu File.Open  :browse confirm edit<CR>

":browse" sprawia, że pojawia się przeglądarka plików. ":confirm" pokaże okno
dialogowe jeśli bieżący bufor zawiera zmiany. Możesz wybrać zapisanie zmian,
odrzucić je albo anulować polecenie.
   W przypadkach bardziej skomplikowanych można użyć funkcji confirm()
i inputdialog(). Domyślne menu zawiera kilka przykładów.

==============================================================================
*42.4*	Pasek narzędzi i menu kontekstowe

Istnieją dwa specjalne menu: ToolBar i PopUp. Punkty, które zaczynają się tymi
nazwami nie pojawiają się w zwykłym pasku menu.

PASEK NARZĘDZI

Pasek narzędzi pojawia się tylko wtedy jeśli w opcji 'guioptions' jest flaga
"T". Używa raczej ikon niż tekstu do pokazania komendy. Na przykład,
{punkt-menu} nazwany "ToolBar.New" spowoduje pojawienie się ikony "New" na
pasku narzędzi.
   Vim ma 28 wbudowanych ikon. Ich tabela jest tu: |builtin-tools|. Większość
z nich jest użyta w domyślnym pasku narzędzi. Możesz redefiniować ich zadania
(po załadowaniu domyślnych menu).
   Możesz też dodać inną bitmapę do paska narzędzi lub zdefiniować nowy
przedmiot na punkt razem z ikoną. Zdefiniuj nowy punkt: >

	:tmenu ToolBar.Compile  Compile the current file
	:amenu ToolBar.Compile  :!cc % -o %:r<CR>

Musisz teraz stworzyć ikonę. W MS-Windows obowiązuje format bitmapy (.bmp),
a plik powinien się nazywać "Compile.bmp". Na Uniksach używa się formatu XPM,
a nazwa pliku to "Compile.xpm". Wielkość ikony to 18 na 18 pikseli.
W MS-Windows można użyć innych wymiarów, ale będzie to brzydko wyglądać.
   Umieść bitmapy w katalogu "bitmaps" w jednym z katalogów z 'runtimepath'.
Dla Uniksów będzie to np. "~/.vim/bitmaps/Compile.xpm".

Możesz też zdefiniować podpowiedzi (tooltip) dla ikon na pasku narzędzi.
Podpowiedź to krótki tekst, który wyjaśni co dany przycisk robi. Na przykład
"Open file" pojawi się kiedy wskaźnik myszy zawiśnie na chwilę nad ikoną.
Bardzo przydatne jeśli znaczenie obrazka nie jest oczywiste. Przykład: >

	:tmenu ToolBar.Make  Run make in the current directory
<
	Note:
	Uważaj na wielkość liter. "Toolbar" i "toolbar" to nie to samo co
	"ToolBar"!

Do usunięcia podpowiedzi użyj polecenia |:tunmenu|.

Opcja 'toolbar' może być użyta do pokazania tekstu zamiast bitmapy albo naraz
tekstu i bitmapy. większość ludzi używa wyłącznie bitmapy ponieważ tekst
zajmuje sporo miejsca.


MENU KONTEKSTOWE

Menu kontekstowe wyskakuje tam gdzie jest wskaźnik myszy. W MS-Windows
aktywuje się je przez kliknięcie prawym przyciskiem myszy. Potem możesz wybrać
odpowiedni punkt lewym przyciskiem. W Uniksie menu kontekstowego używa się
wciskując i przytrzymując prawy przycisk myszy.
   Menu kontekstowe pojawia się tylko wtedy gdy opcja 'mousemodel' została
ustawiona na "popup" albo "popup_setpos". Różnica pomiędzy tymi dwoma jest
taka, że "popup_setpos" przenosi kursor tam gdzie znajduje się wskaźnik myszy.
Klikając w zaznaczonym obszarze, zaznaczenie nie ulegnie zmianie. Przy
kliknięciu poza tym obszarem, zaznaczenie jest usuwane.
   Istnieje osobne menu kontekstowe dla każdego trybu. Dlatego nigdy nie
będzie szarych punktów tak jak w normalnych menu.

Jakie jest znaczenie życia, wszechświata i wszystkiego? *42*
Douglas Adams, jedyna osoba, która naprawdę wiedziała o czym jest to pytanie
niestety już nie żyje. Możesz się już tylko zastanawiać nad znaczeniem
śmierci...

==============================================================================

Następny rozdział: |usr_43.txt|  Typy plików

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
