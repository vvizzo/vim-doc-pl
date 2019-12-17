*usr_40.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				Nowe polecenia


Vim jest edytorem, którego zastosowania możesz rozszerzyć. Jesteś w stanie
wziąć sekwencję poleceń, których często używasz, zamienić w nowe polecenie,
albo przedefiniować istniejące polecenie. Autokomendy pozwalają na
wykonywanie poleceń automatycznie.

|40.1|	Mapowanie klawiszy
|40.2|	Definiowanie komend linii poleceń
|40.3|	Autokomendy

 Następny rozdział: |usr_41.txt|  Pisanie skryptów Vima
Poprzedni rozdział: |usr_31.txt|  Eksploracja GUI
       Spis treści: |usr_toc.txt|

==============================================================================
*40.1*	Mapowanie klawiszy

Proste mapowania zostały wyjaśnione w sekcji |05.3|. Zasada jest taka, że
pewna sekwencja klawiszy jest przetłumaczona na inną sekwencję klawiszy. To
bardzo prosty, ale potężny mechanizm.
   Najprostszą formą jest to, że jeden klawisz jest mapowany do sekwencji
klawiszy. Ponieważ klawisze funkcyjne, z wyjątkiem <F1>, nie mają
predefiniowanego znaczenia w Vimie są dobrym wyborem do mapowania: >

	:map <F2> GoData: <Esc>:read !date<CR>kJ

Widać tu jak wykorzystane są trzy tryby. Po przejściu do ostatniej linii
- "G", komenda "o" otwiera nową linię i zaczyna tryb Insert. Wyraz "Data: "
 zostaje wstawiony i <Esc> kończy tryb Insert.
   Zauważ użycie specjalnych klawiszy wewnątrz nawiasów trójkątnych <>. Jest
to notacja nawiasów trójkątnych. Wpisujesz je jako oddzielne znaki, a nie
wciskając odpowiedni klawisz. Dzięki temu mapowania są bardziej czytelne
i możesz przekopiować tekst bez problemów.
   Znak ":" przenosi Vima do linii poleceń. Polecenie ":read !date" odczytuje
wynik polecenia "date" i wstawia go poniżej bierzącej linii. <CR> jest
konieczne do wykonania polecenia ":read".
   W tym momencie tekst wygląda tak:

	Data:  ~
	nie lut 16 00:18:22 CET 2003~

Teraz "kJ" przenosi kursor jedną linię w górę i łączy obie linie.
   Żeby zdecydować, których klawiszy możesz użyć do mapowań zobacz
|map-which-keys|.


MAPOWANIE I TRYBY

Polecenie ":map" definiuje remapowania dla klawiszy w trybie Normal. Możesz
także definiować mapowania dla innych trybów. Na przykład, ":imap" odnosi się
do trybu Insert. Możesz użyć go do wstawienia daty poniżej kursora: >

	:imap <F2> <CR>Data: <Esc>:read !date<CR>kJ

Wygląda prawie tak samo jak mapowanie dla <F2> w trybie Normal, tylko początek
jest inny. Mapowanie <F2> dla trybu Normal istnieje cały czas. Dzięki temu
możesz mapować klawisze różnie w zależności od trybu.
   Zauważ, że mimo początku w trybie Insert, mapowanie kończy się w trybie
Normal. Jeśli chcesz by kończyło się w trybie Insert, dodaj "a" do mapowania.

Tutaj jest przegląd poleceń "map" i trybów w jakich pracują:

	:map		Normal, Visual i Operator-pending
	:vmap		Visual
	:nmap		Normal
	:omap		Operator-pending
	:map!		Insert i linia poleceń
	:imap		Insert
	:cmap		Linia poleceń

Tryb operator-pending występuje wtedy kiedy wpiszesz znak operatora, takiego
jak "d" lub "y" i oczekuje się od ciebie wydania komendy ruchu lub obiektu
tekstowego. Stąd kiedy wpisujesz "dw", "w" jest wprowadzane w trybie
operator-pending.

Przypuśćmy, że chcesz zdefiniować <F7>, tak że polecenie d<F7> usuwa blok
w programie C (tekst zamknięty w nawiasach klamrowych, {}). Podobnie y<F7>
mogłoby yankować blok programu do bezimiennego rejestru. To co potrzebujesz to
zdefiniować <F7> tak by wybierał bieżący blok programu. Możesz to zrobić
nstępującym poleceniem: >

	:omap <F7> a{

W ten sposób <F7> wybiera blok "a{" w trybie operator-pending, tak jak to
wpisałeś. Użyteczne mapowanie jeśli wpisanie { na twojej klawiaturze jest
trochę kłopotliwe.


LISTA MAPOWAŃ

Żeby zobaczyć zdefiniowane mapowania użyj ":map" bez argumentów lub jeden
z wariantów, który uwzględnia tryb w jakim pracuje. Wynik powinien wyglądać
mniej więcej tak:

	   _g		 :call MyGrep(1)<CR> ~
	v  <F2>		 :s/^/> /<CR>:noh<CR>`` ~
	n  <F2>		 :.,$s/^/> /<CR>:noh<CR>`` ~
	   <xHome>	 <Home>
	   <xEnd>	 <End>


Pierwsza kolumna listy pokazuje, w którym trybie działa mapowanie. "n" dla
trybu Normal, "i" dla Insert, itd. Puste miejsce jest użyte dla mapowania
zdefionawego przez ":map" i działającego w trybach Normal i Visual.
   Listowanie mapowań przydaje się do sprawdzenia czy mapowanie rozpoznało
specjalne klawisze w nawiasach <> (działa tylko jeśli działa kolor). Na
przykład kiedy <Esc> jest podświetlone oznacza znak escape. Kiedy ma ten sam
kolor co reszta tekstu jest to pięć znaków.


REMAPOWANIE

Wynik mapowania jest przeszukiwany pod względem innych mapowań, które mogą być
w nim zawarte. Na przykład mapowanie <F2> z przykładu powyżej może być
skrócone do: >

	:map <F2> G<F3>
	:imap <F2> <Esc><F3>
	:map <F3>  oData: <Esc>:read !date<CR>kJ

Dla trybu Normal <F2> jest tak zmapowany by przeszedł do ostatniej linii,
a potem zachowywał się tak jakby naciśnięto <F3>. W trybie Insert <F2>
wychodzi z trybu Insert przez <Esc>, a potem też używa <F3>. Na końcu <F3>
jest mapowane do wykonania właściwej pracy.

Przypuśćmy, że rzadko używasz trybu Ex i chcesz użyć komendy "Q" do
formatowania tekstu (tak było w starszych wersjach Vima): >

	:map Q gq

Ale w rzadkich przypadkach chcesz użyć trybu Ex. Zmapuj "gQ" do Q, tak więc
możesz ciągle przejść w tryb Ex: >

	:map gQ Q

Teraz kiedy wpiszesz "gQ" jest zmapowane do "Q". Jak na razie nieźle. Ale "Q"
jest zmapowane do "gq" i dlatego wpisanie "gQ" daje w rezultacie "gq" i ciągle
nie możesz się dostać do trybu Ex.
   Aby uniknąć ponownego mapowania klawiszy użyj komendy ":noremap": >

	:noremap gQ Q

Teraz Vim wie, że nie powinien sprawdzać czy "Q" jest do czegoś zmapowane.
Dla każdego trybu jest podobne polecenie:

	:noremap	Normal, Visual i Operator-pending
	:vnoremap	Visual
	:nnoremap	Normal
	:onoremap	Operator-pending
	:noremap!	Insert i linia poleceń
	:inoremap	Insert
	:cnoremap	Linia poleceń


MAPOWANIA REKURSYWNE

Kiedy mapowanie uruchamia samo siebie pętla może trwać wiecznie. Można tego
użyć do powtarzania akcji nieskończoną ilość razy.
   Przykład: masz listę plików, które zawierają numer wersji w pierwszej
linii. Otwierasz te pliki "vim *.txt". Edytujesz teraz pierwszy plik.
Zdefiniuj mapowanie: >

	:map ,, :s/5.1/5.2/<CR>:wnext<CR>,,

Teraz wpisz ",," uruchamiając mapowanie. Zamienia ono "5.1" na "5.2"
w pierwszej linii. Potem wykonuje ":wnext" zapisując plik i przechodząc do
następnego. Mapowanie kończy się na ",,". To znowu uruchamia to samo
mapowanie, które wykonuje zamianę, itd.
   Pętla trwa dopóki nie napotka błędu. W tym wypadku będzie to gdy dojdziesz
do pliku, w którym polecenie ":substitute" nie znajdzie "5.1". Możesz wtedy
wpisać "5.1" i kontynuować przez wciśnięcie ",,". Może też zawieść
":wnext" ponieważ znajdziesz się w ostatnim pliku na liście.
   Kiedy mapowanie napotka błąd w połowie drogi, reszta nie jest wykonywana.
CTRL-C przerywa mapowanie (CTRL-Break w MS-Windows).


USUWANIE MAPOWAŃ

Do usuwania mapowań służy polecenie ":unmap". Znowu, tryb jakiego dotyczy
usuwanie mapowań zależy od użytego polecenia:

	:unmap		Normal, Visual i Operator-pending
	:vunmap		Visual
	:nunmap		Normal
	:ounmap		Operator-pending
	:unmap!		Insert i linia poleceń
	:iunmap		Insert
	:cunmap		Linia poleceń

Jest trik, który służy do zdefiniowania mapowania, które działa w trybach
Normal i Operator-pending, ale nie w trybie Visual. Najpierw zdefiniuj je dla
wszystkich trzech, a potem usuń je z trybu Visual: >

	:map <C-A> /---><CR>
	:vunmap <C-A>

Zauważ, że pięć znaków "<C-A>" oznacza pojedyncze wciśnięcie CTRL-A.

Żeby usunąć wszystkie mapowania użyj polecenia |:mapclear|. Teraz jesteś
w stanie odgadnąć jego wariacje dla różnych trybów. Uważaj z tym poleceniem,
nie może być cofnięte.


ZNAKI SPECJALNE

Polecenie ":map" może poprzedzać inne polecenie. Znak | oddziela dwa
polecenia. Oznacza to także, że | nie może być użyty wewnątrz polecenia
":map". Możesz ten znak włączyć używając zamiast niego <Bar> (pięć znaków): >

	:map <F8> :write <Bar> !checkin %<CR>

Ten sam problem dotyczy polecenia ":unmap", na dodatek musisz uważać na zbędne
spacje. Te dwa polecenia są różne: >

	:unmap a | unmap b
	:unmap a| unmap b

Piersze polecenie próbuje odmapować "a ".

Do mapowania spacji użyj <Space> (siedem znaków): >

	:map <Space> W

Dzięki temu wciśnięcie spacji przeniesie kursor o jeden WYRAZ (WORD) do
przodu.

Nie jest możliwe dodanie komentarza po mapowaniu ponieważ znak " jest uznawany
za część mapowania.


MAPOWANIA I SKRÓTY

Skróty są bardzo podobne do mapowań w trybie Insert. Argumenty są traktowane
w ten sam sposób. Główna różnica leży w sposobie uruchamiania. Skrót jest
uruchamiany przez wpisanie nie-wyrazowego znaku za wyrazem. Mapowanie jest
uruchamiane po wpisaniu ostatniego znaku.
   Inną różnicą jest to, że znaki, które wpisujesz w skrócie są wprowadzane do
tekstu kiedy je wpisujesz. Kiedy skrót jest uruchomiony znaki te zostaną
usunięte i zastąpione przez to co zostało zdefiniowane. Kiedy wpisujesz znaki
w mapowaniu nic nie jest wprowadzane dopóki nie wpiszesz ostatniego znaku,
który uruchomi mapowanie. Jeśli jest ustawiona opcja 'showcmd' wpisywane znaki
są widoczne w ostatniej linii okna Vima.
   Wyjątkiem jest sytuacja gdy mapowanie jest wieloznaczne. Przypuśćmy, że
zrobiłeś dwa mapowania: >

	:imap aa foo
	:imap aaa bar

Teraz kiedy wpiszesz "aa", Vim nie wie czy powinien zastosować pierwsze czy
drugie mapowanie. Czeka na inny znak do wpisania. Jeśli będzie to "a" zostanie
uruchomione drugie mapowanie i wynikiem będzie "bar". Jeśli spacja piersze
mapowanie znajdzie zastosowanie i na ekranie znajdą się "foo", i spacja.


DODATKOWO...

Słowa kluczowego <script> można użyć by mapowanie było lokalne dla skryptu.
Zobacz |:map-<script>|.

Słowa kluczowego <buffer> można użyć by mapowanie było lokalne dla określonego
bufora. Zobacz |:map-<buffer>|.

Słowa kluczowego <unique> można użyć by nowe mapowanie nie było możliwe jeśli
już istnieje. W innym wypadku nowe mapowanie po prostu nadpisze stare. Zobacz
|:map-<unique>|.

Żeby klawisz nic nie robił, zmapuj go do <Nop> (pięć znaków). W ten sposób
klawisz <F7> nie biędzie nic robił: >

	:map <F7> <Nop>| map! <F7> <Nop>

Nie może być spacji po <Nop>.

==============================================================================
*40.2*	Definiowanie komend linii poleceń

Vim pozwala na definiowanie własnych poleceń. Wykonujesz te polecenia
dokładnie tak jak każde inne polecenie trybu linii poleceń.
   Do zdefiniowania polecenia użyj ":command": >

	:command DeleteFirst 1delete

Teraz kiedy wydasz polecenie ":DeleteFirst" Vim wykona ":1delete", które usuwa
pierwszą linię.

	Note:
	Polecenia użytkownika muszą zaczynać się wielką literą. Nie możesz
	użyć ":X", ":Next" i ":Print". Nie można użyć podkreślenia! Cyfry są
	dozwolone, ale ich użycie nie jest zalecane.
	Polskie znaki diakrytyczne są niedozwolone.

Listę poleceń użytkownika uzyskasz dzięki: >

	:command

Tak samo jak polecenia wbudowane, polecenia użytkownika mogą być skrócone.
Wystarczy wpisać tylko tyle liter ile wymagane jest do odróżnienia jednego
polecenia od innego. Uzupełnianie linii poleceń też tu działa.


LICZBA ARGUMENTÓW

Polecenia użytkownika mogą pobierać argumenty. Liczba argumentów musi być
określona przez opcję -nargs. Na przykład polecenie :DeleteFirst nie pobiera
argumentów, tak więc możesz je zdefiniować tak: >

	:command -nargs=0 DeleteFirst 1delete

Jednak ponieważ zero argumentów jest ustawione domyślnie nie musisz dodawać
"-nargs=0". Inne wartości -nargs to:

	-nargs=0	Brak argumentów
	-nargs=1	Jeden argument
	-nargs=*	Dowolna liczba argumentów
	-nargs=?	Zero lub jeden argument
	-nargs=+	Jeden lub więcej argumentów


UŻYWANIE ARGUMENTÓW

Wewnątrz definicji polecenia argumenty są reprezentowane przez słowo kluczowe
<args>: >

	:command -nargs=+ Powiedz :echo "<args>"

Teraz kiedy wpiszesz: >

	:Powiedz Witaj świecie

Vim odpowiada "Witaj świecie". Jednak jeśli dodasz podwójny cudzysłów to nie
zadziała. Na przykład: >

	:Powiedz mu "Witaj"

Żeby znaki specjalne zostały zamienione w łańcuch, odpowiednio użyte jako
wyrażenie, użyj "<q-args>": >

	:command -nargs=+ Powiedz :echo <q-args>

Teraz powyższe polecenie ":Powiedz" będzie równoważne: >

	:echo "mu \"Witaj\""

Słowo kluczowe <f-args> zawiera te same informacje co <args>, z wyjątkiem
tego, że są one w formacie odpowiednim do użycia w wywoływaniu funkcji. Na
przykład: >
>
	:command -nargs=* ZrobTo :call Funkcja(<f-args>)
	:ZrobTo a b c

Wykona polecenie: >

	:call Funkcja("a", "b", "c")


ZASIĘG

Niektóre polecenia mogą pobrać zasięg jako argument. Jednak żeby Vim o tym
wiedział musisz mu o tym powiedzieć określając argument -range. Jego wartości
mogą być następujące:

	-range		Zasięg jest dozwolony: domyślnie bieżąca linia.
	-range=%	Zasięg jest dozwolony: domyślnie cały plik.
	-range={count}	Zasięg jest dozwolony: ostatni numer w nim jest użyty
			jako pojedyncza liczba, która domyślnie jest równa
			{count}

Kiedy zasięg jest określony, słowa kluczowe <line1> i <line2> to wartości
pierwszej i ostatniej linii w zasięgu. Na przykład, następujące polecenie
definiuje polecenie SaveIt, które zapisuje określony zasięg do pliku
save_file: >

	:command -range=% SaveIt :<line1>,<line2>write! save_file


INNE OPCJE

Parę innych opcji i ich słowa kluczowe:

	-count={liczba}		Polecenie może pobrać mnożnik, którego
				domyślną wartością jest {liczba}. Ostateczny
				mnożnik dostępny jest przez słowo kluczowe
				<count>.
	-bang			Możesz użyć !. Jeśli obecny, użycie <bang>
				będzie równoznaczne !.
	-register		Możesz określić rejestr. (Domyślnie nienazwany
				rejestr.)
				Nazwa rejestru dostępna jest przez <reg> (aka
				<register>).
	-complete={typ}		Typ uzupełniania linii poleceń. Zobacz
				|:command-completion| by uzyskać listę
				możliwych wartości.
	-bar			Po poleceniu może wystąpić | i inne polecenie
				albo " i komentarz.
	-buffer			Polecenie jest dostępne tylko dla bieżącego
				bufora.

Do dyspozycji masz także słowo kluczowe <lt>. Oznacza ono znak <. Użyj go do
uniknięcia specjalnego znaczenia elementów ujętych w <>.


REDEFINIOWANIE I USUWANIE

To samo polecenie redefiniujesz używając argumentu !: >

	:command -nargs=+ Powiedz :echo "<args>"
	:command! -nargs=+ Powiedz :echo <q-args>

Do usuwania poleceń użytkownika służy ":delcommand". Wymagany jest
pojedynczy argument, którym jest nazwa polecenia: >

	:delcommand ZachowajTo

Aby usunąć wszystkie polecenia użytkownika: >

	:comclear

Uwaga: to polecenie nie może być cofnięte!

Więcej szczegółów o poleceniach użytkownika w podręczniku encyklopedycznym:
|user-commands|.

==============================================================================
*40.3*	Autokomendy

Autokomenda to polecenie, które jest wykonywane automatycznie w odpowiedzi na
pewne wydarzenie, takie jak odczytanie pliku lub jego zapisanie, albo zmiana
bufora. Poprzez autokomendy można zmusić Vima na przykład do edycji
skompresowanych plików. W ten sposób używa się wtyczki |gzip|.

   Autokomendy to bardzo potężne narzędzie. Użyte z rozwagą pozwolą na
zautomatyzowanie wielu czynności. Użyte bezmyślnie spowodują wiele problemów.

Przypuśćmy, że chcesz wymienić znacznik daty na końcu pliku za każdym razem
kiedy plik jest zapisywany. Najpierw napisz funkcję: >

	:function WstawDate()
	:  $delete
	:  read !date
	:endfunction

Chcesz wywoływać tę funkcję za każdym razem, tuż przed tym kiedy plik jest
zapisywany. Zrób tak: >

	:autocmd FileWritePre *  call DateInsert()

"FileWritePre" to wydarzenie (event), które uruchomi autokomendę: tuż przed
zapisaniem pliku (pre writing a file). "*" to wzorzec, który dopasowuje nazwę
pliku.  W tym wypadku pasują wszystkie pliki.
   Mając to polecenie ustawione kiedy wpiszesz ":write", Vim sprawdzi pasujące
autokomendy FileWritePre i wykona je, a dopiero potem wykona ":write".
   Ogólna forma polecenia :autocmd to: >

	:autocmd [grupa] {zdarzenia} {wzorzec-pliku} [nested] {polecenie}

Nazwa [grupa] jest opcjonalna. Używana do zarządzania i wywoływania poleceń
(więcej o tym później). Parametr {zdarzenia} to lista wydarzeń (odzielonych
przecinkami), które uruchamiają polecenie.
   {wzorzec-pliku} to nazwa pliku, zazwyczaj z kwantyfikatorami. Na przykład
użycie z "*.txt" powoduje wykonanie autokomendy na wszystkich plikach
kończących się na ".txt". Opcjonalna flaga [nested] pozwala na zagnieżdżanie
autokomend (zobacz poniżej), a na końcu {polecenie} to polecenie do wykonania.


ZDARZENIA

Jednym z najbardziej przydatnych zdarzeń jest BufReadPost. Uruchamiane jest
w momencie otwierania nowego pliku. Używane powszechnie do ustawiania
wartości opcji. Wiesz na przykład, że pliki "*.gsm" są plikami GNU asemblera.
Żeby ustawić prawidłowo podświetlanie składni zdefiniuj autokomendę: >

	:autocmd BufReadPost *.gsm  set filetype=asm

Jeśli Vim jest w stanie wykryć typ pliku ustawi opcję 'filetype' za ciebie.
To uruchamia wydarzenie Filetype. Użyj go do zrobienia czegoś przy edycji
określonego typu pliku. Na przykład załaduj listę skrótów dla plików
tekstowych: >

	:autocmd Filetype text  source ~/.vim/abbrevs.vim

Otwierając nowy plik, możesz przekonać Vima by wstawiał szkielet pliku: >

	:autocmd BufNewFile *.[ch]  0read ~/skeletons/skel.c

Zobacz w |autocmd-events| kompletną listę zdarzeń.


WZORCE

Argument {wzorzec-pliku} to właściwie odzielona przecinkami lista wzorców
plików. Na przykład: "*.c,*.h" dopasowuje pliki kończące się na ".c" i ".h".
   Działają tu zwykłe kwantyfikatory nazw plików. Najważniejsze i najczęściej
używane to:

	*		Dopasuj dowolny znak dowolną ilość razy
	?		Dopasuj dowolny znak raz
	[abc]		Dopasuj znak a, b lub c
	.		Dopasowuje kropkę
	a{b,c}		Dopasowuje "ab" i "ac"

Jeśli wzorzec zawiera slash (/) Vim porówna nazwy katalogów. Bez slasha tylko
ostatnia część nazwy pliku jest brana pod uwagę. Na przykład, "*.txt" pasuje
do "/home/biep/readme.txt". Wzorzec "/home/biep/*" też by to dopasował. Ale
"home/foo/*.txt" już nie.
   Włączając slash, Vim dopasowuje wzorzec zarówno do pełnej ścieżki pliku
("/home/biep/readme.txt") i relatywnej (np.: "biep/readme.txt").

	Note:
	Pracując na systemach, które używają backslasha jako separatora (np.:
	MS-Windows) cały czas używaj ciachów w autokomendach. W ten sposób
	łatwiej jest pisać wzorce, ponieważ backslashe mają znaczenie
	specjalne. Dzięki temu autokomendy są też przenośne na inne systemy.


USUWANIE

Do usunięcia autokomendy użyj tego samego polecenia, które autokomendę
definiowało, ale opuść {polecenie} na końcu i użyj !. Przykład: >

	:autocmd! FileWritePre *

Usunie wszystkie autokomendy dla wydarzenia "FileWritePre", które używały
wzorca "*".


LISTOWANIE

Listę aktualnie zdefiniowanych autokomand otrzymasz dzięki poleceniu: >

	:autocmd

Lista może być bardzo długa, szczególnie jeśli używasz wykrywania typu pliku.
Żeby wylistować tylko część komend określ grupę, wydarzenie i/lub
wzorzec-pliku. Na przykład, żeby otrzymać listę wszystkich autokomend
BufNewFile: >

	:autocmd BufNewFile

Lista wszystkich autokomend dla wzorca "*.c": >

	:autocmd * *.c

Użycie "*" dla wydarzenia wylistuje wszystkie wydarzenia. Listę wszystkich
autokomend dla grupy cprograms: >

	:autocmd cprograms


GRUPY

Opcja {grupa} użyta w czasie definiowania autokomendy grupuje powiązane ze
sobą autokomendy. Można tego użyć, na przykład, do usunięcia wszystkich
autokomend z jednej grupy.
   Definiując kilka autokomend dla pewnej grupy użyj polecenia ":augroup". Na
przykład zdefiniuj autokomendy dla programów C: >

	:augroup cprograms
	:  autocmd BufReadPost *.c,*.h :set sw=4 sts=4
	:  autocmd BufReadPost *.cpp   :set sw=3 sts=3
	:augroup END

Robi to samo co: >

	:autocmd cprograms BufReadPost *.c,*.h :set sw=4 sts=4
	:autocmd cprograms BufReadPost *.cpp   :set sw=3 sts=3

Do usunięcia wszystkich autokomend z grupy "cprograms" służy: >

	:autocmd! cprograms


ZAGNIEŻDŻANIE

Generalnie komendy wykonane jako rezultat autokomendy nie spowodują powstania
nowych wydarzeń. Jeśli czytasz plik w odpowiedzi na wydarzenie
FileChangedShell nie uruchomi to autokomendy, która włączyłaby na przykład
składnię. Żeby uruchomić takie wydarzenia musisz dodać argument "nested": >

	:autocmd FileChangedShell * nested  edit


AUTOKOMENDY

Jest możliwe uruchomienie autokomendy przez udawanie, że wystąpiło pewne
wydarzenie. Wygodne jeśli jedna autokomenda uruchamia inną. Przykład: >

	:autocmd BufReadPost *.new  execute "doautocmd BufReadPost " . expand("<afile>:r")

Definiuje autokomendę, która jest uruchamiana przy otwieraniu nowego pliku.
Nazwa pliku musi kończyć się na ".new". Polecenie ":execute" rozwija wyrażenie
dla uformowania nowego polecenia i jego wykonania. Otwierając plik
"tryout.c.new" wykonywane polecenie będzie wyglądać tak: >

	:doautocmd BufReadPost tryout.c

Funkcja expand() pobiera argument "<afile>", który oznacza nazwę pliku,
dla którym autokomenda była wykonywana i pobiera nazwę pliku bez ostatniego
członu przez ":r".

":doautocmd" wykonywana jest na bierzącym buforze. Polecenie ":doautoall"
działa tak samo jak ":doautocmd" z wyjątkiem tego, że jest wykonywana na
wszystkich buforach.


POLECENIA TRYBU NORMAL

Polecenia wykonywane przez autokomendy są poleceniami linii poleceń. Jeśli
chcesz użyć komend trybu Normal musisz użyć polecenia ":normal". Przykład: >

	:autocmd BufReadPost *.log normal G

Dzięki tej komendzie kursor skoczy do ostatniej linii plików *.log kiedy je
otworzysz.
   Użycie polecenia ":normal" może stworzyć kilka problemów. Przede wszystkim
upewnij się, że argument jest kompletnym poleceniem, włączając wszystkie
argumenty.  Kiedy używasz "i" do przejścia w tryb Normal musisz dołączyć też
<Esc> do opuszczenia tego trybu. Jeśli używasz "/" musi być <CR> do wykonania
poszukiwania.
   Polecenie ":normal" używa całego tekstu jaki po nim nastąpi jako komendy.
Dlatego nie może być | i kolejnego polecenia. Żeby to obejść, umieść polecenie
":normal" wewnątrz ":execute". Dzięki temu możliwe jest także wygodne
umieszczenie niedrukowalnych znaków. Przykład: >

	:autocmd BufReadPost *.chg execute "normal ONew entry:\<Esc>" |
		\ 1read !date

Widać tu też użycie backslasha do złamania długich poleceń w więcej linii.
Można tego używać w skryptach Vima (ale nie w linii poleceń).

Czasami chcesz by autokomenda robiła coś skomplikowanego, skakanie po pliku
i powrót do oryginalnej pozycji możesz chcieć przywrócić widok pliku. Zobacz
przykład: |restore-position|.


IGNOROWANIE ZDARZEŃ

Czasami nie chcesz uruchamiać autokomendy. Opcja 'eventignore' zawiera listę
wydarzeń, które będą całkowicie ignorowane. W przykładzie poniżej będą
ignorowane wydarzenia wejścia i wyjścia z okna: >

	:set eventignore=WinEnter,WinLeave

Żeby zignorować wszystkie wydarzenia użyj polecenia: >

	:set eventignore=all

Powrót do normalnego zachowania: >

	:set eventignore=

==============================================================================

Następny rozdział: |usr_41.txt|  Pisanie skryptów Vima

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
