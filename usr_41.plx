*usr_41.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			    Pisanie skryptów Vima


Język skryptowy Vima używany jest w pliku startowym vimrc, plikach składni
i w wielu innych przypadkach. Ten rozdział wyjaśnia co można zrobić
w skryptach Vima. Jest to bardzo dużo, więc rozdział jest długi.

|41.1|	Wstęp
|41.2|	Zmienne
|41.3|	Wyrażenia
|41.4|	Warunki (if, elseif, else)
|41.5|	Wykonywanie wyrażeń
|41.6|	Funkcje
|41.7|	Definiowanie funkcji
|41.8|	Wyjątki
|41.9|	Różne uwagi
|41.10|	Pisanie wtyczki
|41.11|	Pisanie wtyczki dla typu pliku (ftplugin)
|41.12|	Pisanie wtyczki dla kompilatora

 Następny rozdział: |usr_42.txt|  Dodawanie menu
Poprzedni rozdział: |usr_40.txt|  Tworzenie poleceń
       Spis treści: |usr_toc.txt|

==============================================================================
*41.1*	Wstęp   					*vim-script-intro*

Twoje pierwsze doświadczenie ze skryptami Vima to plik vimrc. Vim czyta go
podczas startu i wykonuje zawarte tam polecenia. Między innymi możesz ustawiać
opcje na wartości ci odpowiadające. Możesz tam też użyć dowolnego polecenia
dwukropka (polecenia zaczynające się na ":"; nazywa się je też czasami
komendami Ex lub poleceniami linii poleceń).
   Pliki składni także są skryptami Vima. To samo pliki ustawiające opcje dla
poszczególnych typów plików. Skomplikowane makro może być zdefiniowane
w osobnym pliku skryptowym Vima. Sam możesz wymyśleć inne zastosowania.

Zacznijmy od prostego przykładu: >

	:let i = 1
	:while i < 5
	:  echo "liczba to" i
	:  let i = i + 1
	:endwhile
<
	Note:
	":" nie jest tu naprawdę potrzebny. Dwukropka potrzebujesz tylko kiedy
	wpisujesz polecenie. W skryptach Vima można je pominąć. Tutaj będziemy
	ich jednak używać, żeby przypomnieć o ich funkcji jako poleceniach
	dwukropka i odróżnić od poleceń trybu Normal.

Polecenie ":let" przypisuje wartość do zmiennej. Ogólna forma: >

	:let {zmienna} = {wyrażenie}

W tym wypadku nazwą zmiennej jest "i", a wyrażeniem prosta wartość, liczba
jeden.
   Polecenie ":while" zaczyna pętlę. Ogólna forma to: >

	:while {warunek}
	:  {wyrażenia}
	:endwhile

Wyrażenia przed ":endwhile" są wykonywane tak długo jak warunek jest
prawdziwy. Warunkiem w naszym przykładzie jest wyrażenie "i < 5". Jest ono
prawdziwe dopóki zmienna i jest mniejsza od pięciu.
   Polecenie ":echo" wypisuje na ekranie argumenty. W tym wypadku łańcuch
"liczba to" i wartość zmiennej i. Ponieważ i to jeden, napisze:

	liczba to 1 ~

Później jest inne polecenie ":let i =". Wartością jest wyrażenie "i + 1".
Dodaje ono jeden do zmiennej i i przypisuje nową wartość do tej samej
zmiennej.
   Wynikiem przykładowego kodu jest:

	liczba to 1 ~
	liczba to 2 ~
	liczba to 3 ~
	liczba to 4 ~

	Note:
	Jeśli zdarzy ci się napisać pętlę, która nie chce się skończyć możesz
	ją przerwać CTRL-C (CTRL-Break w MS-Windows).


TRZY RODZAJE LICZB

Liczby mogą być dziesiętne, szesnastkowe lub ósemkowe. Liczby szesnastkowe
zaczynają się od "0x" lub "0X" - "0x1f" to 31. Liczba ósemkowa zaczyna się
zera: "017" to 15. Uważaj: nie umieszczaj zera przed liczbą dziesiętną, będzie
zinterpretowana jako liczba ósemkowa!
   Polecenie ":echo" zawsze drukuje liczby dziesiętne. Przykład: >

	:echo 0x7f 036
<	127 30 ~

Liczba jest ujemna jeśli poprzedza ją znak minus. Działa to również dla liczb
szesnastkowych i ósemkowych. Minus to również znak odejmowania. Porównaj
z powyższym przykładem: >

	:echo 0x7f -036
<	97 ~

Znaki odstępu w wyrażeniach są ignorowane. Zaleca się jednak ich stosowanie do
odzielania elementów wyrażenia, żeby kod był bardziej czytelny. Na przykład
żeby uniknąć pomyłki z liczbą ujemną umieść spację między znakiem minus
i następującą po nim liczbą: >

	:echo 0x7f - 036

==============================================================================
*41.2*	Zmienne

Nazwa zmiennej może składać się z liter ASCII, cyfr i znaków podkreślenie (nie
może zawierać polskich znaków diakrytycznych). Nie może zaczynać się cyfrą.
Prawidłowymi nazwami zmiennych są:

	mnoznik
	_aap3
	bardzo_dluga_nazwa_z_podkresleniami
	FuncLength
	LENGTH

Błędnymi nazwami są "foo+bar", "6var" oraz "mnożnik".
   Zmienne te są globalne. Żeby zobaczyć listę obecnie zdefiniowanych
zmiennych użyj polecenia: >

	:let

Zmiennych globalnych możesz używać wszędzie. Oznacza to, że jeśli użyjesz
zmiennej "mnoznik" w jednym pliku skryptowym może być ona użyta również
w innym. W najlepszym wypadku może prowadzić to do pomyłek, w najgorszym do
poważnych problemów. Żeby tego uniknąć użyj zmiennej lokalnej dla skryptu
poprzedzając jej nazwę "s:". Przykład skryptu: >

	:let s:mnoznik = 1
	:while s:mnoznik < 5
	:  source inny.vim
	:  let s:mnoznik = s:mnoznik + 1
	:endwhile

Ponieważ "s:mnoznik" jest lokalna dla tego skryptu jesteś pewien, że wczytanie
pliku "inny.vim" nie zmieni tej zmiennej. Jeśli "inny.vim" także używa
"s:mnoznik" będzie ona inną kopią, lokalną dla tego skryptu. Więcej
o zmiennych lokalnych dla skryptu: |script-variable|.

Istnieje więcej typów zmniennych, zobacz |internal-variables|. Najczęściej
używane to:

	b:nazwa		zmienna lokalna dla bufora
	w:nazwa		zmienna lokalna dla okna
	g:nazwa		zmienna globalna (także w funkcji)
	v:nazwa		zmienna predefiniowana przez Vima


USUWANIE ZMIENNYCH

Zmienne zajmują pamięć i pokazują się w wyniku polecenia ":let". Do ich
usuwania służy polecenie ":unlet": >

	:unlet s:mnoznik

Usuwa zmienną lokalną skryptu "s:mnoznik", żeby uwolnić pamięć, którą używa.
Jeśli nie jesteś pewien czy zmienna istnieje, a nie chcesz komunikatu błędu
w wypadku gdyby nie istniała, dodaj !: >

	:unlet! s:mnoznik

Kiedy skrypt kończy działanie jego zmienne lokalne nie są automatycznie
usuwane. Następnym razem kiedy skrypt jest wykonywany może użyć starej
wartości. Przykład: >

	:if !exists("s:wywolano_mnoznik")
	:  let s:wywolano_mnoznik = 0
	:endif
	:let s:wywolano_mnoznik = s:wywolano_mnoznik + 1
	:echo "wywołano" s:wywolano_mnoznik "razy"

Funkcja "exists()" sprawdza czy zmienna została już zdefiniowana. Jej
argumentem jest nazwa zmiennej, którą chcesz sprawdzić. Nie sama zmienna!
Gdybyś zrobił coś takiego: >

	:if !exists(s:wywolano_mnoznik)

Użyta by została wartość s:wywolano_mnoznik jako nazwa zmiennej do sprawdzenia
przez exists(). Nie dałoby to oczekiwanego rezultatu.
   Znak wykrzyknika ! zaprzecza wartości. Jeśli wartość jest prawdziwa,
wyrażenie staje się fałszem. Jeśli jest fałszywe staje się prawdziwe. Możesz
go odczytywać jako "nie". Dlatego "if !exists()" można czytać jako "if not
exists()" (jeśli nie istnieje).
   Vim nazywa prawdą wszystko co nie jest równe zero. Tylko zero jest fałszem.


ŁAŃCUCHY I STAŁE

Jak na razie używaliśmy tylko liczb jako wartości zmiennych. Do tego celu
można też użyć łańcuchów. Liczby i łańcuchy to jedyne dwa typy zmiennych jakie
wspiera Vim. Typ jest dynamiczny czyli ustawiany za każdym razem kiedy
przypisuje się zmienną przy pomocy ":let".
   Dp przypisania łańcucha do zmiennej musisz użyć stałej łańcuchowej. Są ich
dwa typy. Najpierw łańcuch w podwójnych cudzysłowach: >

	:let imie = "piotr"
	:echo imie
<	piotr ~

Jeśli chcesz włączyć podwójny cudzysłów wewnątrz łańcucha umieść przed nim
backslash: >

	:let imie = "\"piotr\""
	:echo imie
<	"piotr" ~

Aby uniknąć backslasha możesz łańcuch umieścić wewnątrz pojedynczych
cudzysłowów: >

	:let imie = '"piotr"'
	:echo imie
<	"piotr" ~

W łańcuchu umieszczonym wewnątrz pojedynczych cudzysłowów wszystkie znaki są
traktowane dosłownie. Wadą tego rozwiązania jest niemożność włączenia do
łańcucha pojedynczego cudzysłowu. Backslash też jest traktowany dosłownie,
więc nie możesz go użyć do zmiany znaczenia znaku następującego po nim.
   Wewnątrz podwójnych cudzysłowów możesz użyć znaków specjalnych. Kilka
najbrdziej użytecznych:

	\t		<Tab>
	\n		<NL>, nowa linia
	\r		<CR>, <Enter>
	\e		<Esc>
	\b		<BS>, backspace
	\"		"
	\\		\, backslash
	\<Esc>		<Esc>
	\<C-W>		CTRL-W

Dwa ostatnie to tylko przykłady. Formy "\<nazwa>" można użyć do włączenia
specjalnego klawisza.
   Pełna lista znaków specjalnych w łańcuchu jest tu: |expr-quote|.

==============================================================================
*41.3*	Wyrażenia

Vim posiada bogaty, ale prosty mechanizm wyrażeń. Definicję możesz przeczytać
tu: |expressions-syntax|. Tutaj poznamy tylko podstawy.
   Liczby, łańcuchy i zmienne wspomniane wyżej same są wyrażeniami. Dlatego
wszędzie gdzie spodziewane jest wyrażenie możesz użyć liczby, łańcucha lub
zmiennej. Innymi podstawowymi elementami w wyrażeniach są:

	$NAZWA		zmienna środowiskowa
	&nazwa		opcja
	@r		rejestr

Przykłady: >

	:echo "Wartość 'tabstop' to" &ts
	:echo "Twój katalog domowy to" $HOME
	:if @a > 5

Forma &nazwa może zostać użyta do zachowania wartości opcji, ustawienia nowej
wartości, zrobienia czegoś i przywrócenia starej wartości. Przykład: >

	:let save_ic = &ic
	:set noic
	:/Początek/,$delete
	:let &ic = save_ic

W ten sposób jesteś pewien, że wzorzec "Początek" jest zastosowany z wyłączoną
opcją 'ignorecase'. Na końcu przywracana jest wartość zastosowana przez
użytkownika.


MATEMATYKA

Wszystko stanie się bardziej interesujące jeśli połączymy podstawowe elementy.
Zacznijmy od matematyki na liczbach:

	a + b		dodaj
	a - b		odejmij
	a * b		pomnóż
	a / b		podziel
	a % b		modulo

Zastosowano zwykłe pierwszeństwo operacji.  Przykład: >

	:echo 10 + 5 * 2
<	20 ~

Grupowanie robi się nawiasami. Żadnych niespodzianek.  Przykład: >

	:echo (10 + 5) * 2
<	30 ~

Łańcuchy mogą być łączone ".". Przykład: >

	:echo "foo" . "bar"
<	foobar ~

Kiedy ":echo" dostaje kilka argumentów oddziela je spacją. W przykładzie
argument jest pojedynczym wyrażeniem, więc spacje nie zostały wstawione.

Pożyczono z języka C wyrażenie warunkowe:

	a ? b : c

Jeśli "a" okaże się prawdziwe, stosuje się "b", w innym wypadku "c". Przykład:
>
	:let i = 4
	:echo i > 5 ? "i jest duże" : "i jest małe"
<	i is small ~

Wszystkie trzy części konstrukcji są najpierw rozwiązywane, działa to tak jak:

	(a) ? (b) : (c)

==============================================================================
*41.4*	Warunki (if, elseif, else)

Polecenie ":if" wykonuje kolejne wyrażenia aż do parującego ":endif", ale
tylko jeśli warunek jest prawdziwy. Ogólna forma to:

	:if {warunek}
	   {wyrazenia}
	:endif

Dopiero kiedy wyrażenie {warunek} jest prawdziwe (różne od zera) {wyrazenia}
będą wykonane. Muszą to być prawidłowe polecenia. Jeśli będą zawierały śmieci,
Vim nie będzie w stanie znaleźć ":endif".
   Możesz też użyć ":else". Ogólna forma jest taka:

	:if {warunek}
	   {wyrazenia}
	:else
	   {wyrazenia}
	:endif

Drugie {wyrazenia} wykonywane jest tylko wtedy jeśli pierwsze nie zostały
wykonane.
   Na końcu jest ":elseif":

	:if {warunek}
	   {wyrazenia}
	:elseif {warunek}
	   {wyrazenia}
	:endif

Działa tak jakby użyć ":else", a potem "if", ale bez potrzeby dla dodatkowego
":endif".
   Użyteczny przykład dla twojego vimrc to sprawdzenie opcji 'term'
i zrobienie czegoś na podstawie jej wartości: >

	:if &term == "xterm"
	:  " Zrób coś dla xterma
	:elseif &term == "vt100"
	:  " Zrób coś dla vt100
	:else
	:  " Zrób coś na potrzeby innych terminali
	:endif


OPERACJE LOGICZNE

Niektóre już spotkaliśmy w przykładach. Te są najczęściej używane:

	a == b		równy
	a != b		nierówny
	a >  b		większy od
	a >= b		większy od albo równy
	a <  b		mniejszy od
	a <= b		mniejszy od albo równy

Wynik jest równy jeden jeśli warunek jest spełniony i równy zero w przeciwnym
wypadku. Przykład: >

	:if v:version >= 600
	:  echo "Gratulacje"
	:else
	:  echo "Używasz starej wersji. Upgrade!"
	:endif

"v:version" to zmienna zdefiniowana przez Vima, która określa numer wersji
programu. 600 jest dla 6.0. Wersja 6.1 ma wartość 601. Bardzo pożyteczne przy
pisaniu skryptu, który ma działać na różnych wersjach Vima.  |v:version|

Operatory logiczne działają zarówno na liczbach jak i łańcuchach. W czasie
porównywania dwóch łańcuchów używa się różnicy matematycznej porównującej
wartości bitowe, które mogą być różne w różnych językach.
   Porównując łańcuch i liczbę, łańcuch jest najpierw konwertowany do liczby.
Może to sprawić problemy ponieważ kiedy łańcuch nie wygląda jak liczba Vim
używa 0. Przykład: >

	:if 0 == "jeden"
	:  echo "tak"
	:endif

Warunek będzie spełniony ponieważ "jeden" nie wygląda jak liczba, więc
zostanie przekonwertowany na zero.

Dla łańcuchów są dwa dodatkowe operatory:

	a =~ b		dopasowuje
	a !~ b		nie dopasowuje

Lewy element, "a", jest użyty jako łańcuch. Prawy, "b", to wzorzec, który
będzie przeszukiwany. Przykład: >

	:if str =~ " "
	:  echo "str zawiera spację"
	:elseif str !~ '\.$'
	:  echo "str kończy się na kropce"
	:endif

Zauważ użycie pojedynczych cudzysłowów we wzorcach. Wygodne ponieważ
backslashe muszą być podwojone w łańcuchach wewnątrz podwójnych cudzysłowów
i wzorce potrafią zawierać wiele backslashy.

Opcja 'ignorecase' jest brana pod uwagę w czasie porównywania łańcuchów. Jeśli
tego nie chcesz, dodaj "#", żeby wielość znaków się liczyła i "?", żeby
zostało to zignorowane. Stąd "==?" porównuje dwa łańcuchy nie zwracając uwagi
na wielkość znaków, a "!~#" sprawdza czy wzorzec nie pasuje równocześnie
patrząc na wielkość znaków. Pełna tablica: |expr-==|.


WIĘCEJ O PĘTLACH

Wspomnino już o poleceniu ":while". Można użyj jeszcze dwóch poleceń między
":while" i ":endwhile":

	:continue		Skocz do początku pętli while; pętla jest
				kontynuowana.
	:break			Skocz do ":endwhile" i zakończ pętlę.

Przykład: >

	:while licznik < 40
	:  call zrob_cos()
	:  if flaga_kontynuowania
	:    continue
	:  endif
	:  if flaga_konca
	:    break
	:  endif
	:  sleep 50m
	:endwhile

Polecenie ":sleep" wprawia Vima w drzemkę. "50m" to pięćdziesiąt milisekund.
Innym przykładem jest ":sleep 4" - czyli drzemka czterosekundowa.

==============================================================================
*41.5*	Wykonywanie wyrażeń

Jak na razie polecenia w skrypcie były wykonywane bezpośrednio przez Vima.
Polecenie ":execute pozwala na wykonanie wyniku wyrażenia. Jest to naprawdę
potężne narzędzie do budowania poleceń i wykonywania ich.
   Przykładem może być skok do wyrażenia, który zawarty jest w zmiennej: >

	:execute "tag " . nazwa_znacznika

"." służy do połączenia łańcucha "tag " z wartością zmiennej
"nazwa_znacznika".  Przypuśćmy, że "nazwa_znacznika" ma wartość "get_cmd"
wtedy wykonywane polecenie będzie takie: >

	:tag get_cmd

Polecenie ":execute" może wykonać tylko polecenia dwukropka. ":normal"
wykonuje polecenia trybu Normal. Jego argumentami nie są wyrażenia, ale znaki
komend. Przykład: >

	:normal gg=G

Skacze do pierwszej linii i formatuje wszystkie linie operatorem "=".
   Żeby ":normal" działało z wyrażeniami musisz je połączyć z ":execute".
Przykład: >

	:execute "normal " . polecenia_normal

Zmienna "polecenia_normal" musi zawierać komendy trybu Normal.
   Upewnij się, że argumentem dla ":normal" jest kompletne polecenie. W innym
wypadku Vim dojdzie do końca argumentu i porzuci go. Na przykład jeśli
zacząłeś tryb Insert musisz go też opuścić: >

	:execute "normal Inowy tekst \<Esc>"

Wstawia "nowy tekst " na początku bieżącej linii. Zauważ użycie specjalnego
klawisza "\<Esc>". Unikasz w ten sposób użycia prawdziwego <Esc> w twoim
skrypcie.

==============================================================================
*41.6*	Funkcje

Vim definiuje wiele funkcji i zapewnia w ten sposób bardzo dużą
funkcjonalność. W tej sekcji podamy kilka przykładów. Pełną listę znajdziesz
tu: |functions|.

Funkcja jest wywoływana poleceniem ":call". Parametry są podawane w nawiasach,
oddzielane przecinkami. Przykład: >

	:call search("Date: ", "W")

Wywołuje funkcję search() z argumentami "Date: " i "W". Funkcja
search() używa pierwszego argumentu jako wzorca poszukiwania i drugiego jako
flag. Flaga "W" oznacza, że poszukiwanie nie ma kontynuować pracy po końcu
pliku (czyli kontynuować od początku).

Funkcja może być wywołana w wyrażeniu. Przykład: >

	:let wiersz = getline(".")
	:let zmieniony = substitute(wiersz, '\a', "*", "g")
	:call setline(".", zmieniony)

Funkcja getline() pobiera linię z bieżącego pliku. Jej argumentem jest numer
linii. W tym wypadku użyto ".", co oznacza linię w której jest kursor.
   Funkcja substitute() pełni rolę podobną do polecenia ":substitute".
Pierwszym argumentem jest łańcuch na którym ma być przeprowadzona podmiana.
Drugim wzorzec, trzecim, łańcuch zamieniający. Ostatnim argumentem są flagi.
   Funkcja setline() zamienia wiersz, określony pierwszym argumentem na nowy
łańcuch, drugi argument. W tym przykładzie linia pod kursorem jest zamieniana
na wynik substitute(). Efekt tych trzech linijek jest równoznaczny z: >

	:substitute/\a/*/g

Użycie funkcji staje się bardziej interesujące kiedy robisz coś więcej przed
i po wywołaniu substitute().


FUNKCJE 				*lista-funkcji*	*function-list*

Jest wiele funkcji. Opiszemy je tu krótko, pogrupowane według tego co robią.
Listę alfabetyczną możesz znaleźć tu: |functions|. Użyj CTRL-] na nazwie
funkcji i skoczysz do jej bardziej szczegółowego opisu.

Manipulowanie łańcuchami:
	char2nr()		wartość ASCII znaku
	nr2char()		znak według wartości ASCII
	escape()		zakomentuj znaki w łańcuchu '\'
	strtrans()		zmień łańcuch na drukowalny
	tolower()		zmień łańcuch na małe litery
	toupper()		zmień łańcuch na wielkie litery
	match()			poz. gdzie wzorzec jest dopasowany w łańcuchu
	matchend() 		j.w. ale zwraca koniec wzorca
	matchstr()		dopasuj wzorzec w łańcuchu
	stridx()		1 wystąpienie krótkiego łańcucha w długim
	strridx()		ostatnie wystąpienie kr. łańcucha w długim
	strlen()		długość łańcucha
	substitute()		podmień dopasowanie na łańcuch
	submatch()		zwraca określone dopasowanie w ":substitute"
	strpart()		zwraca część łańcucha
	expand()		rozwiń specjalne słowa kluczowe
	type()			typ zmiennej
	iconv()			konwersja tekstu do innego kodowania

Działanie na tekście w bieżącym buforze:
	byte2line()		zwraca numer linii w określonym bajcie pliku
	line2byte()		zwraca bajt pliku w określonej linii
	col()			zwraca numer kolumny kursora lub zakładki
	virtcol()		zwraca numer kolumny ekranowej kursora lub zakładki
	line()			zwraca numer linii kursora lub zakładki
	wincol()		zwraca numer kolumny okna
	winline()		zwraca numer linii okna
	cursor()		umieszcza kursor w wierszu/kolumnie
	getline()		pobiera linię z bufora
	setline()		zamień linię w buforze
	append()		dodaj {lancuch} poniżej linii {lnum}
	indent()		zwraca wartość wcięcia linii
	cindent()		zwraca wartość wcięcia wg formatowania C
	lispindent()		zwraca wartość wcięcia wg formatowania Lispa
	nextnonblank()		znajduje pierwszą następną nie pustą linię
	prevnonblank()		znajduje pierwszą poprzednią nie pustą linię
	search()		znajduje dopasowanie dla wzorca
	searchpair()		znajduje drugi koniec zestawu początek/omiń/koniec

Funkcje systemowe i manipulowanie plikami:
	browse()		wywołaj przeglądarkę plików
	glob()			rozwiń znaki specjalne
	globpath()		rozwiń znaki specjalne w nazwach katalogów
	resolve()		znajdż gdzie wskazuje skrót
	fnamemodify()		modyfikuj nazwę pliku
	executable()		sprawdź czy istnieje plik wykonywalny
	filereadable()		sprawdź czy można odczytać plik
	filewritable()		sprawdź czy można zapisać do pliku
	isdirectory()		sprawdź czy istnieje katalog
	getcwd()		zwraca bieżący katalog
	getfsize()		zwraca wielkość pliku
	getftime()		zwraca ostatnią datę modyfikacji pliku
	localtime()		zwraca bieżący czas
	strftime()		konwertuje czas do łańcucha
	tempname()		zwraca nazwę pliku tymczasowego
	delete()		usuwa plik
	rename()		zmienia nazwę pliku
	system()		zwraca rezultat polecenia powłoki
	hostname()		nazwa systemu

Bufory, okna i lista argumentów:
	argc()			ilość elementów na liście argumentów
	argidx()		obecna pozycja na liśćie argumentów
	argv()			zwraca jeden element z listy argumentów
	bufexists()		sprawdź czy bufor istnieje
	buflisted()		sprawdź czy bufor istnieje i jest na liście
	bufloaded()		sprawdź czy bufor istnieje i jest załadowany
	bufname()		zwraca nazwę określonego bufora
	bufnr()			zwraca numer bufora określonego bufora
	winnr()			zwraca numer okna dla bieżącego okna
	bufwinnr()		zwraca numer okna dla określonego bufora
	winbufnr()		zwraca numer bufora dla określonego okna
	getbufvar()		zwraca wartość zmiennej z określonego bufora
	setbufvar()		ustawia wartość zmiennej w określonym buforze
	getwinvar()		zwraca wartość zmiennej w określonym oknie
	setwinvar()		ustawia wartość zmiennej w określonym oknie

Zwijanie:
	foldclosed()		sprawdź czy jest zwinięta fałda w danej linii
	foldclosedend()		j.w. ale zwraca ostatnią linię
	foldlevel()		sprawdź poziom fałdy w danej linii
	foldtext()		generuje linię pokazaną jako tytuł zwinięcia

Podświetlanie składni:
	hlexists()		sprawdź czy istnieje grupa podświetlania
	hlID()			zwraca ID grupy podświetlania
	synID()			zwraca ID składni w określonym miejscu
	synIDattr()		zwraca określony atrybut składniID  
	synIDtrans()		zwraca numer składniID

Historia:
	histadd()		dodaj element do historii
	histdel()		usuń element z historii
	histget()		zwraca element z historii
	histnr()		zwraca ostatni element z historii

Interaktywne:
	confirm()		możliwość wyboru
	getchar()		pobiera znak od użytkownika
	getcharmod()		zwraca modyfikatory ostatniego wprowadzonego znaku
	input()			zwraca linię wprowadzoną przez użytkownika
	inputsecret()		zwraca linię wprowadzoną przez użytkownika
				bez pokazywania jej
	inputdialog()		zwraca linię wprowadzoną przez użytkownika
				w oknie dialogowym
	inputresave()		zapisz i wyczyść "typeahead"
	inputresstore()		przywróć "typeahead"

Vim serwer:
	serverlist()		zwraca listę nazw serwerównames
	remote_send()		wysyła znaki komend do serwera Vima
	remote_expr()		rozwija wyrażenie na serwerze Vima
	server2client()		wywysła odpowiedź do klienta serwera Vima
	remote_peek()		sprawdza czy jest odpowiedź z serwera Vima
	remote_read()		czyta odpowiedź z serwera Vima
	foreground()		przenosi okno Vima na pierwszy plan
	remote_foreground()	przenosi okno serwera Vima na pierwszy plan

Różne:
	mode()			zwraca bieżący tryb edycji
	visualmode()		ostatni użyty tryb Visual
	hasmapto()		sprawdź czy istnieje mapowanie
	mapcheck()		sprawdź czy istnieje pasujące mapowanie
	maparg()		zwraca rhs (prawą stronę) mapowania
	exists()		sprawdż czy zmienna, funkcja, itd. istnieją
	has()			sprawdż czy opcja jest wspierana przez Vima
	cscope_connection()	sprawdż czy istnieje połączenie z cscope
	did_filetype()		sprawdź czy użyto autokomendy i FileType
	eventhandler()		sprawdź czy wywołane przez zdarzenie
	getwinposx()		pozycja X okna GUI Vima
	getwinposy()		pozycja Y okna GUI Vima
	winheight()		zwraca wysokość określonego okna
	winwidth()		zwraca szerokość określonego okna
	libcall()		wywołaj funkcję w zewnętrznej bibliotece
	libcallnr()		j.w., zwraca liczbę
	getreg()		zwraca zawartość rejestru
	getregtype()		zwraca typ rejestru
	setreg()		ustawia zawartość rejestru

==============================================================================
*41.7*	Definiowanie funkcji

Vim pozwala na definiowanie własnych funkcji. Podstawowa deklaracja funkcji
to: >

	:function {nazwa}({var1}, {var2}, ...)
	:  {cialo}
	:endfunction
<
	Note:
	Nazwy funkcji muszą zaczynać się wielką literą.
	Nazwy funkcji nie mogą zawierać polskich znaków diakrytycznych.

Napiszmy krótką funkcję, które będzie zwracać mniejszą z dwóch liczb. Zaczyna
się taką linią: >

	:function Min(num1, num2)

Mówi ona Vimowi, że funkcja nazywa się "Min" i pobiera dwa argumenty: "num1"
i "num2".
   Pierwszą rzeczą jakiej potrzebujesz jest sprawdzenie która z liczb jest
mniejsza: >

	:  if a:num1 < a:num2

Specjalny prefiks "a:" oznacza, że zmienna jest argumentem funkcji. Przypiszmy
zmiennej "mniejsza" wartość mniejszej liczby: >

	:  if a:num1 < a:num2
	:    let mniejsza = a:num1
	:  else
	:    let mniejsza = a:num2
	:  endif

Zmienna "mniejsza" jest zmienną lokalną. Zmienne użyte wewnątrz funkcji są
lokalne dopóki nie zostaną poprzedzone "g:", "a:" lub "s:".

	Note:
	Żeby dotrzeć do zmiennej globalnej z wnętrza funkcji musisz poprzedzić
	jej nazwę "g:". Dlatego "g:mnoznik" wewnątrz funkcji odnosi się do
	zmiennej globalnej "mnoznik", a "mnoznik" jest inną zmienną, lokalną
	dla funkcji.

Operator ":return" służy do zwrócenia mniejszej liczby użytkownikowi. Funkcję
kończysz: >

	:  return mniejsza
	:endfunction

Kompletna definicja funkcji: >

	:function Min(num1, num2)
	:  if a:num1 < a:num2
	:    let mniejsza = a:num1
	:  else
	:    let mniejsza = a:num2
	:  endif
	:  return mniejsza
	:endfunction

Funkcje zdefiniowane przez użytkownika wywoływane są w ten sam sposób co
wbudowane. Tylko nazwa jest inna. Funkcja Min może być użyta tak: >

	:echo Min(5, 8)

Tylko teraz funkcja zostanie wykonana a jej linie zinterpretowane przez Vima.
Jeśli są tam błędy, takie jak użycie niezdefiniowanej zmiennej lub funkcji
otrzymasz komunikat błędu. W czasie definiowania funkcji takie błędy nie są
wykrywane.

Kiedy funkcja osiąga ":endfunction" lub ":return" użyte jest bez argumentu,
funkcja zwraca zero.

Do redefiniowania funkcji, która już istnieje dodaj ! do polecenia
":function": >

	:function!  Min(num1, num2, num3)


ZASIĘG

Poleceniu ":call" można przekazać zasięg. Może to oznaczać dwie rzeczy. Kiedy
funkcja jest zdefiniowana ze słowem kluczowym "range" sama zadba o zasięg.
   Funkcja dostanie dodatkowo zmienne "a:firstline" i "a:lastline". Oznaczają
one numery linii z zasięgu, z którym funkcja została wywołana. Przykład: >

	:function Policz_slowa() range
	:  let n = a:firstline
	:  let liczba = 0
	:  while n <= a:lastline
	:    let liczba = liczba + Licznikslow(getline(n))
	:    let n = n + 1
	:  endwhile
	:  echo "znaleziono " . liczba . " słów"
	:endfunction

Możesz wywołać funkcję tak: >

	:10,30call Policz_slowa()

Zostanie wykonana raz i wyświetli liczbę słów.
   Innym sposobem jest użycie zasięgu bez definiowania funkcji ze słowem
"range". Funkcja zostanie wywołana raz dla każdej linii w zasięgu, z kursorem
na tej linii. Przykład: >

	:function  Numer()
	:  echo "linia " . line(".") . " zawiera: " . getline(".")
	:endfunction

Jeśli wywołasz funkcję tak: >

	:10,15call Numer()

Zostanie ona wywołana sześć razy.


ZMIENNA LICZBA ARGUMENTÓW

Vim pozwala na zdefiniowanie funkcji, która ma zmienną liczbę argumentów.
Natępujące polecenie definiuje funkcję, która musi mieć 1 argument (start)
i do 20 dodatkowych argumentów: >

	:function Show(start, ...)

Zmienna "a:1" zawiera pierwszy opcjonalny argument, "a:2" drugi, i tak dalej.
Zmienna "a:0" zawiera liczbę dodatkowych argumentów. >

	:function Show(start, ...)
	:  echohl Title
	:  echo "Show is " . a:start
	:  echohl None
	:  let index = 1
	:  while index <= a:0
	:    echo "  Arg " . index . " is " . a:{index}
	:    let index = index + 1
	:  endwhile
	:  echo ""
	:endfunction

Przykład ten zawiera polecenie ":echohl" do określenia podświetlania użytego
do następującego po nim polecenia ":echo". ":echohl None" znów to wstrzymuje.
Polecenie ":echon" działa jak ":echo", ale nie produkuje znaku końca linii.


LISTOWANIE FUNKCJI

Polecenie ":function" listuje nazwy i argumenty wszystkich funkcji
zdefiniowanych przez użytkownika: >

	:function
<	function Show(start, ...) ~
	function GetVimIndent() ~
	function SetSyn(name) ~

Żeby zobaczyć co dana funkcja robi użyj jej nazwy jako argumentu ":function":
>
	:function SetSyn
<	1     if &syntax == '' ~
	2       let &syntax = a:name ~
	3     endif ~
	   endfunction ~


DEBUGOWANIE

Numer linii jest użyteczny kiedy dostajesz komunikat błędu lub w czasie
debugowania. Zobacz |debug-scripts| o trybie debugowania.
   Możesz też ustawić opcję 'verbose' na 12 lub wyżej, żeby zobaczyć wszystkie
wywołania funkcji. Ustaw na 15 lub wyżej i zobaczysz wszystkie wykonywane
linie.


USUWANIE FUNKCJI

Żeby usunąć funkcję Show(): >

	:delfunction Show

Otrzymasz komunikat o błędzie jeśli funkcja nie istnieje.

==============================================================================
*41.8*	Wyjątki

Zacznijmy od przykładu: >

	:try
	:    read ~/templates/pascal.tmpl
	:catch /E484:/
	:    echo "Przykro mi, nie mogę znaleźć szablonu pliku Pascala."
	:endtry

Polecenie ":read" zawiedzie jeśli plik nie istnieje. Zamiast pokazania
komunikatu błędu kod przechwyci błąd i pokaże użytkownikowi bardziej
szczegółową informację.

Dla poleceń między ":try" i ":endtry" błędy są zamienione w wyjątki - łańcuchy
znaków. W przypadku błędu, łańcuch zawiera komunikat błędu. Każdy błąd posiada
numer. W tym wypadku łańcuch, który przechwyciliśmy zawiera "E484:". Numer
nigdy się nie zmieni (tekst tak, na przykład może zostać przetłumaczony).

Kiedy polecenie ":read" spowoduje inny błąd, wzorzec "E484:" nie będzie
pasować. Wtedy wyjątek nie zostanie przechwycony i rezultatem będzie zwykły
komunikat błędu.

Być może będziesz chciał spróbować: >

	:try
	:    read ~/templates/pascal.tmpl
	:catch
	:    echo "Przykro mi, nie mogę znaleźć szablonu pliku Pascala."
	:endtry

W ten sposób wszystkie błędy zostaną przechwycone, ale nie zobaczysz
komunikatów, które mogłyby być pomocne, np.: "E21: Cannot make changes,
'modifiable' is off".

Innym pożytecznym mechanizmem jest polecenie ":finally": >

	:let tmp = tempname()
	:try
	:   exe ".,$write " . tmp
	:   exe "!filtr " . tmp
	:   .,$delete
	:   exe "$read " . tmp
	:finally
	:   call delete(tmp)
	:endtry

Filtruje linie od kursora do końca pliku przez komendę "filtr", która pobiera
nazwę pliku jako argument. Nie ma znacznia jak to działa, jeśli coś pójdzie
źle między ":try" i ":finally" lub użytkownik odwoła filtrowanie wciskając
CTRL-C, zawsze wykonywane jest "call delete(tmp)". W ten sposób jesteś pewien,
że nie zostawisz tymczasowego pliku.

Więcej informacji o wyjątkach znajdziesz w Przewodniku Encyklopedycznym:
|exception-handling|.

==============================================================================
*41.9*	Różne uwagi

Podsumowanie elementów, które odnoszą się do skryptów Vima. Są wspomniane też
gdzie indziej, ale tutaj zostaną ładnie opisane.

Znak końca linii zależy od systemu. Dla Uniksa <NL>, dla MS-DOS, Windows, OS/2
i podobnych <CR><LF>. Ważne by o tym pamiętać używając mapowań zawierających
<CR>. Zobacz |:source_crnl|.


BIAŁE ZNAKI

Białe linie są dozwolone i ignorowane.

Białe znaki na początku linii (spacje i tabulacje) są zawsze ignorowane. Białe
znaki pomiędzy parametrami (np. pomiędzy 'set' i 'cpoptions' w poniższym
przykładzie) są redukowane do jednego znaku odstępu i odgrywają rolę
separatora, białe znaki po ostatnim (widocznym) znaku są, albo nie są
ignorowane w zależności od sytuacji.

W poleceniu ":set" zawierającym znak "=" (równy): >

	:set cpoptions    =aABceFst

Białe znaki bezpośrednio przed znakiem "=" są ignorowane. Ale nie może być
odstępu po "="!

Żeby można było włączyć biały znak w wartość opcji musi być on poprzedzony
"\" (backslashem) tak jak w przykładzie: >

	:set tags=mój\ ładny\ plik

Ten sam przykład napisany tak >

	:set tags=mój ładny plik

spowoduje komunikat błędu ponieważ zostanie zinterpretowany jako: >

	:set tags=mój
	:set ładny
	:set file


KOMENTARZE

Znak " (podwójny cudzysłów) zaczyna komentarz. Wszystko po nim (włączając sam
znak) aż do końca linii uważane jest za komentarz i ignorowane z wyjątkiem
poleceń, które nie zwracają uwagi na komentarze i są wyjaśnione poniżej.
Komentarz może się zacząć w dowolnym miejscu linii.

Jest mały haczyk z komentarzami w niektórych poleceniach. Przykłady: >

	:abbrev dev development		" skrót
	:map <F3> o#include		" wstaw include
	:execute cmd			" zrób to
	:!ls *.c			" lista plików C

Skrót 'dev' będzie rozwiązany do 'development    " skrót'. Mapowanie <F3>
będzie uwzględiało cało linię po 'o# ...' włączając '" wstaw include'.
Polecenie "execute" spowoduje błąd. Polecenie "!" wyśle wszysko po nim do
powłoki powodując błąd dla niesparowanego znaku '"'.
   Nie może być komentarzy po polecenieach ":map", ":abbreviate", ":execute"
i "!" (jest jeszcze kilka z tym ograniczeniem). Dla poleceń ":map",
":abbreviate" i ":execute" jest mały trik: >

	:abbrev dev development|" skrót
	:map <F3> o#include|" wstaw include
	:execute cmd			|" zrób to

Znak '|' oddziela jedno polecenie od następnego, a następnym poleceniem jest
tylko komentarz.

Zauważ, że nie ma białych znaków przed '|' w skrótach i mapowaniach. Dla tych
poleceń każdy znak aż do końca linii lub '|' jest włączany. W konsekwencji
takiego zachowania nie zawsze zobaczysz włączane zbędne spacje: >

	:map <F4> o#include

Dla uniknięcia takich problemów możesz ustwić opcję 'list' w czasie edycji
plików vimrc.


PUŁAPKI

Większy problem pojawia się w poniższym przykładzie: >

	:map ,ab o#include
	:unmap ,ab

Tutaj polecenie unmap nie zadziała ponieważ próbuje usunąć mapowanie ",ab ".
Coś takiego nie istnieje, Dostaniesz komunikat błędu, który jest bardzo trudny
do zidentyfikowania ponieważ kończący biały znak w ":unmap ,ab " nie jest
widoczny.

To samo zdarzy się kiedy spróbujesz użyć komentarza po poleceniu "unmap": >

	:unmap ,ab     " komentarz

Komentarz zostanie zignorowany jednak Vim będzie próbował zlikwidować
mapowanie dla ",ab     ", które nie istnieje. Przepisz to: >

	:unmap ,ab|    " komentarz


PRZYWRACANIE WIDOKU

Czasami chcesz zrobić jakąś zmianę i wrócić tam gdzie był kursor. Przywracanie
relatywnej pozycji też byłoby miłe tak by ta sama linia pojawiała się na górze
okna.
   Ten przykład kopiuje bieżącą linię, umieszcza ją nad pierwszą linią w pliku
i przywraca widok: >

	map ,p ma"aYHmbgg"aP`bzt`a

Co to oznacza: >
	ma"aYHmbgg"aP`bzt`a
<	ma			ustawia zakładkę na pozycji kursora
	  "aY			yankuj bieżącą linię do rejestru a
	     Hmb		przejdź do pierwszej linii w oknie i ustaw
				zakładkę b
		gg		przejdź do pierwszej linii w pliku
		  "aP		umieść i nad nią skopiowaną linię
		     `b		wróć do pierwszej linii w oknie
		       zt	umieść tekst tak jak był przedtem
			 `a	wróć do zachowanej pozycji kursora


PAKOWANIE

Żeby uniknąć konfliktu nazw twoich funkcji z funkcjami innych zrób tak:
- Wstaw na początku nazwy funkcji jakiś łańcuch. Często używam tego przy
  skrótach. Na przykład, "OW_" używam funkcjach operujących na oknach.
- Umieść definicje funkcji razem w pliku. Ustaw zmienną globalną, żeby
  wskazywała na załadowanie funkcji. Podczas ponownego załadowywania funkcji
  najpierw je usuń.
Przykład: >

	" This is the XXX package

	if exists("XXX_loaded")
	  delfun XXX_jeden
	  delfun XXX_dwa
	endif

	function XXX_jeden(a)
		... treść funkcji ...
	endfun

	function XXX_dwa(b)
		... treść funkcji ...
	endfun

	let XXX_loaded = 1

==============================================================================
*41.10*	Pisanie wtyczki 				*write-plugin*

Możesz tak napisać skrypt Vima, że będzie w stanie go używać duża grupa ludzi.
Nazywa się go wtedy wtyczką. Użytkownicy Vima mogą wrzucić skrypt do ich
katalogu wtyczek i korzystać z nich od razu |add-plugin|.

Są dwa typy wtyczek:

  wtyczka globalna: Dla wszystkich typów plików.
wtyczka typu pliku: Tylko dla określonego typu pliku.

W tej sekcji wyjaśnimy pierwszy typ. większość rzeczy odnosi się też do
pisania wtyczek typu pliku. Elementy specyficzne dla nich wyjaśnione są
w następnej sekcji |write-filetype-plugin|.


NAZWA

Przede wszystkim musisz wybrać nazwę dla swojej wtyczki. Możliwości, które ona
zapewnia powinny być jasno wynikać z jej nazwy. I powinieneś uniknąć sytuacji,
w której ktoś napisze wtyczkę o tej samej nazwie, ale która robiłaby coś
całkiem innego. Lepiej też unikaj nazw dłuższych niż 8 znaków dla uniknięcia
prblemów na starych systemach Windows.

Skrypt, który poprawia błędy w czasie pisania powinien być nazwany
"typecorr.vim". Użyjemy go jako przykładu.

Żeby wtyczka działała dla wszystkich musi spełniać kilka warunków. Zostanie to
wyjaśnione krok po kroku. Kompletna wtyczka jest na końcu.


BODY

Zacznijmy od części zasadniczej wtyczki, linii które zrobią prawdziwą robotę:
>
 14	iabbrev teh the
 15	iabbrev otehr other
 16	iabbrev wnat want
 17	iabbrev synchronisation
 18		\ synchronization
 19	let s:count = 4

Właściwa lista będzie oczywiście o wiele dłuższa.

Numery linii zostały dodate tylko do wyjaśnienia kilku rzeczy, nie umieszczaj
ich w swojej wtyczce!


NAGŁÓWEK

Będziesz prawdopodobnie dodawał poprawki do wtyczki i wkrótce powstanie kilka
wersji. Ludzie będą też chcieli wiedzieć kto napisał tę cudowną wtyczkę
i gdzie mogą wysyłać uwagi. Dlatego umieść nagłówek na samym początku pliku: >

  1	" Vim global plugin for correcting typing mistakes
  2	" Last Change:  2000 Oct 15
  3	" Maintainer:   Bram Moolenaar <Bram@vim.org>

O prawach autorskich i licencjonowaniu: ponieważ wtyczki są bardzo użyteczne
i ograniczanie ich dystrybucji nie ma wielkiego sensu. Proszę rozważ
umieszczanie swoich wtyczek albo w "public domain" lub pod warunkami licencji
Vima |license|. Krótka notka o tym na górze pliku powinna wystarczyć.
Przykład: >

  4	" License:   This file is placed in the public domain.


KONTYNUACJA LINII, UNIKANIE EFEKTÓW UBOCZNYCH

Powyżej, w linii 18, zosta ł użyty mechanizm kontynuacji linii
|line-continuation|. Użytkownicy z ustawioną opcją 'compatible' będą tu mieli
problemy ponieważ zostanie wygenerowany komunika błędu. Nie możemy po prostu
przestawić opcji 'compatible' bo ma to mnówstwo efektów ubocznych. Żeby tego
uniknąć ustawimy 'cpoptions' na domyślne wartości Vima i przywrócimy je
później. Pozwoli to na użycie kontynuacji linii i sprawi, że skrypt będzie
działał dla większosći ludzi. Robi się to tak: >

 11	let s:save_cpo = &cpo
 12	set cpo&vim
 ..
 42	let &cpo = s:save_cpo

Najpierw zapisujemy starą wartość 'cpoptions' w zmiennej s:save_cpo. Na końcu
wtyczki wartość zostanie przywrócona

Zauważ, że została użyta zmienna lokalna skryptu |s:var|. Zmienna globalna
mogłaby być użyta już gdzie indziej. Zawsze używaj zmiennych lokalnych
skryptu dla rzeczy, które używane są tylko w skrypcie..


NOT LOADING

Zdarza się, że użytkownik nie zawsze chce załadować daną wtyczkę. Albo
administrator systemu umieścił ją w systemowym katalogu wtyczek, ale
użytkownik ma swoją wersję i jej chce użyć. Użytkownik musi mieć szansę na
uniemożliwienie załadowania danej wtyczki. Możesz zrobić to tak: >

  6	if exists("loaded_typecorr")
  7	  finish
  8	endif
  9	let loaded_typecorr = 1

W ten sposób unikasz podwójnego ładowania skryptu, co mogłoby powodować
komunikaty błędu dla redefiniowanych funkcji i problemy dla podwójnie
dodawanych autokomend.


MAPOWANIA

Zróbmy teraz wtyczkę bardziej interesującą. Dodajmy do niej mapowanie, które
dodaje korektę dla wyrazu pod kursorem. Możemy po prostu dodać sekwencję
klawiszy dla tego mapowania, ale użytkownik może ich już używać do czegoś
innego. Żeby użytkownik mógł sam zdefiniować, które klawisze mają być użyte
w mapowaniu użyjmy elementu <Leader>: >

 22	  map <unique> <Leader>a  <Plug>TypecorrAdd

"<Plug> TypecorrAdd" działa i zostanie wyjaśnione później.

Użytkownik może ustawić zmienną "mapleader" na sekwencję klawiszy, od której
ma się zaczynać mapowanie. Jeśli zrobi tak: >

	let mapleader = "_"

Mapowaniem będzie "_a". Jeśli nie zmieni wartości "mapleader" zostanie użyta
domyślna wartość, którą jest backslash. Wtedy mapowaniem będzie "\a".

Note, że użyliśmy <unique>. Spowoduje ono komunikat błędu jeśli mapowanie
już istnieje. |:map-<unique>|

Ale co jeśli użytkownik chce zdefiniować swoją własną sekwencję klawiszy?
Możemy na to pozwolić konstrukcją: >

 21	if !hasmapto('<Plug>TypecorrAdd')
 22	  map <unique> <Leader>a  <Plug>TypecorrAdd
 23	endif

Sprawdza ona czy istnieje już mapowanie do "<Plug>TypecorrAdd" i definiuje
mapowanie z "<Leader>a" tylko wtedy jeśli nie istnieje. Użytkownik ma wtedy
szansę na umieszczenie w swoim pliku vimrc: >

	map ,c  <Plug>TypecorrAdd

Wtedy mapowaną sekwencją będzie ",c", a nie "_a" lub "\a".


CZĄSTKI

Jeśli skrypt staje się dłuższy często chcesz podzielić go na mniejsze
fragmenty. Możesz do tego użyć funkcji lub mapowań. Ale nie chcesz by te
funkcje i mapowania oddziaływały na siebie z tymi z innych skryptów. Na
przykład zdefiniujesz funkcję Add(), ale inny skrypt może spróbować
zdefiniować tę samą funkcję. Dla uniknięcia takich sytuacji definiujemy
funkcje lokalne dla skryptu poprzedzając ich nazwę "s:".

Zdefiniujmy funkcję, która dodaje nową korektę: >

 30	function s:Add(from, correct)
 31	  let to = input("type the correction for " . a:from . ": ")
 32	  exe ":iabbrev " . a:from . " " . to
 ..
 36	endfunction

Teraz możemy wywołać funkcję s:Add() z tego skryptu. Jeśli inny skrypt też
definiuje s:Add() będzie ona lokalna dla tamtego skryptu i będzie mogła zostać
wywołana ze skryptu, w którym została zdefiniowana. Może też istnieć funkcja
globalna Add() (bez "s:"), która będzie zupełnie inną funkcją.

<SID> może być użyte w mapowaniach. Generuje ono ID skryptu, które
identyfikuje bieżący skrypt. W naszej wtyczce korygującej błędy pisania
użyjemy go w ten sposób: >

 24	noremap <unique> <script> <Plug>TypecorrAdd  <SID>Add
 ..
 28	noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>

Stąd kiedy użytkwnik wpisze "\a", zostaje wykonana sekwencja: >

	\a  ->  <Plug>TypecorrAdd  ->  <SID>Add  ->  :call <SID>Add()

Jeśli inny skrypt także zmapuje <SID>Add, dostanie inny ID skryptu i definiuje
inne mapowanie.

Zauważ, że zamiast s:Add() użyliśmy tu <SID>Add(). Dzieje się tak ponieważ
mapowanie jest wpisane przez użytkownika, na zewnątrz skryptu. <SID> zostaje
przetłumaczone na ID skryptu, tak więc Vim wie, w którym skrypcie ma szukać
funkcji Add().

Jest to trochę skomplikowane, ale konieczna dla dobrej współpracy wtyczki
z innymi wtyczkami. Podstawową zasadą jest użycie <SID>Add() w mapowaniach
i s:Add() w innych miejscach (sam skrypt, autokomendy, polecenia użytkownika).

Możemy też dodać wpis do menu, żeby robiło to samo co mapowanie: >

 26	noremenu <script> Plugin.Add\ Correction      <SID>Add

Menu "Plugin" jest rekomendowane do dodawania elementów menu dla wtyczek.
W tym wypadku tylko jeden element został użyty. Dodając więcej elementów
zalecane jest użycie podmenu. Na przykład, "Plugin.CVS" służy do wtyczki
oferującej operacje CVS "Plugin.CVS.checkin", "Plugin.CVS.checkout", itd.

Warto zwrócić uwagę, że w linii 28 zostało użyte ":noremap", żeby uniknąć
kłopotów jakie mogłyby sprawić inne mapowania. Ktoś mógłby na przykład
remapować ":call". W linii 24 także użyliśmy ":noremap", ale chcieliśmy
remapować "<SID>Add". Dlatego użyliśmy argumentu "<script>".  Pozwala on tylko
na mapowania lokalne dla skryptu. |:map-<script>| To samo zrobiliśmy w linii
26 dla ":noremenu". |:menu-<script>|


<SID> I <Plug> 						*using-<Plug>*

Zarówno <SID> jak i <Plug> służą do uniknięcia konfliktu między mapowaniami
wpisywanymi, a mapowaniami użytymi w innych mapowaniach. Zauważ następujące
różnice między <SID> i <Plug>:

<Plug>	jest widoczne na zewnątrz skryptu. Używa się do mapowań, które
	użytkownik może chcieć sam zmapować. <Plug> jest specjalnym kodem,
	którego wciśnięte klawisze nigdy nie zwrócą.
	Dla upewnienia się, że inne wtyczki nie użyją tej samej sekwencji
	znaków użyj konstrukcji: <Plug> nazwa_skryptu nazwa_mapowania
	W naszym przykładzie nazwa_skryptu to "Typecorr", a nazwa_mapowania to
	"Add". Wynikiem jest "<Plug>TypecorrAdd". Tylko pierwszy znak
	nazwa_skryptu i nazwa_mapowania jest wielką literą, więc możesz
	zobaczyć gdzie zaczyna się nazwa_mapowania.

<SID>	jest ID skryptu, unikalnym identyfikatorem skrytpu.
	Wewnętrznie Vim tłumaczy <SID> na "<SNR>123_", gdzie "123" może być
	dowolnym numerem. Dlatego funkcja "<SID>Add()" będzie się nazywała
	"<SNR>11_Add()" w jednym skrypcie i "<SNR>22_Add() w drugim. Możesz to
	zobaczyć jeśli użyjesz polecenia ":function" do wylistowania
	istniejących funkcji. Translacja <SID> w mapowaniach działa dokładnie
	tak samo, w ten sposób możesz wywołać funkcję lokalną dla skryptu
	z mapowania.


POLECENIA UŻYTKOWNIKA

Dodajmy teraz polecenie użytkownika do dodawania poprawek: >

 38	if !exists(":Correct")
 39	  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
 40	endif

Polecenie użytkownika jeste zdefiniowane tylko wtedy jeśli nie istnieje żadne
polecenie o takiej samej nazwie. W innym wypadku wystąpi błąd. Nadpisanie
istniejącego już polecenia z ":command!" nie jest dobyrym pomysłem, w ten
sposób użytkownik mógłby się zdziwić dlaczego polecenia przez niego
zdefiniowane nie działają.


ZMIENNE SKRYPTU

Kiedy zmienna zaczyna się "s:" jest to zmienna skryptu. Może być ona użyta
tylko wewnątrz skryptu - poza nim nie jest widoczna. Unika się w ten sposób
problemów ze zmiennymi o takich samych nazwach w różnych skryptach. Zmienne
będą przechowywane tak długo jak działa Vim. Te same zmienne będą użyte
podczas ponownego wczytania skryptu. |s:var|

Zmienne te mogą być także użyte w funkcjach, autokomendach i poleceniach
użytkownika, które są zdefiniowane w skrypcie. W naszym przykładzie możemy
dodać kilka linijek, żeby policzyć ilość korekt: >

 19	let s:count = 4
 ..
 30	function s:Add(from, correct)
 ..
 34	  let s:count = s:count + 1
 35	  echo s:count . " corrections now"
 36	endfunction

Pierwszy s:licznik jest zainicjowany z wartością 4 w samym skrypcie. Kiedy
później wywoływana jest funkcja s:Dodaj(), za każdym razem s:licznik
zwiększany jest o jeden. Nie ma znaczenia skąd funkcja jest wywoływana.
Ponieważ została zdefiniowana w naszym skrypcie będzie używać zmiennych
lokalnych z tego skryptu.


WYNIK

Ostateczny skrypt: >

  1	" Vim global plugin for correcting typing mistakes
  2	" Last Change: 2000 Oct 15
  3	" Maintainer:  Bram Moolenaar <Bram@vim.org>
  4	" License:  This file is placed in the public domain.
  5
  6	if exists("loaded_typecorr")
  7	  finish
  8	endif
  9	let loaded_typecorr = 1
 10
 11	let s:save_cpo = &cpo
 12	set cpo&vim
 13
 14	iabbrev teh the
 15	iabbrev otehr other
 16	iabbrev wnat want
 17	iabbrev synchronisation
 18		\ synchronization
 19	let s:count = 4
 20
 21	if !hasmapto('<Plug>TypecorrAdd')
 22	  map <unique> <Leader>a  <Plug>TypecorrAdd
 23	endif
 24	noremap <unique> <script> <Plug>TypecorrAdd  <SID>Add
 25
 26	noremenu <script> Plugin.Add\ Correction      <SID>Add
 27
 28	noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>
 29
 30	function s:Add(from, correct)
 31	  let to = input("type the correction for " . a:from . ": ")
 32	  exe ":iabbrev " . a:from . " " . to
 33	  if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
 34	  let s:count = s:count + 1
 35	  echo s:count . " corrections now"
 36	endfunction
 37
 38	if !exists(":Correct")
 39	  command -nargs=1  Correct  :call s:Add(<q-args>, 0)
 40	endif
 41
 42	let &cpo = s:save_cpo

Linia 33 jeszcze nie została wyjaśniona. Stosuje ona nowe poprawki do wyrazu
pod kursorem. Polecenie |:normal| służy do użycia nowego skrótu. Zauważ, że
mapowania i skróty są tu rozwinięte, nawet jeśli funkcja została wywołana
z mapowania zdefiniowanego przez ":noremap".

Najlepiej użyć wartości "unix" w opcji 'fileformat'. Dzięki temu skrypty będą
działać wszędzie. Skrypty z 'fileformat' ustawioną na "dos" nie będą działać
w Uniksach. Zobacz też |:source_crnl|. Żeby się upewnić, przed zapisaniem
pliku wydaj polecenie: >

	:set fileformat=unix


DOKUMENTACJA						*write-local-help*

Dobrą rzeczą jest napisanie dokumentacji dla twojej wtyczki. Zwłaszcza wtedy
kiedy jej zachowanie może zostać zmienione przez użtykownika. Zobacz
|add-local-help|, żeby się dowiedzieć jak ją zainstalować.

Prosty przykład dla wtyczki typu pliku, nazwanej "typecorr.txt": >

  1	*typecorr.txt*	Plugin for correcting typing mistakes
  2
  3	If you make typing mistakes, this plugin will have them corrected
  4	automatically.
  5
  6	There are currently only a few corrections.  Add your own if you like.
  7
  8	Mappings:
  9	<Leader>a   or   <Plug>TypecorrAdd
 10		Add a correction for the word under the cursor.
 11
 12	Commands:
 13	:Correct {word}
 14		Add a correction for {word}.
 15
 16							*typecorr-settings*
 17	This plugin doesn't have any settings.

Jedyną linią, w której liczy się formatowanie jest pierwsza. Zostanie ona
wyciągnięta z pliku pomocy i umieszczona w sekcji "LOCAL ADDITIONS:" pliku
help.txt |local-additions|. Pierwsza "*" musi być w pierszej kolumnie
pierwszej linii.

Możesz dodać więcej znaczników wewnątrz ** w pliku pomocy. Ale uważaj by nie
używać istniejących znaczników pomocy. Najlepszym sposobem jest użycie nazwy
twojej wtyczki w większości z nich tak jak "typecorr-settings" w przykładzie.

Zalecane jest użycie odniesień do innych części pomocy w ||. W ten sposób
użytkownikowi łatwiej jest znaleźć odpowiedni punkt pomocy.


PODSUMOWANIE						*plugin-special*

Podsumowanie specjalnych elementów wtyczek:

s:nazwa			Zmienne lokalne dla skryptu.

<SID>			Skrypt-ID, używany dla mapowań i funkcji lokalnych dla
			skryptu.

hasmapto()		Funkcja testująca czy użytkownik już zdefiniował
			mapowanie dla funkcji oferowanej przez skrypt.

<Leader>		Wartość "mapleader", definiowana przez użytkownika
			- klawisz, który zaczyna mapowania.

:map <unique>		Alarmuj jeśli istnieje już takie mapowanie.

:noremap <script>	Używaj tylko mapowań lokalnych dla skryptu, a nie
			globalnych.

exists(":Cmd")		Sprawdza czy już istnieje polecenie użytkownika.

==============================================================================
*41.11*	Pisanie wtyczki dla typu pliku	*write-filetype-plugin* *ftplugin*

Wtyczka typu pliku działa tak jak wtyczka globalna z wyjątkiem tego, że
definiuje mapowania wyłącznie dla bieżącego bufora. Zobacz
|add-filetype-plugin| jak używa się tego typu wtyczki.

Przeczytaj najpierw sekcję o wtyczkach globalnych (|41.10|). Wszystko co tam
napisano odnosi się również do wtyczek typu pliku. Jest kilka dodatków, które
wyjaśniono poniżej. Podstawową rzeczą jest to, że wtyczka typu pliku powinna
mieć efekt wyłącznie na bieżący bufor.


WYŁĄCZANIE

Jeśli piszesz wtyczkę typu pliku, która ma być używana przez wielu ludzi muszą
mieć szansę jej wyłączenia. Umieść te linie na początku pliku: >

	" Only do this when not done yet for this buffer
	if exists("b:did_ftplugin")
	  finish
	endif
	let b:did_ftplugin = 1

Jest to potrzebne również by ta sama wtyczka nie była wykonana dwukrotnie dla
tego samego bufora (zdarza się przy użyciu ":edit" bez argumentów).

Teraz użytkownik może całkowicie wyłączyć domyślną wtyczkę przez utworzenie
wtyczki typu pliku z tylko jedną linią: >

	let b:did_ftplugin = 1

Żeby to zadziałało katalog wtyczek plików musi być przed $VIMRUNTIME
w 'runtimepath'!

Jeśli chcesz użyć domyślnej wtyczki, ale zmienić jedno z ustawień możesz
zapisać inne ustawienia w skrypcie: >

	setlocal textwidth=70

Zapisz to w katalogu "after", w ten sposób plik będzie wczytywany po
dystrybucyjnej wtyczce "vim.vim" |after-directory|. Dla Uniksów powinno to być
"~/.vim/after/ftplugin/vim.vim". Zauważ, że domyślna wtyczka ustawia
"b:did_ftplugin", ale w tym wypadku jest to ignorowane.


OPCJE

Dla pewności, że wtyczka typu pliku będzie oddziaływała na bieżący fufor użyj
polecenia: >

	:setlocal

do ustawiania opcji. I manipuluj tylko tymi opcjami, które są lokalne dla
bufora (przeczytaj o opcji, żeby sprawdzić). Używając |:setlocal| na opcjach
globalnych lub lokalnych dla okna, wartość zostanie zmieniona dla wielu
buforów, a tego wtyczka typu pliku nie powinna robić.

Kiedy opcja ma wartość, która jest listą flag lub elementów, rozważ użycie
"+=" i "-=" dla zachowania istniejących wartości. Bądź świadom, że użytkownik
mógł już zmienić wartość opcji. Powrót do wartości domyślnych i dopiero potem
ich zmienianie jest często dobrym pomysłem. Przykład: >

	:setlocal formatoptions& formatoptions+=ro


MAPOWANIA

Dla upewnienia się, że mapowania będą działać tylko w bieżącym buforze użyj
polecenia >

	:map <buffer>

Musi ono być połączone z dwu stopniowym mapowaniem wyjaśnionym powyżej.
Przykład jak zdefiniować funkcje we wtyczce typu pliku: >

	if !hasmapto('<Plug>JavaImport')
	  map <buffer> <unique> <LocalLeader>i <Plug>JavaImport
	endif
	noremap <buffer> <unique> <Plug>JavaImport oimport ""<Left><Esc>

|hasmapto()| służy do sprawdzenia czy użytkownik zdefiniował już mapowanie dla
<Plug>JavaImport. Jeśli nie, wtedy wtyczka typu pliku definiuje domyślne
mapowanie. Zaczyna się ono od |<LocalLeader>|, który pozwala użytkownikowi na
wybranie klawisza jakim chce zaczynać mapowania we wtyczkach typu pliku.
Domyślnym klawiszem jest backslash.
"<unique>" służy do generacji komunikatu błędu jeśli mapowanie już istnieje
albo nakłada się na istniejące mapowanie.
|:noremap| zapobiega konfliktowi z istniejącymi mapowaniami użytkownika. Być
może będziesz chciał użyć ":noremap <script>", żeby umożliwić remapowanie
mapowań zdefiniowanych w skrypcie zaczynającym się <SID>.

Użytkownik musi mieć szansę na wyłączenie mapowań we wtyczce typu pliku bez
wyłączania wszystkiego. Przykład jak to zrobić we wtyczce dla typu "mail": >

	" Add mappings, unless the user didn't want this.
	if !exists("no_plugin_maps") && !exists("no_mail_maps")
	  " Quote text by inserting "> "
	  if !hasmapto('<Plug>MailQuote')
	    vmap <buffer> <LocalLeader>q <Plug>MailQuote
	    nmap <buffer> <LocalLeader>q <Plug>MailQuote
	  endif
	  vnoremap <buffer> <Plug>MailQuote :s/^/> /<CR>
	  nnoremap <buffer> <Plug>MailQuote :.,$s/^/> /<CR>
	endif

Zostały użyte dwie zmienne globalne:
no_plugin_maps		wyłącza mapowania dla wszystkich wtyczek typu pliku
no_mail_maps		wyłącza mapowania dla określonego typu pliku


POLECENIA UŻYTKOWNIKA

Żeby dodać polecenie użytkownika do określonego typu pliku, tak że będzie
można go używać tylko w jednym buforze dodaj argument "-buffer" do |:command|.
Przykład: >

	:command -buffer  Make  make %:r.s


ZMIENNE

Wtyczka typu pliku będzie wczytywana dla każdego bufora typu dla jakiego jest
przeznaczona. Lokalne zmienne skryptu |s:var| będą wspólne między wszystkimi
plikami tego typu. Użyj zmiennych lokalnych dla bufora |b:var| jeśli chcesz
mieć zmienne tylko dla jednego bufora.


FUNKCJE

Jeśli definiujesz funkcję wystarczy to zrobić raz. Ale wtyczka typu pliku
będzie wczytywana za każdym razem kiedy dany typ pliku będzie otwierany. Ta
konkstrukcja zapewnia, że dana funkcja jest zdefiniowana tylko raz: >

	:if !exists("*s:Func")
	:  function s:Func(arg)
	:    ...
	:  endfunction
	:endif
<

UNDO 						*undo_ftplugin*

Kiedy użytkownik wydaje polecenie ":setfiletype xyz" efekty poprzedniego typu
pliku powinny zostać cofnięte. Wykorzystaj zmienną b:undo_ftplugin do
cofnięcia zmian opcji w twojej wtyczce typu pliku. Przykład: >

	let b:undo_ftplugin = "setlocal fo< com< tw< commentstring<"
		\ . "| unlet b:match_ignorecase b:match words b:match_skip"

Użycie ":setlocal" z "<" po nazwie opcji przywraca opcji jej globalną wartość.
Jest to najczęściej najlepsza metoda resetowania wartości opcji.

Konieczne jest usunięcie flagi "C" z 'cpoptions' by mogła być możliwa
kontynuacja wiersza jak wspomniano w |use-cpo-save|.

NAZWA PLIKU

Typ pliku musi być włączony w nazwę pliku |ftplugin-name|. Użyj jednej
z trzech form:

	.../ftplugin/cos.vim
	.../ftplugin/cos_foo.vim
	.../ftplugin/cos/bar.vim

"cos" to typ pliku. "foo" i "bar" dowolne.


PODSUMOWANIE						*ftplugin-special*

Podsumowanie specjalnych elementów wtyczki typu pliku:

<LocalLeader>		Wartość "maplocalleader", które użytkownik definiuje
			jako klawisze poprzedzające mapowania wtyczki.

:map <buffer>		Definiuj mapowanie lokalne dla bufora.

:noremap <script>	Remapuj tylko mapowania zdefiniowane w skrypcie
			zaczynające się <SID>.

:setlocal		Ustaw opcję lokalną dla bufora.

:command -buffer	Definiuj polecenie użytkownika lokalne dla bufora.

exists("*s:Func")	Sprawdź czy funkcja nie została już zdefiniowana.

Zobacz też |plugin-special|, elementy specjalne dla wszystkich wtyczek.

==============================================================================
*41.12*	Pisanie wtyczki dla kompilatora		*write-compiler-plugin*

Wtyczka kompilatora ustawia opcje dla określonego kompilatora. Użytkownik może
ją załadować poleceniem |:compiler|. Ustawia się tam przede wszystkim opcje
'errorformat' i 'makeprg'.

Najprościej jest spojrzeć na przykłady. To polecenie otworzy wszystkie
dystrybucyjne wtyczki kompilatorów: >

	:next $VIMRUNTIME/compiler/*.vim

Użyj |:next| by przejść do następnego pliku.

Są dwie rzeczy, o których należy pamiętać. Pierwszy to mechanizm pozwalający
użytkownikowi dodać własny plik lub coś wymusić coś na domyślnym pliku.
Standardowo pliki zaczynają się: >

	:if exists("current_compiler")
	:  finish
	:endif
	:let current_compiler = "mine"

Kiedy piszesz plik kompilatora i wstawiasz go do swojego osobistego katalogu
runtime (np. ~/.vim/compiler na Uniksach), ustawiasz zmienną
"current_compiler", żeby nie ładować domyślnych ustawień.

Drumi mechanizm to użycie ":set" dla ":compiler!" i ":setlocal" dla
":compiler". Vim definiuje wtedy polecenie użytkownika ":CompilerSet".
Niestety starsze wersje tego nie potrafią i wtyczka powinna to zrobić.
Przykład: >

  if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
  endif
  CompilerSet errorformat&		" use the default 'errorformat'
  CompilerSet makeprg=nmake

Jeśli piszesz wtyczkę kompilatora dla dystrybucji Vima lub systemowego
katalogu runtime, użyj wyżej wspomnianego mechanizmu. Kiedy "current_compiler"
zostanie ustawiony przez wtyczkę użytkownika nic się nie stanie.

Kiedy piszesz wtyczkę kompilatora, która ma odrzucić ustawienia domyślnej
wtyczki nie sprawdzaj "current_compiler". Taka wtyczka powinna być ładowana na
końcu, a więc musi się znajdować w katalogu na końcu 'runtimepath'. Dla
Uniksów będzie to ~/.vim/after/compiler.

==============================================================================

Następny rozdział: |usr_42.txt|  Dodawanie menu

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
