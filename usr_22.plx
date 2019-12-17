*usr_22.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			 Znajdywanie plików do edycji


Pliki mogą się znajdować wszędzie. Jak więc je znaleźć? Vim oferuje różne
sposoby na przeglądanie drzewa katalogów. Istnieją polecenia by skoczyć do
pliku, który jest wspomniany w innym pliku. Vim pamięta też, które pliki były
wcześniej edytowane.

|22.1|	Eksplorator plików
|22.2|	Katalog bieżący
|22.3|	Odnajdywanie pliku
|22.4|	Lista buforów

 Następny rozdział: |usr_23.txt|  Edycja trochę innych plików
Poprzedni rozdział: |usr_21.txt|  Tam i z Powrotem
       Spis treści: |usr_toc.txt|

==============================================================================
*22.1*	Eksplorator plików

Vim ma wtyczkę, która umożliwia edycję katalogu. Spróbuj: >

	:edit .

Dzięki magii autokomend i skryptów Vima okno wypełni zawartość katalogu.
Będzie wyglądało to tak:

	" Press ? for keyboard shortcuts ~
	" Sorted by name (.bak,~,.o,.h,.info,.swp,.obj,.orig,.rej at end of list) ~
	"= /home/mool/vim/vim6/runtime/doc/ ~
	../ ~
	check/ ~
	Makefile ~
	autocmd.txt ~
	change.txt ~
	eval.txt~ ~
	filetype.txt~ ~
	help.txt.info ~

Możesz zobaczyć:
1. Komentarz o użyciu ? by widzieć pomoc o funkcjach eksploratora plików.
2. Druga linia mówi jak wyświetlane są elementy - mogą być posortowane na
   kilka sposobów.
3. Trzecia linia to nazwa bieżącego katalogu.
4. "../" katalog. Katalog rodzicielski.
5. Nazwa katalogu
6. Nazwy zwykłych plików. Jak wspomniano w drugiej linii, niektóre są na końcu
   listy.
7. Nazwy mniej zwykłych plików. Prawdopodobnie będziesz ich używać rzadziej,
   więc zostały przeniesione na koniec.

Jeśli masz włączone podświetlanie składni, różne części są podświetlone żebyś
mógł łatwiej je wyłapać.

Możesz używać komend trybu Normal do poruszania się po tekście. Na przykład,
przejdź do pliku i wciśnij <Enter>. Jesteś teraz w tym pliku. Wracasz do
eksploratora przez ":edit .". CTRL-O działa tak samo.
   Jeśli wciśniesz <Enter> kiedy kursor jest na nazwie katalogu, eksplorator
przejdzie do tego katalogu i pokaże jego zawartość. Wciśnięcie <Enter> na
pierwszym katalogu "../" przeniesie cię jeden poziom wyżej. Wciśnięcie "-"
robi to samo bez potrzeby przejścia do "../".

Możesz wcisnąć ? żeby dostać krótką pomoc na temat eksploratora:

	" <enter> : open file or directory ~
	" o : open new window for file/directory ~
	" O : open file in previously visited window ~
	" p : preview the file ~
	" i : toggle size/date listing ~
	" s : select sort field    r : reverse sort ~
	" - : go up one level      c : cd to this dir ~
	" R : rename file	   D : delete file ~
	" :help file-explorer for detailed help ~

Pierwsze polecenia służą do wybierania plików. W zależności od tego co
wybierzesz, plik gdzieś się pojawi:

	<Enter>		Używa aktualnego okna.
	o		Otwiera nowe okno.
	O		Używa poprzednio odwiedzonego okna.
	p		Używa okna podglądu i wraca kursorem do okna
			eksplorera. |preview-window|

Następujące komendy służą do pokazania innych informacji:

	i		Pokaż wielkość i datę pliku. Ponowne użycie "i" ukryje
			te informacje.
	s		Użyj pola na którym jest kursor do sortowania.
			Najpierw pokaż wielkość i datę z "i". Później przenieś
			kursor do wielkości dowolnego pliku i wciśnij "s".
			Pliki teraz będą posortowane według wielkości. Wciśnij
			"s" gdy kursor jest na dacie i pliki zostaną
			posortowane według daty.
	r		Odwróć porządek sortowania (zarówno wg wielkości jak
			i daty).

Dodatkowe polecenia:

	c		Zmień katalog bieżący na pokazywany katalog. Później
			możesz wpisać polecenie ":edit" bez pełnej ścieżki.
	R		Zmień nazwę pliku pod kursorem. Zostaniesz zapytany
			o nową nazwę.
	D		Usuń plik pod kursorem. Zostaniesz poproszony
			o potwierdzenie.

==============================================================================
*22.2*	Katalog bieżący

Tak jak powłoka, Vim zna pojęcie bieżącego katalogu. Przypuśćmy, że jesteś
w swoim katalogu domowym i chcesz edytować kilka plików w katalogu
"BardzoDługaNazwaPliku". Możesz zrobić: >

	:edit BardzoDługaNazwaPliku/plik1.txt
	:edit BardzoDługaNazwaPliku/plik2.txt
	:edit BardzoDługaNazwaPliku/plik3.txt

Możesz tego uniknąć: >

	:cd BardzoDługaNazwaPliku
	:edit plik1.txt
	:edit plik2.txt
	:edit plik3.txt

Polecenie ":cd" zmienia katalog bieżący. Nazwę katalogu bieżącego możesz
zmienić komendą ":pwd": >

	:pwd
	/home/Bram/BardzoDługaNazwaPliku

Vim pamięta ostatni katalog. Wracasz do niego ":cd -": >

	:pwd
	/home/Bram/BardzoDługaNazwaPliku
	:cd /etc
	:pwd
	/etc
	:cd -
	:pwd
	/home/Bram/BardzoDługaNazwaPliku
	:cd -
	:pwd
	/etc


KATALOG LOKALNY DLA OKNA

Kiedy podzielisz okno, oba używają tego samego katalogu bieżącego. Jeśli
chcesz edytować kilka plików, w nowym oknie możesz użyć innego katalogu bez
zmiany katalogu bieżącego w starym oknie. Taki katalog nazywa się lokalnym
katalogiem. >

	:pwd
	/home/Bram/BardzoDługaNazwaPliku
	:split
	:lcd /etc
	:pwd
	/etc
	CTRL-W w
	:pwd
	/home/Bram/BardzoDługaNazwaPliku

Tak długo, jak nie zostanie użyte polecenie ":lcd" wszystkie okna używają tego
samego katalogu bieżącego. Użycie polecenia ":cd" w jednym oknie zmieni
katalog bieżący w innych oknach.
   Dla okna gdzie użyto ":lcd" jest to pamiętane. Użycie ":cd" lub ":lcd"
w innych oknach nie zmieni katalogu bieżącego dla tego okna.
   Wydanie polecenia ":cd" w oknie, które używa innego katalogu bieżącego
przywróci główny katalog bieżący.

==============================================================================
*22.3*	Odnajdowanie pliku

Edytujesz program C, który zawiera linię:

	#include "inits.h" ~

Chcesz zobaczyć co to za plik, "inits.h"? Przejdź kursorem na nazwę pliku
i wpisz: >

	gf

Vim znajdzie plik i otworzy go.
   A co jeśli plik nie jest w bieżącym katalogu? Vim użyje opcji 'path' do
odnalezienia pliku. Opcja ta, to lista katalogów gdzie Vim ma szukać plików.
   Przypuśćmy, że twoje pliki include znajdują się w "c:/prog/include". Dodaj
ten katalog do opcji 'path': >

	:set path+=c:/prog/include

Nazwa tego katalogu jest ścieżką absolutną. Nieważne gdzie jesteś, będzie on
w tym samym miejscu. Co jeśli masz pliki w podkatalogu, poniżej tego gdzie jest
plik? Możesz określić ścieżkę względną. Zaczyna się kropką: >

	:set path+=./proto

Mówi to Vimowi by szukał w katalogu "proto" poniżej tego gdzie jest plik
w którym wpisałeś "gf". Użycie "gf" na "inits.h" sprawi, że Vim będzie szukał
"proto/inits.h", zaczynając w katalogu edytowanego pliku.
   Bez "./", po prostu "proto", Vim szukałby w katalogu "proto" poniżej
katalogu bieżącego. A katalog bieżący może nie być tym gdzie jest ulokowany
plik aktualnie edytowany.

Opcja 'path' pozwala określić katalogi gdzie należy szukać plików na o wiele
więcej sposobów. Zobacz pomoc dla opcji 'path'.
   Opcja 'isfname' pozwala decydować, które znaki mogą być włączone do nazwy
pliku, a które nie (np. znak " w przykładzie powyżej).

Jeśli znasz nazwę pliku, ale nie możesz jej znaleźć w pliku możesz wpisać: >

	:find inits.h

Vim użyje wartości opcji 'path' do lokalizacji pliku. Jest to takie samo
polecenie jak ":edit" z wyjątkiem tego, że używa 'path'.

Żeby otworzyć znaleziony plik w nowym oknie użyj CTRL-W f zamiast "gf", lub
":sfind" zamiast ":find".

Szybki sposób otwarcia pliku znajdującego się gdzieś w 'path': >

	vim "+find stdio.h"

To polecenie znajdzie plik "stdio.h" pasujący do wartości 'path'. Cudzysłów 
jest konieczny dla argumentu |-+c|.

==============================================================================
*22.4*	Lista buforów

Vim używa terminu bufor na określenie edytowanego pliku. Dokładnie rzecz
biorąc, bufor jest kopią pliku, na którym operujesz. Kiedy kończysz edycję
bufora, zapisujesz zawartość bufora do pliku. Bufory zawierają nie tylko
zawartość pliku, ale także zakładki, ustawienia opcji oraz różne inne rzeczy.


UKRYTE BUFORY

Przypuśćmy, że edytujesz plik jeden.txt i potrzebujesz otworzyć plik dwa.txt.
Możesz po prostu wpisać ":edit dwa.txt", ale jeśli zrobiłeś zmiany w jeden.txt
to nie zadziała. Poza tym nie chcesz jeszcze zapisywać jeden.txt. Vim ma
rozwiązanie twojego problemu: >

	:hide edit two.txt

Bufor "jeden.txt" znika z ekranu, ale Vim cały czas wie, że edytujesz ten
bufor i zachowuje zmieniony tekst. Nazywa się to ukrytym buforem: zawiera on
tekst, ale nie możesz go zobaczyć.
   Argument polecenia - ":hide" jest innym poleceniem. Sprawia, że polecenie
zachowuje się tak jakby była ustawiona opcja 'hidden'. Sam możesz ustawić tę
opcję. Wtedy każdy opuszczony bufor zostaje ukryty.
   Uważaj! Jeśli masz ukryte bufory zawierające zmiany nie wychodź z Vima bez
upewnienia się, że zachowałeś je wszystkie.


NIEAKTYWNE BUFORY

Jeśli bufor był raz użyty, Vim zapamiętuje o nim trochę informacji. Jeśli nie
jest pokazany w oknie i nie jest ukryty, cały czas będzie na liście buforów.
Nazywa się go wtedy nieaktywnym buforem. Krótki przegląd:

   Active		Widoczny w oknie, tekst załadowany.
   Hidden		Niewidoczny w oknie, tekst załadowany.
   Inactive		Niewidoczny w oknie, tekst nie załadowany.

Nieaktywne bufory są pamiętane, ponieważ Vim zatrzymuje informacje o nich, na
przykład zakładki. A pamiętanie nazwy pliku jest też użyteczne, bo możesz
zobaczyć, które pliki edytowałeś i otworzyć je znowu.


LISTOWANIE BUFORÓW

Zobacz listę buforów: >

	:buffers

Inne polecenie zrobi to samo, nie jest zbyt oczywiste, ale za to krótsze: >

	:ls

Wynik powinien wyglądać tak:

  1 #h	 "help.txt"			line 62 ~
  2 %l + "usr_21.txt"			line 1 ~
  3	 "usr_toc.txt"			line 1 ~

Pierwsza kolumna zawiera numer bufora. Możesz tego użyć do edycji bufora bez
wpisywania nazwy, zobacz też poniżej.
   Po numerze bufora są flagi. Później nazwa pliku i numer linii gdzie był
kursor podczas ostatniej wizyty w tym pliku.
   Flagi, które mogą się pojawić (od lewej do prawej):

	u	Bufor nie jest listowany |unlisted-buffer|.
	 %	Bieżący bufor.
	 #	Bufor zamienny.
	  l	Bufor jest załadowany i pokazany.
	  h	Bufor jest załadowany ale ukryty.
	   =	Bufor jest tylko do odczytu.
	   -	Bufor nie jest do modyfikacji. Opcja 'modifiable' jest
	   	wyłączona.
	    +	Bufor został zmieniony.


EDYCJA BUFORA

Możesz wywołać bufor przez jego numer. W ten sposób nie musisz wpisywać nazwy
pliku: >

	:buffer 2

Ale jedynym sposobem by poznać numer bufora jest spojrzenie na listę buforów.
Zamiast tego możesz użyć nazwy lub jej części: >

	:buffer help

Vim odnajdzie najlepsze dopasowanie dla nazwy jaką podasz. Jeśli jest tylko
jeden bufor, którego nazwa może pasować zostanie pokazany. W tym wypadku
"help.txt".
   Żeby otworzyć bufor w nowym oknie: >

	:sbuffer 3

Działa również z nazwą.


LISTA BUFORÓW

Możesz poruszać się po liście buforów tymi poleceniami:

	:bn[ext]	przejdź do następnego bufora
	:bp[revious]	przejdź do poprzedniego bufora
	:bf[irst]	przejdź do pierwszego bufora
	:bl[ast]	przejdź do ostatniego bufora

Usuwasz bufor z listy poleceniem: >

	:bdelete 3

Działa też z nazwą bufora.
   Jeśli usuwasz aktywny bufor (widoczny w oknie), okno zostanie zamknięte.
Jeśli usuniesz bieżący bufor, aktywne okno zostanie zamknięte. Jeśli to było
ostatnie okno, Vim znajdzie inny bufor do edycji. Nie możesz edytować niczego!

	Note:
	Nawet po usunięciu bufora przez ":bdelete" Vim cały czas go pamięta.
	Bufor jest oznaczony jako "unlisted", nie pojawia się na liście
	":buffers". Polecenie ":buffers!" pokaże "unlisted buffers" (tak, Vim
	może robić rzeczy niemożliwe). Żeby Vim naprawdę zapomniał o buforze
	użyj ":bwipe". Zobacz też opcję 'buflisted'.

==============================================================================

Następny rozdział: |usr_23.txt|  Edycja trochę innych plików

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
