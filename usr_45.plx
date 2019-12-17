*usr_45.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 Wybór języka


Komunikaty w Vimie mogą się pojawiać w kilku różnych językach. Ten rozdział
wyjaśni jak zmienić aktualnie używany język. Zostaną także wyjaśnione różne
sposoby pracy z plikami w kilku językach.

|45.1|	Język komunikatów
|45.2|	Język menu
|45.3|	Używanie innych kodowań
|45.4|	Pliki z różnymi kodowaniami
|45.5|	Wprowadzanie specyficzne dla języka

 Następny rozdział: |usr_90.txt|  Instalacja Vima
Poprzedni rozdział: |usr_44.txt|  Tworzenie własnego schematu podświetlania
       Spis treści: |usr_toc.txt|

==============================================================================
*45.1*	Język komunikatów

Kiedy zaczynasz Vima, sprawdza on środowisko by dowiedzieć się jakiego języka
używasz. Najczęściej mechanizm ten działa dobrze i będziesz mógł czytać
wiadomości w swoim własnym języku (jeśli są dostępne). Informację o bieżącym
języku otrzymasz dzięki poleceniu: >

	:language

Jeśli odpowiedź brzmi "C", oznacza to, że używany jest domyślny język
- angielski.

	Note:
	Używanie różnych języków jest możliwe tylko wtedy kiedy Vim został
	skompilowany tak by sobie z tym radzić. Żeby się dowiedzieć czy będzie
	działało użyj polecenia ":version" i sprawdź czy są "+gettext"
	i "+multi_lang". Jeśli tak, wszystko w porządku. Jeśli zobaczysz
	"-gettext" lub "-multi_lang" musisz poszukać innego Vima.

Co jeśli chcesz widzieć komunikaty w innym języku? Jest kilka sposobów.
Którego z nich użyjesz zależy od możliwości twojego systemu.
   Pierwszym sposobem jest ustawienie środowiska na żądany język przed
rozpoczęciem Vima. przykład dla Uniksa: >

	env LANG=de_DE.ISO_8859-1  vim

Będzie działać tylko wtedy kiedy żądany język jest w systemie. Zaletą jest
fakt, że komunikaty GUI i różne rzeczy w bibliotekach będą używać
odpowiedniego języka. Wadą to, że musisz to zrobić przed odpaleniem Vima.
Jeśli chcesz zmienić język po uruchomieniu Vima wydaj polecenie: >

	:language fr_FR.ISO_8859-1

W ten sposób możesz wypróbować kilka nazw dla żądanego języka. Otrzymasz
komunikaty błędu jeśli nie jest wspierany przez system. Komunikatu takiego nie
będzie jeśli komunikaty nie zostały przetłumaczone. Vim po cichu wróci do
angielskiego.
   Żeby dowiedzieć się, które języki są wspierane w twoim systemie znajdź
katalog gdzie pliki są przechowywane. U mnie jest to "/usr/share/locale". Na
niektórych systemach są w "/usr/lib/locale". Strona podręcznika dla
"setlocale" powinna dać odpowiedź.
   Uważaj by wpisać dokładnie nazwę języka. Liczy się wielkość liter, a znaki
'-' i '_' łatwo pomylić.

Możesz osobno ustawić język dla komunikatów, edytowanego tekstu i formatu
czasu. Zobacz |:language|.


TŁUMACZENIE KOMUNIKATÓW: ZRÓB TO SAM

Jeśli nie ma przetłumaczonych wiadomości dla twojego języka możesz to zrobić
sam. Potrzebujesz do tego źródeł Vima i pakietu GNU gettext. Po rozpakowaniu
źródeł instrukcje można znaleźć w katalogu src/po/README.txt.
   Tłumaczenenie nie jest trudne. Nie musisz być programistą. Oczywiście musisz
znać zarówno angielski jak i język na jaki tłumaczysz.
   Kiedy jesteś zadowolony z tłumaczenia pomyśl o udostępnieniu go innym.
Umieść je na vim-online (http://vim.sf.net) lub prześlij e-mailem do twórcy
Vima <maintainer@vim.org> albo w oba te miejsca naraz.
   Komunikaty dla języka polskiego zostały przetłumaczone przez Marcina
Daleckiego. Marcin tłumaczył także menu. Menu obecnie opiekuje się Rafał
Sulejman.
==============================================================================
*45.2*	Język menu

Domyślne menu są po angielsku. Żeby móc używać w nich lokalnego języka muszą
zostać przetłumaczone. Normalnie robi się to automatycznie jeśli środowisko
jest ustawione dla twojego języka tak jak komunikaty. Nie musisz robić nic
więcej. Działa to jednak tylko wtedy kiedy tłumaczenia są dostępne.
   Przypuśćmy, że jesteś w Niemczech, z językiem ustawionym niemieckim, ale
wolisz użyć "File" zamiast "Datei". Możesz wrócić do używania angielskich menu
w ten sposób: >

	:set langmenu=none

Albo definiując język: >

	:set langmenu=nl_NL.ISO_8859-1

Jak wyżej, różnice między "-" i "_" mają znaczenie. Jednak wielkość liter jest
ignorowana.
   Opcja 'langmenu' musi być ustawiona zanim menu zostaną załadowane. Potem
zmiana 'langmenu' nie ma bezpośredniego efektu. Dlatego dobrze jest umieścić
polecenie ustawiające 'langmenu' w pliku vimrc.
   Jeśli naprawdę chcesz zmienić język menu w czasie kiedy Vim jest
uruchomiony możesz to zrobić tak: >

	:source $VIMRUNTIME/delmenu.vim
	:set langmenu=de_DE.ISO_8859-1
	:source $VIMRUNTIME/menu.vim

Jest jedno ale: wszystkie menu zdefiniowane przez ciebie znikną. Musisz je na
nowo załadować.


TŁUMACZENIE MENU: ZRÓB TO SAM

W tym katalogu możesz sprawdzić jakie tłumaczenia są dostępne:

	$VIMRUNTIME/lang ~

Pliki są nazwane menu_{język}.vim. Jeśli nie widzisz języka jakiego chciałbyś
używać możesz sam zrobić tłumaczenie. Najprostszą metodą jest skopiowanie
jednego z istniejących plików językowych i odpowiednia jego zmiana.
   Najpierw dowiedz się jak nazywa się twój język poleceniem ":language". Użyj
tej nazwy, ale zmień wszystkie litery na małe. Potem skopiuj plik do katalogu
runtime, takiego jaki możesz znaleźć w 'runtimepath'. W Uniksie na przykład
byłby to: >

	:!cp $VIMRUNTIME/lang/menu_ko_kr.euckr.vim ~/.vim/lang/menu_nl_be.iso_8859-1.vim

Wskazówki co do tłumaczeń znajdziesz w "$VIMRUNTIME/lang/README.txt".

==============================================================================
*45.3*	Używanie innych kodowań

Vim przypuszcza, że pliki, które zamierzasz edytować są zakodowane w twoim
języku. Dla wielu języków europejskich jest to "latin1". Każdy bajt to jeden
znak. Oznacza to, że jest możliwych 256 różnych znaków. Nie jest to liczba
wystarczająca dla języków azjatyckich. Używają one w większości kodowania
dwubajtowego zapewniającego możliwość użycia ponad dziesięciu tysięcy różnych
znaków. To cały czas nie jest wystarczające jeśli chcesz operować na tekście,
który zawiera kilka różnych języków. Tutaj wkracza Unikod. Został
zaprojektowany tak, by włączyć wszystkie znaki z powszechnie używanych języków.
Jest to "super kodowanie, żeby zastąpić wszystkie inne". Jednak jeszcze nie
jest szeroko używany w tym celu.
   Na szczęście Vim wspiera wszystkie trzy sposoby kodowania. Z kilkoma
ograniczeniami, możesz ich używać nawet jeśli twoje środowisko używa innego
języka niż tekst.
   Jednak jeśli tylko edytujesz pliki, które są zakodowane w twoim języku,
domyślne wartości powinny działać bez przeszkód i nie potrzebujesz nic
zmieniać. Cały ten rozdział dotyczy cię tylko jeśli chcesz edytować coś
w innych językach.

	Note:
	Użycie innych kodowań będzie możliwe tylko wtedy kiedy Vim zostanie
	skompilowany z odpowiednimi opcjami. Żeby przekonać się co działa użyj
	polecenia ":version" i sprawdź czy jest "+multi_byte". Jeśli tak to
	wszystko w porządku. W innym wypadku musisz poszukać innego Vima.


UNIKOD W GUI

Miłą rzeczą w Unikodzie jest to, że inne kodowania mogą by skonwertowane do
niego i z powrotem bez utraty informacji. Jeśli ustawisz Vima by używał
wewnętrznie Unikodu będziesz w stanie edytować pliki w dowolnym kodowaniu.
   Niestety liczba systemów, które wspierają Unikod jest cały czas
ograniczona. Mało prawdopodobne jest by twój język go używał. Musisz
powiedzieć Vimowi, że chcesz używać Unikodu i jak ma traktować wymianę
informacji z resztą systemu.
   Zacznijmy od wersji GUI, która może pokazywać znaki Unikodu. Tak ustaw
odpowiednie opcje: >

	:set encoding=utf-8
	:set guifont=-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1

Opcja 'encoding' mówi Vimowi jakiego kodowania znaków będziesz używał. Odnosi
się to do tekstu w buforach (plikach jakie edytujesz), rejestrów, plików
skryptowych Vima, itd. Możesz uważać 'encoding' jako ustawienie wewnętrzne dla
Vima.
   Przykład zakłada, że masz odpowiedni font w systemie. Nazwa jest
przykładowa dla systemu X Window. Ten font jest w pakiecie, który ma
rozszerzyć możliwości xterma właśnie o Unikod. Jeśli nie masz tego fontu
możesz go znaleźć tu:

	http://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts.tar.gz ~

W MS-Windows niektóre fonty mają ograniczoną liczbę unikodowych znaków.
Spróbuj "Courier New". Użyj menu Edit/Select Font..., żeby wybrać i wypróbować
dostępne fonty. Można używać tylko czcionek nieproporcjonalnych (o stałej
szerokości). Przykład: >

	:set guifont=courier_new:h12

Jeśli nie działa spróbuj fontpacka. Jeśli Microsoft nie przeniósł tego zestawu
możesz go znaleźć:

	http://www.microsoft.com/typography/fontpack/default.htm ~

Teraz musisz powiedzieć Vimowi by używał Unikodu wewnętrznie i pokazywał tekst
fontem unikodowym. Wpisywane znaki cały czas przekazywane są w oryginalnym,
lokalnym kodowaniu. Musisz je przekonwertować do Unikodu. Powiedz Vimowi
z jakiego kodowania ma to robić opcją 'termencoding'. Możesz to załatwić w ten
sposób: >

	:let &termencoding = &encoding
	:set encoding=utf-8

Przypisujesz w ten sposób starą wartość 'encoding' do 'termencoding' zanim
ustawisz 'encoding' na utf-8. Musisz sprawdzić czy to naprawdę działa w twoim
systemie. Powinno szczególnie dobrze działać jako metoda wprowadzania języków
azjatyckich za pomocą Unikodu.


UNIKOD W TERMINALU UNIKODOWYM

Są terminale, które bezpośrednio wspierają Unikod. Standardowy xterm, który
jest dystrybuowany z XFree86 to jeden z nich. Użyjmy go jako przykładu.
   Przede wszystkim, xterm musi być skompilowany ze wsparciem dla Unikodu.
Zobacz |UTF8-xterm|, żeby zobaczyć jak to sprawdzić.
   Wywołaj xterm z argumentem "-u8". Możesz też określić font. Przykład: >

   xterm -u8 -fn -misc-fixed-medium-r-normal--18-120-100-100-c-90-iso10646-1

Uruchom teraz Vima w terminalu i ustaw 'encoding' na "utf-8". To wszystko.


UNIKOD W ZWYKŁYM TERMINALU

Przypuśćmy, że chcesz pracować z plikami unikodowymi, ale nie masz terminala
ze wsparciem dla Unikodu. Możesz to zrobić z Vimem, ale znaki, które nie są
wspierane przez terminal nie zostaną pokazane. Formatowanie tekstu zostanie
zachowane. >

	:let &termencoding = &encoding
	:set encoding=utf-8

Wypróbuj to tak jak było użyte dla GUI. Tu jednak działa inaczej: Vim
przekonwertuje tekst przed wysłaniem go na terminal. W ten sposób unikniesz
zaśmiecania terminala dziwnymi znakami.
   Aby sposób ten zadziałał musi być możliwa konwersja między 'termencoding'
i 'encoding'. Vim konwertuje z latin1 do Unikodu - ta kombinacja zawsze
zadziała. Dla innych musi być obecna opcja |+iconv|.
   Spróbuj edycji pliku ze znakami unikodowymi. Zauważ, że Vim umieszcza znak
zapytania (albo podkreślenie, albo inny znak) w miejscach gdzie powinien
znaleźć się znak, którego terminal nie może wyświetlić. Przemieść kursor do
znaku zapytania i wydaj polecenie: >

	ga

Vim wyświetli linię z kodem znaku. Dzięki temu masz pojęcie czym może być ten
znak, możesz zajrzeć do tabeli Unikodu. Jeśli masz dużo czasu możesz w ten
sposób przeczytać cały plik.

	Note:
	Ponieważ 'encoding' jest używane dla wszystkich tekstów w Vimie,
	zmiana tej opcji spowoduje, że wszystkie znaki nie-ASCII zostaną
	uznane za błędne. Zauważysz to używając rejestrów i pliku 'viminfo'
	(np.: historia poszukiwań). Zaleca się ustawianie opcji 'encoding'
	w pliku vimrc i zostawienie jej w spokoju.

==============================================================================
*45.4*	Pliki z różnymi kodowaniami

Przypuśćmy, że skonfigurowałeś Vima do użycia Unikodu i chcesz edytować plik,
który jest 16-bitowym Unikodem. Brzmi prosto, nieprawdaż? Vim wewnętrznie
używa kodowania utf-8 i dlatego kodowanie 16-bitowe musi być przekonwertowane.
Istnieje różnica między zestawem znaków (Unikod) i kodowaniem (utf-8 lub
utf-16).
   Vim spróbuje wykryć jaki typ pliku chcesz otworzyć. Używa do tego nazw
kodowań z opcji 'fileencodings'. Używając Unikodu domyślną wartością jest:
"ucs-bom,utf-8,latin1". Oznacza to, że Vim sprawdza plik, żeby sprawdzić czy
jest to jedno z nich:

	ucs-bom		Plik musi się zaczynać Byte Order Mark (BOM). Pozwala
			to na wykrycie 16-, 32-bitowego i utf-8 Unikodu.
	utf-8		utf-8 Unikod. Odrzucany jeśli sekwencja bajtów jest
			nielegalna w utf-8.
	latin1		Stare, dobre kodowanie 8 bitowe. Zawsze działa.

Kiedy otwierasz plik w 16-bitowym Unikodzie i ma on BOM, Vim to wykryje
i przekonwertuje plik do utf-8. Opcja 'fileencoding' (bez 's' na końcu) jest
ustawiona na wykrytą wartość. W tym wypadku będzie to "ucs-2le". Oznacza to
Unikod, dwu bajtowy, little-endian. Ten format pliku jest powszechny na
MS-Windows (np. w plikach rejestrów).
   Zapisując plik Vim porówna 'fileencoding' z 'encoding'. Jeśli są one różne
tekst zostanie przekonwertowany.
   Pusta wartość 'fileencoding' oznacza, że nie ma potrzeby dokonania
konwersji. Przyjmuje się, że tekst jest zakodowany w 'encoding'.

Jeśli domyślna wartość 'fileencodings' ci nie odpowiada ustaw ją na kodowania,
które chcesz by Vim wypróbował. Tylko wtedy kiedy wartość zostanie uznana za
nieodpowiednią następna zostanie użyta. Umieszczenie "latin1" na pierwszym
miejscu nie zadziała bo to kodowanie zawsze jest prawidłowe. Przykład na
powrót do japońskiego kiedy plik nie ma BOM i nie jest utf-8: >

	:set fileencodings=ucs-bom,utf-8,sjis

Zobacz sugerowane wartości w |encoding-values|. Inne wartości też mogą
działać. Wszystko zależy od możliwości konwersji.


WYMUSZANIE KODOWANIA

Jeśli automatyczne wykrywanie nie działa musisz powiedzieć Vimowi jakiego
kodowania używasz. Przykład: >

	:edit ++enc=koi8-r russian.txt

"++enc" określa nazwę kodowania jakie ma być użyte dla tego pliku. Vim
przekonwertuje plik z określonego kodowania, rosyjskiego w tym przypadku do
'encoding'. 'fileencoding' zostanie ustawione na określone kodowanie, tak że
odwrotna konwersja zostanie przeprowadzona przy zapisywaniu pliku.
   Ten sam argument może zostać użyty do zapisania pliku. W ten sposób użyjesz
Vima do konwersji pliku. Przykład: >

	:write ++enc=utf-8 russian.txt
<
	Note:
	W czasie konwersji mogą zostać utracone niektóre znaki. Konwersja do
	i z Unikodu zazwyczaj nie powoduje tego typu problemów, ale istnieją
	"nielegalne" znaki. Konwersja z Unikodu do innych języków często
	powoduje utratę informacji kiedy jest więcej niż jeden język w pliku.


LATIN2 I CP-1250

W języku polskim istnieją 2 standardy: iso-8859-2 (latin2) używany na Uniksach
i w Internecie oraz cp-1250 używany w Windowsach. Czasami trzeba przenieść
plik z jednego systemu do innego, albo edytując pliki html na systemach
MS-Windows odpowiednio przekonwertować przed umieszczeniem ich w Internecie.
   Pracując na Uniksie chcesz otworzyć plik utworzony na MS-Windows. Robisz to
tak: >

	:edit ++enc=cp1250 nazwa_pliku

Przy zwykłym zapisaniu ":write" plik zostanie znowu przekonwertowany na
cp1250. Jeśli chcesz by plik pozostał w kodowaniu iso-8859-2 musisz go zapisać
tak: >

	:write ++enc=iso-8859-2

Odwrotnie postępujesz z plikami iso-8859-2 pod MS-Windows.

==============================================================================
*45.5*	Wprowadzanie specyficzne dla języka

Klawiatura komputera ma niewiele ponad 100 klawiszy. Niektóre języki mają
tysiące znaków, Unikod ma 10 tysięcy. Jak wpisać te znaki?
   Przede wszystkim, jeśli nie używasz zbyt wielu znaków specjalnych możesz
użyć digraphów. Zostało to już wyjaśnione w |24.9|.
   Jeśli używasz języka, który ma o wiele więcej znaków niż twoja klawiatura
będziesz chciał użyć Input Method (IM). Wymaga ona nauczenia się translacji
z wpisywanych znaków do ostatecznego znaku. Jeśli potrzebujesz IM
prawdopodobnie masz już ją w swoim systemie. Powinna działać z Vimem tak jak
z innymi programami. Więcej szczegółów w |mbyte-XIM| dla systemu X Window
i |mbyte-IME| dla MS-Windows.


MAPY KLAWIATURY

W niektórych językach zestaw liter jest inny od łacińskiego, ale używa
podobnej liczby znaków. Istnieje możliwość zmapowania klawiszy do znaków. Vim
używa do tego map klawiatury.
   Przypuśćmy, że chcesz pisać po hebrajsku. Mapę klawiatury ładujesz w ten
sposób: >

	:set keymap=hebrew

Vim będzie próbował znaleźć odpowiedni plik mapy. Zależy to od wartości
'encoding'. Jeśli żaden pasujący plik nie został znaleziony zostaniesz
powiadomiony o błędzie.

Teraz możesz pisać po hebrajsku w trybie Insert. W trybie Normal i po wydaniu
komendy ":" Vim automatycznie przełączy się na angielski. Możesz użyć tego
polecenia do przełączania się między hebrajskim, a angielskim: >

	CTRL-^

Działa to tylko w trybie Insert i linii poleceń. W trybie Normal dzieje się
coś kompletnie innego (skok do alternatywnego pliku).
   Użycie mapy klawiatury jest zaznaczone w komunikacie trybu, jeśli masz
ustawioną opcję 'showmode'. W GUI Vim będzie informował o użyciu mapy innym
kolorem kursora.
   Możesz zmienić sposób użycia map klawiatury w opcjach 'iminsert'
i 'imsearch'.

Listę mapowań możesz zobaczyć dzięki poleceniu: >

	:lmap

Żeby się przekonać jakie mapy klawiatury są dostępne w GUI użyj menu
Edit/Kedymap, w innym wypadku użyj polecenia: >

	:echo globpath(&rtp, "keymap/*.vim")


MAPA KLAWIATURY: ZRÓB TO SAM

Możesz stworzyć własną mapę klawiatury, nie jest to trudne. Zacznij od mapy,
która jest podobna do języka, którego chcesz używać. Skopiuj ją do katalogu
"keymap" w twoim katalogu runtime. Dla Uniksa byłby to katalog
"~/.vim/keymap".
   Nazwa pliku mapy musi wyglądać tak:

	keymap/{nazwa}.vim ~
lub
	keymap/{nazwa}_{kodowanie}.vim ~

{nazwa} to nazwa mapy klawiatury. Wybierz nazwę, która jest oczywista, ale
inna od istniejących map (dopóki nie chcesz zastąpić istniejącej mapy).
{nazwa} nie może zawieraż znaku podkreślenia. Możesz dodać nazwę kodowania po
podkreśleniu. Przykłady:

	keymap/hebrew.vim ~
	keymap/hebrew_utf-8.vim ~

Zawartość pliku powinna być oczywista. Zobacz kilka map, które są
dystrybuowane z Vimem. Więcej w |mbyte-keymap|.


OSTATNIA DESKA RATUNKI

Jeśli inne metody zawiodą możesz wpisać każdy znak dzięki CTRL-V:

	kodowanie  wpisz		zasięg ~
	8-bit	   CTRL-V 123		decymalne 0-255
	8-bit	   CTRL-V x a1		heksadecymalne 00-ff
	16-bit     CTRL-V u 013b	heksadecymalne 0000-ffff
	32-bit	   CTRL-V U 001303a4	heksadecymalne 00000000-7fffffff

Nie wpisuj spacji. Zobacz szczegóły w |i_CTRL-V_digit|.

==============================================================================

Następny rozdział: |usr_90.txt|  Instalacja Vima

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
