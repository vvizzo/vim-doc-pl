*usr_31.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			       Eksploracja GUI


Vim działa dobrze na terminalu, ale GUI oferuje kilka dodatków. Przeglądarka
plików może być użyta do poleceń, które wykorzystują pliki. Okno dialogowe,
żeby wybrać między alternatywami. Użyj skrótów menu, żeby prędko dostać się do
menu.

|31.1|	Przeglądanie plików
|31.2|	Potwierdzanie
|31.3|	Skróty menu
|31.4|	Pozycja i wielkość okna Vima
|31.5|	Różne

 Następny rozdział: |usr_40.txt|  Tworzenie poleceń
Poprzedni rozdział: |usr_30.txt|  Edycja programów
       Spis treści: |usr_toc.txt|

==============================================================================
*31.1*	Przeglądanie plików

Wybierając File/Open... menu otrzymasz przeglądarkę plików. W ten sposób
łatwiej znaleść pliki jakie chcesz edytować. Ale co jeśli chcesz podzielić
okno, żeby otworzyć inny plik? Nie ma takiego menu. Możesz najpierw użyć
Window/Split, a potem File/Open..., ale to sporo roboty.
   Poniewż większość poleceń w Vimie wpisujesz, otwarcie przeglądarki plików
poleceniem z klawiatury też jest możliwe. Żeby polecenie dzielące użyło
przeglądarki plików poprzedź je "browse": >

	:browse split

Wybierz plik, a wtedy polecenie ":split" zostanie wykonane na tym pliku. Jeśli
anulujesz wywołanie okna dialogowego nic się nie zdarzy, okno się nie
podzieli.
   Możesz też dodać argument. Stosuje się to do podania gdzie przeglądarka ma
zacząć. Przykład: >

	:browse split /etc

Przeglądarka plików pokaże się, zaczynając w katalogu "/etc".

Polecenie ":browse" może poprzedzać każde polecenie, które otwiera plik.
   Jeśli nie jest określony żaden katalog, Vim decyduje gdzie zacząć
przeglądanie plików. Domyślnie używa tego samego katalogu co ostatnim razem.
Stąd jeśli poprzednio użyłeś ":browse split" i wybrałeś plik
w "/usr/local/share", następnym razem kiedy wydasz polecenie ":browse" zacznie
w "/usr/local/share".
   Można to zmienić opcją 'browsedir'. Może ona przyjąć jedną z trzech
wartości:

	last		Użyj ostatnio przeglądanego katalogu (domyślne)
	buffer		Użyj tego samego katalogu co bieżący bufor
	current		Użyj bieżącego katalogu

Na przykład, kiedy jesteś w katalogu "/usr", edytując plik
"/usr/local/share/readme" i wydasz polecenia: >

	:set browsedir=buffer
	:browse edit

Zainicjują one przeglądarkę w "/usr/local/share". Inaczej: >

	:set browsedir=current
	:browse edit

Zainicjują przeglądarkę w "/usr".

	Note:
	By uniknąć używania myszy, większość przeglądarek plików oferuje
	klawisze do nawigacji. Ponieważ jest to różne dla różnych systemów,
	nie jest tu opisane. Vim używa standardowej przeglądarki plików kiedy
	to możliwe, dokumentacja twojego systemu powinna zawierać wyjaśnienie
	skrótów klawiszowych.

Jeśli nie używasz wersji GUI, możesz użyć eksploratora plików, żeby wybrać
pliki tak jak w przeglądarce plików. Nie działa wtedy jednak polecenie
":browse". Zobacz |file-explorer|.

==============================================================================
*31.2*	Potwierdzanie

Vim chroni cię przed przypadkowym nadpisaniem pliku i róznymi innymi sposobami
straty zmian. Jeśli robisz coś co może być Złą Rzeczą(tm) Vim wysyła komunikat
błędu i sugeruje dodanie ! jeśli naprawdę chcesz to zrobić.
   Jeśli chcesz uniknąć ponownego wpisywania polecenia z !, możesz przekonać
Vima by pokazał okienko dialogowe. Możesz wtedy wcisnąć "OK" lub "Cancel", żeby
powiedzieć Vimowi czego chcesz.
   Na przykład edytujesz plik i robisz w nim zmiany. Otwierasz inny plik: >

	:confirm edit foo.txt

Vim otworzy okienko dialogowe, które będzie wyglądać mniej więcej tak:

	+-----------------------------------+
	|				    |
	|   ?	Save changes to "bar.txt"?  |
	|				    |
	|   YES   NO		 CANCEL     |
	+-----------------------------------+

Teraz musisz wybrać. Jeśli chcesz zachować zmiany, wybierz "YES". Jeśli chcesz
stracić zmiany na zawsze: "NO". Jeśli zapomniałeś co robiłeś i chcesz
sprawdzić zmiany użyj "CANCEL". Wrócisz z powrotem do pliku, w którym są
zmiany.

Tak samo jak ":browse", polecenie ":confirm" może poprzedzić większość
poleceń, które otwierają inny plik. Można je również łączyć: >

	:confirm browse edit

Pokaże okno dialogowa jeśli bieżący bufor został zmieniony. Później wyskoczy
przeglądarka plików, żeby wybrać plik do edycji.

	Note:
	W oknie dialogowym możesz użyć klawiatury, żeby dokonać wyboru.
	Zazwyczaj <Tab> i kuror zmieniają focus. <Enter> dokonuje wyboru. Może
	to jednak zależeć od systemu.

Jeśli nie używasz GUI, polecenie ":confirm" również działa. Zamiast
wyskakującego okna dialogowego, Vim pokaże komunikat na dole okna i poprosi
o wciśnięcie klawisza by dokonać wyboru. >

	:confirm edit main.c
<	Save changes to "Untitled"? ~
	[Y]es, (N)o, (C)ancel:  ~

Możesz teraz wcisnąć pojedynczy klawisz, żeby wybrać. Nie musisz wciskać
<Enter> w odróżnieniu od innych poleceń w linii poleceń.

==============================================================================
*31.3*	Skróty menu

Klawiatura jest używana do wszystkich poleceń Vima. Menu zapawniają prostszy
sposób wybierania poleceń, bez wiedzy co dokładnie wywołują, ale musisz
przenieść rękę z klawiatury i złapać mysz.
   Menu mogą być często wybrane z klawiszy. Zależy od systemu, ale to
najczęściej działa. Użyj klawisza <Alt> w kombinacji z podkreśloną literką
w menu. Na przykład <A-w> (<Alt> i w) rozwija menu Window.
   W menu Window, "split" ma podkreślone p. Żeby je wybrać zwolnij <Alt>
i wciśnij p.

Po pierwszym wyborze menu z <Alt>, możesz używać klawiszy kursora do
poruszania się po menu. <Left> wybiera submenu, a <Right> zamyka je. <Esc>
także zamyka menu. <Enter> wybiera aktualnie podświetlony temat.

Jest konflikt między użyciem <Alt> do wybrania menu, a użyciem <Alt>
w kombinacjach mapujących. Opcja 'winaltkeys' mówi Vimowi co powinien robić
z klawiszem <Alt>.
   Domyślna wartość "menu" to sprytna rzecz: jeśli kombinacja klawiszy jest
skrótem menu, nie może zostać zmapowana. Wszystkie inne klawisze są dostępne
do mapowania.
   Wartość "no" nie pozwala na użycie <Alt> dla menu. Stąd musisz użyć myszy
do korzystania z menu, a wszystkie kombinacje z <Alt> mogą być mapowane.
   Wartość "yes" oznacza, że Vim użyje dowolnych klawiszy <Alt> dla menu.
Niektóre kombinacje z <Alt> mogą robić inne rzeczy niż wybieranie menu.

	Note:
	W polskiej klawiaturze programisty prawy <Alt> jest zarezerwowany dla
	wprowadzania polskich znaków diakrytycznych. Dlatego możesz używać
	tylko lewego <Alt> zarówno do mapowań jak i skrótów menu.


==============================================================================
*31.4*	Pozycja i wielkość okna Vima

Żeby zobaczyć obecną pozycję okna Vima na ekranie użyj: >

	:winpos

Działa tylko w GUI. Wynik może wyglądać tak:

	Window position: X 272, Y 103 ~

Pozycja jest podana w pikselach ekranu. Teraz możesz użyć numerów do
przeniesienia Vima gdzie indziej. Na przykład, przenieś je w lewo o 100
pikseli: >

	:winpos 172 103
<
	Note:
	Może być mała różnica między raportem o pozycji, a właściwą pozycją.
	Dzieje się tak z powodu ramki okna, która jest dodawana przez menedżer
	okna.

Możesz użyć tego polecenia w skrypcie startowym do umieszczenia okna
w określonej pozycji.

Wielkość okna Vima jest obliczana w znakach. Dlatego zależy od wielkości
użytego fontu. Możesz zobaczyć obecną wielkość poleceniem: >

	:set lines columns

Zmieniasz wielkość ustawiająć opcje 'lines' i/lub 'columns' na nowe wartości:
>
	:set lines=50
	:set columns=80

Informację o wielkości możesz też uzyskać na terminalach. Ustawianie wielkości
nie jest możliwe na większości terminali.

Wersję X-Window gvima możesz uruchomić z argumentem, który określi wielkość
okna i jego umieszczenie na ekranie: >

	gvim -geometry {width}x{height}+{x_offset}+{y_offset}

{width} i {height} są w znakach, {x_offset} i {y_offset} są w pikselach.
Przykład: >

	gvim -geometry 80x25+100+300

==============================================================================
*31.5*	Różne

Możesz użyć gvima do edycji e-maila. W swoim programie pocztowym musisz
wybrać gvima jako edytor wiadomości. Jeśli to zrobisz zobaczysz, że ten sposób
nie działa: program pocztowy myśli, że edycja jest skończona chociaż gvim cały
czas działa!
   Co się stało? Gvim rozłączył się z powłoką, z której został uruchomiony. To
w porządku jeśli zaczynasz gvima w terminalu, tak że możesz wykonywać inne
czynności w tym terminalu. Ale kiedy naprawdę chcesz zaczekać, aż gvim skończy
musisz go powstrzymać od rozłączenia się. Robisz to argumentem "-f": >

	gvim -f file.txt

"-f" oznacza foreground (ang. pierwszy plan). Teraz Vim zablokuje powłokę
z której startował dopóki nie zakończysz edycji i nie wyjdziesz.


OPÓŹNIONY START GUI

Na Uniksie możesz najpierw zacząć Vima w terminalu. Wygodne jeśli robisz różne
rzeczy w tej samej powłoce. Jeśli edytujesz plik i zdecydujesz, że jednak
chcesz użyć GUI, zaczynasz je poleceniem: >

	:gui

Vim otworzy okno GUI i nie będzie dalej korzystać z terminala. Możesz użyć
terminalu do czegoś innego. Argument "-f" jest tu użyty do uruchomienia GUI na
pierwszym planie. Możesz też użyć ":gui -f".


PLIK STARTOWY GVIMA

W czasie startu gvima czytany jest plik gvimrc. Jest podobny do pliku vimrc
wczytywanego kiedy zaczynasz Vima. Plik gvimrc może być użyty do ustawień
i poleceń używanych wyłącznie w GUI. Na przykład możesz ustawić opcję 'lines',
żeby ustawić inny rozmiar okna: >

	:set lines=55

Nie chcesz robić tego w terminalu, którego rozmiar jest stały (z wyjątkiem
xterma, który wspiera zmianę wielkości).
   Pliku gvimrc szuka się w tych samych miejscach co pliku vimrc. Normalnie
jego nazwa to "~/.gvimrc" dla Uniksów i "$VIM\_gvimrc" dla MS-Windows.
   Jeśli z jakiejś przyczyny nie chcesz użyć normalnego pliku gvimrc możesz
użyć innego wraz z argumentem "-U": >

	gvim -U tenrc ...

Pozwala to na start gvima dla różnych rodzajów edycji. Możesz na przykład
ustawić inny font.
   Żeby całkowicie ominąć czytanie pliku gvimrc: >

	gvim -U NONE ...

==============================================================================

Następny rozdział: |usr_40.txt|  Make new commands

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
