*usr_11.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar	
			   tłum. Mikołaj Machowski

			Odzyskiwanie plików po awarii

Czy twój komputer zawiesił się? Po tym jak spędziłeś godziny pisząc? Nie
panikuj! Vim zachowuje wystarczająco wiele informacji na dysku by
odzyskać większość twojej pracy. Ten rozdział pokaże ci jak odzyskać
twoją pracę i wyjaśni jak wykorzystywany jest plik wymiany.

|11.1|	Podstawy odzyskiwania plików
|11.2|	Gdzie znajduje się plik wymiany?
|11.3|	Awaria czy nie?
|11.4|	Dalsza lektura

 Następny rozdział: |usr_12.txt|  Sprytne sztuczki
Poprzedni rozdział: |usr_10.txt|  Duże zmiany
       Spis treści: |usr_toc.txt|

==============================================================================
*11.1*	Podstawy odzyskiwania plików

W większości wypadków odzyskanie pliku jest całkiem proste, przyjąwszy,
że wiesz który plik edytowałeś (a dysk twardy cały czas pracuje).
Wywołaj Vima normalną komendą z dodanym argumentem "-r": >

	vim -r help.txt

Vim odczyta plik wymiany (używany do przechowywania tekstu jaki
edytowałeś) i może odczytać bity i cząsteczki oryginalnego pliku. Jeśli
wszystko jest w porządku, zobaczysz takie wiadomości (z innymi nazwami
plików oczywiście):

	Using swap file ".help.txt.swp" ~
	Original file "~/vim/runtime/doc/help.txt" ~
	Recovery completed. You should check if everything is OK. ~
	(You might want to write out this file under another name ~
	and run diff with the original file to check for changes) ~
	Delete the .swp file afterwards. ~

Na wszelki wypadek zapisz ten plik pod inną nazwą: >

	:write help.txt.odzyskany

Porównaj plik z oryginalnym by sprawdzić czy dostałeś to czego oczekiwałeś.
Bardzo użyteczny jest tu vimdiff |08.7|. Poszukaj oryginalnego pliku i sprawdź
czy zawiera późniejszą wersję (jeśli zapamiętałeś plik tuż przed awarią)
i sprawdź czy nie brakuje żadnej linii (coś mogło pójść tak źle, że Vim nie
mógł tego odzyskać).
    Jeśli Vim drukuje wiadomości z ostrzeżeniami podczas odzyskiwania czytaj
je uważnie. Jest to jednak rzadkie zachowanie.

Normalne jest to, że ostatnie parę zmian nie będzie odzyskane. Vim przesyła
zmiany na dysk kiedy nie piszesz przez jakieś cztery sekundy albo po wpisaniu
około dwustu znaków. Zachowaniem tym możesz sterować poprzez opcje
'updatetime' i 'updatecount'. Jeśli Vim nie będzie miał szansy by zachować
zmiany kiedy system pada, zmiany po ostatnim przesyle danych zostaną utracone.

Jeśli edytowałeś plik bez nadanej jeszcze nazwy podaj pusty ciąg znaków jako
argument: >

	vim -r ""

Musisz być w odpowiednim katalogu, w innym wypadku Vim nie będzie mógł
odnaleźć pliku wymiany.

==============================================================================
*11.2*	Gdzie znajduje się plik wymiany?

Vim może przechowywać plik wymiany w kilku miejscach. Normalnie jest to
ten sam katalog gdzie był oryginalny plik. By znaleźć go, przejdź do
katalogu pliku: >

	vim -r

Vim wypisze listę wszystkich plików wymiany jakie może znaleźć. Będzie również
szukał w innych katalogach gdzie pliki wymiany dla plików z bieżącego katalogu
mogą się znajdować. Nie znajdzie jednak plików wymiany w innych katalogach,
Vim nie przeszukuje drzewa katalogów.
    Wynik powinien wyglądać mniej więcej tak:

	Swap files found: ~
	   In current directory: ~
	1.    .main.c.swp ~
		  owned by: mool   dated: Tue May 29 21:00:25 2001 ~
		 file name: ~mool/vim/vim6/src/main.c ~
		  modified: YES ~
		 user name: mool   host name: masaka.moolenaar.net ~
		process ID: 12525 ~
	   In directory ~/tmp: ~
	      -- none -- ~
	   In directory /var/tmp: ~
	      -- none -- ~
	   In directory /tmp: ~
	      -- none -- ~
	
Jeśli jest kilka plików wymiany, które wyglądają tak jakbyś właśnie ich
szukał, Vim zaprezentuje ich listę i zażąda by wprowadzić numer tego, którego
chcesz użyć. Dokładnie sprawdź dane by zdecydować, którego użyjesz.
    W przypadku gdy nie wiesz, który wybrać spróbuj każdego po kolei i zaznacz
te, które spełniały twoje oczekiwania.


UŻYWANIE NAZWANEGO PLIKU WYMIANY

Jeśli wiesz jakiego pliku wymiany szukasz możesz go odzyskać podając jego
nazwę. Vim odzyka nazwę oryginalnego pliku z pliku wymiany.

Przykład: >
	vim -r .help.txt.swo

Jest to również wygodne kiedy plik wymiany jest w innym katalogu niż
przewidywany. Jeśli to nadal nie działa, sprawdź jakie nazwy plików Vim podaje
i zmień pliki odpowiednio. Sprawdź opcję 'directory' by sprawdzić gdzie Vim
może przechowywać plik wymiany.

	Note:
	Vim próbuje znaleźć plik wymiany przeszukując katalogi w opcji 'dir'
	szukając plików, które pasują do "nazwapliku.sw?". Jeśli dopasowywanie
	nie działa (np.: jeśli opcja 'shell' jest nieprawidłowa), Vim
	desperacko próbuje znaleźć plik "nazwapliku.swp". Jeśli to również
	zawiedzie będziesz musiał podać nazwę pliku wymiany by być zdolnym do
	odzyskania pliku.

==============================================================================
*11.3*	Awaria czy nie?					*ATTENTION* *E325*

Vim próbuje chronić cię przed robieniem głupich rzeczy. Przypuśćmy, że
niewinnie zaczynasz edytować plik spodziewając się zobaczyć zawartość pliku.
W zamian Vim drukuje bardzo długą wiadomość:

		E325: ATTENTION ~
	Found a swap file by the name ".main.c.swp" ~
		  owned by: mool   dated: Tue May 29 21:09:28 2001 ~
		 file name: ~mool/vim/vim6/src/main.c ~
		  modified: no ~
		 user name: mool   host name: masaka.moolenaar.net ~
		process ID: 12559 (still running) ~
	While opening file "main.c" ~
		     dated: Tue May 29 19:46:12 2001 ~
 ~
	(1) Another program may be editing the same file. ~
	    If this is the case, be careful not to end up with two ~
	    different instances of the same file when making changes. ~
	    Quit, or continue with caution. ~
 ~
	(2) An edit session for this file crashed. ~
	    If this is the case, use ":recover" or "vim -r main.c" ~
	    to recover the changes (see ":help recovery"). ~
	    If you did this already, delete the swap file ".main.c.swp" ~
	    to avoid this message. ~

Dostajesz tą wiadomość ponieważ kiedy Vim zaczyna edycję pliku sprawdza czy
już istnieje plik wymiany dla tego plku. Jeśli jest, coś musiało pójść źle.
Może to być jedna z dwóch sytuacji.

1. Inna sesja edycji może być przeprowadzana na tym plku. Spójrz w wiadomość
   do linii z "process ID". Może ona wyglądać następująco:

	process ID: 12559 (still running) ~

   Tekst "(still running)" oznacza, że istnieje już proces edycji dla tego
   pliku na tym komputerze. Pracując na nie uniksowych systemach nie
   dostaniesz tej informacji. Kiedy edytujesz plik przez sieć również możesz
   nie otrzymać tej informacji ponieważ proces może istnieć na innym
   komputerze. W obu wypadkach musisz zorientować się w sytuacji samemu.
       Jeśli jest drugi Vim edytujący ten sam plik kontynuacja może skończyć
   się dwiema wersjami tego samego pliku. Ten zapisany ostatnio nadpisze
   poprzedni. Rezultatem może być utrata zmian. Lepiej wtedy wyjść z Vima.

2. Plik wymiany może być wynikiem poprzedniego krachu Vima lub komputera.
   Sprawdź dane wspomniane w wiadomości. Jeśli data pliku wymiany jest nowsza
   niż pliku, który edytujesz i pojawia się linia:

	modified: YES ~

   Prawdopodobnie miałeś awarię w czasie sesji edycji i lepiej odzyskać plik.
      Jeśli data pliku jest nowsza od daty pliku wymiany, plik został albo
   zmieniony po awarii (może odzyskałeś go wcześniej, ale nie usunąłeś pliku
   wymiany?), albo plik został zapisany przed awarią, ale po ostatnim
   zapisaniu pliku wymiany (wtedy masz szczęście: nie potrzebujesz starego
   pliku wymiany). W takich wypadkach Vim ostrzeże cię specjalną linią:

      NEWER than swap file! ~


NIECZYTELNY PLIK WYMIANY

Czasami pod nazwą pliku wymiany pojawia się komunikat

	[cannot be read] ~

W zależności od okoliczności jest to dobrze lub źle.

Dobrze jeśli zakończona padem poprzednia sesja załamała się w sytuacji bez
zmian w pliku. Plik wymiany będzie miał wielkość 0 bajtów, możesz go usunąć
i kontynuować.

Lekko niepokojące jest jeśli nie masz uprawnień odczytu do pliku. Możesz wtedy
przejrzeć plik tylko w trybie do odczytu lub zakończyć pracę. W systemach
wielo-użytkownikowych jeśli sam zrobiłeś zmiany pod inną nazwą użytkownika,
wylogowanie i ponowne zalogowanie pod inną nazwą powinno naprawić "błąd
odczytu". W innym wypadku powinieneś porozmawiać z osobą, która ostatnia
edytowała (lub cały czas edytuje) plik.

Bardzo źle jeśli oznacza to fizyczny błąd odczytu z dysku zawierającego plik
wymiany. Na szczęście jest to bardzo rzadki wypadek. Możesz obejrzeć plik
w trybie tylko do odczytu na początku, żeby zobaczyć zakres "zapomnianych"
zmian. Jeśli to twój plik przygotuj się na ponowne ich wprowadzenie.


CO ROBIĆ?

Jeśli jest wspomagana interakcja dostaniesz do wybory jedną z pięciu
możliwości:

  Swap file ".main.c.swp" already exists! ~
  [O]pen Read-Only, (E)dit anyway, (R)ecover, (Q)uit, (D)elete it: ~

O  Otwórz plik tylko do odczytu. Użyj tej opcji kiedy chcesz tylko zobaczyć
   plik, a nie potrzebujesz go odzyskiwać. Możesz to zrobić jeśli wiesz, że
   ktoś inny edytuje plik, ale chcesz tylo spojrzeć na niego, a nie robić
   zmiany.

E  Edytuj w każdym razie. Używaj tej opcji ostrożnie! Jeśli plik jest
   edytowany w innym Vimie możesz skończyć z dwoma wersjami pliku. Vim będzie
   próbował ostrzec cię o tym, ale lepiej być ostrożnym niż później żałować.

R  Odzyskaj plik z pliku wymiany. Używaja tego jeśli wiesz, że plik wymiany
   zawiera zmiany, które chcesz odzyskać.

Q  Wyjdź. W ten sposób unikasz edytowania pliku. Używaj tego jeśli inny Vim
   edytuje ten sam plik.
      Jeśli dopiero co zacząłeś Vima, w ten sposób go opuścisz. Jeśli
   zaczynasz Vima z plikami w kilku oknach, Vim wyjdzie jedynie wtedy jeśli
   istnieje plik wymiany dla pierwszego pliku. Używając komendy ":edit" plik
   nie zostanie załadowany, a ty wrócisz do poprzednio edytowanego pliku.

D  Usuń plik wymiany. Użyj tej opcji jeśli jesteś pewien, że go dłużej nie
   potrzebujesz. Na przykład jeśli nie zawiera zmian, albo sam plik jest
   nowszy niż plik wymiany.
      Na uniksach ta opcja jest oferowana tylko wtedy jeśli proces, który
   stworzył plik wymiany już nie istnieje.

Jeśli nie dostajesz możliwości wyboru (używasz wersji Vima, która jej nie
oferuje), musisz zrobić to ręcznie. By odzyskać plik użyj komendy: >

	:recover

Vim nie zawsze może sprawdzić czy istnieje już plik wymiany dla danego pliku.
Dzieje się tak wtedy kiedy inna sesja umieszcza plik wymiany w innym katalogu
albo kiedy ścieżka dla pliku jest różna dla edycji na różnych komputerach.
Z tego względu nie zawsze możesz polegać na tym, że Vim cię ostrzeże.

Jeśli naprawdę nie chcesz widzieć tej wiadomości możesz dodać flagę 'A' do
opcji 'shortmess'. Jest to jednak niezwykłe zachowanie.

==============================================================================
*11.4*	Dalsza lektura

|swap-file|   Wyjaśnienie gdzie będzie umieszczony plik wymiany i jaka będzie
              jego nazwa.
|:preserve|   Ręczne przesyłanie pliku wymiany na dysk.
|:swapname|   Sprawdź nazwę pliku wymiany dla bieżącego pliku.
'updatecount' Liczba uderzeń klawiszy, po których plik wymiany będzie
              przesłany na dysk.
'updatetime'  Czas po jakim plik wymiany będzie przesłany na dysk.
'swapsync'    Czy dysk jest zsynchronizowany kiedy plik wymiany jest
              przesyłany.
'directory'   Lista katalogów gdzie są przechowywane pliki wymiany.
'maxmem'      Limit pamięci do wykorzystania zanim tekst będzie zapisany do
              pliku wymiany.
'maxmemtot'   To samo, ale w sumie dla wszystkich plików.

==============================================================================

Następny rozdział: |usr_12.txt|  Sprytne sztuczki

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
