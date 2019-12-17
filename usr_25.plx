*usr_25.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			 Edycja sformatowanego tekstu


Rzadko zdarza się, by tekst tak, że mieści się jedno zdanie w jednym wierszu.
Ten rozdział jest o łamaniu zdań, żeby lepiej wyglądały na ekranie oraz innych
formatowaniach. Także o użytecznych funkcjach do edytowania jednowierszowych
akapitów oraz tabel.

|25.1|	Łamanie linii
|25.2|	Wyrównywanie tekstu
|25.3|	Wcięcia i tabulatory
|25.4|	Długie linie
|25.5|	Edycja tablic

 Następny rozdział: |usr_26.txt|  Powtarzanie
Poprzedni rozdział: |usr_24.txt|  Szybkie wpisywanie
       Spis treści: |usr_toc.txt|

==============================================================================
*25.1*	Łamanie linii

Vim posiada wiele funkcji, które ułatwiają obróbkę tekstu. Domyślnie edytor
nie przeprowadza automatycznego łamania linii. Innymi słowy, musisz wcisnąć
<Enter>. Jest to wygodne jeśli piszesz programy i sam chcesz dedydować gdzie
kończy się linia. Niezbyt jednak wygodne przy pisaniu dokumentacji lub kiedy
chcesz by tekst był szeroki najwyżej na 70 znaków.
   Jeśli ustawisz opcję 'textwidth' Vim automatycznie będzie wstawiał znaki
końca linii. Przypuśćmy na przykład, że chcesz mieć wąską kolumnę 30 znaków.
Musisz wydać polecenie: >

	:set textwidth=30

Teraz zacznij pisać (linijka została dodana):

		 1	   2	     3
	12345678901234567890123456789012345
	Uczyłem przez jakiś czas progr ~

Kiedy wpiszesz "a" spowoduje to, że linia będzie dłuższa niż wyznaczony limit
30 znaków. Kiedy Vim to zobaczy wstawi znak końca wiersza i otrzymasz:

		 1	   2	     3
	12345678901234567890123456789012345
	Uczyłem przez jakiś czas ~
	progra ~

Wpisz resztę akapitu:

		 1	   2	     3
	12345678901234567890123456789012345
	Uczyłem przez jakiś czas ~
        programowania. Pewnego razu ~
        zostałem zatrzymany przez ~
        policję Fort Worth bo moja ~
        praca domowa była zbyt trudna. ~
        Prawdziwa historia. ~

Nie musisz wstawiać znaków nowej linii; Vim zrobi to automatycznie.

	Note:
	Opcja 'wrap' powoduje, że Vim pokazuje złamane linie, ale nie wstawia
	znaków nowej linii do pliku.


REFORMATOWANIE

Vim nie jest procesorem tekstów. W procesorze jeśli skasujesz coś na początku
akapitu, akapit jest reformatowany. W Vimie nie. Jeśli usuniesz wyraz
"programowania" z drugiego wiersza otrzymasz tylko krótszy wiersz:

		 1	   2	     3
	12345678901234567890123456789012345
	Uczyłem przez jakiś czas ~
        . Pewnego razu ~
        zostałem zatrzymany przez ~
        policję Fort Worth bo moja ~
        praca domowa była zbyt trudna. ~
        Prawdziwa historia. ~

Nie wygląda to ładnie. Żeby akapit znów dobrze wyglądał użyj operatora "gq".
   Użyjmy go najpierw w trybie Visual. Zaczynając w pierwszej linii: >

	v5jgq

"v" do rozpoczęcia trybu Visual, "5j" żeby przejść do końca akapitu, na koniec
operator "gq":

		 1	   2	     3
	12345678901234567890123456789012345
	Uczyłem przez jakiś czas . ~
	Pewnego razu zostałem ~
	zatrzymany przez policję Fort ~
	Worth bo moja praca domowa ~
	była zbyt trudna. Prawdziwa ~
	historia. ~

Teraz wystarczy usunąć spację między "czas" i kropką.
   Ponieważ "gq" jest operatorem, możesz go użyć na jeden z trzech sposobów do
wyboru tekstu na jakim zamierzasz działać: tryb Visual, razem z ruchem albo
obiekt tekstowy.
   Przykład powyżej mógłby być również przeprowadzony tylko z "gq5j". To mniej
pisania ale musisz znać liczbę linii. Bardziej użyteczną komendą ruchu jest
"}". Przenosi ona do końca akapitu. Stąd "gq}" formatuje od pozycji kursora do
końca akapitu.
   Bardzo użytecznym obiektem tekstowym do użycia z "gq" jest akapit. Spróbuj:
>
	gqap

"ap" jest skrótem do "a-paragraph" (ang. akapit). Formatuje on tekst jednego
akapitu (oddzielonego od innych pustymi liniami). Także część przed kursorem.
   Jeśli twoje akapity są oddzielone pustymi liniami możesz zreformatować cały
plik w ten sposób: >

	gggqG

"gg" służy przejściu do pierwszej linii. "gqG" do sformatowania aż do linii
ostatniej.
   Uwaga: Akapity, jeśli nie są prawidłowo oddzielone, zostaną złączone.
Częstym przeoczeniem jest wiersz ze spacją lub znakiem tabulacji. To jest
"biała" linia, ale nie pusta.

Vim może formatować coś więcej niż zwykły tekst. Zobacz |fo-table| jak to
zmienić. Zobacz też opcję 'joinspaces' jak zmienić liczbę spacji wstawianych
po kropce.
   Można też użyć oddzielnego programu do formatowania. Użyteczne, jeśli twój
tekst nie może zostać prawidłowo sformatowany przez polecenia wbudowane
w Vima. Zobacz opcję 'formatprg'.

==============================================================================
*25.2*	Wyrównywanie tekstu

Do wycentrowania kilku linii użyj: >

	:{zasieg}center [szerokosc]

{zasieg} to zwykły zasięg z linii poleceń.  [szerokosc] jest opcjonalną
szerokością wiersza do centrowania. Jeśli [szerokosc] nie jest określona
używana jest wartość 'textwidth'. (Jeśli 'textwidth' równe jest 0, domyślne
jest 80.)
   Na przykład: >

	:1,6center 40

Daje w wyniku:

       Uczyłem przez jakiś czas ~
     programowania. Pewnego razu ~
      zostałem zatrzymany przez ~
      policję Fort Worth bo moja ~
    praca domowa była zbyt trudna. ~
	 Prawdziwa historia. ~


WYRÓWNANIE DO PRAWEJ

Podobnie, polecenie ":right" dosuwa tekst do prawej strony: >

	:1,6right 40

Otrzymujemy:

	      Uczyłem przez jakiś czas ~
	   programowania. Pewnego razu ~
	     zostałem zatrzymany przez ~
	    policję Fort Worth bo moja ~
	praca domowa była zbyt trudna. ~
		   Prawdziwa historia. ~


WYRÓWNANIE DO LEWEJ

W końcu jest polecenie: >

	:{zasieg}left [margines]

W odróżnieniu od ":center" i ":right" argumentem ":left" nie jest długość
linii. Zamiast niej jest szerokość lewego marginesu. Jeśli pominięta tekst
zostanie dosunięty do lewej krawędzi ekranu (użycie zerowego marginesu zrobi
to samo). Jeśli 5, tekst zostanie wcięty o 5 spacji. Użyj tych poleceń: >

	:1left 5
	:2,5left

Wynikiem będzie:

	     Uczyłem przez jakiś czas ~
	programowania. Pewnego razu ~
	zostałem zatrzymany przez ~
	policję Fort Worth bo moja ~
	praca domowa była zbyt trudna. ~
	Prawdziwa historia. ~


JUSTOWANIE TEKSTU

Vim nie ma bezpośrednio wbudowanego justowania tekstu. Jednak istnieje pewne
miłe makro, które to robi. Żeby użyć tego pakietu wykonaj polecenie: >

	:runtime macros/justify.vim

Skrypt ten definiuje nową komendę trybu Visual "_j". Żeby justować blok
tekstu, podświetl tekst w trybie Visual i wydaj komendę "_j".
   Zajrzyj do pliku po więcej instrukcji, żeby do niego przejść zrób "gf" na
tej nazwie: $VIMRUNTIME/macros/justify.vim.

Innym sposobem jest przefiltrowanie tekstu przez program zewnętrzny: >

	:%!fmt

==============================================================================
*25.3*	Wcięcia i tabulatory

Wcięcia mogą być użyte do wyróżnienia jednego fragmentu tekstu z drugiego.
Przykłady w tym podręczniku są wcięte po osiem spacji. Normalnie robisz to
dając znak tabulacji na początku każdego wiersza. Weźmy ten tekst:

	pierwsza linia ~
	druga linia ~

Wprowadzono go wciskając <Tab>, trochę tekstu, <Enter>, <Tab> i jeszcze trochę
tekstu.
   Opcja 'autoindent' wprowadza wcięcia automatycznie: >

	:set autoindent

Kiedy zaczyna się nowa linia dostaje takie samo wcięcie jak poprzednia linia.
W powyższym przykładzie <Tab> po <Enter> nie jest już dłużej potrzebny.


ZWIĘKSZANIE WCIĘCIA

Do zwiększenia ilości wcięć w wierszu użyj operatora ">". Często używany jest
jako ">>" co dodaje jedno wcięcie dla bieżącego wiersza.
   Wielkość wcięcia zależy od liczby określonej opcją 'shiftwidth'. Domyślną
wartością jest 8. Żeby ">>" wstawiał wcięcie o szerokości czterech spacji
wydaj polecenie: >

	:set shiftwidth=4

Po użyciu na drugiej linii przykładowego tekstu otrzymasz:

	pierwsza linia ~
	    druga linia ~

"4>>" zwiększy wcięcie czterech linii.


TABSTOP

Jeśli chcesz mieć wcięcia o wielokrotności 4, ustaw 'shiftwidth' na 4. Jednak
wciskając <Tab> cały czas masz wcięcie o szerokości 8 spacji. Aby to zmienić
ustaw opcję 'softtabstop': >

	:set softtabstop=4

W ten sposób klawisz <Tab> będzie wstawiał wcięcie o szerokości 4 spacji.
Jeśli są tam już cztery spacje zostanie użyty znak <Tab> (zachowując siedem
znaków). (Jeśli zawsze chcesz używać spacji, a nie znaków tabulacji użyj opcji
'expandtab'.)

	Note:
	Możesz ustawić opcję 'tabstop' na 4. Jednak jeśli będziesz edytować
	plik w innym czasie z 'tabstop' ustawionym domyślnie na 8 nie będzie
	to wyglądało dobrze. W innych programach i podczas drukowania
	indentacja także będzie zła. Z tego powodu lepiej zawsze mieć
	ustawione 'tabstop' na 8. Jest to wszędzie standardowa wartość.


ZMIANA TABULACJI

Otwierasz plik, który został napisany z 'tabstop' na 3. Wygląda to brzydko
w Vimie ponieważ używasz normalnego 'tabstop' - 8. Możesz to naprawić
ustawiając 'tabstop' na 3. Ale musiałbyś to robić za każdym razem edytowania
tego pliku.
   Vim może zmienić użycie tabspopów w pliku. Najpierw ustaw 'tabstop' tak,
żeby wcięcia dobrze wyglądały, potem użyj polecenia ":retab": >

	:set tabstop=3
	:retab 8

":retab" zmieni 'tabstop' na 8, a zmieniany tekst będzie wyglądał tak samo.
Zmienia ona "białe znaki" w znaki tabulacji i spacji odpowiednio. Możesz teraz
zapisać plik. Następnym razem wcięcia będą w porządku bez ustawiania opcji.
   Uwaga: podczas użycia ":retab" na programie, może on zmienić białe znaki
wewnątrz łańcuchów. Dlatego do dobrego zwyczaju należy użycie "\t" zamiast
prawdziwych znaków tabulacji.

==============================================================================
*25.4*	Długie linie

Czasami zdarza się edytować plik, który jest szerszy niż liczba kolumn
w oknie. Kiedy tak się zdarzy Vim zawija linie, żeby wszystko było widoczne na
ekranie.
   Jeśli wyłączysz opcję 'wrap' każda linia w pliku pokaże się jako jedna
linia na ekranie, a jej koniec znika po prawej stronie okna.
   Kiedy przejdziesz kursorem do znaku, którego nie widać, Vim przesunie
tekst, żebyś mógł go zobaczyć. To tak jakby przesunięcia poziomo kadru nad
tekstem.
   Domyślnie Vim nie pokazuje poziomego pasku przesuwu w GUI. Jeśli chcesz
taki dodać wydaj polecenie: >

	:set guioptions+=b

Poziomy pasek przesuwu pojawi się na dole okna Vima.

Jeśli nie masz paska przesuwu lub nie chcesz go używać możesz zastosować te
polecenia do przesuwania tekstu. Kursor zawsze pozostanie w tym samym miejscu,
ale cofnie się do widocznego tekstu jeśli jest to konieczne.

	zh		przesuń w prawo
	4zh		przesuń cztery znaki w prawo
	zH		przesuń połowę szerokości okna w prawo
	ze		przesuń w prawo i umieść kursor na końcu
	zl		przesuń w lewo
	4zl		przesuń cztery znaki w lewo
	zL		przesuń połowę szerokości okna w lewo
	zs		przesuń w lewo i umieść kursor na początku

Zobaczmy jak to działa na jednej linii tekstu. Kursor jest na "g" w "którego".
"bieżące okno" powyżej pokazuje, która część zdania jest obecnie widoczna.
"okna" poniżej pokazują, który tekst będzie widoczny po komendzie pokazanej po
lewej.

			       |<-- bieżące okno  -->|
		jakiś długi tekst, którego część jest widoczna ~
	ze	  |<--	    okno      -->|
	zH	   |<--      okno      -->|
	4zh		  |<--	    okno      -->|
	zh		     |<--      okno	 -->|
	zl		       |<--	 okno	   -->|
	4zl			  |<--	    okno      -->|
	zL				|<--	  okno      -->|
	zs			       |<--	 okno	   -->|


PORUSZANIE SIĘ PRZY WYŁĄCZONYM ZAWIJANIU

Kiedy 'wrap' jest wyłączone i tekst został przesunięty w poziomie możesz użyć
następujących komend, żeby przejść do znaku jaki widzisz. Tekst na prawo
i lewo od okna jest ignorowany. Po ich użyciu tekst nigdy nie zostanie
przesunięty:

	g0		do pierwszego widocznego znaku w linii
	g^		do pierwszego nie-białego znaku w linii
	gm		do środka linii
	g$		do ostatniego widocznego znaku w linii

		|<--	 okno      -->|
    jakiś długi     tekst, którego część jest widoczna ~
		 g0  g^    gm	     g$


ŁAMANIE WYRAZÓW 					*edit-no-break*

Podczas przygotowywania tekstu do użycia przez inny program być może chcesz
robić akapity bez złamanych linii. Wadą 'nowrap' jest to, że nie możesz
zobaczyć całego zdania nad którym pracujesz. Kiedy 'wrap' jest włączne, wyrazy
są podzielone w środku co czyni je trudniejszymi do odczytania.
   Dobrym rozwiązaniem do edycji takich akapitów jest włączenie opcji
'linebreak'. Vim łamie wtedy linie w odpowiednich miejscach, a tekst w pliku
zostaje niezmieniony.
   Bez 'linebreak' tekst wygląda tak:

	+---------------------------------+
	|program generujący list dla banku|
	|. Bank chciał wysłać specjalny li|
	|st do 1000 ich najbogatszych klie|
	|ntów. Niestety dla programisty mu|
	+---------------------------------+
Po: >

	:set linebreak

wygląda tak:

	+---------------------------------+
	|program generujący list dla      |
	|banku. Bank chciał wysłać        |
	|specjalny list do 1000 ich       |
	|najbogatszych klientów. Niestety |
	+---------------------------------+

Powiązane opcje:
'breakat' określa znaki, na których można złamać linię.
'showbreak' określa łańcuch, który ma być pokazany na początku zwiniętej
linii.
Ustaw 'textwidth' na zero, żeby uniknąć podziału akapitu.


PORUSZANIE SIĘ PO LINIACH EKRANOWYCH

Komendy "j" i "k" przenoszą do następnej i poprzedniej linii. Jeśli zostaną
użyte na długich liniach oznacza to przejście naraz wielu linii ekranowych.
   Żeby przejść tylko jedną linię ekranową użyj poleceń "gj" i "gk". Jeśli
linia nie jest zawinięta robią to samo co "j" i "k", jeśli jest, przeniosą
kursor na znak w linii poniżej lub powyżej.
   Być może zechcesz użyć mapowań, które wiążą te komendy z klawiszami
kursora: >

	:map <Up> gk
	:map <Down> gj


ZMIANA AKAPITU W JEDNĄ LINIĘ

Jeśli chcesz wyeksportować tekst do programu takiego jak MS-Word każdy akapit
powinien być jedną linią. Jeśli każdy akapit jest oddzielony pustą linią w ten
sposób możesz go przerobić na pojedynczy wiersz: >

	:g/./,/^$/join

Polecenie wygląda na skomplikowane. Rozbijmy je na kawałki:

	:g/./		Polecenie ":global", które znajduje wszystkie linie
			zawierające przynajmniej jeden znak.
	     ,/^$/	Zasięg, zaczynający się od bieżącej linii (nie
			pustej), a kończący na pustej linii.
		  join	Polecenie ":join" łączy zasięg linii razem w jeden
			wiersz.

Zaczynając od tego fragmentu zawierającego osiem linii złamanych na 30
kolumnie:

	+----------------------------------+
	|Zamówili program generujący list  |
	|dla banku. Bank chciał wysłać	   |
	|specjalny, spersonalizowany list. |
	|				   |
	|Do tysiąca ich najbogatszych	   |
	|klientów. Niestety, dla	   |
	|programisty			   |
	+----------------------------------+

Kończysz z dwoma wierszami:

	+----------------------------------+
	|Zamówili program generujący list d|
	|la banku. Bank chciał wysłać specj|
	|alny, spersonalizowany list.      |
	|Do tysiąca ich najbogatszych klien|
	|tów. Niestety, dla programisty    |
	+----------------------------------+

Uwaga: polecenie nie działa jeśli oddzielająca linia nie jest pusta tylko
zawiera białe znaki (spacje lub tabulatory). Następne polecenie będzie działać
z takimi liniami: >

	:g/\S/,/^\s*$/join

Cały czas wymagana jest pusta lub zawierająca tylko białe znaki linia na końcu
pliku by ostatni paragraf także został złączony.

==============================================================================
*25.5*	Edycja tablic

Przypuśćmy, że edytujesz tablicę z czterema kolumnami:

	ładna tabela	  test 1	test 2	      test 3 ~
	input A 	  0.534 ~
	input B 	  0.913 ~

Chcesz wprowadzić liczby w trzeciej kolumnie. Możesz przejść do drugiej linii,
użyć "A", wpisać dużo spacji i na końcu tekst.
   Dla tego rodzaju edycji istnieje specjalna opcja: >

	set virtualedit=all

Teraz przejdź kursorem tam gdzie nie ma jeszcze żadnego tekstu. Nazywa się to
"przestrzenią wirtualną". Dzięki temu edycja tablicy jest o wiele łatwiejsza.
   Przenieś kursor do nagłówka ostatniej kolumny: >

	/test 3

Wciśnij "j" i jesteś tam gdzie możesz wpisać wartość dla "input A". Po
wpisaniu "0.693" tablica wygląda tak:

	ładna tabela	  test 1     test 2	 test 3 ~
	input A 	  0.534			 0.693 ~
	input B 	  0.913 ~

Vim automatycznie uzupełnił przestrzeń przed tekstem, który właśnie wpisałeś.
Teraz, żeby wypełnić następne pole w kolumnie użyj "Bj". "B" cofa do początku
wyrazu oddzielonymi białymi znakami. "j" przenosi w dół, tam gdzie można
wypełnić następne pole.

	Note:
	Możesz umieścić kursor wszędzie na ekranie, także poza końcem linii.
	Vim jednak nie umieści tam spacji dopóki czegoś nie wpiszesz.


KOPIOWANIE KOLUMNY

Chcesz dodać kolumnę, która powinna być kopią trzeciej kolumny i umieszczona
przed kolumną "test 1". Robisz to w siedmiu krokach:
1.  Przenieś kursor do lewego górnego rogu tej kolumny, np.: "/test 3".
2.  Wejdź w tryb Visual Block za pomocą CTRL-V.
3.  Przenieś kursor o dwie linie w dół "2j". Jesteś teraz w "virtual space":
    linia "input B" kolumny "test 3".
4.  Przejdź kursorem w prawo, żeby włączyć całą kolumnę do wybranego obszaru,
    plus przstrzeń jaką chcesz by była między kolumnami. "9l" powinno
    starczyć.
5.  Skopiuj wybrany prostokąt "y".
6.  Przejdź kursorem do "test 1", gdzie chcesz umieścić nową kolumnę.
7.  Wciśnij "P".

Wynik to:

	ładna tabela	  test 3    test 1     test 2	   test 3 ~
	input A 	  0.693     0.534		   0.693 ~
	input B 		    0.913 ~

Zauważ, że cała kolumna "test 1" została przesunięta w prawo, także linia
gdzie kolumna "test 3" nie miała tekstu.

Wróć do nie-wirtualnych ruchów kursora:

	:set virtualedit=


WIRTUALNY TRYB REPLACE

Wadą 'virtualedit' jest odmienne "czucie". Nie możesz rozpoznać znaków
tabulacji lub spacji za końcem linii poruszając kursor. Można użyć innej
metody: wirtualny tryb Replace (Virtual Replace).
   Załóżmy, zę masz linię w tabeli, która zawiera zarówno znaki tabulacji jak
i inne znaki. Użyj "rx" na pierwszym znaku tabulacji:

	inp	0.693   0.534	0.693 ~

	       |
	   rx  |
	       V

	inpx0.693   0.534	0.693 ~

Tabela już nie wygląda tak ładnie. Żeby tego uniknąć użyj komendy "gr":

	inp	0.693   0.534	0.693 ~

	       |
	  grx  |
	       V

	inpx	0.693   0.534	0.693 ~

Co się stało? Zadaniem "gr" jest upewnienie się, że nowy znak zabierze
dokładnie tyle samo miejsca na ekranie. Dodatkowe spacje i tabulatory są
wstawiane, żeby wypełnić lukę. Tutaj znak tabulacji został zastąpiony przez
"x", a potem zostały dodane spacje, żeby tekst za x został w tym samym
miejscu. W tym wypadku wstawiono znak tabulacji.
   Kiedy chcesz zastąpić więcej niż jeden znak używasz komendy "R", żeby
przejść w tryb Replace (zobacz |04.9|). To znowu miesza rozkład tabeli
i zamienia niewłaściwe znaki:

	inp	0	0.534	0.693 ~

		|
	 R0.786 |
		V

	inp	0.78634	0.693 ~

Komenda "gR" wprowadza w tryb Virtual Replace i zachowuje wygląd tabeli:

	inp	0	0.534	0.693 ~

		|
	gR0.786 |
		V

	inp	0.786	0.534	0.693 ~

==============================================================================

Następny rozdział: |usr_26.txt|  Powtarzanie

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
