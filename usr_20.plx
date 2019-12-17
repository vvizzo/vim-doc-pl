*usr_20.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			Linia poleceń dla power-users


Vim ma kilka ułatwień służących szybszemu wprowadzaniu poleceń. Polecenia
dwukropka mogą być skracane, edytowane i powtarzane. Uzupełnianie jest możliwe
dla niemal wszystkiego.

|20.1|	Edycja linii poleceń
|20.2|	Skróty w linii poleceń
|20.3|	Uzupełnianie linii poleceń
|20.4|	Historia linii poleceń
|20.5|	Okno linii poleceń

 Następny rozdział: |usr_21.txt|  Tam i z Powrotem
Poprzedni rozdział: |usr_12.txt|  Sztuczki
       Spis treści: |usr_toc.txt|

==============================================================================
*20.1*	Edycja linii poleceń

Kiedy używasz dwukropka : lub szukasz z / lub ?, Vim przenosi kursor na
dół ekranu. Tam wpisujesz polecenie lub wzorzec wyszukiwania. To jest Linia
Poleceń. Także jeśli jest używana dla wpisania polecenia wyszukiwania.

Najbardziej oczywistym sposobem edycji polecenia, które wpisałeś jest
wciśnięcie klawisza <BS>. Usuwa on znak przed kursorem. By usunąć inny znak,
wpisany wcześniej, najpierw przesuń kursor z strzałką.
   Wpisałeś na przykład: >

	:s/krofa/świnia/

Zanim wcisnąłeś <Enter>, zauważasz, że zamiast "krofa" powinna być "krowa".
Żeby to poprawić wciśnij <Left> dziewięć razy. Kursor jest teraz na "a"
w "krofa".  Wciśnij <BS> i "w" by poprawić: >

	:s/krowa/świnia/

Teraz możesz wcisnąć <Enter> od razu. Nie musisz przenieść kursora na koniec
linii przed wykonaniem polecenia.

Najczęściej używane klawisze do poruszania się w linii poleceń:

	<Left>			jeden znak w lewo
	<Right>			jeden znak w prawo
	<S-Left> or <C-Left>	jeden wyraz w lewo
	<S-Right> or <C-Right>	jeden wyraz w prawo
	CTRL-B or <Home>	do początku linii poleceń
	CTRL-E or <End>		do końca linii poleceń

	Note:
	<S-Left> (strzałka w lewo i równocześnie wciśnięty Shift) i <C-Left>
	(strzałka w lewo i równocześnie wciśnięty Control) mogą nie działać na
	wszystkich klawiaturach. To samo stosuje się do innych kombinacji
	z Shift i Control.

Możesz również użyć myszy do przeniesienia kursora.


USUWANIE

Jak wspomniano <BS> usuwa znak przed kursorem. Do usunięcia całego słowa służy
CTRL-W.

	/to dobra świnia~

		     CTRL-W

	/to dobra~

CTRL-U usuwa cały tekst i pozwala zacząć wszystko od nowa.


NADPISANIE

Klawisz <Insert> przełącza między wprowadzaniem znaków i zastępowaniem
istniejących. Zacznij od:

	/to dobra świnia~

Przenieś kursor na początek "dobra" dwukrotnym <S-Left> (lub 12-krotnym
<Left>, jeśli <S-Left> nie działa). Wciśnij <Insert> by przejść do
nadpisywania i wpisz "wielka":

	/to wielkaświnia~

Ups, straciliśmy spację. Nie możesz tu użyć <BS>, ponieważ to usunie "a"
(różnica z trybem Replace). Zamiast tego wciśnij <Insert> by przejść od
nadpisywania do wprowadzania i wpisz spację:

	/to wielka świnia~


ODWOŁYWANIE

Chciałeś wykonać polecenie : lub /, ale zmieniłeś zdanie. Żeby pozbyć się tego
co już wpisałeś, bez wykonywania, wciśnij CTRL-C lub <Esc>.

	Note:
	<Esc> jest uniwersalnym klawiszem ucieczki. Niestety, w dobrym, starym
	Vi, wciśnięcie <Esc> w linii poleceń wykonywało polecenie! Ponieważ
	może to zostać uznane za błąd, Vim używa <Esc> do odwołania polecenia.
	Ale używając opcji 'cpoptions' można to zrobić kompatybilne z Vi.
	I kiedy użyjesz mapowania (które mogło być napisane dla Vi) <Esc>
	także jest kompatybilne z Vi. Dlatego tylko CTRL-C jest metodą, która
	zawsze działa.

Jeśli jesteś na początku linii poleceń, wciśnięcie <BS> odwoła polecenie. To
jakby usunięcie ":" lub "/", które zaczynają linię.

==============================================================================
*20.2*	Skróty linii poleceń

Niektóre z poleceń ":" są naprawdę długie. Już wspomnieliśmy, że ":substitute"
można zamienić na ":s". Jest to ogólny mechanizm, wszystkie polecenia ":" mogą
zostać skrócone.

Jak krótkie może być polecenie? Jest 26 liter i o wiele więcej poleceń. Na
przykład, ":set także zaczyna się ":s", ale ":s" nie zaczyna polecenia ":set".
Zamiast tego ":set" może zostać skrócone do ":se".
   Kiedy krótsza z form polecenia może być użyta dla dwóch poleceń jest
skrótem tylko dla jednego z nich. Nie ma w tym żadnej logiki, musisz się tego
po prostu nauczyć. W plikach pomocy jest oznaczona najkrótsza forma, która
działa. Na przykład: >

	:s[ubstitute]

Oznacza, że najkrótszą formą ":substitute" jest ":s". Kolejne znaki są
opcjonalne. Dlatego działają zarówno ":su" jak i ":sub".

W podręczniku użytkownika będziemy używać albo pełnej nazwy polecenia, albo
tej skróconej wersji, która jest ciągle czytelna. Na przykład, ":function"
może być skrócone do ":fu". Ale ponieważ większość ludzi nie zrozumiałaby co
to oznacza użyjemy ":fun". (Vim nie posiada polecenia ":funny", w tym wypadku
bowiem ":fun" też mogłoby być mylące.)

Zaleca się by w skrypatch Vima używać pełnych nazw poleceń. W ten sposób są
łatwiejsze do czytania przy robieniu późniejszych zmian. Wyjątkiem są tu
często używane polecenia jak ":w" (":write") lub ":r" (":read").
   Szczególnie mylące jest ":end", które może oznaczać ":endif", ":endwhile"
lub ":endfunction". Z tego powodu lepiej jest zawsze używać pełnej nazwy.


KRÓTKIE NAZWY OPCJI

W Podręczniku Użytkownika używa się długich nazw opcji. Wiele opcji ma także
krótkie nazwy. W odróżnieniu od poleceń ":" jest tylko jedna, prawidłowa,
krótka nazwa, która działa. Na przykład, krótką nazwą dla 'autoindent' jest
'ai'. Te dwa polecenia robią to samo: >

	:set autoindent
	:set ai

Pełną listę długich i krótkich nazw znajdziesz: |option-list|.

==============================================================================
*20.3*	Uzupełnianie linii poleceń

Jest to jedna z tych zalet Vima, dla których warto przesiąść się z Vi. Jak raz
się do niej przyzwyczaisz, nie będziesz mógł bez niej żyć.

Przypuśćmy, że masz katalog zawierający pliki: >

	info.txt
	intro.txt
	bodyofthepaper.txt

Żeby otworzyć ostatni użyjesz polecenia: >

	:edit bodyofthepaper.txt

Łatwo źle wpisać tak długą nazwę. O wiele szybsze jest: >

	:edit b<Tab>

Które skutkuje tym samym. Co się stało? Klawisz <Tab> uzupełnia słowo przed
kursorem. W tym przypadku "b". Vim sprawdza katalog i znajduje jedyny plik
zaczynający się na "b". To musi być ten, którego szukasz i Vim uzupełnia nazwę
pliku dla ciebie.

Teraz wpisz: >

	:edit i<Tab>

Vim bipnie i poda: >

	:edit info.txt

Bipnięcie oznacza, że Vim znalazł więcej niż jedno dopasowanie. Używa
pierwszego dopasowania jakie znalazł (alfabetycznie). Jeśli znowu wciśniesz
<Tab> dostaniesz: >

	:edit intro.txt

Dlatego jeśli pierwsze <Tab> nie poda nazwy pliku jakiego szukasz, wciśnij go
znowu. Jeśli jest więcej dopasowań, zobaczysz je wszystkie, jeden naraz.
   Jeśli wciśniesz <Tab> przy ostatnim dopasowaniu wrócisz do tego co wpisałeś
na początku: >

	:edit i

I zaczynasz od wszystko od nowa. Vim przechodzi cały cykl dopasowań. Użyj
CTRL-P by iść przez listę w odwrotnym kierunku:

	      <------------------- <Tab> -------------------------+
								  |
		  <Tab> -->		       <Tab> -->
	:edit i		      :edit info.txt		   :edit intro.txt
		  <-- CTRL-P		       <-- CTRL-P
	   |
	   +---------------------- CTRL-P ------------------------>


KONTEKST

Jeśli wpiszesz ":set i" zamiast ":edit i" i wciśniesz <Tab> dostaniesz: >

	:set icon

Hej, dlaczego nie ":set info.txt"? Dlatego, że Vim uzupełnia linię poleceń
w zależności od kontekstu. Rodzaj słów jakich Vim będzie szukał zależy od
polecenia przed nim. Vim wie, że nie możesz użyć nazwy pliku tuż po poleceniu
":set" ale możesz użyć nazwy opcji.
   Znowu, jeśli powtórzysz <Tab>, Vim przejdzie przez wszystkie dopasowania.
Jest ich całkiem dużo. Lepiej wpisać najpierw więcej liter: >

	:set isk<Tab>

Da: >

	:set iskeyword

Teraz wpisz "=" i wciśnij <Tab>: >

	:set iskeyword=@,48-57,_,192-255

W tym wypadku Vim wstawił starą wartość opcji. Możesz teraz ją edytować.
   To co <Tab> uzupełnia jest tym czego Vim się w tym miejscu spodziewa.
Wypróbuj jak to działa. W różnych sytuacjach nie dostaniesz tego czego chcesz.
Dzieje się tak bo Vim nie wie czego chcesz lub uzupełnianie nie zostało
zaimplementowane dla tej sytuacji. W takim razie zostanie wstawione <Tab>
(pokazane jako ^I).


LISTA DOPASOWAŃ

Jeśli jest wiele dopasowań, być może będziesz chcieć zobaczyć je wszystkie.
Zrób to wciskając CTRL-D. Na przykład, wciśnięcie CTRL-D po: >

	:set is

daje: >

	:set is
	incsearch  isfname    isident    iskeyword  isprint
	:set is

Vim listuje dopasowania i wraca do tekstu jaki wpisałeś. Możesz sprawdzić
listę dla poszukiwanego przedmiotu. Jeśli go tam nie ma możesz użyć <BS> by
poprawić słowo. Jeśli jest kilka dopasowań, wpisz kilka więcej znaków zanim
wciśniesz <Tab> by uzupełnić resztę.
   Jeśli obserwowałeś uważnie, zauważyłeś, że "incsearch" nie zaczyna się na
"is". Tutaj "is" jest krótką nazwą 'incsearch'. (Wiele opcji ma krótką i długą
nazwę.) Vim jest wystarczająco sprytny by pomyśleć, że mogłeś chcieć
rozszerzyć krótką nazwę opcji w długą.


WIĘCEJ

Polecenie CTRL-L uzupełnia słowo do najdłuższego wspólnego łańcucha. Jeśli
wpisałeś ":edit i", a istnieją pliki "info.txt" i "info_backup.txt" dostaniesz
":edit info".

Opcja 'wildmode' może zostać użyta do zmiany zachowania uzupełniania.
Opcja 'wildmenu' może być użyta do uzyskania listy dopasowań podobnej do menu.
Użyj opcji 'suffixes' do określenia mniej ważnych plików, pojawią się one na
końcu listy plików.
Opcja 'wildignore' określi pliki, które w ogóle się nie pojawią.

Więcej o tym temacie: |cmdline-completion|

==============================================================================
*20.4*	Historia linii poleceń

W rozdziale 3. krótko wspomnieliśmy o historii. Podstawy są takie, że możesz
użyć <Up> do przywołania dawniejszej linii. <Down> wraca do nowszych poleceń.

W rzeczywistości są cztery historie. Te o których wspomnieliśmy są dla ":",
"/", "?". Polecenia "/" i "?" dzielą tę samą historię odnoszącą się do
poszukiwań. Dwie pozostałe historie są dla wyrażeń i dla linii wprowadzania
z funkcji input(). |cmdline-history|

Przypuśćmy, że wydałeś polecenie ":set", później dziesięć innych poleceń
dwukropka i chcesz znowu wydać polecenie ":set". Możesz wcisnąć ":" i potem
dziesięć razy <Up>. Jest krótsza droga: >

	:se<Up>

Vim wróci do poprzedniego polecenia, które zaczynało się na "se". Masz spore
szanse, że to było ":set", którego szukałeś. Przynajmniej nie będziesz musiał
używać <Up> bardzo często (dopóki polecenia ":set" nie są wszystkim co
robisz).

<Up> użyje tekstu wpisanego do tej pory i porówna to z liniami w historii.
Tylko dopasowane linie zostaną użyte.
   Jeśli nie znalazłeś linii, której szukałeś użyj <Down> do powrotu
i poprawienia. Albo CTRL-U by zacząć wszystko od początku.

Żeby zobaczyć wszystkie linie w historii: >

	:history

To jest historia poleceń ":". Historię poszukiwań dostaniesz dzięki: >

	:history /

CTRL-P robi to samo co <Up>, z wyjątkiem tego, że nie ma znaczenia co już
wpisałeś. Podobnie CTRL-N i <Down>. CTRL-P oznacza poprzednie (previous),
CTRL-N następne (next).

==============================================================================
*20.5*	Okno linii poleceń

Wpisywanie tekstu w linii poleceń działa inaczej od wpisywania w trybie
Insert. Nie ma tylu poleceń do zmiany tekstu. W większości przypadków to
wystarcza, ale czasami musisz wprowadzić skomplikowane polecenie. Tu przydaje
się okno linii poleceń.

Otwórz okno linii poleceń komendą: >

	q:

Vim otwiera (małe) okno na samym dole. Zawiera ono historię linii poleceń
i pustą linię na końcu:

	+-------------------------------------+
	|inne okno			      |
	|~				      |
	|plik.txt=============================|
	|:e c				      |
	|:e config.h.in			      |
	|:set path=.,/usr/include,,	      |
	|:set iskeyword=@,48-57,_,192-255     |
	|:set is			      |
	|:q				      |
	|:				      |
	|command-line=========================|
	|				      |
	+-------------------------------------+

Jesteś teraz w trybie Normal. Możesz użyć "hjkl" do poruszania się. Na
przykład przejdź do góry "5k" do ":e config.h.in". Użyj "$h" by przejść do
"i" w "in" i wpisz "cwout". Zmieniłeś tę linię na:

	:e config.h.out ~

Teraz wciśnij <Enter> i polecenie zostanie wykonane. Okno linii poleceń
zamknie się.
   Polecenie <Enter> wykonuje linię pod kursorem. Nie ma znaczenia czy Vim
jest w trybie Insert czy Normal.
   Zmiany w linii poleceń są stracone. Nie zmieniają one historii. Wyjątkiem
jest polecenie, które wykonałeś - zostanie ono dodane do historii, tak jak
wszystkie wykonane polecenia.

Okno linii poleceń jest bardzo użyteczne jeśli chcesz mieć widok na historię,
szukając podobnego polecenia, zmienić je odrobinę i wykonać. Polecenie
wyszukiwnia może być użyte do znalezienia czegoś.
   W poprzednim przykładzie polecenie wyszukiwania "?config" mogłoby być użyte
do znalezienia poprzedniego polecenia zawierającego "config". Jest to trochę
dziwne bo używasz linii poleceń do poszukiwania w oknie linii poleceń. Kiedy
wpisujesz to polecenie wyszukiwania nie możesz otworzyć innego okna linii
poleceń. Okno linii poleceń może być tylko jedno.

==============================================================================

Następny rozdział: |usr_21.txt|  Tam i z Powrotem

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
