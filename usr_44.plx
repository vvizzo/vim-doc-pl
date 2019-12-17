*usr_44.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

		  Tworzenie własnego schematu podświetlania


Vim jest rozprowadzany z podświetlaniem dla kilkuset typów plików. Jeśli nie
ma odpowiedniego pliku dla typu, którego używasz przeczytaj ten rozdział by
się dowiedzieć jak umożliwić podświetlanie składni dla tego typu. Zobacz też
|:syn-define| w Podręczniku Encyklopedycznym.

|44.1|	Podstawowe polecenia składni
|44.2|	Słowa kluczowe
|44.3|	Wzorce
|44.4|	Rejony
|44.5|	Zagnieżdżenia
|44.6|	Grupy następujące po sobie
|44.7|	Inne argumenty
|44.8|	Klastry
|44.9|	Włączanie innego pliku składni
|44.10|	Synchronizacja
|44.11|	Instalacja pliku składni
|44.12|	Tworzenie przenośnych plików składni

 Następny rozdział: |usr_45.txt|  Wybór języka
Poprzedni rozdział: |usr_43.txt|  Typy plików
       Spis treści: |usr_toc.txt|

==============================================================================
*44.1*	Podstawowe polecenia składni

Użycie istniejącego pliku składni jako podstawy oszczędzi ci sporo czasu.
Znajdź plik w $VIMRUNTIME/syntax dla języka przypominającego ten do jakiego
chcesz zrobić podświetlanie. Pliki stamtąd pokażą jak wygląda plik składni.
Żeby je zrozumieć musisz przeczytać przynajmniej ten rozdział.

Zacznijmy od podstawowych argumentów. Zanim zaczniemy definiować nową składnię
musimy wyczyścić wszystkie stare definicje: >

	:syntax clear

Nie jest to wymagane w ostatecznej wersji, ale bardzo pomocne w czasie
eksperymentów.

W tym rozdziale jest więcej takich uproszczeń. Jeśli masz zamiar napisać plik
składni, który ma być używany przez innych przeczytaj całą tę część do końca.


LISTOWANIE ZDEFINIOWANYCH ATOMÓW

Sprawdź jakie są zdefiniowane atomy składni poleceniem: >

	:syntax

W ten sposób zobaczysz jakie atomy już zdefiniowano. Bardzo przydatne
w czasie eksperymentów z nowym plikiem składni. Pokazuje również kolory użyte
do podświetlania każdego atomu dzięki czemu łatwiej się zorientować co jest
co.
   Do wylistowania atomów z określonej grupy składniowej użyj: >

	:syntax list {nazwa-grupy}

Można to polecenie wykorzystać do uzyskania listy klastrów (wyjaśnionych
w |44.8|). Wystarczy dodać do nazwy @.


WIELKOŚĆ ZNAKÓW

Niektóre języki są niewrażliwe na wielkość znaków (np. Pascal). Inne (C)
rozróżniają wielkość znaków. Musisz określić jakiego typu używasz:
>
	:syntax case match
	:syntax case ignore

Argument "match" oznacza, że Vim będzie rozróżniał wielkość znaków
w elementach składniowych. Dlatego będzie różnica między "int", a "Int"
i "INT". Jeśli użyjesz argumentu "ignore" te słowa będą równoważne:
"Procedure", "PROCEDURE" i "procedure".
   Polecenia ":syntax case" mogą być umieszczone w dowolnym miejscu i dotyczą
definicji, które po nich wystąpią. W większości wypadków wystarczy jedno
polecenie ":syntax case", ale czasami występują języki, które zawierają
zarówno elementy, które mogą występować w różnych wielkościach znaków jak i te
które mogą występować tylko w jednej formie. Możesz uzyskać odpowiedni efekt
umieszczając ":syntax case" w kilku różnych miejscach w pliku.

==============================================================================
*44.2*	Słowa kluczowe

Najprostszym elementem składni są słowa kluczowe. Aby zdefiniować słowo
kluczowe użyj formy: >

	:syntax keyword {grupa} {kluczowe} ...

{grupa} jest nazwą grupy składniowej. Poleceniem ":highlight" możesz przypisać
kolory do {grupa}. Argument {kluczowe} jest właściwym słowem kluczowym. Kilka
przykładów: >

	:syntax keyword xType int long char
	:syntax keyword xStatement if then else endif

Ten przykład używa nazw grup "xType" i "xStatement". Zwyczajowo każda nazwa
grupy jest poprzedzona typem pliku dla definiowanego języka. Tutaj definiujemy
składnię dla języka x (eXemplaryczny język bez interesującej nazwy). W pliku
składni dla skryptów "csh" możnaby użyć nazwy "cshType". Prefiks powinien być
taki sam jak wartość 'filetype'.
   Polecenia te spowodują, że słowa "int", "long" i "char" zostaną
podświetlone na jeden sposób, a "if", "then", "else" i "endif" w inny. Teraz
musisz tylko połączyć grupy x ze standardowymi nazwami grup w Vimie: >

	:highlight link xType Type
	:highlight link xStatement Statement

W ten sposób mówisz Vimowi, żeby podświetlił "xType" tak jak "Type",
a "xStatement" jak "Statement". Zobacz standardowe nazwy grup w |group-name|.


NIEZWYKŁE SŁOWA KLUCZOWE

Znaki użyte w słowie kluczowym muszą być uwzględnione w opcji 'iskeyword'.
Jeśli użyjesz innego znaku wyraz nigdy nie będzie dopasowany. Vim nie
poinformuje cię o tym.
   Język x używa znaku '-' w słowach kluczowych. Możesz to zrobić tak: >

	:setlocal iskeyword+=-
	:syntax keyword xStatement when-not

Polecenie ":setlocal" jest tu użyte do zmiany 'iskeyword' tylko dla bieżącego
bufora. Niestety zmienia to zachowanie takich komend jak "w" i "*". Jeśli jest
to zachowanie niepożądane nie definiuj słowa kluczowego, ale użyj "match"
(wyjaśnione w następnej sekcji).

Język x pozwala na użycie skrótów. Na przykład "next" może być skrócone do
"n", "ne" lub "nex". Możesz je zdefiniować poleceniem: >

	:syntax keyword xStatement n[ext]

"nextone" nie będzie dopasowane, {kluczowe} zawsze dopasowują całe wyrazy.

==============================================================================
*44.3*	Wzorce

Zdefiniujmy coś bardziej skomplikowanego. Chcesz dopasować zwykłe
identyfikatory. Żeby to zrobić zdefiniuj atom składni przez dopasowanie. Tutaj
zdefiniuj każde słowo zawierające wyłącznie małe litery: >

	:syntax match xIdentifier /\<\l\+\>/
<
	Note:
	Słowa kluczowe są nadrzędne wobec każdego innego atomu składni.
	Dlatego "if", "then", itd., pozostaną słowami kluczowymi określonymi
	przez polecenia ":syntax keyword" nawet jeśli pasuje do nich wzorzec
	xIdentifier.

Część na końcu jest wzorcem, takim samym jaki jest użyty do poszukiwań.
// używane jest do ograniczenia wzorca (tak jak w poleceniu
":substitute"). Możesz użyć innych znaków, takich jak "+" lub "'".

Zdefiniuj teraz dopasowanie dla komentarza. W języku x jest to cokolwiek od
# do końca linii: >

	:syntax match xComment /#.*/

Ponieważ możesz użyć dowolnego wyrażenia regularnego możesz podświetlać bardzo
skomplikowane atomy. Więcej o wyrażeniach regularnych w |pattern|.

==============================================================================
*44.4*	Regiony

W przykładowym języku x, łańcuchy (stringi) są zamknięte w podwójnych
cudzysłowach (").  Do podświetlania łańcuchów musisz zdefiniować region.
Potrzebujesz określić początek regionu (podwójny cudzysłów) i jego koniec
(także podwójny cudzysłów). Definicja: >

	:syntax region xString start=/"/ end=/"/

Dyrektywy "start" i "end" określają wzorce użyte do znalezienia początku
i końca regionu. Ale co z łańcuchem, który wygląda tak?

	"A string with a double quote (\") in it" ~

Powstaje problem: Podwójny cudzysłów w środku łańcucha zakończy region. Musisz
powiedzieć Vimowi, żeby ominął każdy zakomentowany podwójny cudzysłów
w łańcuchu. Zrób to dyrektywą "skip": >

	:syntax region xString start=/"/ skip=/\\"/ end=/"/

Podwójny backslash dopasowuje pojedynczy backslash ponieważ jest to znak
specjalny w wyrażeniach regularnych.

Kiedy użyć "region" zamiast "match"? Główna różnica polega na tym, że "match"
jest pojedynczym wzorcem, który w całości musi być dopasowany. Rejon zaczyna
się tam gdzie zostanie dopasowany "start". Czy wzorzec do "end" zostanie
znaleziony nie ma znaczenia. Dlatego jeśli atom polega na wzorcu "end" nie
możesz użyć "region". W innych wypadkach rejony są prostsze do zdefiniowania.
W dodatku prostsze jest wtedy użycie atomów zagnieżdżonych wyjaśnionych
w następnej sekcji.

==============================================================================
*44.5*	Zagnieżdżenia

Spójrzmy na ten komentarz:

	%Get input  TODO: Skip white space ~

Chcesz podświetlić TODO jako wielkie żółte litery nawet jeśli komentarz ma być
niebieski. Konfigurujesz następujące grupy składniowe: >

	:syntax keyword xTodo TODO contained
	:syntax match xComment /%.*/ contains=xTodo

W pierwszej linii, argument "contained" mówi Vimowi, że to słowo kluczowe może
istnieć tylko wewnątrz innego atomu składni. Następna linia zawiera
"contains=xTodo". Oznacza, że wewnątrz elementu xComment znajduje się element
xTodo. Rezultatem jest podświetlenie całej linii na niebiesko zgdonie
z "xComment". Wyraz TODO wewnątrz niej jest dopasowany przez xTodo
i podświetlony na żółto (podświetlanie xTodo zostało zrobione gdzie indziej).


ZAGNIEŻDŻANIE REKURSYWNE

W języku x bloki kodu określa się nawiasami klamrowymi. Blok kodu może
zawierać inne bloki kodu. Definiujesz to tak: >

	:syntax region xBlock start=/{/ end=/}/ contains=xBlock

Przypuśćmy, że masz tekst:

	while i < b { ~
		if a { ~
			b = c; ~
		} ~
	} ~

Najpierw xBlock zaczyna się na { w pierwszej linii. W drugiej linii został
znaleziony inny {. Ponieważ jesteśmy wewnątrz atomu xBlock i zawiera on samego
siebie, zaczyna się tu zagnieżdżony xBlock. W ten sposób linia "b = c"
znajduje się we wnętrzu drugiego poziomu regionu xBlock. W następnej linii
zostaje znaleziony } co dopasowuje się do wzorca "end" regionu. Tak kończy się
zagnieżdżony xBlock. Ponieważ } jest włączany do zagnieżdżonego regionu jest
ukryty przed pierwszym regionem xBlock. W końcu ostatnie } kończy pierwszy
region xBlock.


ZACHOWYWANIE KOŃCA

Rozważmy następujące atomy składni: >

	:syntax region xComment start=/%/ end=/$/ contained
	:syntax region xPreProc start=/#/ end=/$/ contains=xComment

Definiujesz komentarz jako cokolwiek od % do końca linii. Dyrektywa
preprocesora to cokolwiek od # do końca linii. Ponieważ możesz mieć komentarz
w linii preprocesora, definicja preprocesora zawiera "contains=xComment".
Zobacz teraz co stanie się z takim tekstem:

	#define X = Y  % Comment text ~
	int foo = 1; ~

Druga linia jest również podświetlona jako xPreProc. Dyrektywa preprocesora
powinna kończyć się wraz z końcem linii. Dlatego użyłeś "end=/$/". Co poszło
źle?
   Problemem jest zagnieżdżony komentarz. Zaczyna się on % i kończy na końcu
linii. Po końcu komentarza składnia preprocesora kontynuuje. Dzieje się to już
po tym jak stwierdzono koniec linii, tak więc następna linia zostaje włączona.
   Można tego uniknąć używając argumentu "keepend". Dba on o to by koniec
linii został dopasowany dwa razy: >

	:syntax region xComment start=/%/ end=/$/ contained
	:syntax region xPreProc start=/#/ end=/$/ contains=xComment keepend


ZAWIERANIE WIELU ATOMÓW

Możesz użyć specjalnego argumentu zawierania do określenia, że wszystkie atomy
mogą być zawarte: >

	:syntax region xList start=/\[/ end=/\]/ contains=ALL

Wszystkie atomy składni będą mogły się znaleźć w xList. Będzie on również
zawierać sam siebie, ale nie na tej samej pozycji (mogłoby to spowodować
niekończącą się pętlę).
   Możesz określić, które grupy nie będą mogły się znaleźć wewnątrz danego
atomu. W ten sposób xList będzie zawierać wszystkie grupy z wyjątkiem
określonych przez ciebie: >

	:syntax region xList start=/\[/ end=/\]/ contains=ALLBUT,xString

"TOP" włączy wszystkie atomy, które nie mają argumentu "contained".
"CONTAINED" służy do włączania atomów zawierających ten argument. Zobacz
więcej w |:syn-contains|.

==============================================================================
*44.6*	Grupy następujące po sobie

Język x ma instrukcje w postaci:

	if (warunek) then ~

Chcesz podświetlić trzy części różnie, ale "(warunek)" i "then" mogą pojawić
się również w innych miejscach gdzie będą inaczej podświetlane. Możesz zrobić
to tak: >

	:syntax match xIf /if/ nextgroup=xIfCondition skipwhite
	:syntax match xIfCondition /([^)]*)/ contained nextgroup=xThen skipwhite
	:syntax match xThen /then/ contained

Argument "nextgroup" określa, który atom będzie następny. Nie jest wymagany.
Jeśli żaden z określonych atomów nie zostanie znaleziony nic się nie zdarzy.
Na przykład w tekście:

	if not (warunek) then ~

"if" jest dopasowane przez xIf. "not" nie pasuje do następnej grupy
xIfCondition, dlatego zostanie podświetlone tylko "if".

Argument "skipwhite" mówi Vimowi, że pomiędzy atomami mogą pojawić się białe
znaki (spacje i znaki tabulacji). Podobnym argumentem jest "skipnl", który
pozwala na pojawienie się znaku nowej linii pomiędzy atomami i "skipempty",
który zezwala na puste linie. Zauważ, że "skipnl" nie pozwala na puste linie,
coś musi być dopasowanego po znaku nowej linii.

==============================================================================
*44.7*	Inne argumenty

MATCHGROUP

Kiedy zdefiniujesz region zostanie on cały podświetlony zdodnie z nazwą grupy.
Do podświetlenia tekstu zamkniętego w nawiasach () za pomocą grupy xInside
użyj następującego polecenia: >

	:syntax region xInside start=/(/ end=/)/

Przypuśćmy, że chcesz podświetlić nawiasy inaczej. Możesz to zrobić za pomocą
wielu skomplikowanych definicji rejonów, albo użyć argumentu "matchgroup".
W ten sposób Vim wie, że ma podświetlić początek i koniec regionu zgodnie
z inną grupą (tutaj xParen): >

	:syntax region xInside matchgroup=xParen start=/(/ end=/)/

Argument "matchgroup" odnosi się do początkowego i końcowego dopasowania.
Jeśli chcesz końcową grupę podświetlić inaczej: >

	:syntax region xInside matchgroup=xParen start=/(/
		\ matchgroup=xParenEnd end=/)/

Ubocznym efektem użycia "matchgroup" jest to, że zawierane atomy nie będą
dopasowywane do początku i końca rejonu. Wykorzystuje to przykład do
"transparent".


TRANSPARENT

W języku C chciałbyś inaczej podświetlić tekst w () po "while", a inaczej po
"for". W obu przypadkach będą zagnieżdżone atomy (), które powinny być
podświetlone w ten sam sposób. Musisz mieć pewność, że podświetlanie
() zakończy się na parującym ). To jeden ze sposobów: >

	:syntax region cWhile matchgroup=cWhile start=/while\s*(/ end=/)/
		\ contains=cCondNest
	:syntax region cFor matchgroup=cFor start=/for\s*(/ end=/)/
		\ contains=cCondNest
	:syntax region cCondNest start=/(/ end=/)/ contained transparent

Teraz możesz dać cWhile i cFor różne podświetlanie. Atom cCondNest pojawia się
w obu z nich, ale przejmuje podświetlanie atomu, w którym się zawiera.
Powoduje to argument "transparent".
   Zauważ, że argument "matchgroup" ma taką samą wartość jak sam atom. Po co
więc go definiować? Ubocznym efektem używania "matchgroup" jest fakt, że
zawierane atomy nie są znajdywane przez ich początek. W ten sposób unika się,
że cCondNest dopasuje ( tuż po "while" lub "for". Gdyby tak się stało,
cCondNest mógłby objąć cały tekst aż do parującego ) i region byłby
kontynuowany dalej. Teraz cCondNest jest dopasowywany tylko po wzorcu
początkowym, czyli po pierwszym (.


OFFSETY

Załóżmy, że chcesz zdefiniować rejon dla tekstu pomiędzy ( i ) po "if". Nie
chcesz jednak włączać "if" lub ( i ). Możesz to zrobić określając offsety dla
wzorców. Przykład: >

	:syntax region xCond start=/if\s*(/ms=e+1 end=/)/me=s-1

Offset dla wzorca startowego to "ms=e+1". "ms" oznacza "match start" (dopasuj
początek). Określa offset dla początku dopasowania. Normalnie dopasowanie
zaczyna się tam gdzie jest dopasowany wzorzec. "e+1" oznacza, że dopasowanie
zaczyna się teraz na końcu dopasowanego wzorca i jeden znak dalej.
   Offset dla końcowego wzorca to "me=s-1". "me" oznacza "match end" (dopasuj
koniec). "s-1" oznacza początek wzorca i jeden znak do tyłu. Wynik jest taki,
że w tekście:

	if (foo == bar) ~

Tylko "foo == bar" zostanie podświetlone jako xCond.

Więcej o offsetach: |:syn-pattern-offset|.


ONELINE

Argument "oneline" wskazuje, że rejon nie może przekroczyć granic linii.
Przykład: >

	:syntax region xIfThen start=/if/ end=/then/ oneline

Definiuje rejon, który zaczyna się "if" i kończy "then". Jeśli nie ma "then"
po "if" w jednej linii, rejon nie zostaje dopasowany.

	Note:
	Używając "oneline" rejon nie zaczyna się jeśli końcowy wzorzec nie
	znajduje się w tej samej linii. Bez "oneline" Vim nie sprawdzi czy
	jest wzorzec dla końca rejonu. Rejon zaczyna się nawet jeśli końcowy
	wzorzec nie może być dopasowany aż do końca pliku.


KONTYNUACJA LINII

Rzeczy stają się teraz odrobinę bardziej skomplikowane. Zdefiniujmy linię
preprocesora. Zaczyna się # w pierwszej kolumnie i kontynuuje aż do końca
wiersza. Wiersz kończący się \ powoduje, że następny jest jego kontynuacją.
Rozwiązaniem tego problemu jest zawarcie w atomie wzorca kontynuacji: >

	:syntax region xPreProc start=/^#/ end=/$/ contains=xLineContinue
	:syntax match xLineContinue "\\$" contained

W tym wypadku, chociaż xPreProc normalnie dopasowuje pojedynczą linię grupa
w niej zawarta (nazwana xLineContinue) pozwala iść dalej niż do końca jednej
linii. Na przykład pasowałyby obie z tych linii:

	#define SPAM  spam spam spam \ ~
			bacon and spam ~

W tym wypadku to jest to czego chcesz. Jeśli nie, możesz wymóc na regionie by
był pojedynczą linią przez dodanie "excludenl" do zawieranego wzorca. Chcesz
na przykład podświetlić "end" w xPreProc, ale tylko na końcu wiersza. Żeby
uniknąć kontynuacji xPreProc do następnej linii, jak robi to xLineContinue
użyj "excludenl": >

	:syntax region xPreProc start=/^#/ end=/$/
		\ contains=xLineContinue,xPreProcEnd
	:syntax match xPreProcEnd excludenl /end$/ contained
	:syntax match xLineContinue "\\$" contained

"excludenl" musi być umieszczone przed wzorcem. Ponieważ "xLineContinue" nie
ma "excludenl" dopasowanie rozwinie xPreProc do następnej linii tak jak
przedtem.

==============================================================================
*44.8*	Klastry

Jedną z rzeczy, które rzucą ci się w oczy podczas pisania pliku składni jest
to, że tworzysz bardzo dużo grup składniowych. Vim pozwala na zdefiniowanie
kolekcji grup składniowych nazywanej klastrem.
   Przypuśćmy, że masz język, który zawiera pętle, warunki if, pętle while
i funkcje. Każdy z nich ma te same elementy składni: liczby i identyfikatory.
Definiujesz je tak: >

	:syntax match xFor /^for.*/ contains=xNumber,xIdent
	:syntax match xIf /^if.*/ contains=xNumber,xIdent
	:syntax match xWhile /^while.*/ contains=xNumber,xIdent

Musisz powtarzać te same "contains=" za każdym razem. Jeśli chcesz dodać
kolejny atom musisz dodać go trzy razy. Klastry składni upraszczają te
definicje przez udostępnienie jednego klastra, który może oznaczać kilka grup
składni.
   Do zdefiniowania klastra dla dwóch atomów, które istnieją w trzech grupach,
użyj polecenia: >

	:syntax cluster xState contains=xNumber,xIdent

Klastry użyte są wewnątrz innych elementów ":syntax" tak jak każda grupa
składniowa. Ich nazwy zaczynają się od @. W ten sposób definiujesz teraz te
trzy grupy: >

	:syntax match xFor /^for.*/ contains=@xState
	:syntax match xIf /^if.*/ contains=@xState
	:syntax match xWhile /^while.*/ contains=@xState

Możesz dodać nową grupę do klastra argumentem "add": >

	:syntax cluster xState add=xString

Oraz równie łatwo usunąć grupę argumentem "remove": >

	:syntax cluster xState remove=xNumber

==============================================================================
*44.9*	Włączanie innego pliku składni

Składnia języka C++ to nadzbiór języka C. Ponieważ nie chcesz pisać dwóch
plików składni, możesz wczytać plik składni dla C do pliku C++ używając
polecenia: >

	:runtime! syntax/c.vim

Polecenie ":runtime!" przeszukuje 'runtimepath' pod kątem wszystkich plików
"syntax/c.vim". W ten sposób podświetlanie składni jest zdefiniowana jak dla
plików C. Jeśli podmieniłeś plik c.vim, dodałeś coś lub dodałeś w innych
plikach to one też zostaną załadowane.
   Po załadowaniu składni C można zdefiniować atomy specyficzne dla C++. Na
przykład dodać słowa kluczowe nieużywane w C: >

	:syntax keyword cppStatement	new delete this friend using

Działa tak jak w każdym innym pliku składni.

Przyjrzyjmy się teraz Perlowi. Składa się on teraz z dwóch różnych części:
dokumentacji w formacie POD i programów napisanych w samym Perlu. Sekcje POD
zaczynają się od "=head" i kończą na "=cut".
   Chcesz zdefiniować składnię POD w jednym pliku i użyć jej w pliku dla
Perla. Polecenie ":syntax include" wczytuje plik składni i przechowuje
elementy zdefiniowane w klastrach. Dla Perla polecenia to: >

	:syntax include @Pod <sfile>:p:h/pod.vim
	:syntax region perlPOD start=/^=head/ end=/^=cut/ contains=@Pod

Kiedy "=head" zostaje znalezione w pliku Perla zaczyna się rejon perlPOD.
W tym rejonie zawarty jest klaster @Pod. Wszystkie atomy najwyższego poziomu
zdefiniowane w pliku składni pod.vim będą tu pasować. Region kończy się na
"=cut" i wracamy do atomów zdefiniowanych w pliku dla Perla.
   Polecenie ":syntax include" jest na tyle sprytne, że ignoruje ":syntax
clear" we włączanym pliku, a argumenty takie jak "contains=ALL" będą zawierać
atomy zdefiniowane we włączanym pliku, a nie w pliku do którego są włączane.
   "<sfile>:p:h/" używa nazwy obecnego pliku (<sfile>), rozwija ją do pełnej
ścieżki (:p) i pobiera główną część (:h). Wynikiem jest nazwa katalogu
w którym znajduje się plik. W ten sposób włączany jest pod.vim znajdujący się
w tym samym katalogu co plik włączający.

==============================================================================
*44.10*	Synchronizacja

Kompilatory mają łatwe zadanie. Zaczynają od początku pliku i parsują go po
kolei. Vim nie ma tak łatwo. Musi zaczynać od środka gdzie jest robiona
edycja. Skąd ma wiedzieć gdzie jest?
   Sekret leży w poleceniu ":syntax sync". Mówi ono Vimowi jak ma się
dowiedzieć gdzie jest. To polecenie mówi Vimowi by skanował plik do tyłu
w poszukiwaniu początku lub końca komentarza w stylu C i zaczął kolorowanie
składni od tego miejsca: >

	:syntax sync ccomment

Możesz usprawnić ten proces kilkoma argumentami. Argument "minlines" mówi
Vimowi o jaką minimalną liczbę linii ma szukać wstecz, a "maxlines" mówi jak
dużą liczbę linii ma przeskanować.
   Na przykład kolejne polecenie każe Vimowi szukać co najmniej 10 linii przed
górną krawędzią ekranu: >

	:syntax sync ccomment minlines=10 maxlines=500

Jeśli Vim nie jest w stanie powiedzieć gdzie jest na podstawie 10 linii
zaczyna szukać dalej dopóki nie jest pewien, ale nie szuka dalej w tył niż 500
linii. (Duża wartość "maxlines" spowalnia działanie Vima. Mała może spowodować
nieprawidłowe działanie synchronizacji.)
   Żeby przyśpieszyć konfigurację przekaż Vimowi, które atomy składni mogą
zostać pominięte. Każde dopasowanie i region, które muszą być użyte tylko
podczas pokazywania tekstu mogą mieć dodany argument "display".
   Domyślnie komentarz będzie kolorowany jako część grupy Comment. Jeśli
chcesz kolorować atomy w inny sposób możesz określić inną grupę składniową: >

	:syntax sync ccomment xAltComment

Jeśli twój język programowania nie ma komentarzy w stylu C możesz spróbować
innej metody synchronizacji. Najprostszą jest kazanie Vimowi do cofnięcia się
o pewną ilość linii i próby parsowania stamtąd. To polecenie mówi Vimowi by
cofnął się o 150 linii i stamtąd parsował plik: >

	:syntax sync minlines=150

Duża wartość "minlines" spowalnia Vima szczególnie podczas przewijania do tyłu
pliku.
   W końcu możesz określić grupę składniową jakiej ma szukać poleceniem: >

	:syntax sync match {sync-nazwa-grupy}
		\ grouphere {nazwa-grupy} {wzorzec}

Oznacza to, że tuż po {wzorzec} zaczyna się grupa składniowa o nazwie
{nazwa-grupy}. {sync-nazwa-grupy} używa się do nazwania tego typu
synchronizacji. Na przykład w skryptach sh warunek if zaczyna się "if"
i kończy "fi":

	if [ --f file.txt ] ; then ~
		echo "File exists" ~
	fi ~

Do zdefiniowania dyrektywy "grouphere" dla tego typu składni użyj polecenia: >

	:syntax sync match shIfSync grouphere shIf "\<if\>"

Argument "groupthere" mówi Vimowi, że wzorzec kończy grupę. Na przykład koniec
grupy if/fi jest taki: >

	:syntax sync match shIfSync groupthere NONE "\<fi\>"

W tym przykładzie NONE mówi Vimowi, że nie jesteś w żadnym specjalnym rejonie.
W szczególności nie jesteś wewnątrz bloku if.

Możesz również zdefiniować dopasowania i rejony bez argumentów "grouphere" lub
"groupthere". Będą one służyły do pomijania grup podczas synchronizacji. Na
przykład to polecenie służy do pomijania wszystkiego wewnątrz {} nawet jeśli
mogłoby pasować do innej metody synchronizacji: >

	:syntax sync match xSpecial /{.*}/

Więcej o synchronizacji w Przewodniku Encyklopedycznym: |:syn-sync|.

==============================================================================
*44.11*	Instalacja pliku składni

Kiedy nowy plik składni jest gotów do użycia, umieść go w katalogu "syntax"
w 'runtimepath'. Dla Uniksów będzie to "~/.vim/syntax".
   Nazwa pliku składni musi być taka sama jak typu pliku z dodanym ".vim".
Stąd dla języka x pełna ścieżka do pliku będzie taka:

	~/.vim/syntax/x.vim ~

Musisz również włączyć rozpoznawanie typu plików. Zobacz |43.2|.

Jeśli plik działa dobrze możesz chcieć udostępnić go innym użytkownikom Vima.
Najpierw przeczytaj następną sekcję by być pewnym, że twój plik będzie działał
dobrze u innych. Później prześlij go e-mailem do opiekuna Vima:
<maintainer@vim.org>. Wyjaśnij także jak można wykryć typ pliku. Z odrobiną
szczęścia twój plik zostanie dołączony do następnej wersji Vima!


ROZSZERZANIE ISTNIEJĄCEGO PLIKU SKŁADNI

Jak dotąd przyjmowaliśmy, że dodajesz kompletnie nowy plik składni. Jeśli
istniejący plik działa, ale czegoś mu jednak brakuje, możesz dodawać atomy
w osobnym pliku. W ten sposób unikasz zmian w dystrybucyjnym pliku składni,
które zostaną stracone podczas instalacji nowej wersji Vima.
   Napisz polecenia składni w pliku, jeśli to możliwe użyj nazw grup
z istniejącej składni. Na przykład dodaj nowe typy zmiennych do pliku składni
C: >

	:syntax keyword cType off_t uint

Zapisz plik z tą samą nazwą jak oryginalny plik. W tym wypadku "c.vim". Umieść
go w katalogu pod koniec 'runtimepath'. W ten sposób zostanie załadowany po
oryginalnym pliku składni. Dla Uniksów będzie to:

	~/.vim/after/syntax/c.vim ~

==============================================================================
*44.12*	Tworzenie przenośnych plików składni

Czy nie byłoby miłe gdyby wszyscy użytkownicy Vima wymieniali między sobą
pliki składni? Żeby było to możliwe plik składni musi spełniać kilka warunków.

Powinien zaczynać się nagłówkiem wyjaśniającym jaką składnię obsługuje, kto
rozwija plik i kiedy był ostatnio zmieniony. Nie wpisuj za dużo informacji
o zmianach, i tak niewiele osób to czyta. Przykład: >

	" Vim syntax file
	" Language:	C
	" Maintainer:	Bram Moolenaar <Bram@vim.org>
	" Last Change:	2001 Jun 18
	" Remark:	Included by the C++ syntax.

Użyj tego samego schematu co inne pliki składni. Użycie istniejącego pliku
składni jako przykładu, pozwoli na zachowanie dużej ilości czasu.

Wybierz dobrą, opisową nazwę dla pliku. Możesz użyć małych znaków i cyfr.
Niech nie będzie zbyt długa, będzie używana w wielu miejscach: nazwa pliku
"nazwa.vim", 'filetype', b:current_syntax, początek każdej grupy składniowej
(nazwaType, nazwaStatement, nazwaString, itd.).

Zacznij od sprawdzenia czy istnieje "b:current_syntax". Jeśli tak został już
załadowany wcześniej w 'runtimepath' jakiś plik składni. Dla kompatybilności
z Vim 5.8 dodaj: >

	if version < 600
	  syntax clear
	elseif exists("b:current_syntax")
	  finish
	endif

Na koniec ustaw "b:current_syntax" na nazwę składni. Nie zapomnij, że włączane
pliki też to robią, będziesz musiał resetować "b:current_syntax" jeśli
włączasz dwa pliki.

Jeśli chcesz by twój plik składni działał w Vimie 5.x, dodatkowo sprawdź
wersję (v:version). Zajrzyj do yacc.vim jak to wygląda.

Nie włączaj niczego co jest preferencją użytkownika. Nie ustawiaj 'tabstop',
'expandtab', itd. To należy do wtyczek typów plików.

Nie dołączaj mapowań i skrótów. Dodaj jedynie ustawianie 'iskeyword' jeśli jest
to naprawdę konieczne dla rozpoznawania słów kluczowych.

Unikaj używania określonych kolorów. Linkuj do standardowych grup
podświetlania gdziekolwiek jest to możliwe. Nie zapomnij, że niektórzy ludzie
używają innego koloru tła, lub mają tylko osiem kolorów.
Dla kompatybilności wstecznej z Vimem 5.8 użyj tej konstrukcji: >

	if version >= 508 || !exists("did_c_syn_inits")
	  if version < 508
	    let did_c_syn_inits = 1
	    command -nargs=+ HiLink hi link <args>
	  else
	    command -nargs=+ HiLink hi def link <args>
	  endif

	  HiLink nameString	String
	  HiLink nameNumber	Number
	  ... etc ...

	  delcommand HiLink
	endif

Dodaj argument "display" do atomów, które nie są używane podczas
synchronizacji do przyśpieszenie przewijania i CTRL-L.

==============================================================================

Następny rozdział: |usr_45.txt|  Wybór języka

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
