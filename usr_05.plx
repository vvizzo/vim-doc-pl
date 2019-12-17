*usr_05.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			 Personalizacja ustawień Vima


Vim może być dostrojony tak jak tego chcesz. Ten rozdział pokazuje jak sprawić
by Vim zaczął pracę z opcjami ustawionymi na różne wartości; dodać wtyczki by
rozszerzyć możliwości Vima lub zdefiniować swoje własne makra.

|05.1|	Plik vimrc
|05.2|	Przykładowy vimrc z komentarzami
|05.3|	Proste mapowania
|05.4|	Dodawanie wtyczki
|05.5|	Dodawanie pliku pomocy
|05.6|	Okno opcji
|05.7|	Często używane opcje

 Następny rozdział: |usr_06.txt|  Podświetlanie składni
Poprzedni rozdział: |usr_04.txt|  Małe zmiany
       Spis treści: |usr_toc.txt|

==============================================================================
*05.1*	Plik vimrc 					*vimrc-intro*

Zapewne jesteś zmęczony wpisywaniem poleceń, których używasz bardzo często.
Vim zacznie działać z wszystkimi twoimi ulubionymi opcjami i mapowaniami jeśli
zapiszesz je w pliku vimrc. Vim czyta go w czasie uruchamiania.

Jeśli masz problemy ze znalezieniem swojego pliku vimrc, wydaj polecenie: >

	:scriptnames

Jeden z pierwszych plików na liście powinien być nazwany ".vimrc" lub "_vimrc"
i znajduje się w twoim katalogu domowym.
   Jeśli nie masz pliku vimrc sprawdź |vimrc| by się dowiedzieć gdzie możesz
go stworzyć. Także polecenie ":version" podaje gdzie Vim szuka "user vimrc
file".

Dla Uniksa plik ten zawsze jest: >

	~/.vimrc

Dla MS-DOS i MS-Windows jest to najczęściej jeden z tych: >

	$HOME/_vimrc
	$VIM/_vimrc

Plik vimrc może zawierać wszystkie polecenia, które wpisujesz po dwukropku.
Najprostszymi są te, które służą do ustawiania opcji. Na przykład jeśli chcesz
by Vim zaczynał zawsze z włączoną opcją 'incsearch' dodaj tę linijkę do
swojego pliku vimrc: >

	set incsearch

Żeby ta linijka działała musisz wyjść z Vima i wejść z powrotem. Później
nauczysz się jak to zrobić bez opuszczania Vima.

Ten rozdział wyjaśnia tylko najprostsze rzeczy. Więcej informacji o pisaniu
skryptów Vima: |usr_41.txt|.

==============================================================================
*05.2*	Przykładowy vimrc z komentarzami		*vimrc_example.vim*

W pierwszym rozdziale zostało wyjaśnione jak można użyć przykładowego pliku
vimrc (włączonego do dystrybucji) by Vim startował w trybie not-compatible
(zobacz |not-compatible|). Plik można znaleźć tu:

	$VIMRUNTIME/vimrc_example.vim ~

W tej sekcji wyjaśnimy różne polecenia użyte w tym pliku. Ułatwi to ustawienie
twoich własnych preferencji. Nie wszystko zostało jednak wyjaśnione. Aby
uzyskać większą pomoc użyj polecenia ":help".

>
	set nocompatible

Jak wspomniano w pierwszym rozdziale, te podręczniki wyjaśniają jak Vim
pracuje w ulepszony sposób nie całkiem kompatybilny z Vi. Wyłączenie opcji
'compatible', czyli ustawienie jej na 'nocompatible' to zapewnia.

>
	set backspace=indent,eol,start

Ta opcja precyzuje gdzie w trybie Insert <BS> może usuwać znaki przed
kursorem. Trzy punkty, oddzielone przecinkami mówią Vimowi, że może usunąć
znak odstępu na początku linii, znak łamania linii i znak przed znakiem gdzie
zaczął się tryb Insert.

>
	set autoindent

Mówi Vimowi by użył wcięcia poprzedniej linii dla nowo stworzonej linii. Obie
będą miały taką samą ilość znaków odstępu przed sobą. Działa to zarówno dla
<Enter> jak i "o" oraz "O".

>
	if has("vms")
	  set nobackup
	else
	  set backup
	endif

Ten zestaw mówi Vimowi by tworzył kopię pliku w czasie nadpisywania. Nie na
systemach VMS ponieważ one same o to dbają. Plik backup będzie miał tę samą
nazwę z dodanym "~". Zobacz |07.4|.

>
	set history=50

Trzyma 50 poleceń i 50 wzorców poszukiwania w historii. Użyj innej liczby
jeśli chcesz pamiętać mniej lub więcej linii.

>
	set ruler

Zawsze pokazuj obecną pozycję kursora w prawym dolnym rogu okna Vima.

>
	set showcmd

Pokazuj niekompletne polecenia w prawym dolnym rogu okna Vima, na lewo od
linijki (ruler). Na przykład, jeśli wpiszesz "2f" Vim czeka na abyś wpisał
następny znak i "2f" jest pokazane. Kiedy w końcu wciśniesz "w", polecenie
"2fw" jest wykonywane, a "2f" znika.

	+-------------------------------------------------+
	|tekst w oknie Vima    				  |
	|~						  |
	|~						  |
	|-- VISUAL --			2f     43,8   17% |
	+-------------------------------------------------+
	 ^^^^^^^^^^^		      ^^^^^^^^ ^^^^^^^^^^
	  'showmode'		     'showcmd'	'ruler'

>
	set incsearch

Pokazuje aktualne dopasowanie wzorca w czasie jego wpisywania.

>
	map Q gq

Definiuje mapowanie. Więcej o tym w następnej sekcji. To mapowanie definiuje
komendę "Q" do formatowania z operatorem "gq". Tak to pracowało przed Vim 5.0.
W innym wypadku komenda "Q" inicjuje tryb Ex, ale raczej nie będziesz go
potrzebował.

>
	vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

To jest skomplikowane. Nie wyjaśnimy tutaj jak polecenie dokładnie działa. To
co robi to sprawia, że "p" w trybie Visual nadpisuje wybrany tekst wcześniej
yankowany. Mapowania mogą być użyte do całkiem skomplikowanych rzeczy. Mimo
tego są to po prostu sekwencje komend, które są wykonywane jakbyś je wpisywał.

>
	if &t_Co > 2 || has("gui_running")
	  syntax on
	  set hlsearch
	endif

Włącza podświetlanie składni, ale tylko wtedy jeśli kolory są dostępne.
A opcja 'hlsearch' mówi Vimowi by podświetlił dopasowania ostatnio użytego
wzorca. Konstrukcja "if" jest bardzo użyteczna do ustawienia opcji
w zależności od warunków. Więcej o tym w |usr_41.txt|.

							*vimrc-filetype*  >
	filetype plugin indent on

Włącza trzy bardzo sprytne mechanizmy:
1. Wykrywanie typu pliku (filetype).
   Kiedy zaczynasz edytować plik Vim spróbuje wykryć jaki to jest typ pliku.
   Jeśli edytujesz "main.c" Vim zobaczy rozszerzenie ".c" i rozpozna go jako
   typ pliku "c". Jeśli edytujesz plik zaczynający się od "#!/bin/sh", Vim
   rozpozna go jako typ pliku "sh".
   Rozpoznawanie typu pliku jest używane do podświetlania składni i wykonania
   następnych dwóch punktów.
   Zobacz też |filetypes|.

2. Użycie wtyczki typu pliku.
   Wiele różnych typów plików jest edytowanych z różnymi opcjami. Na przykład
   jeśli edytujesz plik "c" wygodnie jest ustawić opcję 'cindent' do
   automatycznej indentacji pliku. Te powszechnie używane opcje są włączane do
   wtyczek typów plików Vima. Możesz także zrobić swoją własną wtyczkę, zobacz
   |write-filetype-plugin|.

3. Użycie plików indentacji
   W czasie edytowania programu, wcięcia w pliku często mogą być robione
   automatycznie. Vim dostarcza kilka reguł indentacji dla różnych typów
   plików. Zobacz |:filetype-indent-on| i 'indentexpr'.

>
	autocmd FileType text setlocal textwidth=78

Sprawia, że Vim łamie linie by uniknąć wierszy dłuższych niż 78 znaków. Ale
robi to tylko dla plików rozpoznanych jako czysty tekst (text/plain).
W rzeczywistości polecenie to składa się z dwóch części. "autocmd FileType
text" jest autokomendą. Definiuje, że kiedy typ pliku zostanie ustawiony na
"text" następna komenda jest automatycznie wykonywana. "setlocal textwidth=78"
ustawia opcję 'textwidth' na 78, ale tylko lokalnie w jednym pliku.

>
	autocmd BufReadPost *
	    \ if line("'\"") > 0 && line("'\"") <= line("$") |
	    \   exe "normal g`\"" |
	    \ endif

Następna autokomenda. Ta jest wykonywana po wczytaniu każdego pliku.
Skomplikowany kod po niej sprawdza czy jest zdefiniowana zakładka '" i skacze
do niej jeśli istnieje. Backslashe na początku linii służą do kontynuacji
polecenia z poprzedniej linii. W ten sposób unika się długich linii. Zobacz
|line-continuation|. Działa tylko w skryptach Vima, nie w czasie edycji linii
poleceń.

==============================================================================
*05.3*	Proste mapowania

Mapowania pozwalają na przypisanie kolekcji komend Vima do jednego klawisza.
Przypuśćmy, że potrzebujesz objąć pewne słowa nawiasami klamrowymi. Innymi słowy
potrzebujesz zmienić słowo takie jak "ile" w "{ile}". Dzięki poleceniu :map
możesz sprawić, że <F5> zrobi za ciebie robotę. Polecenie wygląda tak: >

	:map <F5> i{<Esc>ea}<Esc>
<
	Note:
	Wprowadzając to polecenie musisz wprowadzić <F5> wpisując cztery znaki.
	Podobnie <Esc> nie jest wprowadzane wciśnięciem klawisza <Esc>, ale
	pięciu klawiszy. Uważaj na to czytając podręcznik!

Rozłóżmy polecenie na części pierwsze:
    <F5>	Klawisz funkcyjny F5. Powoduje, że polecenie jest wykonywane
		po wciśnięciu odpowiedniego klawisza.

    i{<Esc>	Wprowadza znak {. Klawisz <Esc> kończy tryb Insert.

    e		Przenosi do końca wyrazu.

    a}<Esc>	Dodaje } na końcu wyrazu.

Po wykonaniu polecenia ":map" wszystko co musisz zrobić dla obramowania wyrazu
{} to umieszczenie kursora na pierwszym znaku wyrazu i wciśnięcie <F5>.

W tym przykładzie cynglem był pojedynczy klawisz, ale może być też łańcuch.
Niestety, używając istniejącej komendy Vima, komenda ta nie będzie dłużej
dostępna. Lepiej tego unikać.
   Jednym z klawiszy jakie mogą być użyte w mapowaniach jest backslash.
Ponieważ prawdopodobnie chcesz zdefiniować więcej niż jedno mapowanie dodaj
inny znak. Możesz zmapować "\n" do dodania wzięcia wyrazu w zwykłe nawiasy,
a "\k" do wzięcia go w nawiasy klamrowe. Na przykład: >

	:map \n i(<Esc>ea)<Esc>
	:map \k i{<Esc>ea}<Esc>

Musisz szybko wpisać \ i n, tak że Vim będzie wiedział, że są ze sobą
związane.

Polecenie ":map" (bez argumentów) daje listę wszystkich obecnych mapowań.
Przynajmniej tych dla trybu Normal. Więcej o mapowaniach w sekcji |40.1|.

==============================================================================
*05.4*	Dodawanie wtyczki 				*add-plugin* *plugin*

Funkcjonalność Vima może być rozszerzona przez dodawanie wtyczek. Wtyczka jest
niczym więcej niż plikiem skryptowym ładowanym automatycznie w czasie startu
Vima. Możesz bardzo łatwo dodać wtyczkę przez wrzucenie jej do katalogu
plugin.

{note: niedostępne jeśli Vim został skompilowany bez |+eval|}

Są dwa typu wtyczek:

      wtyczki globalne: dla wszystkich typów plików
    wtyczki typu pliku: tylko dla poszczególnych typów plików

Najpierw omówimy wtyczki globalne, później typu pliku (|add-filetype-plugin|).


WTYCZKI GLOBALNE 					*standard-plugin*

Kiedy zaczynasz Vima ładuje on automatycznie pewną liczbę wtyczek globalnych.
Nie musisz nic z tym robić. Dodają one możliwości, których większość ludzi
będzie chciała używać, ale które zostały zaimplementowane jako skrypt Vima
zamiast wkompilowane w niego. Ich lista jest tu: |standard-plugin-list|.
Zobacz także |load-plugins|.

							*add-global-plugin*
Możesz dodać wtyczkę globalną dla dodania funkcjonalności, która zawsze będzie
obecna w czasie używania Vima. Wystarczą do tego tylko dwa kroki:
1. Zdobądź kopię wtyczki.
2. Wrzuć ją do odpowiedniego katalogu.


ZDOBYCIE WTYCZKI GLOBALNEJ

Gdzie mogę znaleźć wtyczki?
- Kilka przychodzi razem z Vimem. Możesz je znaleźć w katalogu
  $VIMRUNTIME/macros i jego podkatalogach.
- Ściągnij z sieci, sprawdź http://vim.sf.net.
- Niektóre są wysyłane na mail-listę Vima |maillist|.
- Możesz napisać własną, zobacz |write-plugin|.


UŻYWANIE WTYCZKI GLOBALNEJ

Najpierw przeczytaj tekst w samej wtyczce by sprawdzić czy są jakieś specjalne
warunki. Potem skopiuj plik do katalogu wtyczke:

	system		katalog wtyczek~
	Unix		~/.vim/plugin/
	PC i OS/2	$HOME/vimfiles/plugin or $VIM/vimfiles/plugin
	Amiga		s:vimfiles/plugin
	Macintosh	$VIM:vimfiles:plugin
	Mac OS X 	~/.vim/plugin/
	RISC-OS		Choices:vimfiles.plugin

Przykład dla Uniksa (przyjmując, że nie masz jeszcze katalogu wtyczek): >

	mkdir ~/.vim
	mkdir ~/.vim/plugin
	cp /usr/local/share/vim/vim60/macros/justify.vim ~/.vim/plugin

To wszystko! Teraz możesz używać poleceń z tej wtyczki do justowania tekstu.


WTYCZKI TYPU PLIKU 			*add-filetype-plugin* *ftplugins*

Dystrybucja Vima zawiera zestaw wtyczek dla różnych typów plików, których
używanie możesz włączyć używając tego polecenia: >

	:filetype plugin on

To wszystko!  Zobacz |vimrc-filetype|.

Jeśli brakuje ci wtyczki dla typu pliku, którego używasz albo znalazłeś lepszą
możesz ją dodać. Dwa kroki służące do dodania wtyczki typu pliku:
1. Zdobądź kopię wtyczki.
2. Wrzuć ją do odpowiedniego katalogu.


ZDOBYCIE WTYCZKI TYPU PLIKU

Możesz je zdobyć w tych samych miejscach co wtyczki globalne. Jeśli typ pliku
jest wspomniany wiesz czy wtyczka jest globalna czy typu pliku. Skrypty
w $VIMRUNTIME/macros są globalne, wtyczki typu pliku znajdują się
w $VIMRUNTIME/ftplugin.


UŻYWANIE WTYCZKI TYPU PLIKU 				*ftplugin-name*

Możesz dodać wtyczkę typu pliku przez wrzucenie jej do odpowiedniego katalogu.
Nazwa tego katalogu jest taka sama jak dla wtyczek globalnych, z wyjątkiem
ostatniej części: "ftplugin". Przypuśćmy, że znalazłeś wtyczkę dla typu pliku
"stuff" i jesteś na Uniksie. Możesz przenieść plik do katalogu ftplugin: >

	mv thefile ~/.vim/ftplugin/stuff.vim

Jeśli taki plik istnieje, masz już wtyczkę dla "stuff". Możesz sprawdzić czy
nowa wtyczka nie powoduje konfliktów z tą, którą dodajesz. Jeśli wszystko jest
w porządku nadaj nowej inną nazwę: >

	mv thefile ~/.vim/ftplugin/stuff_too.vim

Podkreślenie służy do oddzielenia nazwy typu pliku od reszty, która może
brzmieć dowolnie. "otherstuff.vim" nie będzie działać bo będzie ładowane dla
typu pliku "otherstuff".

W MS-DOS nie można używać długich nazw plików. Mógłbyś wpaść w kłopoty jeśli
dodałbyś drugą wtyczkę a typ pliku miałby więcej niż 6 znaków. Żeby to obejść
możesz użyć osobnego katalogu: >

	mkdir $VIM/vimfiles/ftplugin/fortran
	copy thefile $VIM/vimfiles/ftplugin/fortran/too.vim

Ogólne nazwy dla wtyczek typu pliku to: >

	ftplugin/<filetype>.vim
	ftplugin/<filetype>_<nazwa>.vim
	ftplugin/<filetype>/<nazwa>.vim

Gdzie "<nazwa>" może być dowolną nazwą.
Przykłady typów plików dla Uniksa: >

	~/.vim/ftplugin/stuff.vim
	~/.vim/ftplugin/stuff_def.vim
	~/.vim/ftplugin/stuff/header.vim

Część <filetype> jest nazwą typu pliku, dla którego wtyczka będzie używana.
Tylko pliki tego typu będą miały opcje z tej wtyczki. Część <nazwa> nazwy
wtyczki nie ma znaczenia, możesz tego użyć by mieć kilka wtyczek dla tego
samego typu pliku. Note, że nazwa musi się kończyć na ".vim".


Dalsza lektura:
|filetype-plugins|	Dokumentacja dla wtyczek typów plików i informacja jak
			uniknąć problemów z mapowaniami.
|load-plugins|		Kiedy wtyczki globalne są ładowane.
|ftplugin-overrule|	Nadpisywanie ustawień z wtyczek globalnych.
|write-plugin|		Jak napisać wtyczkę.
|plugin-details|	Więcej informacji o używaniu wtyczek i kiedy twoja
			wtyczka nie pracuje.

==============================================================================
*05.5*	Dodawanie pliku pomocy 		*add-local-help* *matchit-install*

Jeśli masz szczęście, wtyczka, którą zainstalowałeś ma plik pomocy. Wyjaśnimy
tu jak zainstalować plik pomocy, tak że możesz łatwo znaleźć pomoc do nowej
wtyczki.
   Użyjmy wtyczki "matchit.vim" jako przykładu (jest dołączona do Vima).
Wtyczka ta powoduje, że "%" skacze do parujących znaczników HTML,
if/else/endif w skryptach Vima, itd. Bardzo użyteczna, choć nie jest nie
działa w wersjach Vima pre-6.0 (dlatego nie jest włączona domyślnie).
   "matchit.vim" posiada dokumentację: "matchit.txt". Najpierw skopiuj wtyczkę
do odpowiedniego katalogu. Teraz zrób to z Vima, tak że możemy użyć
$VIMRUNTIME. (Możesz opuścić polecenia "mkdir" jeśli masz już odpowiednie
katalogi.) >

	:!mkdir ~/.vim
	:!mkdir ~/.vim/plugin
	:!cp $VIMRUNTIME/macros/matchit.vim ~/.vim/plugin

Teraz stwórz katalog "doc" w jednym z katalogów 'runtimepath'. >

	:!mkdir ~/.vim/doc

Skopiuj plik pomocy do katalogu "doc". >

	:!cp $VIMRUNTIME/macros/matchit.txt ~/.vim/doc

Teraz czas na trik, który pozwala na skakanie do tematów w nowym pliku pomocy:
stwórz lokalny plik znaczników poleceniem |:helptags|. >

	:helptags ~/.vim/doc

Teraz już możesz użyć polecenia >

	:help g%

do znalezienia pomocy o komendzie "g%" w pliku pomocy jaki dopiero co dodałeś.
Zostanie też dodany odpowiedni wpis w katalogu pomocy: >

	:help
	:help local-additions

Linie tytułowe z lokalnego pliku pomocy będą automagicznie dodane w tej
sekcji. Możesz tam zobaczyć, które lokalne pliki pomocy zostały dodane
i skoczyć do nich przez znacznik.

Jak napisać lokalny plik pomocy zobacz |write-local-help|.

==============================================================================
*05.6*	Okno opcji

Jeśli szukasz opcji, o której wiesz co robi, możesz szukać w plikach pomocy:
|options|. Innym sposobem jest polecenie: >

	:options

Otwiera nowe okno z listą opcji i jednowierszowym wyjaśnieniem. Opcje są
pogrupowane tematycznie. Przenieś kursor na temat i wciśnij <Enter> by skoczyć
do grupy. Wciśnij <Enter> znowu by skoczyć znowu (lub użyj CTRL-O).

Możesz zmienić wartość opcji. Na przykład, przejdź do tematu "displaying text"
(prezentacja tekstu). Potem zejdź do linii: >

	set wrap	nowrap

Kiedy wciśniesz <Enter>, linia się zmieni: >

	set nowrap	wrap

Opcja została wyłączona.

Tuż powyżej jest krótki opis opcji 'wrap'. Przejdź tam kursorem, a kiedy
wciśniesz <Enter> skoczysz do pełnego opisu tej opcji.

Przy opcjach, które pobierają liczbę lub łańcuch jako argument możesz edytować
wartość. Potem wciśnij <Enter> by zastosować nową wartość. Na przykład,
przejdź kilka linii wyżej do linii: >

	set so=0

Umieść "$"-em kursor na 0. Zmień je na piątkę "r5". Teraz wciśnij <Enter> by
zastosować nową wartość. Kiedy będziesz manewrował kursorem zauważysz, że
tekst zaczyna się przesuwać zanim osiągniesz krawędź. To jest to co robi opcja
'scrolloff'.

==============================================================================
*05.7*	Często używane opcje

Istnieje ogromna liczba opcji. Większości z nich rzadko będziesz używał. Ale
część z bardziej użytecznych jest tutaj wspomniana. Nie zapomnij, że możesz
uzyskać pomoc na temat tych opcji poleceniem ":help" i z pojedynczymi
cudzysłowami przed i po nazwie opcji. Na przykład: >

	:help 'wrap'

W przypadku jeśli coś pomieszałeś z wartością opcji możesz ustawić ją na
wartość domyślną przez dodanie ampersanda (&) po nazwie opcji: >

	:set iskeyword&


BEZ ZAWIJANIA LINII

Vim normalnie zawija długie linie, tak więc możesz zobaczyć cały tekst.
Czasami lepiej pozwolić by tekst kontynuował poza prawą krawędź okna.  Wtedy
potrzebujesz przewijać tekst lewo-prawo by zobaczyć całość długich linii.
Przełącz wartości opcji 'wrap': >

	:set nowrap

Vim automatycznie będzie przewijał tekst kiedy dojdziesz do nieprezentowanej
części. Żeby zobaczyć kontekst dziesięciu znaków: >

	:set sidescroll=10

Nie zmienia to samego tekstu, tylko sposób jego prezentacji.


ZAWIJANIE POLECEŃ RUCHU

Większość komend ruchu zatrzyma się na początku i końcu linii. Możesz to
zmienić opcją 'whichwrap'. Oto domyślne ustawienia: >

	:set whichwrap=b,s

Pozwalają one klawiszowi <BS>, kiedy użyty w pierwszej kolumnie, na przejście
do końca poprzedniej linii. A klawiszowi <Space> z końca linii do początku
następnej.

Klawisze <Left> i <Right> mogą to robić po wydaniu polecenia: >

	:set whichwrap=b,s,<,>

Działa to tylko dla trybu Normal. <Left> i <Right> mogą to robić w trybie
Insert po poleceniu: >

	:set whichwrap=b,s,<,>,[,]

Jest jeszcze kilka flag, które mogą być dodane, zobacz 'whichwrap'.


OGLĄDANIE ZNAKÓW TABULACJI

Jeśli są znaki tabulacji w pliku nie możesz ich zobaczyć. Aby to zrobić:
>
	:set list

Teraz każdy znak <Tab> jest widoczny jako ^I. $ pokazuje gdzie jest koniec
linii. W ten sposób widzisz zbędne białe znaki, które w innym wypadku byłyby
niezauważalne.
   Niewygodą jest brzydki wygląd kiedy jest wiele <Tab> w pliku. Jeśli masz
kolorowy terminal lub używasz GUI Vim może pokazać spacje i znaki tabulacji
jako podświetlone znaki. Użyj opcji 'listchars': >

	:set listchars=tab:>-,trail:-

Teraz każdy znak <Tab> będzie pokazany jako ">---" i zbędny znak odstępu jako
"-". Wygląda o wiele lepiej, nieprawdaż?


KEYWORDS

Opcja 'iskeyword' decyduje jakie znaki mogą pojawić się w słowie: >

	:set iskeyword
<	  iskeyword=@,48-57,_,192-255

"@" oznacza wszystkie znaki alfabetu. "48-57" to znaki ASCII od 48 do 57,
czyli numery od 0 do 9. "192-255" to drukowalne znaki łacińskie.
   Czasami będziesz chciał włączyć myślnik do keywords, tak aby komenda taka
jak "w" uznawała "biało-czarny" za jeden wyraz. Robisz to tak: >

	:set iskeyword+=-
	:set iskeyword
<	  iskeyword=@,48-57,_,192-255,-

Jeśli spojrzysz na nową wartość zobaczysz, że Vim dodał przecinek za ciebie.
   Aby usunąć znak użyj "-=". Na przykład by usunąć podkreślenie: >

	:set iskeyword-=_
	:set iskeyword
<	  iskeyword=@,48-57,192-255,-

Teraz przecinek został automatycznie usunięty.


MIEJSCE DLA KOMUNIKATÓW

Kiedy Vim startuje jest jedna linia na dole, która jest używana dla
komunikatów. Jeśli komunikat jest długi, jest on albo ucinany, tak że możesz
zobaczyć tylko jego część, albo tekst przewija się i musisz wcisnąć <Enter> by
kontynuować.
   Możesz ustawić opcję 'cmdheight' na liczbę linii używaną dla komunikatów: >

	:set cmdheight=3

Oznacza to też, że będzie mniej miejsca na edycję tekstu, tak więc jest to
kompromis.

==============================================================================

Następny rozdział: |usr_06.txt|  Podświetlanie składni

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
