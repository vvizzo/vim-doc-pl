*usr_08.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00  2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar

				Dzielenie okna


Zobacz dwa różne pliki jeden nad drugim. Obejrzyj dwa miejsca w pliku w tym
samym czasie. Porównaj różnice między dwoma plikami przez umieszczenie ich
obok siebie. To wszystko jest możliwe dzięki dzieleniu okna.

|08.1|	Podział okna
|08.2|	Podział okna z innym plikiem
|08.3|	Wielkość okna
|08.4|	Pionowy podział
|08.5|	Przenoszenie okien
|08.6|	Polecenia dla wszystkich okien
|08.7|	Porównywanie z vimdiff
|08.8|	Różne

 Następny rozdział: |usr_09.txt|  GUI
Poprzedni rozdział: |usr_07.txt|  Edycja więcej niż jednego pliku
       Spis treści: |usr_toc.txt|

==============================================================================
*08.1*	Podział okna

Najprostszym sposobem otwarcia nowego okna jest polecenie: >

	:split

Dzieli ono ekran na dwa okna i pozostawia kursor w górnym:

	+----------------------------------+
	|/* plik jeden.c */		   |
	|~				   |
	|~				   |
	|jeden.c===========================|
	|/* plik jeden.c */		   |
	|~				   |
	|jeden.c===========================|
	|				   |
	+----------------------------------+

To co widzisz to dwa okna na ten sam plik. Linia z "====" to linia statusu.
Pokazuje informacje o oknie ponad nią.
   Dwa okna pozwalają zobaczyć dwie części tego samego pliku. Na przykład,
możesz w górnym oknie oglądać deklaracje zmiennych programu, a w dolnym kod,
który używa tych zmiennych.

Polecenie CTRL-Ww służy do skakania pomiędzy oknami. Jeśli jesteś w górnym
oknie, CTRL-Ww skoczy do dolnego i odwrotnie. (CTRL-W CTRL-W robi to samo na
wypadek gdybyś puścił CTRL trochę później).


ZAMKNIĘCIE OKNA

Do zamknięcia okna użyj polecenia: >

	:close

Właściwie, każde polecenie, które wychodzi z pliku działa -- ":quit" i "ZZ".
Ale ":close" powstrzymuje od przypadkowego zamknięcia Vima jeśli zamykałbyć
ostatnie okno.


ZAMYKANIE WSZYSTKICH INNYCH OKIEN

Jeśli masz otwarte kilka okien, ale chcesz skoncentrować się na jednym z nich
to polecenie będzie pożyteczne: >

	:only

Zamyka ono wszystkie okna z wyjątkiem bieżącego. Jeśli plik w którymkolwiek
z innych okien został zmieniony, dostaniesz komunikat błędu i to okno nie
zostanie zamknięte.

==============================================================================
*08.2*	Podział okna z innym plikiem

To polecenie otwiera drugie okno i zaczyna edycję podanego pliku: >
>
	:split dwa.c

Jeśli pracowałeś z jeden.c, rezultat będzie wyglądał tak:

	+----------------------------------+
	|/* plik dwa.c */		   |
	|~				   |
	|~				   |
	|dwa.c=============================|
	|/* plik jeden.c */		   |
	|~				   |
	|jeden.c===========================|
	|				   |
	+----------------------------------+

Aby otworzyć okno z nowym, pustym plikiem: >

	:new

Możesz powtarzać polecenia ":split" i ":new" tyle razy ile chcesz.

==============================================================================
*08.3*	Wielkość okna

Polecenie ":split" można poprzedzić argumentem liczbowym. Jeśli dodany,
oznacza wysokość nowego okna. Przykładowe polecenie otwiera okno wysokie na
trzy linie i zaczyna edycję pliku alfa.c: >

	:3split alfa.c

Rozmiar istniejących okien można zmienić na kilka różnych sposobów. Jeśli masz
działającą myszkę to proste: przenieś wskaźnik myszy na linię statusu
oddzielającą dwa okna i przeciągnij ją w górę lub w dół.

By zwiększyć wielkość okna: >

	CTRL-W +

Zmniejszyć: >

	CTRL-W -

Oba polecenia współpracują z mnożnikiem. Tak więc "4CTRL-W+" powiększa okno
o cztery linie.

By ustalić wysokość okna na konkretną wartość: >

	{wys.}CTRL-W_

Czyli: liczba {wys.}, CTRL-W i na końcu podkreślenie <Shift-->.
   Maksymalnie powiększone okno można uzyskać dzięki poleceniu CTRL-W_ bez
mnożnika.


MYSZ

W Vimie możesz zrobić wiele rzeczy bardzo szybko klawiaturą. Niestety, zmiana
wielkości okna wymaga trochę klepania. W tym przypadku użycie myszy jest
szybsze. Umieść wskaźnik myszy na linii statusu. Wciśnij lewy przycisk myszy
i przeciągnij. Linia statusu przemieści się robiąc jedno okno większe,
a drugie mniejsze.


OPCJE

Opcja 'winheight' określa minimalną pożądaną wysokość okna, a 'winminheight'
minimalną dozwoloną wysokość.
   Podobnie 'winwidth' określa minimalną pożądaną szerokość, a 'winminwidth'
minimalną dozwoloną szerokość.
   'equalalways' jeśli ustawiona powoduje, że Vim wyrównuje wielkości okien
jeśli okno jest otwierane lub zamykane.

==============================================================================
*08.4*	Pionowy podział

Polecenie ":split" tworzy nowe okno ponad bieżącym. Żeby pojawiło się obok
niego, po lewej stronie: >

	:vsplit

lub: >

	:vsplit two.c

Rezultat będzie wyglądał mniej więcej tak:

	+--------------------------------------+
	|/* plik dwa.c */   |/* plik jeden.c */|
	|~		    |~		       |
	|~		    |~		       |
	|~		    |~		       |
	|dwa.c===============jeden.c===========|
	|				       |
	+--------------------------------------+

Linia | na środku pojawi się jako negatyw. Nazywamy ją pionowym separatorem.
Rozdziela ona dwa okna na lewo i prawo.

Jest także polecenie ":vnew" służące pionowemu podziałowi okna na nowy, pusty
plik. Inny sposób: >

	:vertical new

Polecenie ":vertical" może być wstawione przed inne polecenie dzielące okno.
Spowoduje to podział pionowy okna, zamiast poziomego. Jeśli polecenie nie
dzieli okna zadziała nie zmodyfikowane.


PRZECHODZENIE MIĘDZY OKNAMI

Poniewać możesz dzielić okna pionowo i poziomo tak bardzo jak tylko chcesz
możesz stworzyć dowolny layout okien. Później możesz użyć te polecenia do
przechodzenia między oknami:

	CTRL-W h	przejdź do okna na lewo
	CTRL-W j	przejdź do okna poniżej
	CTRL-W k	przejdź do okna powyżej
	CTRL-W l	przejdź do okna na prawo

	CTRL-W t	przejdź do okna na szczycie (Top)
	CTRL-W b	przejdź do okna na dole (Bottom)

To są te same litery jakie służą do przemieszczania kursora. Możesz też użyć
klawiszy strzałek.
   Więcej poleceń o ruchach między oknami: |Q_wi|

==============================================================================
*08.5*	Przenoszenie okien

Podzieliłeś ekran na kilka okien, ale są teraz w złych miejscach. Potrzebujesz
poleceń by je poprzenosić. Masz, na przykład, takie trzy okna:

	+----------------------------------+
	|/* plik dwa.c */		   |
	|~				   |
	|~				   |
	|dwa.c=============================|
	|/* plik trzy.c */		   |
	|~				   |
	|~				   |
	|trzy.c==== =======================|
	|/* plik jeden.c */		   |
	|~				   |
	|jeden.c===========================|
	|				   |
	+----------------------------------+

Widać wyraźnie, że ostatnie okno powinno być na górze. Przejdź do tego
okna (CTRL-Ww) i wpisz: >

	CTRL-W K

Polecenie używa wielkiej litery K. Teraz okno wędruje na samą górę. Zauważ, że
to K jest użyte do ruchu do góry.
   Jeśli masz pionowe podziały, CTRL-W K przeniesie bieżące okno na szczyt
i spowoduje zajęcie przez niego całej szerokości ekranu. To jest twój layout:

	+-------------------------------------------+
	|/* dwa.c */  |/* trzy.c */   |/* jeden.c */|
	|~	      |~	      |~	    |
	|~	      |~	      |~	    |
	|~	      |~	      |~	    |
	|~	      |~	      |~	    |
	|~	      |~	      |~	    |
	|dwa.c=========trzy.c=========jeden.c=======|
	|					    |
	+-------------------------------------------+

Użycie teraz CTRL-W K w środkowym oknie (trzy.c) spowoduje:

	+-------------------------------------------+
	|/* trzy.c */				    |
	|~					    |
	|~					    |
	|trzy.c==== ================================|
	|/* dwa.c */	       |/* jeden.c */	    |
	|~		       |~		    |
	|dwa.c==================jeden.c=============|
	|					    |
	+-------------------------------------------+

Podobne trzy polecenia (niezbyt trudne do odgadnięcia):

	CTRL-W H	przenosi okno na lewy skraj
	CTRL-W J	przenosi okno na sam dół
	CTRL-W L	przenosi okno na prawy skraj

==============================================================================
*08.6*	Polecenia dla wszystkich okien

Kiedy masz otwartych kilka okien i chcesz wyjść z Vima, możesz wyjść z każdego
okna oddzielnie. Szybszym sposobem jest polecenie: >

	:qall

Oznacza ono ":quit all" (wyjdź ze wszystkich). Jeśli któreś z okien zawiera
zmiany Vim nie wyjdzie. Kursor automatycznie znajdzie się w oknie ze zmianami.
Możesz użyć albo ":write" do zachowania zmian, albo ":quit!" do ich
odrzucenia.

Jeśli wiesz, że są okna ze zmianami i chcesz je wszystkie zachować, użyj tego:
>
	:wall

Oznacza to ":write all" (zapisz wszystkie). Właściwie zapisuje ono tylko pliki
ze zmianami, Vim wie, że nie ma sensu zapisywania plików, które nie były
zmieniane.
   Jest też kombinacja poleceń ":qall" i ":wall": polecenie "zapisz i wyjdź ze
wszystkiego" (write and quit all): >

	:wqall

Zapisuje wszystkie zmodyfikowane pliki i wychodzi z Vima.
   W końcu jest polecenie, które wychodzi z Vima i odrzuca wszystkie zmiany: >

	:qall!

Ostrożnie, nie ma sposobu by to odwrócić!


PO OKNIE DLA ARGUMENTU

Aby Vim otworzył okno dla każdego pliku, zacznij z argumentem "-o": >

	vim -o one.txt two.txt three.txt

Efektem jest:

	+-------------------------------+
	|plik jeden.txt			|
	|~				|
	|jeden.txt======================|
	|plik dwa.txt			|
	|~				|
	|dwa.txt========================|
	|plik trzy.txt			|
	|~				|
	|trzy.txt=======================|
	|				|
	+-------------------------------+

Argument "-O" służy do uzyskania pionowych okien.
   Kiedy Vim już działa, polecenie ":all" otwiera po oknie dla każdego pliku
w liście argumentów. ":vertical all" robi to samo, ale z pionowym podziałem.

==============================================================================
*08.7*	Porównywanie z vimdiff

Istnieje specjalny sposób zainicjowania Vima, który pokaże różnice pomiędzy
dwoma plikami. Weź plik "main.c" i dodaj kilka znaków w jednej z linii.
Zapisz plik z ustawioną opcją 'backup', tak że powstanie plik "main.c~", który
zawiera poprzednią wersję pliku.
   Wprowadź polecenie w powłoce (nie w Vimie): >

	vimdiff main.c~ main.c

Vim pokaże dwa okna obok siebie. Zobaczysz tylko linię, w której wprowadziłeś
zmiany oraz kilka linii powyżej i poniżej.

	 VV		      VV
	+-----------------------------------------+
	|+ +--123 lines: /* a|+ +--123 lines: /* a|  <- fold
	|  tekst	     |	tekst		  |
	|  tekst	     |	tekst		  |
	|  tekst	     |	tekst		  |
	|  tekst	     |	zmieniony tekst	  |  <- zmieniona linia
	|  tekst	     |	tekst		  |
	|  tekst	     |	------------------|  <- usunięta linia
	|  tekst	     |	tekst		  |
	|  tekst	     |	tekst		  |
	|  tekst	     |	tekst		  |
	|+ +--432 lines: teks|+ +--432 lines: teks|  <- fold
	|  ~		     |	~		  |
	|  ~		     |	~		  |
	|main.c~==============main.c==============|
	|					  |
	+-----------------------------------------+

(Ten obrazek nie pokazuje podświetlania, użyj polecenia vimdiff dla lepszej
wizualizacji.)

   Linie, które nie były zmodyfikowane zostały zwinięte w jedną linię. To tak
zwany zwinięta fałda (closed fold). Na obrazku zostały zaznaczone "<- fold".
Pierwsza fałda, na górze, składa się z 123 linii. Te linie są identyczne w obu
plikach.
   Linia zaznaczona "<- zmieniona linia" jest podświetlona, a wprowadzony
tekst jest wyświetlony innym kolorem. Wyraźnie widać różnice między dwoma
plikami.
   Usunięta linia jest pokazana jako "---" w oknie main.c (spójrz na marker
"<- usunięta linia" na obrazku). Tych znaków tak naprawdę tam nie ma.
Wypełniają tylko main.c, żeby było tyle samo linii w obu oknach.


KOLUMNA FAŁDY

Każde okno ma po lewej kolumnę z innym tłem. Na obrazku jest to wskazane przez
"VV". Zauważ "+" przed każdą zamkniętą fałdą. Przenieś tam wksaźnik myszy
i wciśnij lewy przycisk myszy. Fałda się otworzy, a ty będziesz mógł zobaczyć,
który zawiera.
   Kolumna fałdy zawiera znak "-" dla otwartej fałdy, jeśli na nim klikniesz
fałda się zamknie.
   Oczywiście działa to tylko wtedy jeśli masz działającą mysz. Do otwarcia
fałdy służy też "zo" (z open), a do zamknięcia "zc" (z close).


DIFF I VIM

Możesz też zacząć tryb diff wewnątrz Vima. Otwórz "main.c", a potem podziel
okno tak by pokazać różnice: >

	:edit main.c
	:vertical diffsplit main.c~

Polecenie ":vertical" zostało dodane po to by okno podzieliło się pionowo.
Jeśli je pominiesz, podział będzie poziomy.

Jeśli masz łatę lub plik diff istnieje trzeci sposób rozpoczęcia trybu diff.
Otwórz plik, do którego masz łatę. Potem przekaż Vimowi nazwę łaty: >

	:edit main.c
	:vertical diffpatch main.c.diff

UWAGA: Plik łaty może zawierać tylko jedną łatę, dla pliku który edytujesz.
W innym wypadku otrzymasz dużo komunikatów błędu, a niektóre pliki mogą zostać
połatane niespodziewanie.
   Łatanie zostanie zrobione tylko na kopii pliku w Vimie. Plik na dysku
twardym pozostanie nie zmieniony (dopóki nie zdecydujesz się go zapisać).


ZSYNCHRONIZOWANE PRZEWIJANIE

Kiedy pliki mają więcej zmian możesz przewijać normalnie. Vim spróbuje
przewijać je tak by zmiany były widoczne obok siebie.
   Jeśli nie chcesz tego: >

	:set noscrollbind


SKOK DO ZMIAN

Jeśli w jakiś sposób wyłączyłeś fałdowanie znajdowanie zmian może być
utrudnione. Użyj tego do skoku naprzód do następnej zmiany: >

	]c

W drugą stronę: >

	[c

Dodaj mnożnik by skoczyć dalej.


USUWANIE ZMIAN

Możesz przenosić tekst z jednego okna do drugiego. To albo usuwa różnice, albo
dodaje nowe. Vim nie zawsze uaktualnia różnice na bieżąco. By się upewnić, że
wszystko jest uaktualnione: >

	:diffupdate

By usunąć różnicę możesz przenieść podświetlony tekst z jednego do drugiego.
Weźmy powyższy przykład z "main.c" i "main.c~". Przenieś kursor do lewego
okna, na linię, która była usunięta z drugiego. Wpisz: >

	dp

Zmiana zostanie usunięta przez wpakowanie tekstu z bieżącego okna do drugiego.
"dp" oznacza "diff put".
   Możesz to zrobić w drugą stronę. Przenieś kursor do prawego okna, do linii
gdzie "zmieniony" było wstawione. Wpisz: >

	do

Zmiana zostanie usunięta przez pobranie tekstu z drugiego okna. Ponieważ nie
pozostały teraz żadne zmiany, Vim wpakuje cały tekst do zamkniętej fałdy. "do"
oznacza "diff obtain". "dg" byłoby lepsze, ale już ma całkiem inne znaczenie
("dgg" usuwa od kursora do pierwszej linii).

Więcej o trybie diff, zobacz |vimdiff|.

==============================================================================
*08.8*	Różne

Opcja 'laststatus' służy do określenia kiedy ostatnie okno ma linię statusu:

	0	nigdy
	1	tylko wtedy gdy są podzielone okna (domyślne)
	2	zawsze

Wiele poleceń, które otwierają inny plik mają wariant, który dzieli okno. Dla
linii poleceń robione jest to przez dodanie na początku litery "s". Na
przykład: ":tag" skacze do znacznika, ":stag" dzieli okno i skacze do
znacznika.
   Dla poleceń trybu Normal dodaje się CTRL-W. CTRL-^ skacze do pliku
zamiennego, CTRL-W CTRL-^ dzieli okno i skacze do pliku zamiennego.

Opcja 'splitbelow' może być ustawiona, żeby nowe okno pojawiało się poniżej
bieżącego. Opcja 'splitrihgt' może być ustawiona, żeby przy podziale pionowym
okno pojawiało się po prawej stronie.

Kiedy dzielisz okno możesz dodać polecenie modyfikujące, które określi gdzie
okno ma się pojawić:

	:leftabove {cmd}	po lewej lub powyżej bieżącego okna
	:aboveleft {cmd}	j.w.
	:rightbelow {cmd}	na prawo lub poniżej bieżącego okna
	:belowright {cmd}	j.w.
	:topleft {cmd}		na szczycie lub po lewej okna Vima
	:botright {cmd}		na dole lub po prawej okna Vima

==============================================================================

Następny rozdział: |usr_09.txt|  GUI

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
