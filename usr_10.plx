*usr_10.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 Duże zmiany


W rozdziale czwartym wyjaśniliśmy kilka sposobów wykonywania małych zmian. Ten
rozdział wyjaśni jak robić zmiany, które będą powtarzane lub mogą dotyczyć
dużych części tekstu. Tryb Visual pozwala na robienie różnych rzeczy z blokami
tekstu. Nauczysz się także używać zewnętrznych programów do robienia naprawdę
skomplikowanych rzeczy.

|10.1|	Nagrywanie i odtwarzanie poleceń
|10.2|	Zamiana
|10.3|	Zasięg poleceń
|10.4|	Komenda global
|10.5|	Tryb Visual Block
|10.6|	Odczytywanie i zapisywanie części pliku
|10.7|	Formatowanie tekstu
|10.8|	Zmiana wielkości litery
|10.9|	Używanie zewnętrznych programów

 Następny rozdział: |usr_11.txt|  Odzyskiwanie plików po awarii
Poprzedni rozdział: |usr_09.txt|  GUI
       Spis treści: |usr_toc.txt|

==============================================================================
*10.1*	Nagrywanie i odtwarzanie poleceń

Komenda "." powtarza poprzednią zmianę. Ale co jeśli chcesz zrobić więcej niż
pojedynczą zmianę? Tutaj przychodzi z pomocą nagrywanie poleceń. Trzy kroki:

1. Polecenie "q{rejestr}" zaczyna nagrywanie uderzeń klawiszy do rejestru
   {rejestr}. Nazwą rejestru musi być litera od a do z.
2. Wpisz swoje polecenia.
3. Wciśnij q (bez dodatkowego znaku) do zakończenia nagrywania.

Teraz możesz wykonać makro wpisując "@{rejestr}".

Spójrzmy jak to się dzieje w praktyce. Masz listę nazw plików wyglądającą tak:

	stdio.h ~
	fcntl.h ~
	unistd.h ~
	stdlib.h ~

A chcesz uzyskać coś takiego:

	#include "stdio.h" ~
	#include "fcntl.h" ~
	#include "unistd.h" ~
	#include "stdlib.h" ~

Przechodzisz do pierwszego znaku w pierwszej linii. Następnie wykonujesz
polecenia:

	qa			Zacznij nagrywać makro do rejestru a.
	^			Przejdź do początku linii.
	i#include "<Esc>	Wprowadź łańcuch #include " na początku linii.
	$			Przejdź do końca linii.
	a"<Esc>			Dodaj znak podwójnego cudzysłowu (") na końcu
				linii.
	j			Przejdź do następnej linii.
	q			Zakończ nagrywać makro.

Teraz kiedy zrobiłeś to raz możesz powtórzyć zmianę wydając polecenie "@a"
trzy razy.
Polecenie "@a" może być poprzedzone mnożnikiem, który spowoduje, że makro
zostanie wykonany tyle razy ile wynosi jego wartość. W tym wypadku wpisz: >

	3@a


PRZEJDŹ I WYKONAJ

Możesz mieć linie, które chcesz zmienić w różnych miejscach. Wystarczy
przenieść kursor do odpowiedniego miejsca i użyć polecenia "@a". Jeśli
zrobiłeś to raz możesz to powtórzyć "@@". Odrobinę łatwiejsze do wpisania.
Jeśli teraz wykonasz rejestr b z "@b", następne "@@" użyje rejestru b.
   Jeśli porównasz metodę odtwarzania z "." zobaczysz kilka różnic. Przede
wszystkim, "." może powtórzyć tylko jedną zmianę. Jak zobaczyłeś w przykładzie
powyżej nagrywanie może zrobić wiele zmian. Po drugie, "." pamięta tylko
ostatnią zmianę.  Wykonanie rejestru pozwala na zrobienie potem zmian i cały
czas możesz użyć "@a" do odtworzenia poleceń. W końcu, możesz użyć 26 różnych
rejestrów. Masz do dyspozycji 26 różnych sekwencji poleceń do wykonania.


REJESTRY

Rejestry używane do nagrywania są tymi samymi, których używasz do yankowania
i usuwania. Pozwala to na mieszanie nagrywania z innymi poleceniami do
manipulowania rejestrami.
   Przypuśćmy, że masz nagrane kilka poleceń w rejestrze n. Kiedy wykonujesz
"@n" zauważyłeś, że coś poszło źle. Możesz spróbować nagrać go znowu, ale
prawdopodobne jest, że zrobisz inny błąd. Zamiast tego zrób:

	G			Przejdź do końca pliku.
	o<Esc>			Otwórz pustą linię.
	"np			Wpakuj tekst z rejestru n. Możesz teraz
				zobaczyć polecenia, które wklepałeś jako tekst
				w pliku.
	{edycja}		Zmień polecenia, które były złe. To jest jak
				edycja tekstu.
	0			Przejdź do początku linii.
	"ny$			Yankuj poprawione polecenia do rejestru n.
	dd			Usuń niepotrzebną teraz linię.

Teraz możesz wykonać poprawione polecenia z "@n". (Jeśli nagrane polecenia
zawierają znaki końca linii dostosuj ostatnie dwa punkty w przykładzie by
włączyć wszystkie linie).


DODAWANIE DO REJESTRU

Jak na razie używaliśmy małych liter jako nazw rejestrów. By dodać coś do
rejestru użyj wielkiej litery.
   Przypuśćmy, że nagrałeś do rejestru c polecenie, które zmienia słowo.
Działa prawidłowo, ale chcesz dodać poszukiwanie następnego wystąpienia tego
słowa do zmiany. Robisz to tak: >

	qC/wyraz<Enter>q

Zaczynasz "qC", które dogrywa do rejestru c. Zapisywanie do rejestru używając
wielkiej litery oznacza dodawanie do rejestru o tej samej literze, ale małej.

Działa to nie tylko do nagrywania, ale i yankowania oraz usuwania. Na przykład
chcesz zebrać kilka różnych linii w rejestrze. Yankuj pierwszą linię:
>
	"aY

Teraz prejdź do następnej linii i wpisz: >

	"AY

Powtarzaj to polecenie dla wszystkich linii. Rejestr a zawiera teraz wszystkie
te linie w kolejności w jakiej je yankowałeś.

==============================================================================
*10.2*	Zamiana

Polecenie ":substitute" umożliwia wykonanie zamiany łańcuchów na żądanym
zasięgu. Ogólna forma polecenia: >

	:[zasięg]substitute/z/do/[flagi]

To polecenie zmienia łańcuch "z" na łańcuch "do" w liniach określonych przez
 [zasieg]. Na przykład, możesz zmienić "Professor" na "Teacher" we wszystkich
liniach tym poleceniem: >

	:%substitute/Professor/Teacher/
<
	Note:
	Polecenie ":substitute" prawie nigdy nie jest używane w pełnej formie.
	Większość czasu ludzie używają skróconej wersji ":s". Od tego momentu
	będziemy używać formy skróconej.

"%" przed poleceniem oznacza, że polecenie działa na wszystkie linie. Bez
zasięgu, ":s" działa tylko na bieżącej linii. Więcej o zasięgu w następnej
sekcji.

Domyślnie polecenie ":substitute" zmienia tylko pierwsze wystąpienie w każdej
linii. Na przykład, poprzednie polecenie zmienia linię:

	Professor Smith criticized Professor Johnson today. ~

na:

	Teacher Smith criticized Professor Johnson today. ~

Żeby zmienić każde wystąpienie w linii musisz dodać plagę g (globalna).
Polecenie: >

	:%s/Professor/Teacher/g

da w wyniku (zaczynając z oryginalnej linii):

	Teacher Smith criticized Teacher Johnson today. ~

Innymi flagami są: p (print, pokaż), powoduje ona, że polecenie ":substitute"
pokaże każdą linię, którą zmienia; c (confirm, potwierdź) informuje
":substitute", żeby prosiło cię o potwierdzenie przed wykonaniem zamiany.
Wprowadź: >

	:%s/Professor/Teacher/c

Vim znajduje pierwsze wystąpienie "Professor" i podświetla tekst, który zamierza
zmienić. Dostajesz taki znak zachęty: >

	replace with Teacher (y/n/a/q/l/^E/^Y)?
	zamień na Teacher (y/n/a/q/l/^E/^Y)?

Teraz musisz wprowadzić jedną z następujących odpowiedzi:

	y		Tak (Yes); zrób tę zmianę.
	n		Nie (No); opuść to dopasowanie.
	a		Wszystko (All); zrób tę zmianę i wszystkie pozostałe
			bez dalszych pytań.
	q		Wyjdź (Quit); nie rób więcej żadnych zmian.
	l		Ostatnia (Last); zrób tę zmianę, a potem wyjdź.
	CTRL-E		Przewiń tekst jedną linię do góry.
	CTRL-Y		Przewiń tekst jedną linię w dół.


Część "z" polecenia zamiany jest wzorcem. Takim samym jak używany w poleceniu
poszukiwania. Na przykład, to polecenie zamienia "kot" tylko wtedy jeśli
pojawi się na początku linii: >

	:s/^kot/kotołak/

Jeśli w poleceniu ":s" w części "z" lub "do" znajduje się slash musisz go
poprzedzić backslashem. Prostszym sposobem jest użycie innego znaku zamiast
slasha. Na przykład plusa: >

	:s+jeden/dwa+jeden lub dwa+

==============================================================================
*10.3*	Zasięg poleceń

Polecenie ":substitute", jak wiele innych poleceń ":", może być zastosowane do
wybranych linii. Nazywa się to zasięgiem.
   Prostą formą zasięgu jest {liczba},{liczba}. Na przykład: >

	:1,5s/to/na to/g

Wykonuje polecenie zamiany na liniach 1 do 5. Linia 5 jest włączona. Zasięg
jest zawsze umieszczany przed poleceniem.

Pojedyncza liczba może być użyta do wskazania konkretnej linii: >

	:54s/Prezydent/Głupiec/

Niektóre polecenia pracują na całym pliku jeśli nie określisz zasięgu. Żeby
zadziałały tylko na bieżącej linii użyj adresu ".". Tak działa polecenie
":write". Bez zasięgu zapisze cały plik. To polecenie zapisze tylko bieżącą
linię do innyplik: >

	:.write innyplik

Pierwsza linia zawsze ma numer jeden. A ostatnia? Określa ją znak "$". Na
przykład by zmienić coś w pliku od linii w której znajduje się kursor do końca
pliku: >

	:.,$s/tak/nie/

Zasięg "%", którego wcześniej używaliśmy jest skrótem na "1,$": od pierwszej
do ostatniej linii.


WZORZEC W ZASIĘGU

Przypuśćmy, że edytujesz rozdział w książce i chcesz zastąpić wszystkie
wystąpienia "tak" na "nie". Ale tylko w tym rozdziale, nie w następnym. Wiesz,
że tylko granice rozdziałów mają słowo "Rozdział" w pierwszej kolumnie. To
polecenie załatwi sprawę: >

	:?^Rozdział?,/^Rozdział/s=tak=nie=g

Możesz zobaczyć, że wzorzec wyszukujący jest użyty dwukrotnie. Pierwszy
"?^Rozdział?" wyszukuje linię powyżej obecnej pozycji. Podobnie "/^Rozdział/"
wyszukuje wprzód początku następnego rozdziału.
   By uniknąć pomieszania ze slashami, znak "=" zastąpił je w poleceniu
zamiany. Slash lub inny znak działałby równie dobrze.


DODAJ I ODEJMIJ

W powyższym poleceniu jest drobny błąd: jeśli tytuł następnego rozdziału
zawiera słowo "tak" też zostanie ono zmienione. Być może jest to to czego
chcesz, ale co jeśli nie? Wtedy określasz offset.
   Do znalezienia wzorca i użycia linii powyżej niego: >

	/Rozdział/-1

Możesz użyć dowolnego numeru zamiast 1. Druga linia poniżej dopasowania jest
znaleziona w ten sposób: >

	/Rozdział/+2

Offsety mogą być użyte w połączeniu z innymi rzeczami w zasięgu. Spójrz tu: >

	:.+3,$-5

Określony tu jest zasięg, który zaczyna się 3 linie poniżej kursora i kończy
5 linii powyżej ostatniej linii w pliku.


ZAKŁADKI

Zamiast wyszukiwania numerów linii konkretnych miejsc w pliku, zapamiętywania
ich i wpisywania ich w zasięgu możesz użyć zakładek.
   Umieść zakładki w rozdziale 3. Na przykład, użyj "mg" do zazanaczenia góry
obszaru i "md" do zaznaczenia dołu. Później możesz użyć ich w zasięgu
(włączając linie z zakładkami): >

	:'g,'d


TRYB VISUAL I ZASIĘG

Możesz wybrać tekst w trybie Visual. Jeśli wtedy wciśniesz ":" by rozpocząć
polecenie dwukropka zobaczysz to: >

	:'<,'>

Teraz wpisz polecenie i zostanie ono zastosowane na obszarze, który był
zaznaczony.

	Note:
	Używając trybu Visual pamiętaj, że niezależnie czy wybierasz część
	linii, czy CTRL-V do wybrania bloku, polecenia dwukropka będą i tak
	zastosowane w całej linii. Może się to zmienić w przyszłych wersjach
	Vima.

'< i '> są to zakładki umieszczone, odpowiednio, na początku i końcu wybranego
obszaru. Zakładki pozostają na miejscu dopóki nie zostanie zaznaczony inny
obszar w trybie Visual. Dlatego możesz użyć polecenia "'<" by skoczyć do
miejsca gdzie zaczynał się wybrany obszar. Możesz też mieszać te zakładki
z innymi znakami: >

	:'>,$

Wskazuje linie od końca zaznaczonego obszaru do końca pliku.


ILOŚĆ LINII

Jeśli wiesz ile linii chcesz zmienić możesz wpisać liczbę, a dopiero potem
":". Na przykład, jeśli wpiszesz "5:", dostaniesz: >

	:.,.+4

Teraz możesz wpisać polecenie, którego chcesz użyć. Użyje ono zasięgu od "."
(bieżąca linia) do ".+4" (cztery linie w dół). W sumie użyje pięciu linii.

==============================================================================
*10.4*	Komenda global

Polecenie ":global" jest jednym z najpotężniejszych poleceń Vima. Pozwala ono
na znalezienie dopasowania wzorca i wykonanie tam polecenia. Ogólna forma to:
>

	:[zasięg]global/{wzorzec}/{polecenie}

Jest podobna do polecenia ":substitute". Ale zamiast zamieniania dopasowanego
tekstu innym tekstem, polecenie {polecenie} jest wykonywane.

	Note:
	Polecenie wykonywane dla ":global" musi być jednym z tych, które
	zaczynają się dwukropkiem. Polecenia trybu Normal nie mogą być użyte
	bezpośrednio. Komenda |:normal| zrobi to pośredno.

Przypuśćmy, że chcesz zmienić "foobar" na "barfoo", ale tylko w komentarzach
w stylu C++. Polecenia te zaczynają się "//". Użyj polecenia: >

	:g+//+s/foobar/barfoo/g

Zaczyna się ":g". Jest to skrót na ":global", tak jak ":s" jest skrótem na
":substitute". Później jest wzorzec zamknięty w znakach plusa. Ponieważ
wzorzec którego szukamy zawiera slashe użycie znaków plusa oddziela wzorzec.
Natępne jest polecenie zamiany, które zmienia "foobar" na "barfoo".
   Domyślnym zasięgiem dla polecenia global jest cały plik. Dlatego zasięg nie
został tu określony. Jest tu różnica w stosunku do ":substitute", które
pracuje na pojedynczej linii jeśli nie ma podanego zasięgu.
   Polecenie nie jest doskonałe ponieważ dopasowuje też linie gdzie "//"
pojawia się w połowie linii, a zamiana będzie także działać przed "//".

Tak jak z ":substitute" może być dowolny wzorzec. Kiedy później nauczysz się
bardziej skomplikowanych wzorców możesz ich tu użyć.

==============================================================================
*10.5*	Tryb Visual Block

CTRL-V zaczyna wybieranie prostokątnego obszaru tekstu. Jest kilka poleceń,
które robią coś niezwykłego z blokiem tekstu.

Komenda "$" robi coś specjalnego w trybie Visual Block. Jeśli ostatnim użytym
poleceniem ruchu był "$", wszystkie objęte trybem Visual Block linie zostaną
podświetlone do końca linii, także jeśli linia z kursorem jest krótsza.
Zaznaczenie pozostaje dopóki nie użyjesz polecenia ruchu poziomego. Dlatego
"j" utrzymuje to podświetlenie, "h" kończy.


WPROWADZANIE TEKSTU

Polecenie "I{string}<Esc>" wprowadza tekst {string} w każdej linii, na lewo od
bloku. Zaczynasz wciskając CTRL-V by zacząć tryb Visual Block. Teraz
zaznaczasz blok, wciskasz I zaczynając tryb Insert, a następnie tekst, który
zamierzasz wprowadzić. Kiedy go wpisujesz pojawia się on tylko w pierwszej
linii.
   Po tym jak wciśniesz <Esc> kończąc wprowadzanie, tekst po chwili magicznie
pojawi się przed wszystkimi zaznaczonymi liniami. Przykład:

	include jeden ~
	include dwa ~
	include trzy ~
	include cztery ~

Przejdż do "j" w "jeden" i wciśnij CTRL-V. Przejdź w dół "3j" do "cztery".
Masz teraz blok, który obejmuje cztery linie. Teraz wpisz: >

	Imain.<Esc>

Wynik:

	include main.jeden ~
	include main.dwa ~
	include main.trzy ~
	include main.cztery ~

Jeśli blok obejmuje krótkie linie, które nie są na tyle długie by do niego
trafić, tekst nie jest wstawiany do tych linii. Na przykład stwórz blok, który
obejmuje słowo "długa" w pierwszej i ostatniej linii tego tekstu, a nie
zawiera tekstu z drugiej linii:

	To jest pewna długa linia ~
	krótka ~
	Inna, ale też długa linia ~
		      ^^^^^ wybrany blok

Wydaj teraz polecenie "Ibardzo <Esc>". Wynikiem jest:

	To jest pewna bardzo długa linia ~
	krótka ~
	Inna, ale też bardzo długa linia ~

W krótszej linii nie został wstawiony żaden tekst.

Jeśli łańcuch, który wstawiłeś zawiera znak nowej linii, "I" działa tak jak
w trybie Normal i wywiera efekt tylko na pierwszej linii w bloku.

Komenda "A" działa w ten sam sposób, z wyjątkiem tego, że dodaje tekst po
prawej stronie bloku.
   W jednym wypadku "A" działa inaczej: wybierz Visual Block i użyj "$" do
rozszerzenia bloku do końca każdej linii. "A" doda teraz tekst na końcu każdej
linii.
   W przykładzie powyżej i użyciu "$A XXX<Esc>, dostaniesz:

	To jest pewna długa linia XXX~
	krótka XXX~
	Inna, ale też długa linia XXX~

To naprawdę wymaga komendy "$". Vim pamięta, że została ona użyta. Wykonanie
tej samej selekcji przez przeniesienie kursora na koniec najdłuższej linii
z innymi poleceniami ruchu nie da tego samego rezultatu.


ZMIANA TEKSTU

Komenda "c" w Visual Block usuwa blok i przenosi cię w tryb Insert żebyś mógł
wpisać tekst. Tekst zostanie wstawiony w każdej linii bloku.
   Zaczynając z tym samym wyborem słowa "długa" jak wyżej, a potem wpisując
"c_DŁUGA_<Esc>", dostaniesz:

	To jest pewna _DŁUGA_ linia ~
	krótka ~
	Inna, ale też _DŁUGA_ linia ~

Tak jak z "I" krótka linia nie została zmieniona. I tak samo nie możesz użyć
<Enter> w nowym tekście.

Komenda "C" usuwa tekst od lewej krawędzi bloku do końca linii. Jednocześnie
przenosi cię w tryb Insert, tak że możesz wprowadzić tekst, który zostanie
dodany na końcu każdej linii.
   Zaczynając znów z tym samym tekstem i wpisując "Cnowa linia<Esc>"
uzyskasz:

	To jest pewna nowa linia~
	krótka ~
	Inna, ale też nowa linia~

Zwróć uwagę, że nawet jeśli tylko słowo "długa" zostało wybrane tekst po nim
także został usunięty. Liczy się tylko umiejscowienie lewej krawędzi Visual
Block.
   Znowu, krótka linia nie włączona do bloku została pominięta.

Inne komendy, które zmieniają znaki w bloku:

	~	zmiana wielkości (a -> A i A -> a)
	U	... na wielkie   (a -> A i A -> A)
	u	... na małe      (a -> a i A -> a)


WYPEŁNIANIE ZNAKAMI

By wypełnić cały blok jednym znakiem użyj komendy "r". Znowu ten sam przykład
i wpisanie "rx":

	To jest pewna xxxxx linia ~
	krótka ~
	Inna, ale też xxxxx linia ~


	Note:
	Jeśli chcesz włączyć znaki poza końcem linii do bloku, sprawdź
	'virtualedit' z rozdziału 25.


PRZESUWANIE

Komenda ">" przesuwa wybrany tekst na prawo o jedną jednostkę przesuwu,
umieszczając znaki odstępu. Punktem startowym jest lewa krawędź bloku.
   W tym samym przykładzie, ">" daje:

	To jest pewna	  długa linia ~
	krótka ~
	Inna, ale też	  długa linia ~

Wielkość przesunięcia jest określona w opcji 'shiftwidth'. Żeby zmienić ją na
4 spacje: >

	:set shiftwidth=4

Komenda "<" usuwa jedną wartość przesunięcia w znakach odstępu na lewej
krawędzi bloku. Komenda jest ograniczona ilością tekstu, który tam jest; jeśli
jest tam mniej znaków odstępu niż wartość przesunięcia, usunie co tylko może.


ŁĄCZENIE LINII

Komenda "J" łączy wszystkie wybrane linie w jedną. Po prostu usuwa znaki nowej
linii. Właściwie, znaki nowej linii oraz białe na końcu i początku wiersza
są zamienione na jedną spację. Dwie spacje są użyte po zakończeniu zdania
(może być to zmienione opcją 'joinspaces').
   Ten sam przykład. Wynik użycia komendy "J":

	To jest pewna długa linia krótka Inna, ale też długa linia ~

Komenda "J" nie wymaga trybu blokowego. Działa z "v" i "V" w dokładnie ten sam
sposób.

Jeśli nie chcesz by białe znaki zostały zmienione, użyj polecenia "gJ".

==============================================================================
*10.6*	Odczytywanie i zapisywanie części pliku

Kiedy piszesz maila chcesz włączyć inny plik. Robisz to poleceniem ":read
{nazwa-pliku}". Zawartość pliku jest wczytywana poniżej linii, w której
aktualnie znajduje się kursor.
   Zaczynając z tekstem:

	Cześć Wojtek, ~
	Tu jest diff, który poprawia buga: ~
	NoToPa M. ~

Przejdź do drugiej linii i wpisz: >

	:read patch

Plik o nazwie "patch" zostanie wstawiony tak:

	Cześć Wojtek, ~
	Tu jest diff, który poprawia buga: ~
	2c2 ~
	<	for (i = 0; i <= length; ++i) ~
	--- ~
	>	for (i = 0; i < length; ++i) ~
	NoToPa M. ~

Polecenie ":read" akceptuje zasięg. Plik zostanie wstawiony poniżej ostatniej
linii zasięgu. Tak więc ":$r patch" dodaje plik "patch" na końcu pliku.
   A co jeśli chcesz wstawić plik powyżej pierwszej linii? Jest to możliwe
dzięki linii 0. Linia ta naprawdę nie istnieje i dostaniesz komunikat
o błędzie używając tego z większością poleceń. Ale tu jest to możliwe: >

	:0read patch

Plik "patch" zostanie wstawiony powyżej pierwszej linii w pliku.


ZAPISYWANIE ZASIĘGU LINII

Do zapisania zasięgu linii do pliku trzeba użyć polecenia ":write". Bez
zasięgu zapisze ono cały plik. Z zasięgiem tylko wyszczególnione linie będą
zapisane: >

	:.,$write tempo

To polecenie zapisuje linie od kursora do końca pliku w pliku "tempo". Jeśli
ten plik istnieje, otrzymasz komunikat błędu. Vim chroni przed przypadkowym
nadpisaniem istniejącego pliku. Jeśli wiesz, że chcesz ten plik nadpisać
dodaj "!": >

	:.,$write! tempo

UWAGA: ! musi wystąpić bezpośrednio po poleceniu ":write", bez znaku odstępu.
W innym wypadku zostanie potraktowany jako polecenie filtrujące, co zostanie
wyjaśnione w dalszej części rozdziału.


DODAWANIE DO PLIKU

W pierwszej sekcji tego rozdziału zostało wyjaśnione jak zebrać kilka linii
w rejestrze. To samo można zrobić by zebrać linie w pliku. Zapisz pierwszą
linię tym poleceniem: >

	:.write kolekcja

Przenieś teraz kursor do drugiej linii, którą chcesz dodać do kolekcji
i wpisz: >

	:.write >> kolekcja

">>" mówi Vimowi, żeby nie nadpisywał pliku "kolekcja", ale dodał linię do
końca pliku. Możesz to powtarzać tyle razy ile chcesz.

==============================================================================
*10.7*	Formatowanie tekstu

Kiedy piszesz zwykły tekst jest wygodniej jeśli długość każdej linii jest
automatycznie ustalana tak, by pasowała do okna. Służy do tego opcja
'textwidth': >

	:set textwidth=72

Być może pamiętasz, że w przykładowym pliku vimrc to polecenie było użyte dla
każdego pliku txt. Dlatego jeśli używasz tego pliku vimrc masz już ustawioną
tę wartość. Bieżącą wartość 'textwidth' sprawdzasz tak: >

	:set textwidth

Teraz linie będą złamane tak by zawierały do 72 znaków. Ale jeśli wprowadzisz
tekst w połowie linii lub usuniesz kilka słów linie będą zbyt długie lub zbyt
krótkie i Vim nie formatuje automatycznie tekstu.
   Polecenie by Vim formatował bieżący paragraf: >

	gqap

Zaczyna się poleceniem "gq", które jest operatorem. Następne jest "ap", obiekt
tekstowy oznaczający "a paragraph" (ang. AkaPit). Akapity oddzielone są od
siebie pustymi liniami.

	Note:
	Pusta linia, ale zawierająca białe znaki NIE rozdziela akapitów.
	Jest trudna do zauważenia!

Zamiast "ap" możesz użyć dowolnego ruchu lub obiektu tekstowego. Jeśli akapity
są prawidłowo oddzielone, możesz użyć tego polecenia do sformatowania całego
pliku: >

	gggqG

"gg" to ruch do pierwszej linii, "gq" jest operatorem formatowania, a "G"
ruchem, który skacze do ostatniej linii.

W przypadku, kiedy akapity nie są jasno określone możesz formatować tylko
linie, które wybierzesz ręcznie. Przenieś kursor do pierwszej linii, którą
chcesz formatować. Zacznij poleceniem "gqj". Formatuje ono bieżącą linię
i następną. Jeśli pierwsza linia była krótka, słowa z następnej zostaną
dodane. Jeśli była za długa, słowa zostaną przeniesione do następnej linii.
Kursor przeniesie się do drugiej linii. Teraz możesz użyć "." do powtórzenia
polecenia. Powtarzaj to dopóki nie znajdziesz się na końcu tekstu, który
chcesz formatować.

==============================================================================
*10.8*	Zmiana wielkości litery

Masz tekst z nagłówkami sekcji pisanych małymi literami. Chcesz by słowo
"section" było pisane wielkimi literami. Zacznij z kursorem w pierwszej
kolumnie: >

			     gUw
<	section header	    ---->      SECTION header

Operator "gu" robi dokładnie odwrotnie: >

			     guw
<	SECTION header	    ---->      section header

Możesz też użyć "g~" do zamiany wielkości znaków. Wszystkie "gx" są
operatorami i działają z dowolnym poleceniem ruchu, obiektami tekstowymi
i trybem Visual.
   Żeby operator działał na całej linii podwajasz go. Operator usuwania to "d"
i dlatego "dd" usuwa całą linię. Podobnie, "gugu" zmienia całą linię w pisaną
małymi literami. Można to skrócić do "guu". "gUgU" jest skracane do "gUU",
a "g~g~" do "g~~". Przykład: >

				g~~
<	Some GIRLS have Fun    ---->   sOME girls HAVE fUN ~

==============================================================================
*10.9*	Używanie zewnętrznych programów

Vim ma potężny zestaw poleceń, możesz z nimi zrobić wszystko. Ale cały czas
pojawiają się problemy, których rozwiązanie zewnętrznymi programami może być
lepsze lub szybsze.
   Polecenie "!{ruch}{program}" bierze blok tekstu i filtruje go przez
zewnętrzny program. Innymi słowy, uruchamia polecenie systemowe reprezentowane
przez {program}, podając mu blok tekstu reprezentowany przez {ruch} jako
wejście. Wynik tego polecenia zastąpi wybrany blok.
   Ponieważ nie brzmi to jasno, jeśli nie znasz filtrów uniksowych, spójrzmy
na przykład. Polecenie sort sortuje plik. Jeśli wykonasz następujące polecenie
nieposortowany plik wejście.txt zostanie posortowany i zapisany do wynik.txt.
(Ten przykład działa na Uniksach i w Microsoft Windows.) >

	sort <input.txt >output.txt

Zróbmy to samo w Vimie. Chcesz posortować linie 1 do 5 pliku. Zaczynasz
umieszczając kursor w linii 1. Następnie wykonujesz polecenie: >

	!5G

"!" przekazuje Vimowi, że wykonujesz operację filtrowania. Vim spodziewa się
polecenia ruchu, wskazującego, którą część pliku filtrować. Polecenie "5G"
mówi Vimowi by przeszedł do linii 5. W ten sposób Vim wie, że ma filtrować linie
1 (linia bieżąca) do 5.
   Spodziewając się filtrowania, kursor przechodzi do dołu okna i pokazuje
znak zachęty !. Możesz teraz wpisać nazwę programu filtrującego, w tym wypadku
"sort". Stąd pełne polecenie to: >

	!5Gsort<Enter>

Wynikiem jest przebieg programu sort na pierwszych 5 liniach. Wynik programu
zamienia te linie.

	linia 55		      linia 11
	linia 33		      linia 22
	linia 11        -->	      linia 33
	linia 22		      linia 44
	linia 44		      linia 55
	ostatnia linia		      ostatnia linia

Polecenie "!!" filtruje bieżącą linię. W Uniksach polecenie "date" drukuje
bieżący czas i datę. "!!date<Enter>" zamienia bieżącą linię w wynik "date".
Przydaje się przy dodawaniu daty do pliku.


JEŚLI NIE DZIAŁA

Rozpoczęcie działania powłoki, przesłanie jej tekstu i przechwycenie wyniku
wymaga od Vima znajomości dokładnie jak dana powłoka działa. Jeśli masz
problemy z filtrowaniem sprawdź wartośc tych opcji:

	'shell'		określa program, którego będzie używał Vim do
			wykonywania zewnętrznych programów.
	'shellcmdflag'	argument do przekazania powłoce
	'shellquote'	cudzysłów jaki ma być użyty wokół polecenia
	'shellxquote'	cudzysłów jaki ma być użyty wokół polecenia
			i przekierowania
	'shelltype'	rodzaj powłoki (tylko dla Amigi)
	'shellslash'	użyj slashy w poleceniach (tylko dla MS-Windows
			i podobnych
	'shellredir'	łańcuch użyty do zapisywania wyniku do pliku

Na Uniksach rzadko jest to problem bo są tam dwa rodzaje powłok: typu "sh"
i "csh". Vim sprawdza opcję 'shell' i ustawia związane z nią automatycznie
zależnie od tego czy zobaczy "csh" gdzieś w 'shell'.
   Jednak w MS-Windows jest wiele różnych powłok być może będziesz musiał
dostroić opcje by filtrowanie działało. Sprawdź pomoc dla opcji by uzyskać
więcej informacji.


ODCZYTYWANIE WYNIKU POLECENIA

By wczytać zawartość bieżącego katalogu do pliku użyj: >

na Uniksach: >
	:read !ls
na MS-Windows: >
	:read !dir

Wynik poleceń "ls" lub "dir" jest przechwycony i wprowadzony do tekstu pod
linią kursora. Działa to podobnie do wczytywania pliku, z wyjątkiem tego, że
"!" jest użyty do przekazania Vimowi następnego polecenia.
   Polecenie może mieć argumenty. Zasięg też może być użyty by Vim wiedział
gdzie umieścić linie: >

	:0read !date -u

To polecenie wprowadza bieżący czas i datę w formacie UTC na samą górę pliku.
(OK, tylko jeśli masz polecenie date akceptujące argument "-u".) Zauważ, że
istnieje różnica w stosunku do "!!date", które zastępuje linię, a ":read !date"
wprowadzi nową linię.


WRITING TEXT TO A COMMAND

Uniksowe polecenie "wc" liczy słowa. Żeby policzyć słowa w bieżącym pliku: >

	:write !wc

Jest to to samo polecenie zapisywania jak wcześniej, ale zamiast nazwy pliku
użyty został tu znak "!" i nazwa polecenia zewnętrznego. Zapisany tekst
zostanie przekazany do polecenia jako standardowe wejście. Wyjście powinno
wyglądać tak:

       4      47     249 ~

Polecenie "wc" nie jest zbyt gadatliwe. To oznacza, że masz 4 linie, 47 słów
i 249 znaków.

Uważaj na ten błąd: >

	:write! wc

To polecenie zapisze siłowo plik "wc" w bieżącym katalogu. Znak odstępu jest
tu ważny!


ODŚWIEŻANIE EKRANU

Jeśli zewnętrzne polecenie spowodowało błąd, na ekranie może być bałagan. Vim
jest bardzo efektywny i odświeża tylko te części ekranu o których wie, że
potrzebują odświeżenia, ale nie może wiedzieć o tym co narobił inny program.
Żeby Vim odświeżył ekran: >

	CTRL-L

==============================================================================

Następny rozdział: |usr_11.txt|  Odzyskiwanie plików po awarii

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
