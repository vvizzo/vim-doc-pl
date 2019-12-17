*usr_28.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				   Zwijanie


Tekst strukturalny może być podzielony na sekcje. A sekcje w podsekcje.
Zwijanie pozwala na pokazanie sekcji jako jednej linii, zapewniając przegląd
zawartości pliku. Ten rozdział pokazuje parę sposobów jak to robić.

|28.1|	Czym jest zwijanie?
|28.2|	Ręczne zwijanie
|28.3|	Praca ze zwiniętymi obszarami
|28.4|	Zachowywanie i odzyskiwanie zwiniętych obszarów
|28.5|	Zwijanie według wcięcia
|28.6|	Zwijanie według zaznaczeń
|28.7|	Zwijanie według składni
|28.8|	Zwijanie według wyrażeń
|28.9|	Zwijanie niezmienionych linii
|28.10| Jakiej metody zwijania użyć?

 Następny rozdział: |usr_29.txt|  Poruszanie się po programach
Poprzedni rozdział: |usr_27.txt|  Polecenia wyszukiwania i wzorce
       Spis treści: |usr_toc.txt|

==============================================================================
*28.1*	Czym jest zwijanie?

Zwijanie służy do pokazanie pewnej ilości wierszy w buforze jako pojedynczej
linii na ekranie. Tak jak kawałek papieru jest zwinięty, żeby był krótszy:

	+------------------------+
	| linia 1		 |
	| linia 2		 |
	| linia 3		 |
	|_______________________ |
	\			 \
	 \________________________\
	 / zwinięte linie	  /
	/________________________/
	| linia 12		 |
	| linia 13		 |
	| linia 14		 |
	+------------------------+

Tekst jest cały czas w buforze, niezmieniony. Tylko sposób w jaki pokazane są
wiersze został zmieniony.

Zaletą zwijania jest to, że dostajesz lepszy przegląd struktury tekstu dzięki
zwinięciu całych sekcji i zastąpienie ich jedną linią, która wskazuje
zawartość sekcji.

==============================================================================
*28.2*	Ręczne zwijanie

Wypróbuj: umieść kursor w akapicie i wpisz: >

	zfap

Zobaczysz, że akapit został zastąpiony przez podświetloną linię. Stworzyłeś
zwinięty obszar (fałdę). |zf| jest operatorem, a |ap| obiektem tekstowym.
Możesz użyć operatora |zf| z każdym poleceniem ruchu aby stworzyć fałdę
z tekstu na którym porusza się kursor. |zf| działa także w trybie Visual.

Żeby zobaczyć tekst otwórz fałdę: >

	zo

I możesz ją zamknąć: >

	zc

Wszystkie polecenia zwijania zaczynają się "z". Dzięki odrobinie wyobraźni "z"
wygląda jak zwinięty kawałek papieru oglądany z boku. Litera po "z" ma
znaczenie mnemoniczne by łatwiej zapamiętać polecenia:

	zf	F-ałdę stwórz
	zo	O-twórz fałdę
	zc	C-lose (zamknij) fałdę

Fałdy mogą być zagnieżdżane: region tekstu, który zawiera fałdy może być
zwinięty znowu. Na przykład możesz zwinąć każdy akapit w tej sekcji, a potem
zwinąć wszystkie sekcje w rozdziale. Wypróbuj to. Zobaczysz, że otwarcie fałdy
całego rozdziału przywróci zagnieżdżone fałdy tak jak były, niektóre mogą być
otwarte, a niektóre zamknięte.

Przypuśćmy, że stworzyłeś kilka fałd, a teraz chcesz zobaczyć cały tekst.
Możesz przejść do każdej fałdy i wpisać "zo". Szybsze będzie użycie polecenia:
>
	zr

To r-edukuje zwinięcia. Odwrotnością jest: >

	zm

To m-asowo zamyka fałdy. Możesz powtarzać "zr" i "zm", żeby otwierać
i zamykać fałdy na kilku poziomach.

Jeśli masz zagnieżdżone kilka poziomów w głąb, możesz otworzyć je wszystkie: >

	zR

Otwiera fałdy R-ekursywnie dopóki wszystkie nie zostaną otwarte. Wszystkie
możesz zamknąć tak: >

	zM

Zwija M-asowo aż do końca.

Możesz szybko wyłączyć zwijanie poleceniem |zn|. |zN| przywraca fałdy takie
jak były. |zi| przełącza między tymi stanami. Wygodna metoda pracy:
- stwórz fałdy, żeby mieć wgląd w strukturę pliku
- przejdź tam gdzie chcesz pracować
- |zi|, żeby spojrzeć na tekst i go edytować
- znowu |zi|, żeby łatwo się przemieszczać

Więcej o ręcznym zwijaniu w Przewodniku Encyklopedycznym: |fold-manual|

==============================================================================
*28.3*	Praca ze zwiniętymi obszarami

Kiedy fałdy są zamknięte, polecenia ruchu takie jak "j" i "k" poruszają się
nad fałdą jakby to była pojedyncza, pusta linia. Pozwala to na szybkie
poruszanie się po pliku z fałdami.

Możesz yankować, usuwać i przemieszczać fałdy jakby to były pojedyncze linie.
Wygodne przy zmienianiu kolejności funkcji w programie. Najpierw upewnij się,
że każda fałda zawiera całą funkcję (albo odrobinę mniej) przez wybranie
odpowiedniej 'foldmethod'. Później usuń funkcję "dd", przenieś kursor i wpakuj
ją "p". Jeśli kilka linii funkcji jest powyżej lub poniżej fałdy możesz wybrać
tekst w trybie Visual:
- umieść kursor na pierwszej linii, która ma być przemieszczona
- zacznij tryb Visual "V"
- przenieś kursor do ostatniej linii, która ma być przemieszczona
- usuń wybrane linie "d"
- przenieś kursor do nowej pozycji i w"p"akuj tam linię.

Czasami trudno jest zobaczyć lub pamiętać gdzie konkretnie jest fałda i gdzie
będzie działać polecenie |zo|. Zobacz zdefiniowane fałdy: >

	:set foldcolumn=4

Pokaże małą kolumnę po lewej stronie okna by pokazać fałdy. "+" oznacza
zamkniętą fałdę, "-" oznacza początek otwartej fałdy, a "|" kolejne linie
otwartej fałdy.

Możesz użyć myszy do otwarcia fałdy klikając na "+" w fałdkolumnie. Kliknięcie
na "-" lub "|" zamknie otwartą fałdę.

Otwórz wszystkie fałdy w linii kursora |zO|.
Zamknij wszystkie fałdy w linii kursora |zC|.
Usuń fałdę w linii kursora |zd|.
Usuń wszystkie fałdy w linii kursora |zD|.

W trybie Insert, fałda gdzie znajduje się kursor nigdy nie jest zamknięta.
Pozawala to widzieć co piszesz!

Fałdy są otwierane automatycznie kiedy wykonuje się do nich skok lub porusza
kursor w lewo lub prawo. Na przykład, komenda "0" otwiera fałdę pod kursorem
(jeśli 'foldopen' zawiera "hor", które jest domyślną zawartością). Opcja
'foldopen' może zostać zmieniona by otwierać fałdy określonymi poleceniami.
Jeśli chcesz by linia pod kursorem była zawsze otwarta: >

	:set foldopen=all

Uwaga: nie będziesz w stanie przejść na zamkniętą fałdę. Możesz tego używać
czasowo, a potem wrócić do wartości domyślnej: >

	:set foldopen&

Fałdy będą się automatycznie zamykały kiedy z nich wyjdziesz: >

	:set foldclose=all

Zastosuje to ponownie 'foldlevel' dla wszystkich fałd, które nie zawierają
kursora. Musisz to wypróbować by wiedzieć jak się z tym czujesz. Użyj |zm| do
zwinięcia więcej i |zr| do zredukowania fałd.

Zwijanie jest lokalne dla okna. Pozwala to na otwarcie dwóch okien na ten sam
bufor, jeden z fałdami i jeden bez lub jeden z wszystkimi fałdami zwiniętymi
i jeden z wszystkimi fałdami otwartymi.

==============================================================================
*28.4*	Zachowywanie i odzyskiwanie zwiniętych obszarów

Kiedy opuścisz plik (otwierając inny), stan fałd jest stracony. Jeśli wrócisz
później do pliku wszystkie ręcznie otwarte i zamknięte fałdy są przywrócone do
domyślnego stanu. Wszystkie fałdy stworzene ręcznie są stracone! Żeby zachować
fałdy użyj polecenia |:mkview|: >

	:mkview

Zachowa ono ustawienia i różne inne rzeczy, które mają wpływ na to jak jest
prezentowany plik. Na to co jest zapamiętywane masz wpływ poprzez opcję
'viewoptions'. Jeśli wrócisz do tego samego pliku później, możesz załadować
widok: >

	:loadview

Możesz przechowywać do dziesięciu widoków jednego pliku. Na przykład, żeby
zachować bieżące ustawienia jako trzeci widok i załadować drugi: >

	:mkview 3
	:loadview 2

Zauważ, że kiedy wprowadzasz lub usuwasz wiersze widoki mogą się popsuć.
Sprawdź także opcję 'viewdir', która określa gdzie widoki są przechowywane.
Będziesz chciał od czasu do czasu usunąć stare widoki.

==============================================================================
*28.5*	Zwijanie według wcięcia

Definiowanie fałd |zf| to sporo roboty. Jeśli twój tekst jest strukturyzowany
przez dodawanie przedmiotom o niższym poziomie większego wcięcia, możesz użyć
zwijania według wcięcia. Tworzy ono fałdy dla każdej sekwencji linii z tym
samym wcięciem. Linie o większym wcięciu staną się fałdami zagnieżdżonymi.
Działa całkiem dobrze ze sporą ilością jezyków programowania.

Spróbuj ustawić opcję 'foldmethod': >

	:set foldmethod=indent

Teraz możesz użyć |zm| i |zr| do zwijania i rozwijania całych poziomów. Łatwo
to obserwować na następującym przykładzie:

Ta linia nie jest wcięta
	Ta linia jest wcięta raz
		Ta linia jest wcięta dwukrotnie
		Ta linia jest wcięta dwukrotnie
	Ta linia jest wcięta raz
Ta linia nie jest wcięta
	Ta linia jest wcięta raz
	Ta linia jest wcięta raz

Zauważ, że relacja między wielkością wcięcia i głebokością fałdy zależy od opcji
'shiftwidth'. Każda wartość 'shiftwidth' wcięcia dodaje jeden do głebokości
fałdy. Nazywa się to poziomem fałdy.

Kiedy używasz poleceń |zr| i |zm| zwiększasz lub zmniejszasz opcję
'foldlevel'. Możesz to zrobić bezpośrednio: >

	:set foldlevel=3

Oznacza to, że wszystkie fałdy z trzykrotnym wcięciem (liczonym według
'shiftwidth') lub większym zostaną zamknięte. Im niższa wartość 'foldlevel', tym
więcej fałd zostanie zamkniętych. Kiedy 'foldlevel' wynosi 0, wszystkie fałdy
są zamknięte. |zM| ustawia 'foldlevel' na zero. Przeciwne polecenie |zR|
ustawia 'foldlevel' na wartość równą najgłębszemu poziomowi fałd w pliku.

Stąd też dwa sposoby, by otworzyć i zamknąć fałdy:
(A) Przez ustawienie poziomu fałd.
    To szybki sposób na "oddalenie" by zobaczyć strukturę tekstu, przejście
    kursorem i "przybliżenie" tekstu.

(B) Używanie poleceń |zo| i |zc| do otwierania i zamykania fałd.
    W ten sposób otwierasz tylke te fałdy, które chcesz by były otwarte,
    podczas gdy inne pozostają zamnknięte.

Oczywiście możesz łączyć te sposoby: najpierw zamknij większość fałd
kilkukrotnie używając |zm|, a potem otwórz interesującą cię fałdę |zo|. Lub
otwórz wszystko |zR|, a potem zamknij niektóre fałdy |zc|.

Ale nie możesz definiować ręcznie fałd, kiedy 'foldmethod' jest równa
"indent", bo to mogłoby spowodować konflikt między wcięciem, a poziomem fałd.

Więcej o zwijaniu według wcięcia w Przewodniku Encyklopedycznym: |fold-indent|

==============================================================================
*28.6*	Zwijanie według markerów

Markerów w tekście używa się do określenia początku i końca zwiniętego
regionu. Daje to precyzyjną kontrolę nad tym, które linie mają być włączone do
fałd. Wadą tego rozwiązania jest konieczność modyfikacji tekstu.

Spróbuj: >

	:set foldmethod=marker

Przykładowy tekst, jaki mógłby się pojawić w programie C:

	/* foobar () {{{ */
	int foobar()
	{
		/* return a value {{{ */
		return 42;
		/* }}} */
	}
	/* }}} */

Zauważ, że linia fałdy pokaże tekst przed markerem. Bardzo wygodne bo
pokazuje co zawiera fałda.

Bardzo zaskakujące efekty potrafią się pojawić jeśli markery nie parują
się prawidłowo po przeniesieniu kilku linii. Można tego uniknąć używając
numerowanych markerów. Przykład:

	/* global variables {{{1 */
	int varA, varB;

	/* functions {{{1 */
	/* funcA() {{{2 */
	void funcA() {}

	/* funcB() {{{2 */
	void funcB() {}
	/* }}}1 */

Na każdym numerowanym markerze zaczyna się fałda o określonym poziomie.
Powoduje to, że każda fałda o wyższym poziomie kończy się w tym miejscu.
Wystarczy, że będziesz numerował markery otwierające do zdefiniowania
wszyskich fałd. Tylko wtedy kiedy chcesz zakończyć konkretną fałdę zanim
zacznie się inna potrzebujesz dodać marker zamykający.

Więcej o zwijaniu według markerów w Przewodniku Encyklopedycznym: |fold-marker|

==============================================================================

*28.7*	Zwijanie według składni

Dla każdego języka Vim używa innego pliku składni. Definiuje on kolory dla
różnych elementów pliku. Jeśli czytasz to w Vimie, na terminalu który wspiera
kolorowanie składni, kolory jakie widzisz są określone w pliku składni "help".
   W pliku składni możliwe jest dodanie przedmiotów składni, które mają
argument "fold". Definiują one regiony zwijania. Wymaga to napisania pliku
składni i dodania do niego tych przedmiotów. Nie jest to łatwe, ale raz
zrobione, zwijanie robione jest automatycznie.
   Tutaj przyjmujemy, że używasz istniejącego pliku składni. Nie ma nic więcej
do wyjaśnienia. Możesz otworzyć i zamknąć fałdy jak wyjaśniono wcześniej.
Fałdy będą tworzone i usuwane autowmatycznie kiedy edytujesz plik.

Więcej o zwijaniu według składni w Przewodniku Encyklopedycznym: |fold-syntax|

==============================================================================
*28.8*	Zwijanie według wyrażeń

Podobne do zwijania według wcięcia, ale zamiast używania wcięcia linii
wywoływana jest funkcja użytkownika do obliczenia poziomu zwinięcia. Możesz
tego użyć do tekstów gdzie coś w tekście wskazuje na to, że linie są ze sobą
związane. Przykładem jest e-mail gdzie cytowany tekst jest wyróżniony przez
">" przed linią. Żeby zwinąć te linie: >

	:set foldmethod=expr
	:set foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','',\"g\"),'[^>].*','',''))

Możesz to wypróbować na tym tekście:

> cytowany tekst
> cytowany tekst
> > podwójnie cytowany tekst
> > podwójnie cytowany tekst

Wyjaśnienie 'foldexpr' użytego w przykładzie (od środka):
   getline(v:lnum)			bieżąca linia
   substitute(...,'\\s','','g')		usuwa znaki odstępu z bieżącej linii
   substitute(...,'[^>].*','',''))	usuwa wszystko po pierwszych '>'
   strlen(...)				liczy długość łańcucha, która jest
					ilością znalezionych '>'

Zauważ, że backslash musi poprzedzać każdą spację, podwójny cudzysłów
i backslash w poleceniu ":set". Jeśli cię to peszy, zrób >

	:set foldexpr

Żeby sprawdzić aktualną wartość. Aby poprawić skomplikowane wyrażenie użyj
uzupełniania linii poleceń: >

	:set foldexpr=<Tab>

Gdzie <Tab> jest wciśnięciem klawisza. Vim uzupełni poprzednią wartość, którą
możesz edytować.

Więcej o zwijaniu według wyrażeń w Podręczniku Encyklopedycznym: |fold-expr|

==============================================================================
*28.9* Zwijanie niezmienionych linii

Użyteczne przy ustawieniu opcji 'diff' w tym samym oknie. Polecenie |vimdiff|
robi to za ciebie. Przykład: >

	setlocal diff foldmethod=diff scrollbind nowrap foldlevel=1

Zrób to w każdym oknie, które pokazuje różne wersje tego samego pliku.
Przejrzyście zobaczysz różnice między plikami bo tekst, którym się nie różnią
zostanie zwinięty.

Więcej szczegółów: |fold-diff|

==============================================================================
*28.10* Jakiej metody zwijania użyć?

Wszystkie te możliwoście powodują, że trudno zdecydować się na jedną z nich.
Niestety nie ma idealnego wyboru. Mogę jednak podać kilka wskazówek.

Jeśli istnieje zwijający plik składni dla języka, który edytujesz to jest to
najprawdopodobniej najlepszy wybór. Jeśli taki nie istnieje możesz spróbować
taki napisać. Wymagana jest dobra znajomość wzorców. Nie jest to łatwe, ale
jeśli działa nie musisz ręcznie definiować fałd.

Wydawanie poleceń do ręcznego tworzenia fałd może zostać użyte do zwijania
tekstu nie strukturalnego. Użyj potem |:mkview| do zachowania i przywracania
fałd.

Metoda markerów wymaga zmiany pliku. Jeśli dzielisz plik z innymi ludźmi lub
musisz wypełnić standardy w pracy możesz nie mieć na to pozwolenia.
   Główną zaletą markerów jest to, że możesz je umieszczać dokładnie tam gdzie
chcesz. W ten sposób trudniej zgubić kilka linii w czasie kopiowania
i usuwania fałd. Możliwe jest również dodanie komentarza co fałda zawiera.

Zwijanie według wcięcia jest czymś co działa w wielu plikach, ale nie zawsze
bardzo dobrze. Używaj tego jeśli nie możesz użyć żadnej innej metody. Jednak
jest to bardzo wygodne do tworzenia szkiców. Potem używasz jednego
'shiftwidth' dla każdego poziomu zagnieżdżenia.

Zwijanie według wyrażeń może stworzyć fałdy w prawie każdym ustrukturyzowanym
takście. Jest całkiem łatwo do zdefinowania, szczególnie jeśli start i koniec
fałdy jest łatwy do rozpoznania.
   Jeśli używasz metody "expr" do definiowania fałd, ale nie są one dokładnie
tym czym chcesz możesz przełączyć się na metodę "manual". Nie usunie to
zdefiniowanych fałd. Potem możesz usuwać i dodawać fałdy ręcznie.

==============================================================================

Następny rozdział: |usr_29.txt|  Moving through programs

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
