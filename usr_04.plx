*usr_04.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 Małe zmiany


Ten rozdział przedstawia kilka sposobów poprawiania tekstu i manewrowania nim.
Uczy trzech podstawowych sposobów zmiany tekstu: operator-ruch, trybu
Visual i obiektów tekstowych.

|04.1|	Operatory i ruchy
|04.2|	Zmiana tekstu
|04.3|	Powtarzanie zmiany
|04.4|	Tryb Visual
|04.5|	Przenoszenie tekstu
|04.6|	Kopiowanie tekstu
|04.7|	Używanie schowka
|04.8|	Obiekty tekstowe
|04.9|	Tryb Replace
|04.10|	Podsumowanie

 Następny rozdział: |usr_05.txt|  Personalizacja ustawień Vima
Poprzedni rozdział: |usr_03.txt|  Poruszanie się
       Spis treści: |usr_toc.txt|

==============================================================================
*04.1*	Operatory i ruchy

W rozdziale drugim nauczyłeś się jak użyć "x" do usunięcia pojedynczego znaku.
A także używania mnożnika: "4x" usuwa 4 znaki.
   Polecenie "dw" usuwa wyraz. Być może rozpoznajesz komendę "w" jako
polecenie ruchu o jeden wyraz. Komendę "d" można uzupełnić każdym poleceniem
ruchu i usunie ona tekst od obecnego położenia kursora do tego gdzie skieruje
go owo polecenie ruchu.
   Na przykład polecenie "4w" przesuwa kursor o 4 wyrazy. Polecenie "d4w"
usuwa 4 wyrazy.

	To err is human. To really foul up you need a computer. ~
			 ------------------>
				 d4w

	To err is human. you need a computer. ~

Vim usuwa tylko do miejsca gdzie znajdzie się kursor. Dzieje się tak dlatego,
ponieważ Vim przyjmuje, że prawdopodobnie nie chcesz usuwać pierwszego znaku
wyrazu. Jeśli użyjesz komendy "e" by przejść do końca wyrazu Vim przyjmie, że
w tym wypadku chcesz włączyć ostatni znak:

	To err is human. you need a computer. ~
			-------->
			   d2e

	To err is human. a computer. ~

Czy znak pod kursorem jest włączony zależy od komendy, której użyłeś od
przejścia do znaku. "Reference Manual" nazywa to "exclusive" jeśli znak nie
jest włączany i "inclusive" jeśli jest włączony.

Komenda "$" przenosi na koniec linii. Polecenie "d$" usuwa znaki od kursora do
końca linii. Jest to ruch włączający ponieważ ostatni znak linii jest włączony
do operacji usuwającej:

	To err is human. a computer. ~
		       ------------>
			    d$

	To err is human ~

Istnieje tu wzorzec: operator-ruch. Najpierw wpisujesz operator. Na przykład
"d" jest operatorem usuwania. Potem wydajesz polecenie ruchu np. "4l" lub "w".
W ten sposób możesz operować na każdym tekście do którego możesz dojść.

==============================================================================
*04.2*	Zmiana tekstu

Innym operatorem jest "c", change (ang. zmiana). Działa dokładnie tak samo jak
operator "d" z wyjątkiem tego, że kończysz w trybie Insert. Na przykład, "cw"
zmienia wyraz. Dokładniej - usuwa wyraz i zmienia tryb na Insert.

	To err is human ~
	   ------->
	  c2wbe<Esc>

	To be human ~

Polecenie"c2wbe<Esc>" zawiera następujące elementy:

	c	operator zmiany
	2w	przejdź 2 wyrazy (są usuwane i zaczyna się tryb Insert)
	be	wprowadza ten tekst
	<Esc>	wraca do trybu Normal

Jeśli uważałeś, zauważysz coś dziwnego: spacja przed "human" nie została
usunięta. Mówi się, że na każdy problem istnieje rozwiązanie, które jest
proste, jasne i nieprawidłowe. Tak jest z poleceniem "cw". Operator c działa
tak jak operator d z wyjątkiem na polecenie "cw". Działa ono bardziej jak
"ce", zmiana do końca wyrazu. Z tego powodu spacja nie jest włączana. Jest to
wyjątek, którego istnienie datuje się od starego Vi. Ponieważ wielu ludzi jest
do tego przyzwyczajonych, niespójność została zachowana w Vimie.


WIĘCEJ ZMIAN

Tak jak "dd" usuwa całą linię, "cc" zmienia całą linię, ale zachowuje wcięcie
linii (białe znaki na początku linii).

Podobnie jak "d$" usuwa do końca linii, "c$" zmienia do końca linii. To jakby
użyć "d$" by usunąć tekst, a potem użyć "a" by zacząć tryb Insert i dodać nowy
tekst.


SKRÓTY

Niektóre polecenia operator-ruch są używane na tyle często, że mają
odpowiedniki jednoliterowe:

	x  działa jak  dl  (usuwa znak pod kursorem)
	X  działa jak  dh  (usuwa znak na lewo od kursora)
	D  działa jak  d$  (usuwa tekst do końca linii)
	C  działa jak  c$  (zmienia tekst do końca linii)
	s  działa jak  cl  (zmienia jeden znak)
	S  działa jak  cc  (zmienia całą linię)


GDZIE WSTAWIĆ MNOŻNIK

Polecenie takie jak "3dw" i "d3w" usuwają trzy wyrazy. Jeśli jesteś naprawdę
zainteresowany w szczegółach to pierwsze polecenie "3dw" usuwa jeden wyraz
3 razy; "d3w" usuwa 3 słowa za jednym zamachem. Niezauważalna różnica. Możesz
nawet użyć dwóch mnożników. Na przykład "3d2w" usuwa 2 wyrazy powtórzone
3 razy co daje w efekcie 6 usuniętych wyrazów.


ZAMIANA JEDNEGO ZNAKU

Komenda "r" nie jest operatorem. Czeka żebyś wpisał znak i zamienia nim znak
pod kursorem. Możesz to zrobić poleceniami "cl" lub "s", ale używając "r" nie
musisz potem wciskać <Esc>

	coś tam jest pardzo zle.~
	rC	     rb     rź

	Coś tam jest bardzo żle.~

Użycie mnożnika z "r" powoduje zatąpienie tylu znaków ile wynosiła wartość
mnożnika tym samym znakiem.  Przykład:

	Coś tam jest bardzo żle.~
		     6rx

	Coś tam jest xxxxxx żle.~

By zastąpić znak przejściem do nowej linii użyj "r<Enter>". Polecenie to usuwa
znak pod kursorem i wstawia znak nowej linii. Użycie tu mnożnika zadziała
wyłącznie na znaki: "4r<Enter>" zastąpi cztery znaki jednym znakiem nowej
linii.

==============================================================================
*04.3*	Powtarzanie zmiany

Komenda "." jest jedną z najpotężniejszych, a równocześnie najprostszych
komend Vima. Powtarza ona ostatnią zmianę. Dla przykładu przypuśćmy, że
edytujesz plik HTML i chcesz usunąć wszystkie znaczniki <B>. Umieszczasz
kursor na pierwszym < i usuwasz <B> poleceniem "df>". Następnie idziesz do
< zamykającego znacznika </B> i usuwasz go komendą ".". "." wykonuje ostatnie
polecenie zmiany (w tym wypadku "df>"). By usunąć inny znacznik, umieść
kursor na < i użyj znów polecenia ".".

			      To <B>generate</B> a table of <B>contents ~
     f<   znajdź pierwsze  <  --->
     df>  usuń do          >	 -->
     f<   znajdź następne  <	   --------->
     .    powtórz          df>		    --->
     f<   znajdź następne  <		       ------------->
     .    powtórz          df>				    -->

Komenda "." działa dla wszystkich zmian jakie zrobiłeś z wyjątkiem: "u"
(undo), CTRL-R (redo) i poleceń, które zaczynają się dwukropkiem (":").

Inny przykład: Chcesz zmienić wyraz "cztery" na "pięć". Pojawia się on kilka
razy w tekście. Możesz to zrobić szybko prostą sekwencją poleceń:

	/cztery<Enter>	znajdź pierwsze wystąpienie "cztery"
	cwpięć<Esc>	zmień wyraz na "pięć"
	n		znajdź następne "cztery"
	.		powtórz zmianę na "pięć"
	n		znajdź następne "cztery"
	.		powtórz zmianę
			itd.

==============================================================================
*04.4*	Tryb Visual

Dla usuwania prostych rzeczy metoda operator-ruch działa całkiem dobrze. Ale
często nie jest łatwo zdecydować, które polecenie zadziała na tekście, który
chcesz zmienić. Wtedy możesz użyć trybu Visual.

Tryb Visual zaczyna się wciśnięciem "v". Przenosisz kursor na tekst, nad
którym chcesz pracować. W czasie kiedy to robisz tekst jest podświetlany.
Ostatecznie wydajesz komendę operatora.
   Na przykład by usunąć z połowy jednego wyrazu do połowy innego:

		This is an examination sample of visual mode ~
			       ---------->
				 velllld

		This is an example of visual mode ~

Robiąc to nie musisz liczyć ile razy trzeba wcisnąć "l" by zakończyć ruch na
prawidłowej pozycji. Natychmiast widzisz tekst, który będzie usunięty po
wciśnięciu "d".

Jeśli w którymś momencie zdecydujesz, że nie chcesz nic robić z podświetlonym
tekstem wystarczy wcisnąć <Esc> i tryb Visual zakończy się bez efektów.


WYBIERANIE LINII

Jeśli chcesz pracować na całych liniach użyj "V" do rozpoczęcia trybu Visual.
Zobaczysz od razu podświetloną całą linię, bez przemieszczania kursora. Kiedy
będziesz się ruszał w lewo lub prawo nic się nie będzie działo. Ale kiedy
ruszysz do góry lub w dół wybór jest rozszerzony od razu na całe linie.
   Na przykład, wybierz trzy linie "Vjj":

			  +------------------------+
			  | tekst więcej tekst	   |
		       >> | więcej tekst więcej    | |
         Wybrane linie >> | tekst tekst tekst	   | | Vjj
		       >> | tekst więcej	   | V
			  | więcej tekst więcej	   |
			  +------------------------+


WYBIERANIE BLOKÓW

Jeśli chcesz pracować na prostokątnych blokach znaków użyj CTRL-V by zacząć
tryb Visual. Bardzo użyteczna rzecz jeśli pracujesz na tabelach.

		name		Q1	Q2	Q3
		pierre		123	455	234
		john		0	90	39
		steve		392	63	334

Do usunięcia środkowej kolumny "Q2" przenieś kursor na "Q" w "Q2". Wciśnij
CTRL-V by rozpocząć blokowy tryb Visual. Teraz przenieś kursor 3 linie w dół
"3j" i do następnego wyrazu "w". Teraz widzisz, że pierwszy znak następnej
kolumny jest włączony. By go wykluczyć wciśnij "h". Teraz wciśnij "d" i już
nie ma środkowej kolumny.


PRZEJŚCIE DO ODWROTNEGO KOŃCA

Jeśli wybrałeś jakiś tekst w trybie Visual i odkryłeś, że potrzebujesz coś
zmienić w drugim końcu wyboru użyj komendy "o" (o jak odwrotny koniec lub jak
other, ang. inny). Kursor przejdzie do odwrotnego końca i możesz zmieniać
zasięg selekcji tam gdzie się zaczynał. Ponowne wciśnięcie "o" przenosi cię
z powrotem na odwrotny koniec.

W czasie używania selekcji blokowej masz cztery rogi. "o" zabierze cię tylko
do tego z rogów, którzy znajduje się po przekątnej. Użyj "O" by przenieść się
do innego rogu w tej samej linii.

Note: W trybie Visual "o" i "O" działa zupełnie inaczej niż w trybie Normal
gdzie służą one do otwierania nowych linii.

==============================================================================
*04.5*	Przemieszczanie tekstu

Jeśli usuwasz coś komendami "d", "x". lub innymi tekst jest zachowywany.
Możesz do wpakować z powrotem używając komendy p. (Vim nazywa to put -- ang.
umieszczać, pakować).
   Sprawdźmy jak to działa. Najpierw usuwasz całą linię umieszczając kursor na
linii, którą chcesz usunąć i wydajesz polecenie "dd". Teraz przenosisz kursor
tam gdzie chcesz wpakować linię i używasz komendy "p" (put, pakować). Linia
jest wstawiona w linię pod kursorem.

	linia		linia	      linia
	linia 2	  dd	linia 3	  p   linia 3
	linia 3			      linia 2

Ponieważ usunąłeś całą linię, komenda "p" wpakuje tekst do linii poniżej
kursora. Jeśli usuniesz część linii (wyraz na przykład), komenda "p" upakuje
usunięty tekst tuż za kursorem.

	Więcej tekstu nudnego do wypróbowania poleceń.~
	       ------>
		 dw

	Więcej nudnego do wypróbowania poleceń.~
	      -------->
		welp

	Więcej nudnego tekstu do wypróbowania poleceń.~


WIĘCEJ O UPAKOWYWANIU

Komenda "P" upakuje tekst podobnie jak "p", ale przed kursorem. Kiedy usuniesz
całą linię z "dd", "P" wpakuje ją z powrotem powyżej kursora. Kiedy usuniesz
wyraz z "dw", "P" wpakuje go z powrotem tuż przed kursorem.

Możesz powtarzać upakowywanie tak wiele razy jak chcesz. Zostanie użyty ten
sam tekst.

Z "p" i "P" można też użyć mnożnika. Tekst będzie powtórzony tak wiele razy
jak będzie na to wskazywał mnożnik. Tak więc "dd" a potem "3p" wpakuje trzy
kopie tej samej, usuniętej linii.


ZAMIANA DWÓCH ZNAKÓW

Często w czasie pisania palce wyprzedzają umysł (albo odwrotnie?). Rezultatem
są literówki takie jak "nei" zamiast "nie". W Vimie bardzo łatwo usunąć
problem tego typu. Przesuń kursor na e w "nei" i wydaj polecenie "xp". Działa
ono tak: "x" usuwa znak e i umieszcza go w rejestrze. "p" pakuje tekst za
kursor, czyli za i.

	nei     ni     nie~
	 x       p

==============================================================================
*04.6*	Kopiowanie tekstu

Aby skopiować tekst z jednego miejsca do drugiego możesz go usunąć, użyć "u"
do odwrócenia zmiany i w końcu "p" do wpakowania tekstu gdzie indziej. Jest
prostszy sposób: yankowanie (ang. yanking). Operator "y" kopiuje tekst do
rejestru. Potem komenda "p" może być użyta do wpakowania go do tekstu.
   Yankowanie jest nazwą Vima nadaną kopiowaniu. Litera "c" była już użyta
jako operator zmiany, a "y" wolna. Nazwanie tego operatora "yank" ma służyć
łatwiejszemu zapamiętaniu klawisza "y".

Ponieważ "y" jest operatorem możesz użyć "yw" do yankowania wyrazu. Mnożnik
jak zwykle jest do usług. Do yankowania dwóch wyrazów użyj "y2w". Przykład:

	let sqr = DługaZmienna * ~
		 -------------->
		       y2w

	let sqr = DługaZmienna * ~
			       p

	let sqr = DługaZmienna * DługaZmienna ~

Pamiętaj, że "yw" włącza biały znak po wyrazie. Jeśli tego nie chcesz, użyj
"ye".

Komenda "yy" yankuje całą linię, tak jak "dd" usuwa całą linię. Niespodzianka!
Podczas gdy "D" usuwa linię od kursora do końca linii, "Y" działa tak jak
"yy", yankuje całą linię. Uważaj na tę niezgodność! Użyj "y$" do yankowania
tekstu do końca linii.

	linia tekstu     yy	linia tekstu           linia tekstu
	linia 2			linia 2		p      linia 2
	ostatnia linia		ostatnia linia	       linia tekstu
						       ostatnia linia

==============================================================================
*04.7*	Używanie schowka

Jeśli używasz wersji GUI (gvim) możesz znaleźć opcję "Copy" (Kopiuj) w menu
"Edit" (Edycja). Najpier zaznacz trochę tekstu w trybie Visual, później użyj
menu Edit/Copy (Edycja/Kopiuj). Zaznaczony tekst jest teraz skopiowany do
schowka.  Możesz przenieść tekst ze schowka do innych programów, także do
samego Vima.

Jeśli skopiowałeś tekst do schowka w innej aplikacji, możesz umieścić go
w Vimie z menu Edit/Paste. Działa w trybach Normal i Insert. W trybie
Visual tekst umieszczany zastępuje zaznaczony.

Menu "Cut" usuwa tekst zanim zostanie on umieszczony w schowku. Opcje "Copy",
"Cut" (Wytnij) i "Paste" (Wklej) są dostępne także w menu kontekstowym
(oczywiście tylko wtedy gdy jest ono dostępne). Jeśli twój Vim ma pasek
narzędzi także tam możesz znaleźć te opcje.

Jeśli nie używasz GUI lub nie lubisz używania menu masz inne sposoby. Do tego
służą komendy "y" (yank) i "p" (put), ale poprzedzone "* (podwójny cudzysłów,
gwiazdka). By skopiować linię do schowka: >

	"*yy

Do wpakowania tekstu ze schowska do tekstu: >

	"*p

Działa to tylko wtedy jeśli twoja wersja Vima wspiera schowek. Więcej
o schowku w sekcji |09.3| i tu: |clipboard|.

==============================================================================
*04.8*	Obiekty tekstowe

Jeśli kursor jest w środku wyrazu, a chcesz usunąć to słowo musisz cofnąć się
do początku wyrazu by zrobić "dw". Jest na to prostszy sposób: "daw".

	to jest przykładowy tekst. ~
		       daw

	to jest tekst.~

"d" w "daw" jest operatorem usunięcia.  "aw" jest obiektem tekstowym.
Wskazówka: "aw" oznacza "A Word". W sumie "daw" oznacza "Delete A Word". Żeby
być precyzyjnym biały znak po wyrazie także jest usuwany (biały znak przed
wyrazem jeśli wyraz jest na końcu wiersza).

Użycie obiektów tekstowych jest trzecim sposobem robienia zmian w Vimie. Znamy
już operator-ruch i tryb Visual. Do tego dodamy operator-obiekt tekstowy.
   Jest to bardzo podobne do operator-ruch, ale zamiast operowania na tekście
pomiędzy pozycją kursora i zasięgiem polecenia ruchu, będzie użyty obiekt
tekstowy. Nie ma znaczenia gdzie w obiekcie znajduje się kursor.

Do zmiany całego zdania (sentencji - ang. sentence) służy "cis":

	Witajcie. To jest~
	trochę tekstu.  Po prostu ~
	trochę tekstu. ~

Teraz przejdź na początek drugiej linii, na "trochę tekstu" i użyj "cis":

	Witajcie.   Po prostu ~
	trochę tekstu. ~

Kursor znajduje się pomiędzy białymi znakami w pierwszej linii. Teraz możesz
wpisać now zdanie "Inna linia.":

	Witajcie. Inna linia. Po prostu ~
	trochę tekstu. ~

"cis" składa się z operatora "c" (change - zmiana) i obiektu tekstowego "is".
Tłumaczy się to na "Inner Sentence" (wewnętrzne zdanie). Jest także obiekt
"as" (a sentence). Różnica polega na tym, że "as" włącza biały znak po
zdaniu, a "is" nie. Jeśli chcesz usunąć zdanie, prawdopodobnie chcesz usunąć
biały znak w tym samym czasie - użyj "das". Jeśli chcesz wpisać nowy tekst
biały znak może zostać - "cis".

Można także używać obiektów tekstowych w trybie Visual. Włączy on obiekty
tekstowe do selekcji. Tryb Visual będzie kontynuowany, dlatego możesz to
powtórzyć kilka razy. Na przykład zacznij tryb Visual z "v" i wybierz zdanie
z "as". Teraz powtórz "as" by dołączyć więcej zdań. Na koniec użyj operatora
do zrobienia czegoś z wybranymi zdaniami.

Długą listę obiektów tekstowych możesz znaleźć tu: |text-objects|.

==============================================================================
*04.9*	Tryb Replace

Komenda "R" powoduje przejście Vima w tryb Replace (zamiana). W tym trybie
każdy znak jaki wpiszesz zamienia znak pod kursorem dopóki nie wydasz komendy
<Esc>.
   W tym przykładzie zaczynasz tryb Replace na pierwszym "t" w "text":

	To jest tekst.~
		Rowarzystwo.<Esc>

	To jest towarzystwo.~

Pewnie zauważyłeś, że ta komenda zamieniła 5 znaków w linii na 12 innych.
Komenda "R" automatycznie powiększa linię jeśli skończyły się znaki do
podmiany. Tryb jednak nie będzie kontynuowany w następnej linii.

Możesz przełączać się między trybami Insert i Replace klawiszem <Insert>.

Kiedy użyjesz <BS> do zrobienia poprawki, stary tekst zostanie przywrócony.
Działa to podobnie jak komenda undo dla ostatniego wpisanego znaku.

==============================================================================
*04.10*	Podsumowanie

Operatory, komendy ruchu i obiekty tekstowe dają ci możliwość wielu
kombinacji. Skoro teraz wiesz jak to pracuje możesz użyć N operatorów razem
z M komend ruchu by uzyskać N * M poleceń!

Listę operatorów możesz znaleźć tu: |operator|.

Jest wiele sposobów by usunąć fragment tekstu. Tu są najczęściej używane:

x	usuwa znak pod kursorem         (skrót dla "dl")
X	usuwa znak przed kursorem       (skrót dla"dh")
D	usuwa od kursora do końca linii (skrót dla "d$")
dw	usuwa od kursora do początku następnego wyrazu
db	usuwa od kursora do poprzedniego początku wyrazu
diw	usuwa wyraz pod kursorem        (wyłączając biały znak)
daw	usuwa wyraz pod kursorem        (włączając biały znak)
dG	usuwa wszystko do końca pliku
dgg	usuwa wszystko do początku pliku

Gdy użyjesz "c" zamiast "d" będą to zmiany, a z "y" będziesz kopiował tekst,
itd.

Jest kilka często używanych komend do wprowadzania zmian, które nie pasują
nigdzie indziej:

	~	zmień wielkość litery pod kursorem i przenieś kursor do
		następnego znaku. To nie jest operator (dopóki 'tildeop' nie
		jest ustawiona), dlatego nie możesz tego użyć jako polecenia
		ruchu. Działa w trybie Visual i zmienia wielkość liter dla
		całego wybranego tekstu.

	I 	Zaczyna tryb Insert po przeniesieniu kursora do pierwszego
		znaku w linii nie będącego białym znakiem.

	A 	Zaczyna tryb Insert po przeniesieniu kursora do końca linii.

==============================================================================

Następny rozdział: |usr_05.txt|  Personalizacja ustawień Vima

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
