*usr_02.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			    Pierwsze kroki w Vimie


Rozdział ten przedstawia wystarczająco wiele informacji by móc zacząć edytować
plik w Vimie. Niezbyt sprawnie bądź szybko, ale jest to możliwe. Należy
spędzić trochę czasu na treningu tych poleceń, stanowią one podstawę do
wszystkiego co przyjdzie potem.

|02.1|	Pierwsze uruchomienie Vima
|02.2|	Wprowadzanie tekstu
|02.3|	Poruszanie się
|02.4|	Usuwanie znaków
|02.5|	Undo i Redo
|02.6|	Inne polecenia edycji
|02.7|	Wychodzenie
|02.8|	System pomocy

 Następny rozdział: |usr_03.txt|  Poruszanie się
Poprzedni rozdział: |usr_01.txt|  O podręcznikach
       Spis treści: |usr_toc.txt|

==============================================================================
*02.1*	Pierwsze uruchomienie Vima

Vima uruchamia się poleceniem: >

	gvim plik.txt

W Uniksie można tę komendę wprowadzić przy każdym znaku zachęty. W MS-Windows
należy otworzyć okno MS-DOS i tam wpisać polecenie.
   W każdym wypadku Vim otwiera plik nazwany plik.txt. Ponieważ jest to nowy
plik otwiera się puste okno. Ekran będzie wyglądał tak:

	+---------------------------------------+
	|#					|
	|~					|
	|~					|
	|~					|
	|~					|
	|"plik.txt" [New file]			|
	+---------------------------------------+
		("#" pozycja kursora.)

Linie zaczynające się tyldą (~) nie należą do pliku.  Innymi słowy, jeśli
Vimowi brakuje pliku do pokazania na ekranie pokazuje linie zaczynające się
tyldą. Na dole ekranu linia komunikatów informuje, że plik nazywa się plik.txt
i jest on plikiem. Komunikat jest chwilowy i inne informacje szybko go
nadpiszą.


POLECENIE VIM

Polecenie gvim każe edytorowi stworzyć nowe okno do edycji. Jeśli użyjesz
polecenia: >

	vim plik.txt

Edycja odbędzie się w oknie poleceń. Oznacza to, że jeśli polecenie było
wydane  wewnątrz xterma edytor będzie używał okna xterma. Jeśli polecenie
zostało wydane w oknie poleceń MS-DOS w systemie Microsoft Windows edycja
będzie odbywać się wewnątrz tego okna. Tekst w obu oknach będzie wyglądał tak
samo, ale gvim ma parę dodatkowych możliwości, na przykład pasek menu. Więcej
o tym później.

==============================================================================
*02.2*	Wprowadzanie tekstu

Vim jest edytorem modalnym. Oznacza to, że zachowuje się różnie w zależności
od trybu w jakim się znajdujesz. Dwa podstawowe tryby to Normal i Insert.
W trybie Normal znaki jakie wpisujesz są poleceniami. W trybie Insert znaki są
wprowadzane jako tekst.
   W chwili kiedy zaczynasz Vima będzie on w trybie Normal. By zapoczątkować
tryb Insert wydaj polecenie "i" (i jak Insert). Teraz możesz wprowadzać tekst,
będzie on zapisany do pliku. Nie martw się jeśli zrobisz błąd, możesz go
poprawić później. Żeby napisać limeryk programistyczny wpisz: >

	iA very intelligent turtle
	Found programming UNIX a hurdle

Po wyrazie "turtle" wciśnij <Enter> aby zacząć nową linię. Na końcu wciśnij
<Esc> kończąc tryb Insert i powracając do trybu Normal. Teraz masz dwie linie
w oknie Vima:

	+---------------------------------------+
	|A very intelligent turtle		|
	|Found programming UNIX a hurdle	|
	|~					|
	|~					|
	|					|
	+---------------------------------------+


CZYM JEST TRYB?

Tryb w którym jesteś można sprawdzić poleceniem: >

	:set showmode

Zauważ, że kiedy wpisujesz dwukropek, Vim przenosi kursor do ostatniej linii
okna. Tam wpisujesz polecenia dwukropka (zaczynające się dwukropkiem). 
Zakończ polecenie wciskając <Enter> (wszystkie polecenia, które zaczynają się
dwukropkiem kończysz w ten sposób).
   Teraz jeśli wciśniesz "i" Vim pokaże --INSERT-- na dole okna. Oznacza to,
że jesteś w trybie Insert.

	+---------------------------------------+
	|A very intelligent turtle		|
	|Found programming UNIX a hurdle	|
	|~					|
	|~					|
	|-- INSERT --				|
	+---------------------------------------+

Po wciśnięciu <Esc> i powrocie do trybu Normal ostatnia linia będzie pusta.


WYDOSTAWANIE SIĘ Z PROBLEMÓW

Jednym z problemów dla nowicjuszy w Vimie, jest mylenie trybów w jakich się
znajdują lub przypadkowe wciśnięcie klawisza, który powoduje zmianę trybu. Do
trybu Normal, nieważne w jakim trybie się znajdujesz, wciśnij <Esc>. Czasami
musisz go wcisnąć dwa razy. Jeśli Vim piszczy jesteś już w trybie Normal.

==============================================================================
*02.3*	Poruszanie się

Po powrocie do trybu Normal możesz poruszać się używając klawiszy:

	h   lewo 			*hjkl*
	j   dół
	k   góra
	l   prawo

Z początku może się wydawać, że polecenia te zostały wybrane przypadkowo.
Przede wszystkim kto słyszał o używaniu l jako "prawo"? Istnieje bardzo dobra
przyczyna takiego wyboru: poruszanie się jest najczęstszą czynnością jaką się
wykonujesz w edytorze, a te klawisze znajdują się w "rzędzie domowym" (home
row) prawej ręki. Innymi słowy, polecenia te znajdują się tam gdzie możesz je
najszybciej wydać (zwłaszcza jeśli piszesz dziesięcioma palcami).

	Note:
	Do poruszania się możesz też używać klawiszy strzałek. Jednak jeśli to
	robisz zwalnia to twoje działanie: by użyć strzałek musisz przenieść
	rękę z części tekstowej klawiatury do strzałek. W sumie, jeśli robisz
	to setki razy w ciągu godziny może to zająć spory kawał czasu.
	   Zdarzają się też klawiatury, które nie mają strzałek, lub które
	umieszczają je w niezwykłych miejscach. Wiedza o hjkl może pomóc
	w takich sytuacjach.

Jednym ze sposobów by zapamiętać te komendy jest fakt, że h jest po lewej,
l po prawej, a j wskazuje w dół. Na obrazku: >

		       k
		   h     l
		     j

Najlepszą metodą by nauczyć się tego jest używanie ich. Wciśnij "i" i wprowadź
kilka linii tekstu. Potem użyj hjkl do poruszania się i wprowadzenia kilku
słów w różnych miejscach. Nie zapominaj o <Esc> by wrócić do trybu Normal.
|vimtutor| jest również dobrą metodą nauki przez pracę.

Dla Japończyków Hiroshi Iwatani wymyślił wskazówkę:

			Komsomolsk
			    ^
			    |
	  Huang Ho      <--- --->  Los Angeles
	(Żółta Rzeka)	    |
			    v
			  Java
	    (wyspa, nie język programowania)

==============================================================================
*02.4*	Usuwanie znaków

Najprostszą metodą usunięcia znaku jest przejście kursorem nad znak
i wciśnięcie "x". (Jest to odniesienie do starych czasów kiedy na maszynach do
pisania usuwało się znaki nadpisujęc je xxxx.) Przejdź kursorem do początku
pierwszej linii i wciśnij xxxxxxx (siedem razy x) by usunąć "A very ".
Rezultatem będzie:

	+---------------------------------------+
	|intelligent turtle			|
	|Found programming UNIX a hurdle	|
	|~					|
	|~					|
	|					|
	+---------------------------------------+

Teraz można wpisać nowy tekst, na przykład: >

	iA young <Esc>

Fraza ta zaczyna wprowadzanie ("i"), wypisuje wyrazy "A young", a w końcu
opuszcza tryb Insert (<Esc> na końcu). Wynik:

	+---------------------------------------+
	|A young intelligent turtle		|
	|Found programming UNIX a hurdle	|
	|~					|
	|~					|
	|					|
	+---------------------------------------+


USUWANIE LINII

Do usunięcia całej linii służy komenda "dd". Następne linie zostaną
przesunięte w górę by wypełnić lukę:

	+---------------------------------------+
	|Found programming UNIX a hurdle	|
	|~					|
	|~					|
	|~					|
	|					|
	+---------------------------------------+


USUWANIE ZNAKU NOWEJ LINII

W Vimie można połączyć dwie linie, co oznacza, że znak nowej linii pomiędzy
nimi zostanie usunięty. Robi się to komendą "J".
   Na początku są dwie linie:

	A young intelligent ~
	turtle ~

Przenieś kursor do pierwszej linii i wciśnij "J":

	A young intelligent turtle ~

==============================================================================
*02.5*	Undo i Redo

Przypuśćmy, że usunąłeś za dużo. W porządku, możesz to wpisać znowu, ale
istnieją łatwiejsze sposoby. Komenda "u" cofa ostatnią zmianę.
W rzeczywistości wygląda to tak: "dd" usuwa pierwszą linię, "u" ją przywraca.
   Inny przykład: przenieś kursor do A w pierwszej linii:

	A young intelligent turtle ~

Teraz wstukaj xxxxxxx by usunąć "A young". Wynikiem jest:

	 intelligent turtle ~

Wciśnij "u" by cofnąć ostatnie usunięcie. Wycięło ono g, tak więc undo
przywraca znak.

	g intelligent turtle ~

następne polecenie u przywraca kolejny usunięty znak:

	ng intelligent turtle ~

Następne polecenie u zwraca u itd.:

	ung intelligent turtle ~
	oung intelligent turtle ~
	young intelligent turtle ~
	 young intelligent turtle ~
	A young intelligent turtle ~

	Note:
	Jeśli wcisnąłeś "u" dwukrotnie, a w rezultacie otrzymałeś ten sam
	tekst z powrotem oznacza to, że masz Vima skonfigurowanego jako
	kompatybilnego z Vi. Sprawdź jak to naprawić: |not-compatible|.
	   Ten tekst przyjmuje, że pracujesz na sposób Vima. Możesz działać
	jak w starym, dobrym Vi, ale musisz wtedy zwracać uwagę na małe
	różnice w tekście.


REDO

Jeśli cofnąłeś zmiany zbyt wiele razy możesz wcisnąć CTRL-R (redo) by cofnąć
poprzednie polecenie. Innymi słowy, CTRL-R cofa cofnięcie. Można to zobaczyć
w akcji wciskając CTRL-R dwukrotnie. Znak A i spacja po nim zniknie:

	young intelligent turtle ~

Istnieje specjalna wersja polecenia undo, komenda "U" (cofnij wszystkie zmiany
w linii). Cofnięcie wszystkich zmian w wierszu unieważnia wszystkie zmiany,
które były wprowadzone w linii podczas ostatniej edycji. Wydanie tej komendy
dwukrotnie odwołuje poprzednie "U".

	A very intelligent turtle ~
	  xxxx				Usuwa very

	A intelligent turtle ~
		      xxxxxx		Usuwa turtle

	A intelligent ~
					Przywróć wiersz z "U"
	A very intelligent turtle ~
					Cofnij "U" przez "u"
	A intelligent ~

Sama komenda "U" jest zmianą samą w sobie, którą polecenie "u" cofa i CTRL-R
przywraca. Może być to odrobinę mylące. Nie martw się, dzięki "u" i CTRL-R
możesz wrócić do każdej sytuacji jaką miałeś.

==============================================================================
*02.6*	Inne polecenia edycji

Vim posiada dużą liczbę poleceń służących do zmiany tekstu. Zobacz |Q_in|
i poniżej. Jest tu przegląd najczęściej używanych komend.


APPENDING (dodawanie)

Komenda "i" wprowadza znak przed znakiem pod kursorem. W porządku, ale co
jeśli chcesz dodać znaki na końcu linii? Dlatego potrzebujesz czegoś co
wprowadziłoby tekst za kursorem. Robi się to komendą "a" (append - dodaj).
   Na przykład by zmienić wiersz

	and that's not saying much for the turtle. ~
na
	and that's not saying much for the turtle!!! ~

przenieś kursor na kropkę na końcu linii. Wciśnij "x" by usunąć kropkę. Kursor
znajduje się teraz na końcu linii na e w turtle. Teraz wpisz >

	a!!!<Esc>

by dodać trzy wykrzykniki za e w turtle:

	and that's not saying much for the turtle!!! ~


OTWIERANIE NOWEJ LINII

Komenda "o" tworzy nową, pustą linię poniżej kursora i przenosi Vima do trybu
Insert. Możesz teraz wpisywać tekst w nowej linii.
   Przypuśćmy, że kursor jest gdzieś w pierwszej z dwóch linii:

	A very intelligent turtle ~
	Found programming UNIX a hurdle ~

Jeśli teraz użyjesz komendy "o" i wpiszesz nowy tekst: >

	oThat liked using Vim<Esc>

Rezultatem będzie:

	A very intelligent turtle ~
	That liked using Vim ~
	Found programming UNIX a hurdle ~

Komenda "O" (wielka litera) otwiera linię powyżej kursora.


UŻYWANIE LICZNIKA

Przypuśćmy, że chcesz przenieść się w górę o dziewięć wierszy. Możesz wstukać
"kkkkkkkkk", ale możesz też użyć polecenia "9k". W rzeczywistości jest możliwe
poprzedzenie większości komend liczbą. Wcześniej w tym rozdziale dodałeś trzy
wykrzykniki wpisując "a!!!<Esc>". Innym sposobem jest użycie polecenia
"3a!<Esc>". Liczba 3 każe komendzie potroić jej efekt. Podobnie, by usunąć
trzy znaki użyj polecenia "3x". Liczba zawsze poprzedza komendę do której się
odnosi.

==============================================================================
*02.7*	Wychodzenie

Z Vima wychodzi się komendą "ZZ". Zapisuje ona plik i zamyka Vima.

	Note:
	W odróżnieniu od innych edytorów Vim nie zapisuje automatycznie pliku
	backup. Jeśli wpiszesz "ZZ" twoje zmiany są wprowadzone i nie ma
	odwrotu. Możesz skonfigurować Vima by tworzył pliki backup, zobacz
	|07.4|.


ODRZUCANIE ZMIAN

Czasami powstaje sekwencja zmian i nagle uświadamiasz sobie, że zanim zacząłeś
było lepiej. Nie martw się: Vim ma polecenie wyjdź-i-odrzuć-zmiany. Jest to: >

	:q!

Nie zapomnij wcisnąć <Enter> by zakończyć polecenie.

Dla zainteresowanych szczegółami. Polecenie składa się z trzech części:
dwukropka (:), który przenosi nas do trybu poleceń; komendy q, która nakazuje
wyjście z edytora; modyfikatora wymuszenia (!).
   Modyfikator wymuszenia jest konieczny ponieważ Vim niechętnie odrzuca
zmiany. Jeśli wpiszesz jedynie ":q", Vim wyświetli komunikat błędu i odmówi
wyjścia:

	E37: No write since last change (use ! to override) ~

Wymuszając wykonanie polecenia mówisz Vimowi: "Wiem, że to co robię wygląda
głupio, ale jestem dużym chłopcem i naprawdę chcę to zrobić".

Jeśli chcesz kontynuować edycję z Vimem: polecenie ":e!" ładuje z powrotem
oryginalną wersję pliku.

==============================================================================
*02.8*	System pomocy

Wszystko co zawsze chciałeś wiedzieć możesz znaleźć w plikach pomocy Vima. Nie
bój się zapytać!
   Ogólną pomoc dostaniesz dzięki komendzie: >

	:help

Można także użyć pierwszego klawisza funkcyjnego <F1>. Jeśli twoja klawiatura
ma klawisz <Help> także będzie działał.
   Jeśli nie podasz tematu, ":help" przedstawi ogólne okno pomocy. Twórcy Vima
zrobili coś bardzo sprytnego (albo bardzo leniwego) z systemem pomocy: okno
pomocy jest zwykłym oknem edycji. Możesz użyć wszystkich normalnych poleceń
Vima by się w nim poruszać. Stąd h, j, k i l to lewo, dół, góra i prawo.
   Aby wydostać się z okna pomocy możesz użyć komendy, której używasz do
wyjścia z Vima: "ZZ". Zamknie ona tylko okno pomocy, nie całego Vima.

W czasie czytania plików pomocy zobaczysz tekst zamknięty wewnątrz pionowych
kresek (na przykład |help|). Jest to hiperłącze. Jeśli umieścisz kursor
pomiędzy kreskami i wciśniesz CTRL-] (skok do znacznika), system pomocy
przeniesie cię do żądanego tematu. (Dla przyczyn tutaj nie dyskutowanych,
określeniem Vima na hiperłącze jest znacznik - tag. Tak więc CTRL-] skacze do
miejsca znacznika określonego przez słowo pod kursorem.)
   Po kilku skokach, być może zechcesz wrócić. CTRL-T zabierze cię do
poprzedniej pozycji. CTRL-O także dobrze działa w takiej sytuacji.
   Na samym szczycie ekranu pomocy jest notacja *help.txt*. Nazwa pomiędzy "*"
użyta jest przez system pomocy do zdefiniowania znacznika (miejsce
przeznaczenia hiperłącza).
   Zobacz |29.1| dla szczegółowego wyjaśnienia sprawy znaczników.

Pomocy na konkretny temat dostarcza: >

	:help {temat}

Pomoc na temat komendy x otrzymasz tak: >

	:help x

Pomoc na temat usuwania tekstu uzyskasz dzięki poleceniu: >

	:help deleting

Kompletny indeks wszystkich komend Vima to: >

	:help index

Jeśli szukasz pomocy na temat komendy używającej klawisza Ctrl (np.: CTRL-A)
robisz to tak: >

	:help CTRL-A

Edytor Vim ma wiele trybów. Domyślnie system pomocy wyświetla komendy trybu
Normal. Na przykład następujące polecenie przedstawia pomoc na temat komendy
CTRL-H w trybie Normal: >

	:help CTRL-H

By zidentyfikować inne tryby musisz użyć prefiksu. Jeśli szukasz pomocy na
temat wersji komendy dla trybu Insert użyj "i_". Dla CTRL-H daje to
następujące polecenie: >

	:help i_CTRL-H

Kiedy zaczynasz Vima możesz użyć kilku argumentów linii poleceń. Wszystkie
zaczynają się myślnikiem (-). By znaleźć pomoc na temat argumentu -t użyj: >

	:help -t

Vim posiada wiele opcji, które pozwalają na szeroko posuniętą konfigurację
i adaptację edytora. Jeśli szukasz pomocy dla opcji musisz zamknąć jej nazwę
wewnątrz pojedynczych cudzysłowów. Dla opcji 'number' polecenie będzie
wyglądało tak: >

	:help 'number'

Tabela z prefiksami dla wszystkich trybów jest tu: |help-context|.

Znaki specjalne są zamknięte w nawiasach trójkątnych. Pomoc na temat strzałki
w górę w trybie Insert uzyskasz: >

	:help i_<Up>

Jeśli widzisz komunikat błędu, którego nie rozumiesz, na przykład:

	E37: No write since last change (use ! to override) ~

Możesz wpisać ID błędu by na początek znaleźć pomoc na ten temat: >

	:help E37

==============================================================================

Następny rozdział: |usr_03.txt|  Poruszanie się

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
