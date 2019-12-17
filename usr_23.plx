*usr_23.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			 Edycja trochę innych plików


Ten rozdział opisuje edycję plików, które są trochę niezwykłe. Vim może
edytować pliki, które są skompresowane lub zaszyfrowane. Niektóre pliki muszą
być osiągalne przez Internet. Z pewnymi ograniczeniami także pliki binarne
mogą być edytowane.

|23.1|	Pliki DOS-a, Mac-a i Uniksa
|23.2|	Pliki w Internecie
|23.3|	Pliki zaszyfrowane
|23.4|	Pliki binarne
|23.5|	Pliki skompresowane

 Następny rozdział: |usr_24.txt|  Szybkie wpisywanie
Poprzedni rozdział: |usr_22.txt|  Znajdywanie plików do edycji
       Spis treści: |usr_toc.txt|

==============================================================================
*23.1*	Pliki DOS-a, Mac-a i Uniksa

Dawno, dawno temu stare maszyny Teletype używały 2 znaków by zacząć nową
linię. Jeden z nich przenosił karetkę do pierwszej kolumny (carriage return,
<CR>), drugi przesuwał papier do góry (line feed, <LF>).
   Kiedy pojawiły się komputery pamięć była kosztowna. Niektórzy ludzie
zdecydowali, że nie potrzebują dwóch znaków dla końca linii. Ludzie Uniksa
postanowili używać tylko <LF>. Ludzie Apple'a postawili na <CR>. MS-DOS
(i MS-Windows) zostawiło stare rozwiązanie <CR><LF>.
   Oznacza to, że jeśli chcesz przenieść plik z jednego systemu do drugiego
możesz mieć problemy z łamaniem linii. Vim automatycznie rozpoznaje różne
formaty plików i traktuje je odpowiednio bez twojej interwencji.
   Opcja 'fileformats' zawiera różne formaty, które będą wypróbowywane kiedy
otwierany jest nowy plik. Następująca komenda mówi Vimowi by najpierw
spróbował formatu uniksowego, a potem MS-DOS: >

	:set fileformats=unix,dos

Kiedy otwierasz plik zobaczysz jego format w specjalnym komunikacie. Jeśli
jednak edytujesz plik w formacie natywnym nic nie będzie się działo. Z tego
względu edycja pliku uniksowego na Uniksie nie zaowocuje komunikatem. Ale
jeśli będziesz otwierał plik dosowy Vim zawiadomi cię tak:

	"/tmp/test" [dos] 3L, 71C ~

Dla pliku Maca zobaczyłbyś "[mac]".
   Wykryty format pliku jest przechowywany w opcji 'fileformat'. By sprawdzić
jakiego formatu plik używa wpisz: >

	:set fileformat?

Możliwe są trzy wartości:

	unix		<LF>
	dos		<CR><LF>
	mac		<CR>


FORMAT MAC

Na Uniksie, <LF> jest używane do łamania linii. Nie jest niczym niezwykłym
pojawienie się znaku <CR> w połowie linii. Przypadkiem zdarza się to całkiem
często w skryptach Vi i Vima.
   Na Macintoshach gdzie <CR> jest znakiem łamania linii możliwe jest użycie
znaku <LF> w połowie linii.
   Rezultatem jest niemożliwa 100% pewność czy plik zawierający i <CR>, i <LF>
jest plikiem Maca czy Uniksa. Dlatego Vim przyjmuje, że na Uniksie nie
będziesz edytował plików Macowych i nie sprawdza czy plik należy do tego typu
plików. Jeśli jednak chcesz sprawdzać ten format dodaj "mac" do 'fileformats':
>
	:set fileformats+=mac

Vim będzie wtedy próbował zgadnąć typ pliku. Uważaj jednak bo możliwe jest, że
Vim się pomyli.


NARZUCENIE FORMATU

Jeśli używasz dobrego, starego Vi i próbujesz edytować plik w formacie MS-DOS
zobaczysz, że każda linia kończy się na ^M (^M to <CR>). Automatyczna detekcja
pozwala tego uniknąć. Przypuśćmy jednak, że chcesz edytować plik w ten sposób.
Musisz wtedy narzucić format: >

	:edit ++ff=unix file.txt

Łańcuch "++" jest przełącznikiem, który mówi Vimowi, że następująca nazwa
opcji wymusza zastosowanie jej wartości, a nie domyślnej dla tej komendy.
"++ff" jest użyte dla 'fileformat'. Możesz również użyć "++ff=mac" lub
"++ff=dos".
   Ten sposób nie działa na wszystkie opcje. W chwili obecnej zaimplementowany
jest jedynie dla "++ff" i "++enc". Pełne nazwy, "++fileformat" i "++encoding",
również działają.


KONWERSJA

Możesz użyć opcji 'fileformat' by przekonwertować plik z jednego formatu do
innego. Przypuśćmy, że masz plik MS-DOS nazwany README.TXT, który
chcesz przekonwertować na format uniksowy. Zaczynasz edycję pliku: >

	vim README.TXT

Vim rozpozna ten plik jako format dos. Teraz zmień format pliku na uniksowy: >

	:set fileformat=unix
	:write

Plik został zapisany w formacie Unix.

==============================================================================
*23.2*	Pliki w internecie

Ktoś przysyła ci e-maila, która odwołuje się do pliku przez URL. Na przykład:

	You can find the information here: ~
		ftp://ftp.vim.org/pub/vim/README ~

Możesz teraz ściągnąć plik specjalnym programem, zachować go na dysku
lokalnym, a następnie otworzyć w Vimie.
   Istnieje jednak znacznie prostszy sposób. Przenieś kursor na dowolny znak
należący do URL-a i wydaj komendę: >

	gf

Z odrobiną szczęścia, Vim zorientuje się jakiego programu należy użyć by
ściągnąć plik, ściągnie go i wyedytuje kopię. By otworzyć plik w nowym oknie
użyj CTRL-W f.
   Jeśli coś poszło źle dostaniesz komunikat błędu. Być może, że URL jest
nieprawidłowy, nie masz praw by odczytać plik, leży połączenie sieciowe, itd.
Niestety trudno jest zlokalizować przyczynę. W takim przypadku możesz
spróbować tradycyjną drogę ściągania pliku.

Dostęp do pliku przez internet działa dzięki wtyczce netrw. Obecnie
rozpoznawane są następujące formaty URL-i:

	ftp://		używa ftp
	rcp://		używa rcp
	scp://		używa scp
	http://		używa wget (tylko do odczytu)

Vim nie komunikuje się samodzielnie, ale polega na wspomnianych programach,
które są dostępne na twoim komputerze. Na większości systemów uniksowych "ftp"
i "rcp" są obecne. "scp" i "wget" być może trzeba będzie zainstalować.

Vim wykrywa te URL-e dla każdej komendy, która rozpoczyna edycję nowego pliku,
także ":edit" i ":split". Polecenia służące zapisywaniu także działają,
z wyjątkiem protokołu http://.

Dla uzyskania większej liczby informacji, także o hasłach, zobacz |netrw|.

==============================================================================
*23.3*	Szyfrowanie

Niektóre informacje wolisz zatrzymać dla siebie. Na przykład pisząc test na
komputerze, którego używają studenci. Nie chcesz by sprytni studenci odkryli
sposób by przeczytać pytania przed egzaminem. Vim może zaszyfrować plik co
daje pewną ochronę.
   By zacząć sesję Vima z włączonym szyfrowaniem użyj argumentu "-x".
Przykład: >

	vim -x exam.txt

Vim prosi cię o klucz, którego użyje do zaszyfrowanie i odszyfrowania pliku:

	Enter encryption key: ~

Ostrożnie wpisz tajny klucz. Nie możesz zobaczyć znaków jakie wpisujesz,
zostaną one zastąpione przez gwiazdki. Vim prosi o ponowne wprowadzenie
klucza, by uniknąć sytuacji w jakiej błąd przy wprowadzaniu klucza
spowodowałby problemy,:

	Enter same key again: ~

Możesz teraz normalnie edytować plik i powierzyć mu wszystkie swoje sekrety.
Kiedy skończysz edycję i będziesz chciał wyjść z Vima plik będzie zaszyfrowany
i zapisany.
   W chwili kiedy będziesz chciał edytować plik w Vimie zostaniesz poproszony
o wprowadzenie znowu tego samego klucza. Nie potrzebujesz już używać argumentu
"-x". Możesz użyć też normalnego polecenia ":edit". Vim dodaje magiczny
łańcuch do pliku, dzięki któremu rozpoznaje, że plik został zaszyfrowany.
   Jeśli spróbujesz obejrzeć ten plik w innym programie zobaczysz tylko
śmieci. Także otwierając plik w Vimie i wprowadzając zły klucz dostaniesz śmieci.
Vim nie posiada mechanizmu, który by sprawdzał czy klucz jest dobry (dzięki
temu trudniej jest złamać klucz).


WŁĄCZANIE I WYŁĄCZANIE SZYFROWANIA

Aby wyłączyć szyfrowanie pliku ustaw opcję 'key' jako pusty łańcuch: >

	:set key=

Następnym razem kiedy zapiszesz plik, zostanie to zrobione bez szyfrowania.
   Zmiana opcji 'key' by włączyć szyfrowanie nie jest dobrym pomysłem ponieważ
hasło pojawi się jako otwarty tekst. Każdy zaglądający ci przez ramię będzie
mógł odczytać hasło.
   Dla uniknięcia tego problemu zostało stworzone polecenie ":X". Prosi ono
o klucz tak samo ja robił to argument "-x": >

	:X
	Enter encryption key: ******
	Enter same key again: ******


OGRANICZENIA SZYFROWANIA

Algorytm szyfrowania użyty w Vimie jest słaby. Wystarczy by wytrzymać atak
przypadkowego szperacza, ale nie jest dość dobry by powstrzymać eksperta
w kryptografii z dużą ilością czasu. Powinieneś także pamiętać, że plik
wymiany nie jest szyfrowany. Tak więc w czasie edycji pliku ktoś
z przywilejami superużytkownika będzie mógł przeczytać niezaszyfrowany tekst
pliku.  Jedynym sposobem powstrzymania kogoś od czytania pliku wymiany jest
nie tworzenie go. Jeśli argument "-n" został użyty w linii poleceń nie
powstanie plik wymiany (zamiast tego Vim będzie trzymał wszystko w pamięci).
Na przykład, by edytować "plik.txt" bez pliku wymiany użyj: >

	vim -x -n file.txt

Kiedy już edytujesz plik, plik wymiany może zostać wyłączony: >

	:setlocal noswapfile

Ponieważ nie ma pliku wymiany, odzyskanie pliku w razie awarii będzie
niemożliwe. Zapamiętuj plik odrobinę częściej niż zwykle by zmniejszyć ryzyko
utraty zmian.

Ponieważ plik znajduje się w pamięci jest on w czystym tekście. Każdy
z odpowiednimi prawami może zajrzeć do pamięci edytora i odkryć zawartość
pliku.
   Jeśli używasz pliku viminfo, bądź świadom, że zawartość rejestrów jest tam
zapisywana także w czystym tekście.
   Jeśli naprawdę chcesz zabezpieczyć zawartość pliku edytuj go tylko na
przenośnym komputerze nie podłączonym do sieci, używaj dobrych narzędzi
kryptograficznych i trzymaj komputer zamknięty w dobrym sejfie jeśli go nie
używasz.

==============================================================================
*23.4*	Pliki binarne

Możesz edytować pliki binarne w Vimie. Nie był on do tego stworzony, więc
istnieją pewne ograniczenia. Ale możesz odczytać plik, zmienić znak i zapisać
plik z powrotem, tak że jedynie jeden znak będzie zmieniony, a poza tym plik
będzie identyczny jak przedtem.
   By być pewnym, że Vim nie będzie próbował sprytnych sztuczek dodaj argument
"-b" wywołując Vima: >

	vim -b datafile

To ustawia opcję 'binary'. Skutkuje to wyłączeniem niespodziewanych efektów
ubocznych. Na przykład, 'textwidth' zostaje ustawiona na 0 by uniknąć
automatycznego reformatowania linii. Pliki są zawsze odczytywane w formacie
uniksowym.

Tryb binarny może być użyty do zmiany komunikatu w programie. Uważaj by nie
dodać lub usunąć żadnych znaków, mogłoby to uszkodzić program. Używaj "R" do
wejścia w tryb Replace.

Wiele znaków w pliku nie będzie się nadawało do wydrukowania na ekranie.
Możesz je zobaczyć w formacie Hex: >

	:set display=uhex

Innym sposobem jest polecenie "ga". Służy ono do zorientowania się w wartości
znaku pod kursorem. Wynik kiedy kursor jest na <Esc> wygląda tak:

	<^[>  27,  Hex 1b,  Octal 033 ~

W pliku nie będzie zbyt wiele znaków nowej linii. Wyłącz opcję 'wrap': >

	:set nowrap


POZYCJA BAJTU

Na którym jesteś bajcie w pliku możesz zobaczyć wydając polecenie: >

	g CTRL-G

Wynik:

    Col 9-16 of 9-16; Line 277 of 330; Word 1806 of 2058; Byte 10580 of 12206~

Ostatnie dwie liczby to pozycja bajtowa w pliku i całkowita liczba bajtów.
Brane jest pod uwagę to jak 'fileformat' zmienia liczbę bajtów, które używają
znaki złamania linii.
    Przejść do żądanego bajtu w pliku można używając polecenia "go". Na
przykład by przejść do bajtu 2345: >

	2345go


XXD

Prawdziwy edytor binarny pokazuje tekst na dwa sposoby: tak jak jest
i w formacie hex. W Vimie można to uzyskać konwertując plik programem "xxd".
Jest dołączany do Vima.
   Najpierw edytuj plik w formacie binarnym: >

	vim -b datafile

Teraz przekonwertuj plik do zrzutu heksowego: >

	:%!xxd

Tekst będzie wyglądał tak:

	0000000: 1f8b 0808 39d7 173b 0203 7474 002b 4e49  ....9..;..tt.+NI ~
	0000010: 4b2c 8660 eb9c ecac c462 eb94 345e 2e30  K,.`.....b..4^.0 ~
	0000020: 373b 2731 0b22 0ca6 c1a2 d669 1035 39d9  7;'1.".....i.59. ~

Możesz teraz oglądać i edytować tekst jak ci się podoba. Vim traktuje
informację jak zwykły tekst. Zmiana wartości heksu nie powoduje zmiany znaku
w prawej kolumnie (tekstowej) i odwrotnie.
   Na koniec przekonwertuj plik z powrotem: >
>
	:%!xxd -r

xxd używa tylko części heksowej. Zmiany w prawej kolumnie (tekstowej) są
ignorowane.

Więcej informacji możesz uzyskać na stronie man xxd.

==============================================================================
*23.5*	Pliki skompresowane

To jest łatwe: możesz edytować skompresowany plik tak samo jak każdy inny
plik. Wtyczka "gzip" troszczy się o dekompresję pliku kiedy go edytujesz.
I kompresuje go z powrotem w trakcie zapisywania.
   Obecnie są obsługiwane następujące metody kompresji:

	.Z	compress
	.gz	gzip
	.bz2	bzip2

Vim używa wspomnianych programów by wykonać właściwą kompresję i dekompresję.
Może być konieczne wcześniejsze zainstalowanie programów.

==============================================================================

Następny rozdział: |usr_24.txt|  Szybkie wpisywanie

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
