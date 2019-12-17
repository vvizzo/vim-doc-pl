*usr_09.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				     GUI


Vim pracuje w zwykłym terminalu. GVim może robić to samo i parę rzeczy więcej.
GUI oferuje menu, pasek narzędzi, paski przesuwu itd. Ten rozdział jest o tych
ekstra dodatkach, które oferuje GUI.

|09.1|	Części GUI
|09.2|	Mysz
|09.3|	Schowek
|09.4|	Tryb Select

 Następny rozdział: |usr_10.txt|  Duże zmiany
Poprzedni rozdział: |usr_08.txt|  Podział okna
       Spis treści: |usr_toc.txt|

==============================================================================
*09.1*	Części GUI

Być może masz ikonę na pulpicie, która inicjuje gVima. Jeśli nie, możesz to
zrobić tak: >

	gvim plik.txt
	vim -g plik.txt

(Jeśli nie działa nie masz wersji Vima wspierającej GUI. Musisz najpierw ją
zainstalować.)
   Vim otworzy okno i pokaże w nim "plik.txt". Jak okno wygląda, zależy od
wersji Vima. Powinno przypominać ten obrazek (na ile to możliwe używając
ASCII!).

+----------------------------------------------------+
| plik.txt + (~/dir) - VIM			   X |	<- pasek tytułu
+----------------------------------------------------+
| File	Edit  Tools  Syntax  Buffers  Window  Help   |	<- pasek menu
+----------------------------------------------------+
| aaa  bbb  ccc  ddd  eee  fff	ggg  hhh  iii  jjj   |	<- pasek narzędzi
| aaa  bbb  ccc  ddd  eee  fff	ggg  hhh  iii  jjj   |
+----------------------------------------------------+
| tekst pliku					 | ^ |
| ~						 | # |
| ~						 | # |	<- pasek przewijania
| ~						 | # |
| ~						 | # |
| ~						 | # |
|						 | V |
+----------------------------------------------------+

Największa przestrzeń jest zajmowana przez tekst pliku. Jest on pokazany
identycznie jak na terminalu. Możliwe, że z innymi kolorami i fontami.


PASEK TYTUŁU

Na samym szczycie jest pasek tytułu. Jest on tworzony przez system. Vim ustawi
tytuł by pokazać nazwę bieżącego pliku. Na początku jest nazwa pliku. Potem
kilka znaków specjalnych i katalog pliku w nawiasach. Znaki specjalne to:

	-	Plik nie może być zmieniony (np. pliki pomocy)
	+	Plik zawiera zmiany
	=	Plik jest tylko do odczytu
	=+	Plik jest tylko do odczytu, ale zawiera zmiany

Jeśli nie ma żadnych znaków, masz normalny, nie zmieniony plik.


PASEK MENU

Wiesz jak pracują menu, prawda? Vim ma tradycyjne opcje, plus kilka
dodatkowych. Przejrzyj je, żeby się zorientować co masz do dyspozycji.
Odpowiednie submenu masz w Edit/Global Settings (Edycja/Ustawienia globalne).
Zobaczysz:

   Toggle Toolbar		włączanie/wyłączanie paska narzędzi
	(Pasek narzędzi)
   Toggle Bottom Scrollbar	wł./wył. paska przewijania na dole
	(Dolny przewijacz)
   Toggle Left Scrollbar	wł./wył. paska przewijania po lewej
	(Lewy przewijacz)
   Toggle Right Scrollbar	wł./wył. paska przewijania po prawej
	(Prawy przewijacz)

Na większości systemów możesz oderwać menu. Wybierz najwyższy przedmiot
z menu, ten który wygląda jak przerywana linia. Uzyskasz oddzielne okno
z przedmiotami z menu. Pozostanie widoczne dopóko go nie zamkniesz.


PASEK NARZĘDZI

Zawiera ikony dla najczęściej używanych akcji. Ikony są zrozumiałe same przez
się (mam nadzieję). Są też dymki dla uzyskania podpowiedzi (przenieś wskaźnik
myszy na ikonę bez klikania i nie ruszaj jej przez sekundę).

Menu "Edit/Global Settings/Toggle Toolbar" (Edycja/Ustawienia globalne/Pasek
narzędzi) może być użyty do wyłączenia paska narzędzi. Jeśli nie chcesz by
pasek w ogóle się pojawiał dodaj do pliku vimrc: >

	:set guioptions-=T

Polecenie to usuwa flagę 'T' z opcji 'guioptions'.  Inne części GUI mogą także
być włączane lub wyłączane poprzez tę opcję. Zobacz pomoc dla niej.


PASKI PRZESUWU

Domyślnie jest jeden pasek przesuwu po prawej stronie. Robi rzeczy oczywiste.
Jeśli podzielisz okno, każde z okien dostanie swój własny pasek przesuwu.
   Możesz dodać z menu "Edit/Global Settings/Toggle Bottom Scrollbar"
(Edycja/Ustawienia globalne/Dolny przewijacz) poziomy pasek przesuwu. Jest
użyteczny w trybie diff lub kiedy opcja 'wrap' została zresetowana (więcej
o tym później).

Kiedy okna są podzielone pionowo tylko okno po prawej stronie ma pasek
przesuwu. Jednak jeśli przeniesiesz kursor do okna po lewej, pasek przesuwu
zostanie w tym samym miejscu, ale będzie kontrolował inne okno. Zajmie ci
trochę czasu przyzwyczajenie się do tego.
   Kiedy pracujesz z oknami podzielonymi pionowo rozważ dodanie paska przesuwu
po lewej. Możesz to zrobić przez menu, albo opcją 'guioptions': >

	:set guioptions+=l

Polecenie to dodaje flagę 'l' do 'guioptions'.

==============================================================================
*09.2*	Mysz

Standardy to cudowna rzecz. W Microsoft Windows możesz używać myszy do
wybierania tekstu w standardowy sposób. System X Window także ma standardowy
sposób użycia myszy. Niestety, te dwa standardy nie są tożsame.
   Na szczęście możesz dostosować Vima. Możesz sprawić, że mysz będzie
zachowywała się jak w X Window, albo Microsoft Windows. To polecenie powoduje,
że mysz zachowuje się jak mysz w X Window: >

	:behave xterm

A to spowoduje zachowanie myszy takie jak w Microsoft Windows: >

	:behave mswin

Domyślnym zachowaniem na Uniksach jest xterm. Domyślne zachowanie na Microsoft
Windows jest wybierane w trakcie instalacji. Szczegóły czym oba zachowania się
różnią możesz obejrzeć tu: |:behave|. Krótkie podsumowanie:


ZACHOWANIE XTERM

Lewe kliknięcie myszy		pozycja kursora
Lewe przeciągnięcie myszy	wybierz tekst w trybie Visual
Środkowe kliknięcie myszy	wprowadź tekst ze schowka
Prawe kliknięcie myszy		rozszerz wybrany tekst do wskaźnika myszy


ZACHOWANIE MSWIN

Lewe kliknięcie myszy		pozycja kursora
Lewe przeciągnięcie myszy	wybierz tekst w trybie Select (zobacz |09.4|)
Lewe kliknięcie myszy z Shift	rozszerz wybrany tekst do wskaźnika myszy
Środkowe kliknięcie myszy	wprowadź tekst ze schowka
Prawe kliknięcie myszy		pokaż menu kontekstowe


Możesz dalej dostroić zachowanie myszy. Sprawdź te opcje jeśli chcesz zmienić
sposób działania myszy:

	'mouse'			w jakim trybie Vim używa myszy
	'mousemodel'		jaki efekt ma kliknięcie myszą
	'mousetime'		czas między kliknięciami dla dwumlasku
	'mousehide'		ukryj mysz w trakcie pisania
	'selectmode'		czy mysz zaczyna tryb Select czy Visual

==============================================================================
*09.3*	Schowek

W sekcji |04.7| zostało wyjaśnione podstawowe użycie schowka. Trzeba jednak
wyjaśnić jedną rzecz o X Window: istnieją dwa miejsca do wymiany tekstu między
programami. MS-Windows nie ma takiej opcji.

W X Window jest "bieżący wybór". Jest to tekst podświetlony w chwili obecnej.
W Vimie jest to przestrzeń trybu Visual (zakładając, że używasz domyślnych
wartości opcji). Możesz umieścić ten wybór w innej aplikacji bez dalszych
działań.
   Na przykład, w tym tekście wybierz kilka słów myszą. Vim przełączy się na
tryb Visual i podświetli tekst. Teraz zacznij innego gVima, bez nazwy pliku
jako argumentu, tak że ukaże się puste okno. Wciśnij środkowy przycisk myszy.
Wybrany tekst zostanie wprowadzony.

"Bieżący wybór" pozostanie ważny dopóki nie zostanie wybrany inny tekst. Po
wprowadzeniu tekstu do innego gVima wybierz kilka znaków w tym oknie.
Zauważysz, że słowa, które były wybrane w pierwszym oknie zostaną podświetlone
w inny sposób. Oznacza to, że nie są już dłużej "bieżącym wyborem".

Nie musisz wybierać tekstu myszą, polecenia klawiszowe dla trybu Visual
działają równie dobrze.


PRAWDZIWY SCHOWEK

Teraz o innym miejscu z którym tekst może być wymieniany. Nazywamy go
"prawdziwym schowkiem", żeby uniknąć pomyłek. Często "biężący wybór"
i "prawdziwy schowek" są nazywane schowkiem. Musisz się do tego przyzwyczaić.
   By umieścić tekst w prawdziwym schowku wybierz kilka różnych słów
w jednym z gVimów. Potem użyj menu "Edit/Copy" (Edycja/Kopiuj). Teraz tekst
został skopiowany do prawdziwego schowka. Nie możesz tego zobaczyć dopóki nie
masz aplikacji, która pokazuje zawartość schowka (np. Klipper w KDE).
  Teraz wybierz innego gVima, umieść gdzieś kursor i użyj menu "Edit/Paste"
(Edycja/Wklej). Zobaczysz tekst wprowadzony z prawdziwego schowka.


UŻYWANIE OBU

Ten sposób użycia naraz "bieżącego wyboru" i "prawdziwego schowka" może
wyglądać trochę myląco, ale jest to bardzo użyteczne. Zobaczmy to na
przykładzie. Otwórz jakiś plik tekstowy w gVimie i przeprowadź następujące
akcje:

-  Wybierz dwa słowa w trybie Visual.
-  Użyj menu "Edit/Copy" (Edycja/Kopiuj) do skopiowania tych słów do schowka.
-  Wybierz jedno słowo w trybie Visual.
-  Użyj menu "Edit/Paste" (Edycja/Wklej). Co się teraz zdarzy to to, że
   pojedyncze zaznaczone słowo zostanie zamienione dwoma słowami ze schowka.
-  Przenieś gdzieś wskaźnik myszy i wciśnij środkowy klawisz myszy. Zobaczysz,
   że słowo, które dopiero co nadpisałeś ze schowka zostanie tu wpakowane.

Jeśli będziesz używać ostrożnie "bieżącego wyboru" i "prawdziwego schowka"
możesz z nimi zrobić dużo użytecznych rzeczy.


KLAWIATURA

Jeśli nie lubisz używać myszy masz dostęp do bieżącego wyboru i prawdziwego
schowka przez dwa rejestry. Rejestr "* służy bieżącemu wyborowi.
   Żeby tekst stał się bieżącym wyborem użyj trybu Visual (np. by wybrać całą
linię wciśnij "V").
   Do wprowadzenia biężącego wyboru przed kursor: >

	"*P

Zwróć uwagę na wielkie "P". Małe "p" wpakuje tekst po kursorze.

Rejestr "+ jest zarezerwowany dla prawdziwego schowka. Na przykład, żeby
skopiować tekst od pozycji kursora do końca linii do schowka: >

	"+y$

Pamiętaj, "y" to yankowanie - komenda Vima dla kopiowania.
   Do wpakowania zawartości prawdziwego schowka przed kursorem: >

	"+P

To jest to samo co przy bieżącym wyborze, ale używa rejestru plusa (+) zamiast
rejestru gwiazdki (*).

==============================================================================
*09.4*	Tryb Select

Teraz o czymś co jest częściej używane w MS-Windows niż w X Window, ale oba to
potrafią. Wiesz już o trybie Visual. Tryb Select jest jak tryb Visual ponieważ
też jest używany do wybierania tekstu. Ale jest oczywista różnica: kiedy
wpisujesz tekst, wybrany tekst jest usuwany, a tekst wpisywany go zastępuje.

Żeby zacząć pracę z trybem Select musisz najpierw go włączyć (dla MS-Windows
jest już prawdopodobnie włączony, ale możesz to zrobić i tak): >

	:set selectmode+=mouse

Teraz można użyć myszy do wybrania odrobiny tekstu. Jest podświetlony jak
w trybie Visual. Wciśnij literę. Wybrany tekst został usunięty i zastąpiony
przez pojedynczą literę. Ponieważ jesteś teraz w trybie Insert możesz
kontynuować pisanie.

Ponieważ wpisywanie normalnego tekstu powoduje usunięcie wybranego tekstu nie
możesz używać normalnych poleceń ruchu "hjkl", "w", etc. Zamiast tego użyj
klawiszy funkcyjnych z Shiftem. <S-Left> (lewa strzałka + Shift) przenosi
kursor w lewo). Wybrany tekst jest zmieniony jak w trybie Visual. Inne
zshiftowane klawisze pracują tak samo, również <S-End> i <S-Home>.

Możesz sterować zachowaniem trybu Select przez opcję 'selectmode'.

==============================================================================

Następny rozdział: |usr_10.txt|  Duże zmiany

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
