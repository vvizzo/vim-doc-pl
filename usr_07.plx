*usr_07.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

		       Edycja więcej niż jednego pliku


Nieważne ile masz plików, możesz edytować je wszystkie nie opuszczając Vima.
Zdefiniuj listę plików z którymi chcesz pracować i skacz z jednego do
drugiego. Kopiuj tekst z jednego i pakuj go do drugiego.

|07.1|	Edytuj inny plik
|07.2|	Lista plików
|07.3|	Skakanie z pliku do pliku
|07.4|	Pliki awaryjne
|07.5|	Kopiowanie tekstu między plikami
|07.6|	Podgląd pliku
|07.7|	Zmiana nazwy pliku

 Następny rozdział: |usr_08.txt|  Dzielenie okna
Poprzedni rozdział: |usr_06.txt|  Podświetlanie składni
       Spis treści: |usr_toc.txt|

==============================================================================
*07.1*	Edytuj inny plik

Jak dotąd musiałeś inicjować Vima dla każdego pliku jaki chciałeś edytować.
Jest prostszy sposób. Edytowanie innego pliku możesz zacząć poleceniem: >

	:edit foo.txt

Możesz użyć dowolnej nazwy pliku zamiast "foo.txt". Vim zamknie bieżący plik
i otworzy nowy. Jednak jeśli bieżący plik miał nie zachowane zmiany, Vim
wyświetli komunikat błędu i nie otworzy nowego pliku:

	E37: No write since last change (use ! to override) ~
	E37: Nie zapisano od ostatniej zmiany (wymuś przez !)~

	Note:
	Na początku każdej wiadomości wyświetlany jest numer błędu. Jeśli nie
	rozumiesz komunikatu lub tego co go spowodowało, użyj systemu pomocy
	dla tego numeru: >

		:help E37

W tej chwili masz kilka możliwości. Możesz zapisać plik poleceniem: >

	:write

Lub możesz zmusić Vima do porzucenia zmian i edytować nowy plik używając znaku
wymuszenia (!): >

	:edit! foo.txt

Jeśli chcesz edytować inny plik, ale jeszcze nie zapisywać zmiany w bieżącym
pliku możesz go ukryć: >

	:hide edit foo.txt

Zmiany w tekście są w nim nadal, ale nie możesz tego zobaczyć. Jest to
wyjaśnione w sekcji |22.4|: Lista buforów.

==============================================================================
*07.2*	Lista plików

Możesz zainicjować Vima by edytował sekwencję plików: >

	vim jeden.c dwa.c trzy.c

Polecenie to rozpoczyna Vima i mówi mu, że będziesz edytował trzy pliki. Vim
pokaże tylko pierwszy. Po tym jak z nim skończysz, żeby edytować następny
wydaj polecenie: >

	:next

Jeśli masz nie zachowane zmiany w bieżącym pliku zobaczysz komunikat błędu,
a ":next" nie zadziała. To ten sam problem co z ":edit" w poprzedniej sekcji.
Zmiany odrzucisz: >

	:next!

Ale najczęściej chcesz zachować zmiany i przejść do następnego pliku. Sluży do
tego specjalne polecenie: >

	:wnext

Robi to samo co dwie różne komendy: >

	:write
	:next


GDZIE JESTEM?

W celu sprawdzenia, który plik z listy edytujesz spójrz w tytuł okna. Powinien
pokazywać coś na kształt "(2 of 3)". Oznacza to, że edytujesz drugi z trzech
plików.
   Jeśli chcesz zobaczyć listę plików: >

	:args

To skrót od "arguments" (argumenty). Wynik może wyglądać tak: >

	jeden.c [dwa.c] trzy.c

To są pliki z którymi zaczynałeś. Ten, który aktualnie edytujesz, "dwa.c",
znajduje się w nawiasach kwadratowych.


PRZEJŚCIE DO INNYCH ARGUMENTÓW

By wrócić jeden plik do tyłu na liście: >

	:previous

Działa dokładnie jak polecenie ":next", z wyjątkiem tego, że porusza się
w innym kierunku listy plików. Istnieje też skrót jeśli chcesz zapisać
najpierw plik: >

	:wprevious

By przejść do ostatniego pliku z listy: >

	:last

I wrócić do pierwszego: >

	:first

Nie ma poleceń ":wlast" lub ":wfirst"!

Możesz użyć mnożnika dla poleceń ":next" i ":previous". Aby przejść dwa pliki
do przodu: >

	:2next


AUTOMATYCZNE ZAPISYWANIE

Podczas poruszania się po plikach i robieniu zmian musisz pamiętać o użyciu
":write". W innym wypadku będziesz cały czas dostawał komunikaty o błędach.
Jeśli jesteś pewien, że zawsze chcesz zapisywać zmodyfikowane pliki, możesz
kazać Vimowi by robił to automatycznie: >

	:set autowrite

Jeśli edytujesz plik, którego nie chcesz zapisać wyłącz tę opcję: >

	:set noautowrite


EDYCJA INNEJ LISTY PLIKÓW

Możesz zmienić listę plików bez potrzeby wychodzenia z Vima i zaczynania od
początku. Użyj tego polecenia by edytować trzy inne pliki: >

	:args pięć.c sześć.c siedem.h

Albo użyj "dzikich znaków" (kwantyfikatorów) tak jak są używane w powłoce: >

	:args *.txt

Vim przeniesie cię do pierwszego pliku na liście. Znowu, jeśli bieżący plik
został zmieniony możesz najpierw go zapisać albo użyć ":args!" (dodane !) by
zarzucić zmiany.


CZY EDYTOWAŁEŚ OSTATNI PLIK?
							*arglist-quit*
Kiedy używasz listy plików Vim przyjmuje, że chcesz edytować je wszystkie. By
powstrzymać cię przed wyjściem zbyt wcześnie dostaniesz komunikat błędu, że
nie jeszcze ostatniego pliku z listy: >

	E173: 46 more files to edit
	E173: jeszcze 46 plików do edycji

Jeśli naprawdę chcesz wyjść, zrób to znowu. Zadziała (ale tylko wtedy jeśli
nie wydałeś w międzyczasie innych poleceń).

==============================================================================
*07.3*	Skakanie z pliku do pliku

Szybko między plikami można skakać dzięki CTRL-^ (powyżej 6): >

	:args jeden.c dwa.c trzy.c

Jesteś teraz w jeden.c. >

	:next

Teraz jesteś w dwa.c. Użyj CTRL-^ by wrócić do jeden.c. Kolejne CTRL-^
i z powrotem jesteś w dwa.c. Jeszcze raz CTRL-^ i znów w jeden.c. Jeśli teraz
zrobisz: >

	:next

Jesteś w trzy.c. Zauważ, że polecenie CTRL-^ nie zmienia idei gdzie jesteś
w liście plików. Robią to tylko polecenia takie jak ":next" i ":previous".

Plik, który poprzednio edytowałeś jest nazywany plikiem "zamiennym" (ang.
alternate). Jeśli dopiero co zacząłeś Vima CTRL-^ nie będzie działać ponieważ
nie ma poprzedniego pliku.


PREDEFINIOWANE ZAKŁADKI

Po skoku do innego pliku możesz użyć dwóch bardzo użytecznych predefiniowanych
zakładek: >

	`"

Ta zabiera cię do miejsca gdzie był kursor gdy opuszczałeś plik. Inna zakładka
pamięta miejsce gdzie robiłeś ostatnią zmianę: >

	`.

Przypuśćmy, że edytujesz plik "jeden.txt". Gdzieś w połowie pliku używasz "x"
by usunąć znak. Potem idziesz do ostatniej linii ("G") i zapisujesz plik
(":w"). Edytujesz kilka innych plików, a potem używasz ":edit jeden.txt" by
wrócić do pliku "jeden.txt". Jeśli teraz użyjesz `" Vim skoczy do ostatniej
linii pliku. Użycie `. zabiera cię do pozycji gdzie usunąłeś znak. Nawet kiedy
będziesz poruszał się po pliku `" i `. zabiorą cię do zapamiętanych miejsc.
Przynajmniej do momentu kiedy zrobisz inną zmianę lub opuścisz plik.


ZAKŁADKI W PLIKU

W rozdziale 4 zostało wyjaśnione jak możesz umieścić zakładkę w pliku
poleceniem "mx" i skoczyć do tego miejsca dzięki "`x". To działa w jednym
pliku. Jeśli edytujesz inny plik i umieszczasz tam zakładki są one lokalne
dla tego pliku. Każdy plik ma własny zestaw zakładek.
   Jak dotąd używaliśmy zakładek z małych liter. Są też zakładki z wielkich
liter. Te są globalne i mogą być użyte z każdego pliku. Przypuśćmy, że
edytujemy plik "foo.txt". Przejdź do połowy pliku ("50%") i umieść tam
zakładkę F (F jak foo): >

	50%mF

Teraz edytuj plik "bar.txt" i umieść tam zakładkę B (B jak bar) w ostatniej
linii: >

	GmB

Teraz możesz użyć polecenia "'F" by skoczyć do połowy pliku foo.txt. Lub
wyedytować jeszcze inny plik, wpisać "'B" i znaleźć się na końcu bar.txt.

Zakładki w plikach są pamiętane dopóki nie są umieszczone gdzie indziej.
Dlatego możesz umieścić zakładkę, edytować godzinami i ciągle być zdolnym do
skoku do tej zakładki.
   Pożytecznym jest wymyślić proste powiązanie między literą zakładki
i miejscem jej umieszczenia. Na przykład możesz użyć zakładki H dla pliku
nagłówkowego, M w Makefile, a C w pliku C.

Jeśli chcesz zobaczyć gdzie są poszczególne zakładki podaj argument poleceniu
":marks": >

	:marks M

Możesz podać kilka argumentów: >

	:marks MCP

Nie zapominaj, że istnieją komendy CTRL-O i CTRL-I, którymi można skoczyć do
starszych i nowszych pozycji bez umieszczania zakładek.

==============================================================================
*07.4*	Pliki awaryjne

Zazwyczaj Vim nie robi plików awaryjnych. Jeśli chcesz mieć takie, wszystko co
musisz zrobić to: >

	:set backup

Nazwą pliku jest nazwa pliku oryginalnego z dodanym "~" na koniec. Jeśli twój
plik został nazwany dane.txt, plik awaryjny będzie miał nazwę dane.txt~.
   Możesz zmienić rozszerzenie, jeśli nie lubisz ~: >

	:set backupext=.bak

Plik będzie nazywał się dane.txt.bak, a nie dane.txt~.
   Inną liczącą się tu opcją jest 'backupdir'. Od niej zależy gdzie będą
zapisywane pliki awaryjne. Domyślnym zachowaniem jest zapisanie pliku
awaryjnego w tym samym katalogu co plik oryginalny - w większości wypadków
jest to odpowiednie zachowanie.

	Note:
	Kiedy opcja 'backup' nie jest ustawiona, ale jest opcja 'writebackup'
	Vim będzie tworzył plik awaryjny. W tym wypadku będzie on usunięty jak
	tylko oryginalny plik zostanie zapisany poprawnie. Ta opcja służy jako
	środek bezpieczeństwa przeciw utracie oryginalnego pliku jeśli
	zapisywanie w jakiś sposób zawiedzie (pełen dysk jest najczęstszym
	przypadkiem; czasami zdarza się też trafienie błyskawicą).


ZACHOWANIE ORYGINALNEGO PLIKU

Jeśli edytujesz pliki źródłowe możesz chcieć zachować oryginalny plik zanim
zrobisz w nim jakieś zmiany. Ale plik awaryjny będzie nadpisywany za każdym
razem kiedy zapisujesz plik i zawiera on tylko poprzednią wersję, nie
pierwszą.
   Vim zatrzyma oryginalny plik dzięki opcji 'patchmode'. Określa ona
rozszerzenie jakie będzie miał pierwszy plik awaryjny zmienionego pliku.
Zazwyczaj wygląda to tak: >

	:set patchmode=.orig

Teraz kiedy edytujesz plik dane.txt po raz pierwszy, robisz zmiany
i zapisujesz plik, Vim zachowa niezmienioną kopię pliku pod nazwą
"dane.txt.orig".
   Jeśli robisz dalsze zmiany, Vim zauważy, że plik "dane.txt.orig" już
istnieje i zostawi go w spokoju. Kolejne pliki awaryjne będą nazywane
"dane.txt~" (lub zgodnie z wartością opcji 'backupext').
   Jeśli pozostawisz opcję 'patchmode' pustą (domyślne zachowanie), oryginalny
plik nie będzie zachowany.

==============================================================================
*07.5*	Kopiowanie tekstu między plikami

Tutaj wyjaśnimy jak skopiować tekst z jednego pliku do innego. Zacznijmy
z prostym przykładem. Edytuj plik zawierający tekst, który chcesz skopiować.
Przenieś kursor na początek tekstu i wciśnij "v". Wchodzisz w tryb Visual.
Teraz przenieś kursor do końca tekstu i wciśnij "y". To yankuje (kopiuje)
wybrany tekst.
   Żeby skopiować powyższy paragraf powinieneś zrobić: >

	:edit tenplik
	/Tutaj
	vjjjj$y

Teraz otwórz plik do którego chcesz ten tekst wpakować. Przenieś kursor do
znaku po którym chcesz by tekst się pojawił. Użyj "p" do wpakowania tekstu. >

	:edit innyplik
	/Tam
	p

Oczywiście możesz użyć wielu innych poleceń do yankowania tekstu. Na przykład
do wybierania całych linii trybu Visual zaczynanego "V". Lub CTRL-V do
wybrania prostokątnego bloku. Lub "Y" do yanknięcia pojedynczej linii, "yaw"
do yank-a-word (yank-a-wyraz), itd.
   Komenda "p" pakuje tekst po kursorze. "P" pakuje go przed kursorem. Zauwaź,
że Vim pamięta czy yankowałeś całą linię czy blok i pakuje tekst z powrotem
w ten sam sposób.


UŻYWANIE REJESTRÓW

Kiedy chcesz skopiować kilka fragmentów tekstu z jednego pliku do innego,
przełączanie się między plikami i zapisywanie pliku docelowego za każdym razem
zabiera sporo czasu. Możesz go trochę oszczędzić kopiując każdy fragment
tekstu do jego własnego rejestru.
   Rejestr jest miejscem gdzie Vim przechowuje tekst. Tutaj użyjemy rejestrów
nazywanych od a do z (później odkryjesz, że istnieją jeszcze inne). Skopiujmy
zdanie do rejestru p (p jak pierwszy): >

	"pyas

Polecenie "yas" yankuje zdanie jak przedtem. To "p mówi Vimowi, że tekst
powinien być umieszczony w rejestrze p. Musi to być wyszczególnione tuż przed
komendą yankowania.
   Teraz yankuj trzy całe linie do rejestru l (l jak linia): >

	"l3Y

Mnożnik mógłby być też przed "l. Do zyankowania bloku tekstu do rejestru
b jak blok: >

	CTRL-Vjjww"by

Zauważ, że nazwa rejestru "b jest tuż przed komendą "y". Jest to konieczne.
Gdybyś użył nazwy rejestru przed komendą "w" cała sekwencja nie zadziałałaby.
   Masz teraz trzy fragmenty tekstu w rejestrach p, l i b. Otwórz inny plik
i umieść tekst gdzie chcesz: >

	"pp

Nazwa rejestru "p jest tuż przed komendą "p".
   Możesz umieszczać zawartość rejestrów w dowolnej kolejności. Tekst
pozostaje w rejestrze dopóki nie yankujesz tam czegoś innego. Dlatego możesz
wstawiać zawartość rejestru ile razy chcesz.

Kiedy usuwasz tekst także możesz wskazać rejestr. Służy to do przemieszczania
fragmentów tekstu. Na przykład, aby delete-a-word i zapisać je do rejestru w:
>
	"wdaw

Znowu, wskaźnik rejestru jest tuż przed komendą usuwania "d".


DODAWANIE DO PLIKU

Do zbierania linii tekstu do jednego pliku, możesz użyć polecenia: >

	:write >> logfile

Dopisze ono tekst bieżącego pliku do końca "logfile". Unikasz w ten sposób
kopiowania linii, otwierania pliku logów i pakowania linii na koniec.
Oszczędzasz w ten sposób dwa kroki, ale możesz tylko dodawać do końca pliku.
   By dodać tylko kilka linii, wybierz je w trybie Visual przed wydaniem
polecenia ":write". W rozdziale 10 nauczysz się innych sposobów określania
zasięgu linii.

==============================================================================
*07.6*	Podgląd pliku

Czasami chcesz tylko zobaczyć co zawiera plik bez ochoty na wprowadzanie
zmian. Istnieje ryzyko odruchowego wpisania ":w" i nadpisania oryginalnego
pliku. Możesz tego uniknąć otwierając plik tylko do odczytu.
   Vima w trybie tylko do odczytu zaczynasz poleceniem: >

	vim -R plik

Na Uniksie to polecenie też powinno załatwić sprawę: >

	view plik

Edytujesz teraz "plik" w trybie tylko do odczytu. Kiedy spróbujesz użyć ":w"
otrzymasz komunikat błędu i plik nie zostanie zapisany.
   Kiedy próbujesz zrobić zmianę w pliku Vim wyśle komunikat:

	W10: Warning: Changing a readonly file ~

Mimo to zmiana będzie wprowadzona. Pozwala to na formatowanie pliku, choćby
dla łatwiejszego czytania.
   Jeśli robisz zmiany w pliku i zapomnisz, że jest on tylko do odczytu możesz
mimo to go zapisać. Dodaj ! do polecenia ":write" by wymusić zapisywanie.

Jeśli naprawdę chcesz zabronić robienia zmian w pliku zrób: >

	vim -M file

Teraz każda próba zmiany tekstu nie powiedzie się. Tak są ustawione pliki
pomocy. Jeśli spróbujesz wprowadzić zmianę dostaniesz komunikat:

	E21: Cannot make changes, 'modifiable' is off~
	E21: Nie mogę wykonać zmian, 'modifiable' jest wyłączone~

Możesz użyć argumentu -M dla ustawienia Vima w trybie "widokowym". Jest to
tylko dobrowolne ponieważ te polecenia usuną zabezpieczenia: >

	:set modifiable
	:set write

==============================================================================
*07.7*	Zmiana nazwy pliku

Sprytnym sposobem tworzenia nowego pliku jest użycie starego pliku, który
zawiera większość tego co potrzebujesz. Na przykład, zaczynasz pisać nowy
program do przenoszenia plików. Wiesz, że masz już program kopiujący plik,
dlatego zaczynasz: >

	:edit copy.c

Teraz usuwasz rzeczy, których nie potrzebujesz. Potrzebujesz zapisać plik pod
inną nazwą. Możesz użyć polecenia ":saveas": >

	:saveas move.c

Vim zapisze plik pod podaną nazwą i otworzy ten plik. Dlatego kiedy następnym
razem użyjesz ":write", zapisze "move.c". "copy.c" pozostanie niezmienione.
   Kiedy chcesz zmienić nazwę pliku, który edytujesz, ale nie chcesz zapisać
pliku użyj: >

	:file move.c

Vim oznaczy plik jako "nie edytowany". Oznacza to, że Vim wie, że to nie jest
plik, który zacząłeś edytować. Kiedy spróbujesz zapisać plik możesz zobaczyć
komunikat:

	E13: File exists (use ! to override)~
	E13: Plik istnieje (wymuś poprzez !)~

Chroni cię to przed przypadkowym nadpisaniem innego pliku.

==============================================================================

Następny rozdział: |usr_08.txt|  Dzielenie okna

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
