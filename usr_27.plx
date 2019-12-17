*usr_27.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

		       Polecenia wyszukiwania i wzorce


W rozdziale 3. wspomniano kilka przykładów wzorców wyszukiwania |03.9|. Vim
może przeprowadzać wyszukiwania o wiele bardziej skomplikowane. Ten rozdział
wyjaśnia najczęściej używane sposoby. Dokładną specyfikację można znaleźć:
|pattern|

|27.1|	Ignorowanie wielkości znaków
|27.2|	Zawijanie wokół końca pliku
|27.3|	Offset
|27.4|	Wielokrotne dopasowanie
|27.5|	Operator OR
|27.6|	Zasięg znaków
|27.7|	Klasy znaków
|27.8|	Dopasowanie końca linii
|27.9|	Przykłady

 Następny rozdział: |usr_28.txt|  Powtarzanie
Poprzedni rozdział: |usr_26.txt|  Zwijanie
       Spis treści: |usr_toc.txt|

==============================================================================
*27.1*	Ignorowanie wielkości znaków

Domyślnie Vim wyszukuje biorąc pod uwagę na wielkość liter. Dlatego,
"include", "INCLUDE" oraz "Include" są trzema różnymi wyrazami, i wyszukiwanie
dopasuje tylko jeden z nich.
   Włącz teraz opcję 'ignorecase': >

	:set ignorecase

Szukając teraz "include" Vim dopasuje także "Include", "INCLUDE" i "InClUdE".
(Włącz opcję 'hlsearch', żeby zobaczyć gdzie wzorzec jest dopasowany.)
   Wyłącz 'ignorecase': >

	:set noignorecase

Ale na razie utrzymaj ją i szukaj "INCLUDE". Dopasuje dokładnie ten sam tekst
co "include". Ustaw opcję 'smartcase': >

	:set ignorecase smartcase

Jeśli masz wzorzec z przynajmniej jedną wielką literą, poszukiwania będą czułe
na wielkość liter. Idea jest taka, że nie musisz wpisywać wielkiej litery,
więc jeśli to zrobiłeś to znaczy, że jej szukasz. Sprytne!
    Z tymi dwoma opcjami szukasz takich dopasowań:

	wzorzec 		dopasowanie~
	wyraz 			wyraz, Wyraz, WYRAZ, WyRaZ, itd.
	Wyraz 			Wyraz
	WYRAZ 			WYRAZ
	WyRaZ 			WyRaZ


WIELKOŚĆ W JEDNYM WZORCU

Jeśli chcesz zignorować wielkość znaku w jednym szczególnym wzorcu, możez to
zrobić poprzedzając go atomem "\c". "\C" spowoduje dopasowanie wielkości
znaku. Opcje 'ignorecase' i 'smartcase' są ignorowane kiedy "\c" lub "\C" są
użyte.

	wzorzec 		dopasowanie~
	\Cwyraz			wyraz
	\CWyraz			Wyraz
	\cWYRAZ			wyraz, Wyraz, WYRAZ, WyRaZ, itd.
	\cWyRaZ			wyraz, Wyraz, WYRAZ, WyRaZ, itd.

Dużą zaletą "\c" i "\C" jest to, że są one częścią wzorca. Stąd jeśli
powtarzasz wzorzec korzystając z historii wyszukiwania, zdarzy się to samo
niezależnie od ustawień 'ignorecase' lub 'smartcase'.

	Note:
	Użycie "\" we wzorcach wyszukiwania załeży od opcji 'magic'. W tym
	rozdziale przyjmujemy, że 'magic' jest włączone gdyż jest to
	ustawienie domyślne i rekomendowane. Gdybyś chciał zmienić
	'magic' wiele wzorców wyszukiwania może nagle przestać działać.

	Note:
	Jeśli wyszukiwanie zajmuje więcej czasu niż się spodziewałeś, możesz
	je przerwać CTRL-C na Uniksie lub CTRL-Break w MS-DOS i MS-Windows.

==============================================================================
*27.2*	Zawijanie wokół końca pliku

Domyślnie, wyszukiwanie w przód zaczyna szukać żądanego łańcucha od aktualnej
pozycji kursora w kierunku końca pliku. Jeśli nie znalazł łańcucha do końca
pliku zaczyna go szukać od początku pliku do pozycji kursora.
   Pamiętaj, że powtarzając komendę "n" do znalezienia następnego dopasowania
ostatecznie wrócisz do pierwszego dopasowania. Jeśli tego nie zauważysz,
będziesz szukał bez końca! Vim daje ci wskazówkę:

	search hit BOTTOM, continuing at TOP ~

Jeśli używasz komendy "?" do szukania w odwrotnym kierunku dostaniesz taki
komunikat:

	search hit TOP, continuing at BOTTOM ~

Jednak cały czas nie wiesz kiedy wrócisz do pierwszego dopasowania. Jedynym
sposobem do zorientowania się gdzie jesteś jest włączenie opcji 'ruler': >

	:set ruler

Vim pokaże pozycję kursora w prawym dolnym rogu okna (w linii statusu jeśli
jest). Wygląda to tak:

	101,29       84% ~

Piersza liczba to numer linii w której znajduje się kursor. Zapamiętaj numer
linii gdzie zaczynałeś, w ten sposób będziesz mógł sprawdzić czy nie minąłeś
tej pozycji.


BEZ ZAWIJANIA

Żeby wyłączyć zawijanie poszukiwania użyj polecenia: >

	:set nowrapscan

Teraz kiedy wyszukiwanie dobije do końca pliku dostaniesz komunikat błędu:

	E385: search hit BOTTOM without match for: forever ~

Możesz znaleźć wszystkie dopasowania przez przejście do początku pliku z "gg"
i szukanie dopóki nie zobaczysz tej wiadomości.
   Jeśli szukasz w innym kierunku z "?" zobaczysz:

	E384: search hit TOP without match for: forever ~

==============================================================================
*27.3*	Offset

Domyślnie, wzorzec wyszukiwanie umieszcza kursor na początku znalezionego
wzorca. Możesz powiedzieć Vimowi by umieścił go w innym miejscu określając
offset. Dla komendy wyszukującej w przód "/", offset jest określony przez
dodanie slasha (/) i offsetu: >

	/wzorzec/2

To polecenie wyszukuje wzorzec "wzorzec" i przenosi kursor do początku
drugiej linii po dopasowaniu. Używając tego polecenia na akapicie wyżej Vim
znajdzie wyraz "wzorzec" w pierwszej linii, później kursor jest przeniesiony
dwie linie w dół do "offset".

Jeśli offset jest zwykłym numerem kursor zostanie umieszczony na początku
wiersza o tyle linii poniżej ile wskazuje numer. Liczba offsetu może być
dodatnia lub ujemna. Jeśli jest dodatnia - kursor przemieszcza się w dół;
jeśli ujemna - w górę.


OFFSETY ZNAKOWE

Offset "e" wskazuje offset z końca dopasowania (ang. end - koniec). Przenosi
kursor na ostatni znak dopasowania. Polecenie: >

	/const/e

umieszcza kursor na "t" w "const".
   Od tego miejsca, dodanie liczby przenosi kursor do przodu o tyle znaków. To
polecenie przenosi na znak tuż po dopasowaniu: >

	/const/e+1

Liczba dodatnia przemieszcza kursor w prawo, a ujemna w lewo. Na przykład: >

	/const/e-1

Przenosi kursor na s w "const".

Jeśli offset zaczyna się "b", kursor umieszczany jest na początku dopasowania
(ang. begin - początek).  Nie jest to zbyt użyteczne ponieważ jeśli nie ma "b"
robione jest to samo.  Jednak przydaje się jeśli dodaje się liczbę lub ją
odejmuje. Kursor porusza się wtedy do przodu lub tyłu. Na przykład: >

	/const/b+2

Przenosi kursor do początku dopasowania i dwa znaki w prawo. W końcu ląduje na
n.


POWTARZANIE

Żeby powtórzyć wyszukiwanie poprzednio użytej ścieżki, ale z innym offsetem
odrzuć wzorzec: >

	/that
	//e

Jest równe: >

	/that/e

By powtórzyć z tym samym offsetem ("n" robi to samo): >

	/

"n" robi to samo. By powtórzyć usuwając poprzednio użyty offset: >

	//


WYSZUKIWANIE W TYŁ

Komenda "?" używa offsetów w ten sam sposób, ale musisz użyć "?" zamiast "/" by
oddzielić offset od wzorca: >

	?const?e-2

"b" i "e" zachowują swoje znaczenie, nie zmieniają kierunku wraz z użyciem
"?".


POZYCJA STARTOWA

Wyruszając na poszukiwanie, zazwyczaj zaczyna się ono na pozycji kursora.
Kiedy określisz offset linii może to spowodować problemy. Na przykład: >

	/const/-2

Znajduje następny wyraz "const" i przenosi się dwie linie w górę. Jeśli
użyjesz "n" do ponownego wyszukiwania, Vim zacznie od bieżącej pozycji
i dopasuje to samo "const". Potem, używając znowu offsetu znajdziesz się w tym
samym miejscu gdzie zaczynałeś. Utknąłeś w miejscu!
   Może być jeszcze gorzej: przypuśćmy, że jest kolejne dopasowanie z "const"
w następnej linii. Powtórzone wyszukiwanie w przód dopasuje je i przeniesie
cię dwie linie do góry. W rezultacie kursor się cofnie!

Kiedy określasz offset znakowy Vim kompensuje to. Dlatego wyszukiwanie zaczyna
się kilka znaków w przód lub w tył, tak więc to samo dopasowanie nie jest
powtórnie znalezione.

==============================================================================
*27.4*	Wielokrotne dopasowanie

"*" określa, że atom przed nim może zostać dopasowany dowolną ilość razy: >

	/a*

dopasowuje "a", "aa", "aaa", itd. Ale także "" (pusty łańcuch), ponieważ
dopasowuje także zero razy.
   "*" odnosi się tylko do atomu bezpośrednio przed nim. "ab*" dopasowuje "a",
"ab", "abb", "abbb", itd. Żeby wielokrotnie dopasować cały łańcuch musi zostać
on zgrupowany w jeden atom. Robi się to przez dodanie "\(" przed nim i "\)" po
nim. Polecenie: >

	/\(ab\)*

dopasowuje: "ab", "abab", "ababab", itd. Także "".

Żeby uniknąć dopasowania pustego łańcuch użyj "\+". Dopasowuje on poprzedni
łańcuch jeden lub więcej razy. >

	/ab\+

Dopasowuje "ab", "abb", "abbb", itd. Nie dopasowuje "a" jeśli nie występuje po
nim "b".

Opcjonalne dopasowanie uzyskuje się dzięki "\=". Przykład: >

	/folders\=

Dopasowuje "folder" i "folders".


OKREŚLONE ILOŚCI WYSTĄPIEŃ

Określoną ilość atomów dopasowuje forma "\{n,m}". "n" i "m" są liczbami. Atom
przed nimi będzie dopasowany "n" do "m" razy (włączając).
Przykład: >

	/ab\{3,5}

dopasowuje "abbb", "abbbb" i "abbbbb".
  Kiedy opuszczone jest "n", domyślne jest zero. Kiedy opuszczone jest "m",
domyślna jest nieskończoność. Kiedy ",m" jest opuszczone, dopasuje dokładnie
"n" razy.
Przykład:

	wzorzec		liczba dopasowań ~
	\{,4}		0, 1, 2, 3 lub 4
	\{3,}		3, 4, 5, itd.
	\{0,1}		0 lub 1, tak samo jak \=
	\{0,}		0 lub więcej, tak samo jak *
	\{1,}		1 lub więcej, tak samo jak \+
	\{3}		3


DOPASOWANIE TAK MAŁO JAK TO MOŻLIWE

Atomy jak na razie dopasowują tak wiele znaków jak tylko mogą znaleźć. Żeby
znaleźć tak mało jak to możliwe użyj "\{-n,m}". Działa tak samo jak "\{n,m}",
z wyjątkiem tego, że dopasuje minimalną możliwą ilość znaków.
   Na przykład: >

	/ab\{-1,3}

Dopasuje "ab" w "abbb". Właściwie nigdy nie dopasuje więcej niż jedno b,
ponieważ nie ma przyczyny by dopasować więcej. Wymagane jest coś innego, żeby
zmusić Vima do dopasowania powyżej dolnego limitu.
   Te same reguły stosują się do usuwania "n" i "m". Jest nawet możliwe do
usunięcia obu w wyniku czego powstanie "\{-}". To dopasowuje atom przed nim
zero lub więcej razy, tak mało jak to możliwe. Przedmiot sam z siebie zawsze
dopasowuje zero razy. Użyteczne w kombinacji z czymś innym. Przykład: >

	/a.\{-}b

Dopasuje "axb" w "axbxb". Jeśli użyto by tego wzorca: >

	/a.*b

Próbowałby dopasować tak wiele znaków jak to możliwe z ".*" i dopasowałby
"axbxb" jako całość.

==============================================================================
*27.5*	Operator OR

Operatorem OR we wzorcu jest "\|". Przykład: >

	/foo\|bar

Dopasowuje "foo" lub "bar". Można dodać więcej możliwości: >

	/jeden\|dwa\|trzy

Dopasowuje "jeden", "dwa" i "trzy".
   Żeby dopasować kilka razy, całe wyrażenie musi być umieszczone między "\("
i "\)": >

	/\(foo\|bar\)\+

Dopasowuje "foo", "foobar", "foofoo", "barfoobar", itd.
   Inny przykład: >

	/end\(if\|while\|for\)

Dopasowuje "endif", "endwhile" i "endfor".

Podobny atom to "\&". Wymaga by obie alternatywy były dopasowane. Wynikowe
dopasowanie używa ostatniej alternatywy. Przykład: >

	/forever\&...

Dopasowuje "for" w "forever". Nie dopasuje zaś "fortuin".

==============================================================================
*27.6*	Zasięg znaków

Żeby dopasować "a", "b" lub "c" możesz użyć "a\|b\|c". Kiedy chcesz dopasować
wszystkie litery od "a" do "z" robi się to bardzo długie. Jest krótsza metoda:
>
	/[a-z]

Konstrukt [] dopasowuje pojedynczy znak. Wewnątrz tego określasz jakie znaki
dopasować. Możesz wpisać listę znaków takie jak: >

	/[0123456789abcdef]

To dopasuje dowolny z określonych znaków. Dla występujących po sobie znaków
możesz określić zasięg. "0-3" oznacza "0123". "w-z" - "wxyz". Dlatego powyższe
polecenie może zostać skrócone do: >

	/[0-9a-f]

Znak "-" dopasujesz przez umieszczenie go na pierszym lub ostatnim miejscu
w zasięgu. Te znaki specjalne są akceptowane dla łatwiejszego użycia wewnątrz
[] (mogą być użyte praktycznie wszędzie we wzorcach wyszukiwania):

	\e	<Esc>
	\t	<Tab>
	\r	<CR>
	\b	<BS>

Jest jeszcze kilka znaków specjalnych dla [], zobacz |/[]| dla pełnej listy.


ZASIĘG PRZECZĄCY

Żeby uniknąć dopasowania określonego znaku użyj "^" na początku zasięgu. []
dopasowuje później wzystkie znaki z wyjątkiem umieszczonych wewnątrz [].
Przykład: >

	/"[^"]*"
<
	 "	  podwójny cudzysłów
	  [^"]	  dowolny znak nie będący podwójnym cudzysłowem
	      *	  tak dużo ile możliwe
	       "  znowu podwójny cudzysłów

Dopasowuje "foo" i "3!x", włączając podwójne cudzysłowy.


ZASIĘGI PREDEFINIOWANE

Wiele zasięgów jest używanych bardzo często. Vim oferuje dla nich skróty.
Na przykład: >

	/\a

Znajduje znak alfabetu. Równa się użyciu "/[a-zA-Z]". Inne:

	atom	dopasowanie		równowartość ~
	\d	cyfra			[0-9]
	\D	nie cyfra		[^0-9]
	\x	cyfra heksowa		[0-9a-fA-F]
	\X	nie cyfra heksowa	[^0-9a-fA-F]
	\s	znak odstępu		[ 	]     (<Tab> i <Space>)
	\S	nie znak odstępu	[^ 	]     (nie <Tab> i nie <Space>)
	\l	mała litera		[a-z]
	\L	nie mała litera		[^a-z]
	\u	wielka litera		[A-Z]
	\U	nie wielka litera	[^A-Z]

	Note:
	Te klasy działają o wiele szybciej niż zasięgi znakowe jakie
	zastępują.
	Nie mogą być zastosowane wewnątrz []. Dlatego "[\d\l]" NIE dopasuje
	cyfry lub małej litery. Zamiast tego użyj "\(\d\|\l\)".

Zobacz |/\s| dla całej listy klas.

==============================================================================
*27.7*	Klasy znaków

Zasięg znaków dopasowuje mieszany zestaw znaków. Klasa znaków jest podobna,
ale ze znaczącą różnicą: zestaw znaków może być redefiniowany bez zmiany
wzorca wyszukiwania.
   Na przykład, poszukując tego wzorca: >

	/\f\+

Klasa "\f" oznacza znaki nazw plików. Dlatego może dopasować sekwencję znaków,
która może być nazwą pliku.
   Które znaki mogą być częścią nazwy pliku zależy od systemu jakiego używasz.
Na MS-Windows, backslash jest włączony, na Uniksach nie. Jest to określone
w opcji 'isfname'. Domyślną wartością na Uniksy jest: >

	:set isfname
	isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=

Dla innych systemów domyślna wartość jest inna. Stąd możesz wykonać szukanie
wzorca z "\f" by dopasować nazwę pliku i zostanie ono automatycznie
dostosowane do systemu jakiego używasz.

	Note:
	Właściwie, Unix pozwala użyć prawie dowolnego znaku w nazwie pliku,
	włączając znak odstępu. Włączenie tych znaków do 'isfname' mogłoby być
	teoretycznie poprawne. Ale mogłoby uniemożliwić znalezienie końca
	nazwy pliku w tekście. Dlatego domyślna wartość 'isfname' jest
	kompromisem.

Klasy znakowe:

	atom	dopasowuje			opcja ~
	\i	znaki identyfikatorów		'isident'
	\I	jak \i, wyłączając cyfry
	\k	znaki keyword			'iskeyword'
	\K	jak \k, wyłączając cyfry
	\p	znaki drukowalne		'isprint'
	\P	jak \p, wyłączając cyfry
	\f	znaki nazw plików		'isfname'
	\F	jak \f, wyłączając cyfry

==============================================================================
*27.8*	Dopasowanie końca linii

Vim może znaleźć wzorzec, który zawiera znak końca linii. Musisz określić
gdzie znajduje się znak końca linii ponieważ żadna ze wspomnianych klas jak
dotąd nie dopasowuje końca linii.
   Żeby znaleźć koniec linii w określonym miejscu użyj "\n": >

	/ten\nwyraz

Dopasuje w wierszu, który kończy się na "ten" i następny wiersz zaczyna się
"wyraz". Żeby dopasować "ten wyraz", musisz dopasować spację lub koniec linii.
Znakiem, który to robi jest "\_s": >

	/ten\_swyraz

Żeby dopuścić każdą ilość znaków odstępu: >

	/ten\_s\+wyraz

Dopasowuje też kiedy "ten  " jest na końcu linii, a "   wyraz" na początku
następnej.

"\s" dopasowuje biały znak, "\_s" dopasowuje biały znak lub koniec linii.
Podobnie "\a" dopasowuje znak alfabetu (UWAGA: [A-Za-z]!), a "\_a" znak
alfabetu lub koniec linii. Inne klasy znaków i zasięgi mogą być modyfikowane
w ten sam sposób wstawiając "_".

Wiele innych znaków może dopasować koniec linii przez dodanie "\_". Na
przykład: "\_." dopasowuje dowolny znak lub koniec linii.

	Note:
	"\_.*" dopasowuje wszystko do końca pliku. Uważaj, sprawia, że
	polecenia wyszukiwania jest wolne.

Innym przykładem jest "\_[]", znak zasięgu, który włącza koniec linii: >

	/"\_[^"]*"

Znajduje tekst w podwójnych nawiasach, który może być podzielony na kilka
linii.

==============================================================================
*27.9*	Przykłady

Jest tu kilka wzorców wyszukiwania jakie mogą ci się przydać. Pokazują jak
opisane wcześniej problemy można łączyć ze sobą.


ODNAJDYWANIE REJESTRACJI SAMOCHODOWEJ (STAREJ)

Przykładowa tablica rejestracyjna to "WRA1365". Składają się na nią 3 wielkie
litery i 4 cyfry. Bezpośrednio możesz to ująć tak: >

	/\u\u\u\d\d\d\d

Innym sposobem jest określenie, że są litery i cyfry z mnożnikiem: >

	/\u\{3}\d\{4}

I używając zasięgu []: >

	/[A-Z]\{3}[0-9]\{4}

Którego z nich użyć? Takiego jaki łatwo zapamiętasz. Prosty sposób jaki możesz
zapamiętać jest o wiele szybszy od regexpowego cudeńka, którego nie możesz
zachować w pamięci.
Jeśli pamiętasz je wszystkie, unikaj ostatniego, ponieważ jest i trudniejszy
do wpisania, i wolniejszy w wykonaniu.


ODNALEZIENIE IDENTYFIKATORA

W programach C (i wielu innych językach komputerowych) identyfikator zaczyna
się literą i dalej składa się z liter lub cyfr. Można też używać znaków
podkreślenia. Znajdziesz go: >

	/\<\h\w*\>

"\<" i "\>" służą do znalezienia tylko całych wyrazów. "\h" oznacza
"[A-Za-z_]", a "\w" "[0-9A-Za-z_]".

	Note:
	"\<" i "\>" zależą od opcji 'iskeyword'. Jeśli zawiera ona "-", na
	przykład, wtedy "ident-" nie jest dopasowany. W takiej sytuacji użyj:
>
		/\w\@<!\h\w*\w\@!
<
	Sprawdza czy "\w" nie pasuje przed lub po identyfikatorze. Zobacz
	|/\@<!| i |/\@!|.

==============================================================================

Następny rozdział: |usr_28.txt|  Zwijanie

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
