*usr_26.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 Powtarzanie


Edycja bardzo często jest ustrukturyzowana. Zadanie często musi być
powtórzone kilka razy. W tym rozdziale zostanie wyjaśnione kilka sposobów
powtarzania wprowadzonej zmiany.

|26.1|	Powtarzanie w trybie Visual
|26.2|	Dodaj i odejmij
|26.3|	Zmiana w wielu plikach
|26.4|	Używanie Vima w skrypcie powłoki

 Następny rozdział: |usr_27.txt|  Komenda wyszukiwania i ścieżki
Poprzedni rozdział: |usr_25.txt|  Edycja sformatowanego tekstu
       Spis treści: |usr_toc.txt|

==============================================================================
*26.1*	Powtarzanie w trybie Visual

Tryb Visual jest bardzo wygodny do wprowadzania zmian w kilku następujących po
sobie wierszach. Możesz zobaczyć podświetlony tekst, sprawdzić czy zostały
zmienione te linie o które ci chodziło. Ale selekcja tekstu wymaga wpisania
kilku komend. Komenda "gv" wybiera ten sam obszar ponownie. Pozwala to na
zrobienie innej operacji na tym samym fragmencie tekstu.
   Przypuśćmy, że masz kilka linii gdzie chcesz zmienić "2001" na "2002"
i "2000" na "2001":

	Finansowe rezultaty w 2001 są lepsze niż ~
	w 2000. Dochód wzrósł o 50%, mimo że ~
	w 2001 więcej padało niż w 2000. ~
			2000		2001 ~
	dochód		45,403		66,234 ~

Najpierw zmień "2001" na "2002". Wybierz linie w trybie Visual i wpisz: >

	:s/2001/2002/g

Użyj "gv" by wybrać ponownie ten sam tekst. Nie ma znaczenia gdzie znajduje
się kursor. Teraz wpisz ":s/2000/2001/g" by wprowadzić drugą zmianę.
   Oczywiście możesz powtarzać te zmiany kilka razy.

==============================================================================
*26.2*	Dodaj i odejmij

Powtarzając zmiany jednej liczby w inną często masz stałą zmianę. W
przykładzie powyżej do każdego roku dodany był jeden. Zamiast używać do
każdego roku zamiany (s///) możesz posłużyć się CTRL-A.
   Używając tego samego tekstu co powyżej, szukaj roku: >

	/19[0-9][0-9]\|20[0-9][0-9]

Teraz wciśnij CTRL-A. Rok zwiększy się o jeden:

	Finansowe rezultaty w 2002 są lepsze niż ~
	w 2000. Dochód wzrósł o 50%, mimo że ~
	w 2001 więcej padało niż w 2000. ~
			2000		2001 ~
	dochód		45,403		66,234 ~

Użyj "n" by znaleźć następny rok i wciśnij "." by powtórzyć CTRL-A ("." jest
odrobinę szybsze do wklepania polecenia). Powtarzaj "n" i "." dla wszystkich
lat jakie się pojawią.
   Wskazówka: ustaw opcję 'hlsearch' by zobaczyć wzorce jakie masz zamiar
zmienić, możesz wtedy to szybciej.

Dodawanie więcej niż 1 jest możliwe dzięki poprzedzeniu CTRL-A mnożnikiem.
Przypuśćmy, że masz listę:

	1.  czwarty element ~
	2.  piąty element ~
	3.  szósty element ~

Przenieś kursor na "1." i wpisz: >

	3 CTRL-A

"1." zmieni się w "4.". Znów możesz użyć "." by powtórzyć to na innych
numerach.

Inny przykład:

	006	foo bar ~
	007	foo bar ~

Użycie CTRL-A na tych liczbach kończy się tak:

	007	foo bar ~
	010	foo bar ~

7 plus 1 równa się 10? W tym momencie Vim rozpoznał "007" jako liczbę ósemkową
z powodu poprzedzającego 0. Taka notacja jest często używana w programach
pisanych w języku C. Jeśli nie chcesz by liczby z zerami na początku były
traktowane jako ósemkowe użyj: >

	:set nrformats-=octal

CTRL-X odejmuje w podobny sposób.

==============================================================================
*26.3*	Zmiana w wielu plikach

Przypuśćmy, że masz zmienną nazwaną "x_cnt" i chcesz zmienić ją na
"x_counter". Zmienna ta jest używana w kilku z twoich plików C. Musisz ją
zmienić we wszystkich. Możesz to zrobić w następujący sposób:
   Dodaj wszystkie interesujące cię pliki do listy argumentów: >

	:args *.c
<
Polecenie znajdzie wszystkie pliki C i otwiera pierwszy. Teraz możesz
przeprowadzić zamianę (s///) na nich wszystkich: >

	:argdo %s/\<x_cnt\>/x_counter/ge | update

Komenda ":argdo" pobiera inną komendę jako argument. Ta inna komenda będzie
wykonana na wszystkich plikach z listy argumentów.
   Polecenie zamiany "%s" wykonuje komendę na wszystkich liniach. Znajduje
wyraz "x_cnt" z "\<x_cnt\>". "\<" i "\>" służą dopasowania całego słowa, a nie
"px_cnt" lub "x_cnt2".
   Flagi dla komendy zamiany to: "g" by zamienić wszystkie "x_cnt" w tej samej
linii; "e" by uniknąć komunikatu o błędzie jeśli "x_cnt" nie pojawi się
w pliku. W innym wypadku ":argdo" mogłoby skończyć na pierwszym pliku,
w którym "x_cnt" nie zostałoby znalezione.
   "|" oddziela dwie komendy. Następna komenda "update" zapisuje plik jedynie
wtedy gdy plik uległ zmianie. Jeśli "x_cnt" nie zostało zmienione na
"x_counter" nic się nie dzieje.

Istnieją również takie komendy jak ":windo", która wykonuje polecenia na
wszystkich oknach, a ":bufdo" robi to na wszystkich buforach. Uważaj z tym
ponieważ możesz mieć więcej plików na liście buforów niż myślisz. Sprawdź to
komendą ":buffers" (lub ":ls").

==============================================================================
*26.4*	Używanie Vima w skrypcie powłoki

Przypuśćmy, że masz wiele plików w których chcesz zmienić łańcuch "-osoba-" na
"Kowalski" a potem to wydrukować. Jak to zrobić? Jednym ze sposobów jest wiele
pisania. Innym napisanie skryptu powłoki, który wykona całą robotę.
   Vim robi wspaniałe rzeczy jako edytor ekranowy używając komend trybu
Normal. Jednak dla plików wsadowych komendy trybu Normal nie są najlepszym
wyborem. Tutaj powinieneś użyć trybu Ex. Tryb ten oferuje miły interfejs
z linią poleceń, który łatwo dopasować do pliku wsadowego. ("komenda Ex" jest
po prostu inną nazwą dla komendy linii poleceń ":").
   Potrzebujesz następujących poleceń Ex: >


	%s/-osoba-/Kowalski/g
	write tempfile
	quit

Zapisujesz te polecenia w pliku "zmiana.vim". Teraz by użyć edytora w trybie
wsadowym użyj takiego skryptu powłoki: >

	for file in *.txt; do
	  vim -e -s $file < zmiana.vim
	  lpr -r tempfile
	done

Pętla for-done jest konstrukcją powłoki, która powtarza dwie linie pomiędzy
dopóki zmienna $file jest ustawiona na inną nazwę pliku za każdym razem.
   Druga linia uruchamia edytor Vim w trybie Ex (argument -e) na pliku $file
i czyta komendy z pliku "zmiana.vim". Argument -s mówi Vimowi by działał po
cichu. Innymi słowy, by nie zgłaszał ":prompt" lub jakiegokolwiek innego znaku
zachęty.
   Komenda "lpr -r tempfile" drukuje wynikowy plik "tempfile" i usuwa go (to
robi argument -r).


CZYTANIE Z STDIN

Vim potrafi pobierać tekst ze standardowego wejścia. Ponieważ normalnie czyta
w ten sposób komendy musisz powiedzieć, że ma pobrać zamiast tego tekst.
Robisz to przekazując argument "-" w miejsce pliku. Przykład: >

	ls | vim -

Pozwala edytować wynik komendy "ls" bez zapamiętywania najpierw tekstu do
pliku.
   Jeśli użyjesz standardowego wejścia by wczytać tekst możesz użyć
przełącznika "-S" by odczytać skrypt: >

	producer | vim -S change.vim -


SKRYPTY TRYBU NORMAL

Jeśli naprawdę chcesz w skrypcie użyć poleceń trybu Normal możesz to zrobić
tak: >

	vim -s skrypt plik.txt ...
<
	Note:
	"-s" ma inne znaczenie jeśli jest użyte bez "-e". Tutaj oznacza to, że
	vim ma wczytać (|source|) "skrypt" jako polecenia trybu Normal. Użyte
	z "-e" oznacza, że Vim ma być cicho i nie używać następnego argumentu
	jako nazwy pliku.

Polecenia w "skrypt" są wykonywane jakbyś je wpisywał. Nie zapomnij, że zmiana
linii jest odczytana jako wciśnięcie <Enter>. W trybie Normal <Enter> przenosi
kursor do nowej linii.
   By stworzyć skrypt musisz edytować plik skryptowy i wprowadzić polecenia.
Potrzebujesz wyobraźni by wiedzieć jakie będą rezultaty co może być odrobinę
trudne. Innym sposobem jest nagrywanie (|recording|) komend w czasie ich
ręcznego wykonywania. Robisz to tak: >

	vim -w skrypt plik.txt ...

Wszystkie wciśnięte klawisze będą zapisane do "skrypt". Jeśli zrobisz mały
błąd wystarczy jeśli będziesz kontynuować i zapamiętasz by poprawić skrypt
później.
   Argument "-w" dogrywa do istniejącego skryptu. Przydatne jeśli chcesz
nagrać skrypt kawałek po kawałku. Jeśli chcesz zacząć wszystko od zera użyj
"-W". Ten argument nadpisze każdy istniejący plik.

==============================================================================

Następny rozdział: |usr_27.txt|  Komenda wyszukiwania i ścieżki

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
