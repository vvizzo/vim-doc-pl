*usr_90.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			       Instalacja Vima

								*install*
Zanim będziesz mógł użyć Vima trzeba go najpierw zainstalować. W zależności od
systemu jest to łatwe lub proste. Ten rozdział podaje kilka wskazówek
i wyjaśnia jak zrobić upgrade do nowszej wersji.

|90.1|	Unix
|90.2|	MS-Windows
|90.3|	Uaktualnianie programu
|90.4|	Zwykłe problemy przy instalacji
|90.5|	Odinstalowywanie Vima

Poprzedni rozdział: |usr_45.txt|  Wybierz swój język
       Spis treści: |usr_toc.txt|

==============================================================================
*90.1*	Unix

Najpierw musisz się zdecydować czy instalujesz Vima dla całego systemu czy
tylko dla pojedynczego użytkownika. Instalacja jest prawie taka same, ale inne
są katalogi docelowe.
   Dla instalacji systemowej domyślny katalog to "/usr/local". Może być jednak
inny dla twojego systemu. Dowiedz się gdzie zainstalowane są inne pakiety.
   Instalując dla pojedynczego użytkownika używasz dowomego katalogu jako
bazy. Pliki zostaną umieszczone w podkatalogach takich jak "bin"
i "share/vim".


Z PAKIETU

Możesz dostać prekompilowane binaria na wiele systemów UNIXowych. Długa lista
z linkami jest na tej stronie:

	http://www.vim.org/binaries.html ~

Binarki utrzymują ochotnicy i często są trochę nieaktualne. Dobrym
pomysłem jest kompilacja swojej własnej wersji ze źródeł. Ponadto, stworzenie
edytora ze źródeł pozwala na kontrolę, które właściwości są wkompilowane.
Wymagany jest jednak kompilator.

Jeśli masz dystrybucję Linuksa, program "vi" to prawdopodobnie minimalna
wersja Vima. Nie ma w nim na przykład podświetlania składni. Spróbuj znaleźć
inny pakiet Vima w twojej dystrybucji lub poszukaj na stronie dystrybucji
w Internecie.


ZE ŹRÓDEŁ

Do skompilowania i zainstalowania Vima musisz mieć:

	-  Kompilator C (najlepiej GCC)
	-  Program GZIP (możesz go dostać na http://www.gnu.org)
	-  Źródła Vima i archiwa runtime

Żeby dostać archiwa Vima poszukaj w tym pliku mirrora blisko ciebie, powinien
on zapewnić najszybszy dostęp:

	ftp://ftp.vim.org/pub/vim/MIRRORS ~

Możesz też użyć domowej strony ftp.vim.org jeśli uważasz, że prędkość jest
wystarczająca. Przejdź do katalogu "unix" i znajdziesz tam listę plików. Numer
wersji jest włączony do nazwy pliku. Zapewne będziesz chciał ściągnąć
najnowszą wersję.
   Pliki dla Uniksa możesz ściągnąć na dwa sposoby: jedno duże archiwum, które
zawiera wszystko lub cztery mniejsze (każde zmieści się na jednej dyskietce).
Dla wersji 6.1 jeden duży nazywa się:

	vim-6.1.tar.bz2 ~

Potrzebujesz programu bzip2 do rozpakowania. Jeśli go nie masz, ściągnij
cztery mniejsze pliki, które mogą być rozpakowane gzipem. Dla Vima 6.1
nazywają się:

	vim-6.1-src1.tar.gz ~
	vim-6.1-src2.tar.gz ~
	vim-6.1-rt1.tar.gz ~
	vim-6.1-rt2.tar.gz ~


KOMPILACJA

Najpierw utwórz katalog główny, w którym będziesz pracował, na przykład: >

	mkdir ~/vim
	cd ~/vim

Rozpakuj tam archiwum. Jeśli masz jedno duże zrób tak: >

	bzip2 -d -c ścieżka/vim-6.1.tar.bz2 | tar xf -

Zmień "ścieżka" na taką, która będzie pasować do pliku. >

	gzip -d path/vim-6.1-src1.tar.gz | tar xf -
	gzip -d path/vim-6.1-src2.tar.gz | tar xf -
	gzip -d path/vim-6.1-rt1.tar.gz | tar xf -
	gzip -d path/vim-6.1-rt2.tar.gz | tar xf -

Jeśli satysfakcjonują cię domyślne ustawienia i twoje środowisko jest
prawidłowo skonfigurowane możesz kompilować Vima po prostu tak: >

	cd vim61/src
	make

Program make uruchomi configure i skompiluje wszystko. Dalej wyjaśnimy jak
kompilować z różnymi ustawieniami.
   Jeśli w czasie kompilacji pojawiają się błędy, uważnie przejrzyj komunikaty
błędów. Powinna tam być wskazówka co poszło źle. Powinieneś być w stanie
poprawić te błędy. Być może będziesz musiał usunąć niektóre opcje, żeby Vim
dał się skompilować. Zajrzyj do Makefile po wskazówki specyficzne dla twojego
systemu.


TESTOWANIE

Możesz teraz sprawdzić czy kompilacja poszła OK: >

	make test

Uruchomi to kilkanaście skryptów testowych, żeby sprawdzić czy Vim pracuje jak
powinien. Vim zostanie uruchomiony wiele razy i wszystkie rodzaje tekstu oraz
wiadomości przelecą przez ekran. Jeśli wszystko jest w porządku na końcu
zobaczysz:

	test results: ~
	ALL DONE ~

Jeśli pojawią się jedna lub dwie wiadomości o nie zdanych testach Vim może
ciągle pracować, ale nie idealnie. Jeśli zobaczysz wiele komunikatów błędów
lub Vim nie chce skończyć coś musi być źle. Spróbuj to naprawić sam, lub znajdź
kogoś kto to zrobi. Poszukaj rozwiązania w |maillist-archive|. Jeśli wszystko
inne zawiedzie możesz zapytać na vim-liście |maillist|.


INSTALACJA
							*install-home*
Jeśli chcesz Vima zainstalować w swoim katalogu domowym otwórz Makefile
i szukaj linii:

	#prefix = $(HOME) ~

Usuń # na początku linii.
   W czasie instalacji dla całego systemu Vim najprawdopodobniej już wybrał
odpowiedni katalog za ciebie. Możesz także jakiś określić, zobacz poniżej.
Musisz zalogować się jako root dla następnych czynności.

Żeby zainstalować Vima: >

	make install

To polecenie powinno przenieść wszystkie pliki w odpowiednie miejsca. Teraz
możesz spróbować uruchomić Vima, żeby sprawdzić czy działa. Zrób dwa proste
testy i przekonaj się czy Vim może znaleźć pliki runtime: >

	:help
	:syntax enable

Jeśli polecenia nie skutkują użyj tego polecenia by sprawdzić gdzie Vim szuka
odpowiednich plików: >

	:echo $VIMRUNTIME

Możesz również uruchomić Vima z argumentem "-V", żeby zobaczyć co się dzieje
podczas uruchomienia: >

	vim -V

Nie zapomnij, że podręcznik użytkownika zakłada, że działasz w Vimie w pewien
określony sposób. Po instalacji Vima posługując się instrukcjami
w |not-compatible| spraw by Vim działał tak jak zakłada ten podręcznik.


WYBÓR OPCJI

W Vimie jest wiele sposobów wyboru opcji. Jednym z prostszych sposobów jest
edycja Makefile. Można tam znaleźć wiele wskazówek i przykładów. Najczęściej
możesz uaktywnić lub zdeaktywować opcję przez odkomentowanie linii.
   Alternatywą jest oddzielne uruchomienie "configure". Pozwala to na "ręczny"
wybór opcji. Wadą tego rozwiązania jest fakt, że musisz wiedzieć co trzeba
wpisać.
   Tutaj podaję kilka najbardziej interesujących argumentów. Są one dostępne
też przez Makefile.

	--prefix={katalog}		Katalog gdzie zainstalować Vima.

	--with-features=tiny		Kompilacja z małą ilością opcji.
	--with-features=small		Kompilacja z większą ilością opcji.
	--with-features=big		Kompilacja z dużą ilością opcji.
	--with-features=huge		Kompilacja z bardzo dużą ilością opcji.
					Zobacz |+feature-list|, wyjaśniono
					tam, które opcje są uaktywnione
					w każdym wypadku.

	--enable-perlinterp		Udostępnij interfejs perla. Jest
					kilka podobnych argumentów dla ruby,
					pythona i tcl.

	--disable-gui			Kompiluj bez GUI.
	--without-x			Nie kompiluj opcji X-window.
					Kiedy oba są użyte, Vim nie będzie się
					kontaktował z serwerem X co czyni
					start Vima szybszym.

Żeby zobaczyć pełną listę: >

	./configure --help

Znajdziesz tam proste wyjaśnienia dla każdej opcji i wskazówki. Więcej
informacji jest tu: |feature-list|.
   Dla odważnych jest edycja pliku "feature.h". Możesz sam zmienić plik
źródłowy!

==============================================================================
*90.2*	MS-Windows

Istnieją dwa sposoby zainstalowania Vima w Microsoft Windows. Możesz użyć
kilku skompresowanych archiwów albo samoinstalującego się dużego archiwum.
Większość użytkowników z nowszymi komputerami wybierze drugą metodę.
W przypadku pierwszej potrzebujesz:

	- Archiwum z plikami binarnymi Vima.
	- Archiwum runtime.
	- Program do rozpakowania archiwum zip.

Żeby dostać archiwa Vima poszukaj w tym pliku mirrora blisko ciebie, powinien
zapewnić najszybszy dostęp:

	ftp://ftp.vim.org/pub/vim/MIRRORS ~

Lub użyj domowej strony ftp.vim.org, jeśli uważasz, że prędkość jest
wystarczająca. Przejdź do katalogu "pc" i znajdziesz tam listę plików. Numer
wersji jest włączony do nazwy pliku. Zapewne będziesz chciał ściągnąć
najnowszą wersję. W przykładach użyjemy "61", co oznacza wersję 6.1.

	gvim61.exe		Samo instalujące się archiwum.

To wszystko czego potrzebujesz do drugiej metody. Wystarczy uruchomić plik exe
i wykonywać poszczególne punkty instalacji.

W pierwszym wypadku musisz wybrać jeden ze spakowanych plików binarnych.
Dostępne są:

	gvim61.zip		Zwykła wersja GUI dla MS-Windows.
	gvim61ole.zip		Wersja GUI dla MS-Windows ze wsparciem OLE.
				Używa więcej pamięci, wspiera interakcję
				z innymi aplikacjami OLE.
	vim61w32.zip		32-bitowa, konsolowa wersja dla MS-Windows.
				Do użycia na konsoli Win NT/2000/XP. Niezbyt
				dobrze pracuje na Win 95/98.
	vim61d32.zip		32-bitowa wersja dla MS-DOS. Do użycia na
				konsoli w Win 95/98.
	vim61d16.zip		16-bitowa wersja dla MS-DOS. Tylko na starsze
				systemy. Nie wspiera długich nazw plików.

Potrzebujesz tylko jednego z nich. Chociaż możesz zainstalować zarówno GUI jak
i wersję konsolową. Zawsze potrzebujesz archiwum z plikami runtime.

	vim61rt.zip		Pliki runtime.

Użyj programu do rozpakowywania archiwów zip (na przykład programu "unzip"): >

	cd c:\
	unzip ścieżka\gvim61.zip
	unzip ścieżka\vim61rt.zip

Pliki zostaną rozpakowane do katalogu "c:\vim\vim61". Jeśli już masz gdzieś
katalog "vim" będziesz chciał pliki przenieść do katalogu powyżej.
   Teraz przejdź do katalogu "vim\vim61" i uruchom program "install": >

	install

Uważnie czytaj wiadomości i wybierz opcje jakich będziesz chciał używać.
W końcu wybierz "do it" i program instalacyjny przeprowadzi wybrane przez
ciebie operacje.
   Program instalacyjny nie przenosi plików runtime. Pozostają tam gdzie je
umieściłeś.

W przypadku kiedy nie jesteś usatysfakcjonowany opcjami włączonymi
w udostępnionych wersjach binarnych możesz spróbować sam skompilować Vima.
Archiwa ze źródłami są w tym samym miejscu gdzie binarki. Potzebujesz
kompilatora dla którego istnieje makefile. Microsoft Visual C działa, ale jest
drogi. Free Borland kompilator 5.5 też działa, tak jak i MingW oraz Cygwin.
Poczytaj wskazówki w src/INSTALLpc.txt.

==============================================================================
*90.3*	Uaktualnianie programu

Jeśli masz już jakąś wersję Vima, a chcesz zainstalować inną tu jest
wyjaśnione co musisz zrobić.


UNIX

Kiedy wydajesz polecenie "make install" pliki runtime zostaną skopiowane do
katalogu specyficznego dla danej wersji. Dlatego nie nadpiszą one już
istniejących plików dla innej wersji. W ten sposób możliwe jest używanie obok
siebie dwóch lub więcej wersji.
   Pliki wykonywalne "vim" nadpiszą starszą wersję. Jeśli nie chcesz zachować
starszej wersji wpisanie "make install" starczy. Możesz usunąć stare pliki
runtime ręcznie. Wystarczy usunąć katalog z numerem wersji i wszystkie pliki,
które się w nim znajdują: >

	rm -rf /usr/local/share/vim/vim58

Normalnie nie ma zmienionych plików w tym katalogu. Jeśli jednak zmieniłeś, na
przykład, plik "filetype.vim" to lepiej wprowadź zmiany do nowej wersji przed
usunięciem starej.

Jeśli jesteś ostrożny i chcesz wypróbować nową wersję przez pewien czas,
zainstaluj nową wersję pod inną nazwą. Musisz określić specjalny argument dla
"configure": >

	./configure --with-vim-name=vim6

Zanim uruchomisz "make install" możesz użyć "make -n install", żeby sprawdzić
czy któryś z istniejących plików nie zostanie nadpisany.
   Kiedy w końcu zdecydujesz się przesiąść na nową wersję, wszystko co musisz
zrobić to zmienić nazwę binarki na "vim": >

	mv /usr/local/bin/vim6 /usr/local/bin/vim


MS-WINDOWS

Uaktualnianie najczęściej równa się instalacji nowej wersji. Po prostu
rozpakuj pliki w to samo miejsce gdzie jest poprzednia wersja. Zostanie
utworzony nowy katalog, np.: "vim61", dla plików nowej wersji. Pliki runtime,
vimrc, vimifo itp. zostaną nietknięte.
   Jeśli chcesz uruchomić nową wersję obok starej musisz trochę popracować.
Nie uruchamiaj programu instalacyjnego bo nadpisze kilka plików ze starej
wersji. Wywołuj nowe pliki binarne przez określenie pełnej ścieżki do nich.
Program powinien znaleźć pliki runtime dla odpowiedniej wersji. Niestety nie
będzie działać jeśli jest gdzieś określona zmienna $VIMRUNTIME.
   Jeśli jesteś usatysfakcjonowany uaktualnieniem możesz usunąć pliki ze
starszej wersji. Zobacz |90.5|.

==============================================================================
*90.4*	Zwykłe problemy przy instalacji

Ta sekcja opisuje kilka powszechnych problemów, które mogą się zdarzyć przy
instalacji Vima i sugeruje rozwiązania. Zawiera też odpowiedzi na wiele pytań
o instalację.


Q: Nie mam przywilejów roota. Jak zainstalować Vima? (Unix)

Użyj następującego polecenia konfigurującego, żeby zainstalować Vima
w katalogu $HOME/vim: >

	./configure --prefix=$HOME

W ten sposób będziesz miał swoją własną kopię Vima. Musisz dodać $HOME/bin do
zmiennej $PATH do wywoływania edytora. Zobacz też |install-home|.


Q: Kolory nie prezentują się prawidłowo na ekranie (Unix)

Sprawdź ustawienia terminala wydając w powłoce polecenie: >

	echo $TERM

Jeśli typ terminala nie jest prawidłowy, napraw to. Więcej wskazówek jest tu:
|06.2|. Innym rozwiązaniem jest używanie zawsze wersji GUI Vima, nazywanj
gvim. W ten sposób unikasz potrzeby prawidłowego ustawienia terminala.


Q: Moje klawisze Backspace i Delete nie działają prawidłowo

Definicja, który klawisz wysyła jaki kod jest niezbyt jasna dla Backspace <BS>
i Delete <Del>. Przede wszystkim sprawdź ustawienia $TERM. Jeśli tu wszystko
jest prawidłowo spróbuj tego: >

	:set t_kb=^V<BS>
	:set t_kD=^V<Del>

W pierwszej linii musisz wcisnąć CTRL-V, a potem klawisz Backspace.  W drugiej
linii musisz wcisnąć CTRL-V, a potem klawisz Delete. Możesz wstawić te dwie
linie do swojego vimrca, zobacz |05.1|. Wadą tego rozwiązania jest to, że może
nie działać kiedy użyjesz kiedyś innego terminala. Zajrzyj tu po inne
rozahwiązania: |:fixdel|.


Q: Używam RedHat Linux. Mogę używać Vima, który przychodzi razem z systemem?

Domyślnie RedHat instaluje minimalną wersję Vima. Poszukaj w pakietach RPM
czegoś co się nazywa "vim-enhanced" i zainstaluj to.


Q: Jak włączyć podświetlanie składni? Jak działają wtyczki?

Użyj przykładowego vimrca. Wyjaśnienie jak go używać znajdziesz tu:
|not-compatible|.

W rozdziale 6 jest więcej informacji o podświetlaniu składni: |usr_06.txt|.


Q: Jaki jest dobry plik vimrc?

Zajrzyj na www.vim.org. Tam jest kilka niezłych przykładów.


Q: Gdzie znajdę dobrą wtyczkę do Vima?

Zobacz stronę Vim-online: http://vim.sf.net. Wielu użytkowników wystawiło tam
użyteczne skrypty i wtyczki dla Vima.


Q: Gdzie mogę znaleźć więcej wskazówek?

Zobacz stronę Vim-online: http://vim.sf.net. Jest tam archiwum ze wskazówkami
dla użytkowników Vima. Możesz też przeszukać archiwum vim-listy:
|maillist-archive|.

==============================================================================
*90.5*	Odinstalowywanie Vima

W mało prawdopodobnym wypadku kiedy będziesz chciał całkowicie odinstalować
Vima tu jest wyjaśnione jak należy to zrobić.


UNIX

Jeśli instalowałeś Vima jako pakiet sprawdź w swoim zarządcy pakietów jak
usunąć pakiet.
   Jeśli instalowałeś Vima ze źródeł użyj polecenia: >

	make uninstall

Jednak jeśli usunąłeś oryginalne pliki lub użyłeś archiwum, które ktoś inny
dostarczył nie możesz tego zrobić. Żeby usunąć pliki ręcznie tu jest przykład
dla katalogu "/usr/local" jako root: >

	rm -rf /usr/local/share/vim/vim61
	rm /usr/local/bin/eview
	rm /usr/local/bin/evim
	rm /usr/local/bin/ex
	rm /usr/local/bin/gview
	rm /usr/local/bin/gvim
	rm /usr/local/bin/gvim
	rm /usr/local/bin/gvimdiff
	rm /usr/local/bin/rgview
	rm /usr/local/bin/rgvim
	rm /usr/local/bin/rview
	rm /usr/local/bin/rvim
	rm /usr/local/bin/rvim
	rm /usr/local/bin/view
	rm /usr/local/bin/vim
	rm /usr/local/bin/vimdiff
	rm /usr/local/bin/vimtutor
	rm /usr/local/bin/xxd
	rm /usr/local/man/man1/eview.1
	rm /usr/local/man/man1/evim.1
	rm /usr/local/man/man1/ex.1
	rm /usr/local/man/man1/gview.1
	rm /usr/local/man/man1/gvim.1
	rm /usr/local/man/man1/gvimdiff.1
	rm /usr/local/man/man1/rgview.1
	rm /usr/local/man/man1/rgvim.1
	rm /usr/local/man/man1/rview.1
	rm /usr/local/man/man1/rvim.1
	rm /usr/local/man/man1/view.1
	rm /usr/local/man/man1/vim.1
	rm /usr/local/man/man1/vimdiff.1
	rm /usr/local/man/man1/vimtutor.1
	rm /usr/local/man/man1/xxd.1


MS-WINDOWS

Jeśli instalowałeś Vima z samo instalującego się archiwum możesz uruchomić
program "uninstall-gui" znajdujący się w tym samym katalogu co inne programy,
np.: c:\vim\vim61". Możesz również uruchomić go również z menu Start jeśli
zainstalowałeś tam menu Vima. Usunie on większość plików, menu oraz skróty
z Pulpitu. Niektóre pliki mogą zostać, i zostaną, usunięte dopiero po restarcie
Windows.
   Będziesz miał możliwość usunięcia całego katalogu "vim". Prawdopodobnie
zawiera on twój plik vimrc i inne stworzone przez ciebie pliki runtime, więc
uważaj.

W innym wypadku, jeśli instalowałeś Vima z pliku zip, zalecaną metodą jest
użycie programu "uninstal' (zauważ brak l na końcu). Znajdziesz go w tym samym
katalogu co program "install", np.: "c:\vim\vim61". Powinien również działać
ze zwykłego miejsca w Panelu Zarządzania "zainstaluj/usuń programy".
   Jednak program ten usuwa tylko odpowiednie punkty w rejestrze. Pliki musisz
usunąć sam. Po prostu usuń katalog "vim\vim61" razem z podkatalogami. Nie
powinno być tam plików, które sam stworzyłeś, ale być może będziesz wolał to
najpierw sprawdzić.
   Katalog "vim" prawdopodobnie zawiera twój plik vimrc i inne pliki runtime,
które stworzyłeś. Możesz chcieć je zachować.

==============================================================================

Spis treści: |usr_toc.txt|

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
