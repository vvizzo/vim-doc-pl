*usr_06.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			    Podświetlanie składni


Czarno biały tekst jest nudny. Pokolorowany plik odżywa. Nie tylko wygląda
ładniej, ale i przyśpiesza pracę. Zmień kolory używane dla różnych typów
tekstu. Wydrukuj tekst z kolorami jakie widzisz na ekranie.

|06.1|	Włączanie podświetlania
|06.2|	Brak koloru lub zły kolor?
|06.3|	Różne kolory
|06.4|	Z kolorami czy bez kolorów?
|06.5|	Drukowanie z kolorami
|06.6|	Dalsza lektura

 Następny rozdział: |usr_07.txt|  Edycja więcej niż jednego pliku
Poprzedni rozdział: |usr_05.txt|  Personalizacja ustawień Vima
       Spis treści: |usr_toc.txt|

==============================================================================
*06.1*	Włączanie podświetlania

Wszystko można zacząć jedną, prostą komendą: >

	:syntax enable

Powinno to wystarczyć w większości wypadków do pokolorowania plików. Vim
automagicznie wykryje typ pliku i załaduje odpowiedni plik podświetlania
składni. Nagle komentarze staną się niebieskie, słowa kluczowe brązowe,
a łańcuchy czerwone. Dzięki temu przeglądanie pliku jest łatwe. Po chwili
zauważysz, że czarno-biały tekst spowalnia pracę!

Jeśli chcesz zawsze używać podświetlania składni wstaw polecenie ":syntax
enable" do pliku |vimrc|.

Jeśli natomiast chcesz by składnia była podświetlana tylko wtedy gdy terminal
wspiera kolory musisz wstawić następującą sekwencję do pliku |vimrc|: >

	if &t_Co > 1
	   syntax enable
	endif

Jeśli chcesz kolorować składnię tylko w wersji GUI, wstaw polecenie "syntax
enable" do pliku |gvimrc|.

==============================================================================
*06.2*	Brak koloru lub zły kolor?

Istnieje wiele przyczyn, dla których możesz nie widzieć kolorów:

- Terminal nie wspiera kolorów.
       Vim może użyć wytłuszczonego, pochylonego i podkreślonego tekstu, ale
       to nie wygląda zbyt ładnie. Prawdopodobnie będziesz wolał użyć
       terminalu z kolorami. Dla Uniksa polecam xterm z XFree86:
       |xfree-xterm|.

- Terminal wspiera kolory, ale Vim o tym nie wie.
       Upewnij się, że zmienna $TERM ustawiona jest poprawnie. Na przykład
       kiedy używasz xterma, który wspiera kolory: >

		setenv TERM xterm-color
<
	lub (w zależności od powłoki): >

		TERM=xterm-color; export TERM

<	Nazwa terminalu musi być odpowiednia dla terminalu, którego używasz.
	Jeśli podświetlanie nadal nie działa przeczytaj |xterm-color|, który
	wyjaśnia parę sposobów uzyskania w Vimie kolorów (nie tylko dla
	xterma)>

- Typ pliku nie został rozpoznany.
	Vim nie zna wszystkich typów plików i czasami jest prawie niemożliwe
	zgadnąć jakiego języku używa plik. Spróbuj polecenia: >

		:set filetype
<
	Jeśli wynikiem jest "filetype=" wtedy problemem jest rzeczywiście fakt,
	że Vim nie był w stanie rozpoznać typu pliku. Możesz to ustawić
	ręcznie: >

		:set filetype=fortran

<	By zobaczyć jakie typy są dostępne zajrzyj do katalogu
	$VIMRUNTIME/syntax. Dla wersji GUI możesz użyć menu Syntax (Składnia).
	Ustawienie typu pliku jest również możliwe dzięki |modeline|, tak że
	plik będzie używał żądanego podświetlania za każdym razem kiedy
	będziesz go edytował. Następująca linia może być użyta w Makefile
	(wstaw ją blisko początku lub końca pliku): >

		# vim: syntax=make

<	Teraz wiesz jak wykryć typ pliku samemu. Często można użyć
	rozszerzenie nazwy (po kropce).
	Zobacz |new-filetype| jak przekazać Vimowi w jaki sposób może wykryć
	dany typ pliku.

- Nie ma podświetlania składni dla danego typu pliku.
	Możesz spróbować użyć podobnego typu pliku przez ręczne ustawienie tak
	jak wspomniano powyżej. Jeśli rezultat nie spełnia twoich oczekiwań
	możesz napisać własny plik składni, zobacz |mysyntaxfile|.


Lub kolory mogą być nieprawidłowe:

- Pokolorowany tekst jest bardzo trudny do czytania.
        Vim sprawdza kolor tła jakiego używasz. Jeśli jest czarny (lub innego
	ciemnego koloru) użyje jasnych kolorów dla tekstu. Jeśli jest biały
	(lub innego jasnego koloru) użyje ciemnych kolorów dla tekstu. Jeśli
	Vim źle odczyta rodzaj koloru tekst będzie trudny do odczytania.
	Rozwiązaniem jest ustawienie opcji 'background'. Dla ciemnego tła: >

		:set background=dark

<	A dla jasnego tła: >

		:set background=light

<	Upewnij się, że wstawiłeś to _przed_ komendą ":syntax enable", w innym
	wypadku kolory już będą ustawione. Możesz wydać polecenie ":syntax
	reset" po ustawieniu opcji 'background' by Vim znowu ustawił domyślne
	kolory.

- Kolory są nieprawidłowe kiedy przesunie się od początku do końca.
        Vim nie czyta całego pliku do sparsowania tekstu. Zaczyna parsować za
	każdym razem kiedy przeglądasz plik. Oszczędza to sporo czasu, ale
	czasami kolory mogą być nieprawidłowe. Prostym remedium jest CTRL-L.
	Albo cofnięcie się odrobinę, a później powrót.
	Prawdziwym rozwiązaniem jest |:syn-sync|. Niektóre pliki składni mają
	specjalne sposoby by szukać głębiej, zobacz pomoc dla danego pliku
	składni. Na przykład |tex.vim| dla składni TeXa.

==============================================================================
*06.3*	Różne kolory    				*:syn-default-override*

Jeśli nie lubisz domyślnych kolorów możesz wybrać inny schemat kolorystyczny.
W GUI użyj menu Edit/Color Scheme (Edytuj/Schemat koloru). Możesz również
wydać polecenie: >

	:colorscheme evening

"evening" jest nazwą schematu kolorystycznego. Istnieje kilka innych, które
możesz wypróbować. Zajrzyj do katalogu $VIMRUNTIME/colors (poszukaj też na
stronie vim.sf.net).

Kiedy znajdziesz schemat kolorystyczny, który ci się podoba, dodaj polecenie
":colorscheme" do pliku |vimrc|.

Możesz także stworzyć własny schemat kolorystyczny:

1. Wybierz najbardziej podobny schemat. Skopiuj ten plik do twojego katalogu
   Vim. Dla Uniksa: >

	:!mkdir ~/.vim/colors
	:!cp $VIMRUNTIME/colors/morning.vim ~/.vim/colors/mine.vim
<
   Wykonujesz to spod Vima ponieważ zna on wartość $VIMRUNTIME.

2. Otwórz plik schematu. Te punkty będą pomocne

	term		atrybuty na terminalu czarno białym
	cterm		atrybuty na terminalu kolorowym
	ctermfg		pierwszy plan na terminalu kolorowym
	ctermbg		tło na terminalu kolorowym
	gui		atrybuty w GUI
	guifg		pierwszy plan w GUI
	guibg		tło w GUI

   Na przykład by komentarze były zielone: >

	:highlight Comment ctermfg=green guifg=green
<
   Atrybutami jakich możesz użyć dla "cterm" i "gui" są "bold" i "underline".
   Jeśli chcesz użyć obu wpisz "bold,underline". Zobacz |:highlihgt| by
   dowiedzieć się czegoś więcej o tym poleceniu.

3. Przekaż Vimowi by zawsze używał twojego schematu. Wpisz do swojego |vimrc|:
>
	colorscheme mine

Jeśli chcesz zobaczyć jak wyglądają najczęściej używane kombinacje użyj
poleceń: >

	:edit $VIMRUNTIME/syntax/colortest.vim
	:source %

Zobaczysz tekst w różnych kombinacjach kolorystycznych. Możesz sprawdzić,
które są wygodne w czytaniu i wyglądają ładnie.

==============================================================================
*06.4*	Z kolorami lub bez kolorów

Pokazywanie tekstu w kolorze wymaga wielu zasobów. Jeśli ekran odświerza się
zbyt wolno możesz na chwilę wyłączyć podświetlanie składni: >

	:syntax clear

Kiedy będziesz edytował inny plik (lub ten sam) kolory wrócą.

							*:syn-off*
Jeśli chcesz całkowicie wyłączyć podświetlanie składni: >

	:syntax off

To polecenie całkowicie wyłączy podświetlanie składni dla wszystkich buforów.

							*:syn-manual*
Jeśli chcesz używać podświetlania składni tylko dla niektórych plików: >

	:syntax manual

Uruchomi podświetlanie składni, ale nie włączy jej automatycznie w czasie
startu edycji bufora. By włączyć podświetlanie dla bieżącego bufora ustaw
opcję 'syntax': >

	:set syntax=ON
<
==============================================================================
*06.5*	Drukowanie z kolorami 				*syntax-printing*

W wersji dla MS-Windows możesz wydrukować bieżący plik z pomocą polecenia: >

	:hardcopy

Zobaczysz zwykłe okienko dialogowe drukowania, gdzie możesz wybrać drukarkę
i kilka ustawień. Jeśli masz drukarkę kolorową, wynik na papierze powinien
wyglądać dokładnie tak jak w Vimie, jeśli jednak używasz ciemnego tła kolory
będą poprawione tak by wyglądały dobrze na białym papierze.

Istnieje parę opcji, które zmieniają sposób w jaki Vim drukuje:
	'printdevice'
	'printheader'
	'printfont'
	'printoptions'

By wydrukować tylko niektóre linie, użyj trybu Visual by wybrać linie: >

	v100j:hardcopy

"v" zaczyna tryb Visual. "100j" rozszerza go o sto linii w dół, zostaną one
podświetlone. Później ":hardcopy" wydrukuje te linie. Możesz oczywiście użyć
innych poleceń do poruszania się w trybie Visual.

Działa to również w Uniksie jeśli masz drukarkę PostScriptową. W innym
wypadku musisz wykonać trochę pracy. Najpierw przekonwertować tekst na HTML,
a potem wydrukować go spod przeglądarki internetowej takiej jak Netscape.

Konwersja bieżącego pliku na HTML: >

	:source $VIMRUNTIME/syntax/2html.vim

W przypadku dużych plików może to zająć trochę czasu. Po pewnym czasie inne
okno pokaże kod HTML. Teraz zapisz go gdzieś (nie ma znaczenia gdzie, usuniesz
go później): >
>
	:write main.c.html

Otwórz ten plik w ulubionej przeglądarce i wydrukuj go z niej. Jeśli wszystko
poszło dobrze wersja drukowana powinna wyglądać dokładnie tak samo jak
w Vimie. Zobacz |2html.vim| by dowiedzieć się więcej. Nie zapomnij usunąć
pliku HTML kiedy z nim skończysz.

Zamiast drukowania możesz wstawić plik HTML na serwer i pozwolić oglądać innym
pokolorowany tekst.

==============================================================================
*06.6*	Dalsza lektura

|usr_44.txt|  Tworzenie własnego schematu podświetlania.
|syntax|      Wszystkie szczegóły.

==============================================================================

Następny rozdział: |usr_07.txt|  Edycja więcej niż jednego pliku

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
