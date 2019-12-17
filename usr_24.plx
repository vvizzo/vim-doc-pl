*usr_24.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

			      Szybkie wpisywanie


Vim oferuje wiele sposobów dla zredukowania liczby uderzeń w klawisze
i uniknięcia błędów przy przepisywaniu. Użyj uzupełniania trybu Insert, żeby
powtórzyć poprzednio wpisane wyrazy. Skróć długie wyrazy do krótkich. Wpisz
znaki, których nie ma na klawiaturze.

|24.1|	Wprowadzanie poprawek
|24.2|	Pokazywanie elementów parujących
|24.3|	Uzupełnianie
|24.4|	Powtarzanie wprowadzania
|24.5|	Kopiowanie z innej linii
|24.6|	Wprowadzanie rejestru
|24.7|	Skróty
|24.8|	Znaki specjalne
|24.9|	Digrafy
|24.10|	Polecenia trybu Normal

 Następny rozdział: |usr_25.txt|  Edycja sformatowanego tekstu
Poprzedni rozdział: |usr_23.txt|  Edycja trochę innych plików
       Spis treści: |usr_toc.txt|

==============================================================================
*24.1*	Wprowadzanie poprawek

O klawiszu <BS> już mówiliśmy. Usuwa znak tuż przed kursorem. Klawisz <Del>
robi to samo ze znakiem pod (za) kursorem.
   Jeśli wpiszesz całe słowo źle użyj CTRL-W:

	The horse had fallen to the sky ~
				       CTRL-W
	The horse had fallen to the ~

Jeśli całkowicie namieszałeś w linii i chcesz zacząć od początku wciśnij
CTRL-U, żeby ją usunąć. Zachowasz w ten sposób tekst za kursorem i wcięcie.
Tylko tekst od pierwszego wpisanego znaku do kursora jest usunięty. Z kursorem
na "f" w "fallen" w następnej linii wciśnięcie CTRL-U spowoduje:

	The horse had fallen to the ~
		      CTRL-U
	fallen to the ~

Jeśli zauważysz błąd kilka słów w tył, musisz przenieść tam kursor, żeby go
poprawić. Na przykład wpisałeś:

	The horse had follen to the ground ~

Musisz zmienić "follen" na "fallen". Z kursorem na końcu możesz wpisać: >

					<Esc>4blraA

<	wyjdź z trybu Insert		<Esc>
	cztery wyrazy do tyłu		     4b
	przejdź na "o"			       l
	zamień na "a"   			ra
	wróć do trybu Insert			  A

Innym sposobem jest: >

		<C-Left><C-Left><C-Left><C-Left><Right><Del>a<End>

<	cztery wyrazy do tyłu	     <C-Left><C-Left><C-Left><C-Left>
	przejdź na "o"				<Right>
	usuń "o"				       <Del>
	wprowadź "a"					    a
	przejdź na koniec linii				     <End>

Używasz tu specjalnych klawiszy do poruszania się w trybie Insert. Przypomina
to edytor bez trybów. Jest łatwiejsze do zapamiętania, ale zabiera więcej
czasu (musisz przenieść rękę z liter do klawiszy strzałek, a <End> jest trudny
do znalezienia bez spojrzenia na klawiaturę).
   Klawisze te najczęściej są użyteczne do pisania mapowań, które nie
opuszczają trybu Insert. Dodatkowe wpisywanie nie ma wtedy znaczenia.
   Przegląd klawiszy jakich możesz użyć w trybie Insert:

	<C-Home>	do początku pliku
	<PageUp>	ekran do góry
	<Home>		do początku linii
	<S-Left>	jeden wyraz w lewo
	<C-Left>	jeden wyraz w lewo
	<S-Right>	jeden wyraz w prawo
	<C-Right>	jeden wyraz w prawo
	<End>		do końca linii
	<PageDown>	ekran w dół
	<C-End>		do końca pliku

Jest jeszcze kilka innych, zobacz |ins-special-special|.

==============================================================================
*24.2*	Pokazywanie elementów parujących

Kiedy wpiszesz ) byłoby miło zobaczyć z którym ( jest sparowane. Wydaj
polecenie, by Vim tak robił: >

	:set showmatch

Jeśli teraz wpiszesz tekst taki jak "(przykład)", natychmiast jak wpiszesz )
Vim skoczy do parującego (, zatrzyma się tam na pół sekundy i wróci tam gdzie
byłeś.
   W przypadku jeśli nie ma parującego (, Vim bipnie. W ten sposób będziesz
wiedział, że gdzieś zapomniałeś (, albo wpisałeś za dużo ).
   Dopasowanie zostanie też pokazane dla par [] i {}. Nie musisz czekać
z wpisywaniem nowego znaku, jak tylko Vim zobaczy, że coś wpisujesz, kursor
wróci i wpisywanie tekstu będzie kontynuowane.
   Możesz zmienić czas jaki Vim czeka na powrót opcją 'matchtime'. Na
przykład, żeby Vim czekał półtorej sekundy: >

	:set matchtime=15

Czas jest określany w dziesiątych częściach sekundy.

==============================================================================
*24.3*	Uzupełnianie

Vim jest w stanie automatycznie uzupełniać słowa podczas wstawiania. Wpisz
pierwszą część wyrazu, wciśnij CTRL-P, a Vim zgadnie resztę.
   Przypuśćmy, że piszesz program w C i chcesz napisać następującą linię:

	total = ch_array[0] + ch_array[1] + ch_array[2]; ~

Zaczynasz tak:

	total = ch_array[0] + ch_ ~

W tym momencie mówisz Vimowi, żeby uzupełnił wyraz używając komendy CTRL-P.
Vim szuka wyrazu, który zaczyna się tym co jest przed kursorem. W tym wypadku
jst to "ch_", które pasuje do wyrazu ch_array. Wciśnięcie CTRL-P daje
w efekcie:

	total = ch_array[0] + ch_array ~

Po chwili pisania dostajesz (kończąc spacją):

	total = ch_array[0] + ch_array[1] +  ~

Jeśli teraz wciśniesz CTRL-P Vim będzie znów szukał słowa, które uzupełnia
wyraz przed kursorem. Ponieważ nie ma nic przed kursorem znajduje pierwszy
wyraz do tyłu, którym jest "ch_array". Wpisanie CTRL-P znowu daje następny
pasujący wyraz, którym jest "total". Trzecie CTRL-P szuka dalej do tyłu. Jeśli
nie ma już nic, edytorowi skończył się zapas słów i wraca do oryginalnego
tekstu, którym jest nic. Czwarte CTRL-P powoduje, że edytor wraca od nowa do
"ch_array".

Do szukania w przód, użyj CTRL-N. Ponieważ szukanie zawija wokół końca pliku,
CTRL-N i CTRL-P będą znajdować te same dopasowania, ale w różnej kolejności.
Wskazówka: CTRL-N to Następne dopasowanie, a CTRL-P to Poprzednie dopasowanie.

Vim wkłada wiele wysiłku, żeby znaleźć słowa do uzupełniania. Domyślnie szuka
w następujących miejscach:

	1. Bieżący plik
	2. Pliki w innych oknach
	3. Inne załadowane pliki (aktywne bufory)
	4. Niezaładowane pliki (nieaktywne bufory)
	5. Pliki znaczników
	6. Wszystkie pliki włączane przez bieżący plik


OPCJE

Możesz dostosować kolejność wyszukiwania opcją 'complete'.

Stosowana jest opcja 'ignorecase'. Jeśli jest ustawiona, różnice w wielkości
liter są ignorowane w czasie poszukiwań.

Specjalną opcją dla uzupełniania jest 'infercase'. Użyteczne przy wyszukiwaniu
dopasowań ignorując wielkość liter ('ignorecase' musi być ustawione) ale cały
czas używając wielkości liter wpisanych do tej pory. Jeśli więc wpiszesz "Dla",
a Vim znajdzie "dlatego", wyraz zostanie zmieniony w "Dlatego".


UZUPEŁNIANIE RÓŻNYCH RZECZY

Jeśli wiesz czego szukasz, możesz użyć tych poleceń, żeby uzupełnić określone
rzeczy:

	CTRL-X CTRL-F		nazwy plików
	CTRL-X CTRL-L		całe linie
	CTRL-X CTRL-D		definicje makr (także w plikach włączanych)
	CTRL-X CTRL-I		bieżący i włączane pliki
	CTRL-X CTRL-K		słowa ze słownika
	CTRL-X CTRL-T		słowa z tezaurusa
	CTRL-X CTRL-]		znaczniki (tags)
	CTRL-X CTRL-V		linia poleceń Vima

Po każdym z nich CTRL-N może być użyte do znalezienia następnego dopasowania,
a CTRL-P do znalezienia poprzedniego.
   Więcej informacji o każdym z tych poleceń tu: |ins-completion|.


UZUPEŁNIANIE NAZW PLIKÓW

Weźmy CTRL-X CTRL-F jako przykład. Ta kombinacja znajdzie nazwę pliku. Skanuje
bieżący katalog w poszukiwaniu nazw plików i pokazuje każdą, która pasuje do
wyrazu przed kursorem.
   Przypuśćmy, że masz takie pliki w bieżącym katalogu:

	main.c  sub_count.c  sub_done.c  sub_exit.c

Wejdź teraz w tryb Insert i zacznij pisać:

	Kod wyjściowy jest w pliku sub~

W tym momencie wprowadź polecenie CTRL-X CTRL-F. Vim uzupełni teraz bieżący
wyraz "sub" szukając plików w bieżącym katalogu. Pierwszym dopasowaniem jest
sub_count.c. Nie jest to plik, którego szukasz, więc dopasowujesz następny
plik wciskając CTRL-N. To dopasuje sub_done.c. Powtórzenie CTRL-N zabierze
cię do sub_exit.c. Rezultat:

	Kod wyjściowy jest w pliku sub_exit.c~

W nazwie pliku zaczynającej się / (Unix) lub C:\ (MS-Windows) możesz znaleźć
wszystkie pliki w systemie. Na przykład, wpisz "/u" i CTRL-X CTRL-F. Dopasuje
to "/usr" (na Uniksie):

	plik został znaleziony w /usr/ ~

Jeśli teraz wciśniesz CTRL-N wrócisz do "/u". Zamiast tego zaakceptuj "/usr/"
i przejdź jeden poziom katalogów niżej: użyj znów CTRL-X CTRL-F:

	plik został znaleziony w /usr/X11R6/ ~

Rezultat zależy oczywiście od tego co się znajduje w twoim systemie.
Dopasowania są posortowane alfabetycznie.


==============================================================================
*24.4*	Powtarzanie wprowadzania

Kiedy wciśniesz CTRL-A, edytor wprowadzi tekst jaki wpisałeś ostatnim razem
kiedy byłeś w trybie Insert.
   Załóżmy, że masz plik zaczynający się następująco:

	"file.h" ~
	/* Zaczyna się główny program */ ~

Edytujesz ten plik wporwadzając "#include " na początku pierwszej linii:

	#include "file.h" ~
	/* Zaczyna się główny program */ ~

Idziesz w dół do początku następnej linii używając komendy "j^". Chcesz
wprowadzić nową linię "#include". Wpisujesz więc: >

	i CTRL-A

Rezultat jest następujący:

	#include "file.h" ~
	#include /* Zaczyna się główny program */ ~

"#include " zostało wpisane ponieważ CTRL-A wprowadza tekst poprzedniej sesji
trybu Insert. Dokończ linię wpisując "main.h"<Enter>:

	#include "file.h" ~
	#include "main.h" ~
	/* Zaczyna się główny program */ ~

Polecenie CTRL-@ wykonuje CTRL-A i opuszcza tryb Insert. Jest to szybki sposób
zrobienia tego samego wprowadzenia.

==============================================================================
*24.5*	Kopiowanie z innej linii

Polecenie CTRL-Y wprowadza znak powyżej kursora. Wygodne kiedy kopiujesz
poprzednią linię. Na przykład masz linię kodu C:

	b_array[i]->s_next = a_array[i]->s_next; ~

Chcesz wpisać tę samą linię, ale z "s_prev" zamiast "s_next". Zacznij nową
linię i wciśnij CTRL-Y czternaście razy, dopóki nie będziesz pod "n" z "next":

	b_array[i]->s_next = a_array[i]->s_next;~
	b_array[i]->s_ ~

Teraz wpisz "prev":

	b_array[i]->s_next = a_array[i]->s_next; ~
	b_array[i]->s_prev ~

Kontynuuj wciskanie CTRL-Y aż do następnego "next":

	b_array[i]->s_next = a_array[i]->s_next;~
	b_array[i]->s_prev = a_array[i]->s_ ~

Teraz wpisz "prev;" żeby dokończyć.

Polecenie CTRL-E działa tak jak CTRL-Y z wyjątkiem tego, że wprowadza znak
poniżej kursora.

==============================================================================
*24.6*	Wprowadzanie rejestru

Polecenie CTRL-R{rejestr} wprowadza zawartość rejestru. Użyteczne kiedy chce
się uniknąć wpisywania długiego słowa. Na przykład musisz wpisać to:

	r = VeryLongFunction(a) + VeryLongFunction(b) + VeryLongFunction(c) ~

Nazwa funkcji jest zdefiniowana w innym pliku. Otwórz ten plik i przejdź
kursorem na nazwę funkcji i yankuj ją do rejestru v: >

	"vyiw

"v jest określeniem rejestru, "yiw" to yank-inner-word. Teraz otwórz plik
gdzie nowa linia ma zostać wprowadzona i wpisz pierwsze litery:

	r = ~

Teraz użyj CTRL-Rv żeby wprowadzić nazwę funkcji:

	r = VeryLongFunction ~

Kontynuujesz wpisywanie liter pomiędzy nazwami funkcji i używasz CTRL-Rv
jeszcze dwa razy.
   Możesz zrobić to samo z uzupełnianiem. Użycie rejestru jest wygodniejsze
jeśli istnieje wiele słów zaczynających się tymi samymi znakami.

Jeśli rejestr zawiera znaki takie jak <BS> lub inne znaki specjalne, są one
interpretowane tak jakby były wpisywane z klawiatury. Jeśli nie chcesz by tak
się nie działo (naprawdę chcesz by <BS> został wstawiony do tekstu), użyj
polecenia CTRL-R CTRL-R{rejestr}.

==============================================================================
*24.7*	Skróty

Skrót (abbreviation) jest krótkim słowem, które zastępuje długie. Na przykład
"og" zastępuje "ogłoszenie". Vim pozwala na wpisanie skrótu i automatycznie go
rozwija.
   Żeby Vim rozwinął "og" w "ogłoszenie" za każdym razem kiedy to wpiszesz,
użyj następującego polecenia: >

	:iabbrev og ogłoszenie

Teraz kiedy wpiszesz "og", całe słowo "ogłoszenie" zostanie wstawione do
tekstu. Jest to uruchamiane przez wpisanie wyrazu, który nie może być częścią
wyrazu, na przykład spacją:

	Co jest wprowadzane     Co widzisz
	Widziałem o		Widziałem o ~
	Widziałem og		Widziałem og ~
	Widziałem og<Spacja>	Widziałem ogłoszenie<Spacja> ~

Rozwinięcie wyrazu nie zdarzy się kiedy wpiszesz "og". Pozwala to na wpisanie
słowa takiego jak "ogród", które nie zostanie rozwinięte. Tylko całe wyrazy są
sprawdzane na okoliczność skrótów.


SKRACANIE KILKU WYRAZÓW

Jest możliwe zdefiniowanie skrótu, który zawiera kilka wyrazów. Na przykład,
żeby skrócić "Jan Kowalski" do "JK" wydaj polecenie: >

	:iabbrev JK Jan Kowalski

Jako programista używam dwóch, raczej niezwykłych, skrótów: >

	:iabbrev #b /****************************************
	:iabbrev #e <Space>****************************************/

Używam ich do tworzenia komentarzy blokowych. Komentarz zaczyna się #b, które
rysuje górną linię. Później wpisuję tekst komentarza i używam #e do
narysowania dolnej linii.
   Zauważ, że skrót #e zaczyna się spacją. Innymi słowy, pierwsze dwa znaki to
spacja-gwiazdka. Zazwyczaj Vim ignoruje spacje między skrótem i rozwinięciem.
Żeby tego uniknąć piszę spację jako siedem znaków: <, S, p, a, c, e, >.

	Note:
	":iabbrev" jest długim słowem. ":iab" działa równie dobrze.
	To skrócenie polecenia skrótu!


POPRAWIANIE LITERÓWEK

Bardzo częste jest popełnianie cały czas tych samych błędów w czasie pisania.
Na przykład "nei" zamiast "nie". Możesz to naprawić skrótem: >

	:abbreviate nei nie

Możesz dodać całą listę takich błędów. Dodaj jeden za każdym razem kiedy
wykryjesz zwykły błąd.


LISTA SKRÓTÓW

Polecenie ":abbreviate" listuje wszyskie skróty:

	:abbreviate
	i  #e		  ****************************************/
	i  #b		 /****************************************
	i  JK		 Jan Kowalski
	i  og		 ogłoszenie
	i  nei		 nie

"i" w pierwszej kolumnie oznacza tryb Insert. Te skróty są aktywne tylko
w trybie Insert. Inne możliwe znaki to:

	c    tryb linii poleceń				:cabbrev
	!    zarówno tryb Insert jak i linia poleceń	:abbreviate

Ponieważ skróty nie są zbyt użyteczne w trybie linii poleceń najczęściej
będziesz używał polecenia ":iabbrev". W ten sposów unikniesz rozwinięcia "ad"
wpisując polecenie: >

	:edit ad


USUWANIE SKRÓTÓW

Do usunięcia skrótu służy komenda ":unabbreviate". Przypuśćmy, że masz taki
skrót: >

	:abbreviate @n nowy

Usuwasz go poleceniem: >

	:unabbreviate @n

Kiedy będziesz to wpisywał zobaczysz, że @n jest rozwinięte do "nowy". Nie
martw się tym, Vim rozumie to i tak (z wyjątkiem sytuacji kiedy masz skrót na
"nowy", ale to naprawdę mało prawdopodobne).
   Żeby usunąć wszystkie skróty: >

	:abclear

":unabbreviate" i ":abclear" istnieją także w wariantach dla trybu Insert
(":iunabbreviate" i ":iabclear") oraz trybu linii poleceń (":cunabbreviate"
i ":cabclear").


REMAPOWANIE SKRÓTÓW

Jest jedna rzecz, której należy się wystrzegać definiując skrót: wynik nie
powinien być mapowany. Na przykład: >

	:abbreviate @a adder
	:imap dd disk-door

Jeśli wpiszesz @a dostaniesz "adisk-doorer". Oczekiwałeś trochę innego efektu.
Żeby tego uniknąć użyj polecenia ":noreabbrev". Robi to samo co ":abbreviate",
ale rezultat nie jest użyty do mapowania: >

	:noreabbrev @a adder

Na szczęście jest mało prawdopodobne by rezultat skrótu był mapowany.

==============================================================================
*24.8*	Znaki specjalne

Polecenie CTRL-V służy do wprowadzenia następnego znaku literalnie. Innymi
słowy, bez względu jakie znaczenie specjalne ma znak zostanie ono zignorowane.
Na przykład: >

	CTRL-V <Esc>

Wprowadza znak escape. Dlatego nie opuszczasz trybu Insert. (Nie wpisuj spacji
po CTRL-V, jest tu ona tylko dla łatwiejszego odczytania).

	Note:
	W MS-Windows CTRL-V służy do wpisywania tekstu ze schowka. Użyj
	zamiast tego CTRL-Q. Z drugiej strony, na Uniksach, CTRL-Q nie działa
	na niektórych terminalach, ponieważ ma specjalne znaczenie.

Możesz także użyć polecenia CTRL-V {liczba}, żeby wprowadzić znak przez liczbę
dziesiętną {liczba}. Na przykład, znak numer 127 to znak <Del> (ale
niekoniecznie klawisz <Del>!). Aby wprowadzić <Del>: >

	CTRL-V 127

W ten sposób możesz wpisać do 255 znaków. Kiedy wpiszesz mniej niż dwie cyfry,
nie-cyfra przerwie polecenie. Żeby uniknąć wpisywania nie-cyfr, poprzedź cyfrę
jednym lub dwoma zerami.
   Wszystkie następne polecenia wprowadzają <Tab> i kropkę:

	CTRL-V 9.
	CTRL-V 09.
	CTRL-V 009.

Żeby wprowadzić znak w notacji heksadecymalnej użyj "x" po CTRL-V: >

	CTRL-V x7f

Tak też da się wpisywać znaki tylko do 255 (CTRL-V xff). Możesz użyć "o", żeby
podać numer znaku jako liczbę ósemkową a kolejne dwie metody pozwalają na
użycie liczb 16 i 32 bitowych (dla znaków unikodowych): >

	CTRL-V o123
	CTRL-V u1234
	CTRL-V U12345678

==============================================================================
*24.9*	Digrafy

Niektóre znaki nie pojawiają się na klawiaturze. Na przykład znak paragrafu
(§). Żeby wpisać te znaki w Vimie trzeba użyć digrafów, gdzie dwa znaki
reprezentują jeden. Do wprowadzenia §, wciskasz trzy klawisze: >

	CTRL-K SE

Żeby dowiedzieć się jakie digrafy są dostępne użyj polecenia: >

	:digraphs

Vim pokaże tabelę digrafów. Tu pokazujemy trzy linie:

  AC ~_ 159  NS |  160  !I Ą  161  Ct ˘  162  Pd Ł  163  Cu ¤  164  Ye Ľ  165 ~
  BB Ś  166  SE §  167  ': ¨  168  Co Š  169  -a Ş  170  << Ť  171  NO Ź  172 ~
  -- ­  173  Rg Ž  174  'm Ż  175  DG °  176  +- ą  177  2S ˛  178  3S ł  179 ~

Widać, że digrafem, który uzyskasz wpisując CTRL-K Pd jest Ł. Jest to znak
numer 163 (dziesiętny).
   Pd jest skrótem na funta (Pound). Większość digrafów jest wybranych tak by
dać wskazówkę co do znaku jaki wyprodukują. Jeśli przejrzysz listę powinieneś
zrozumieć logikę.
   Możesz wymienić pierwszy i drugi znak, jeśli nie ma digrafu dla tej
kombinacji. Dlatego CTRL-K dP będzie działało. Ponieważ nie ma digrafu dla
"dP" Vim będzie też szukał digrafu "Pd".

	Note:
	Digrafy zależą od zestawu znaków jakiego Vim używa. Na MS-DOS jest on
	inny od MS-Windows. Zawsze użyj ":digraphs", żeby się dowiedzieć co
	digrafy aktualnie oznaczają.
	Digrafy są dostosowane do ISO-8859-1. Niestety używając ISO-8859-2,
	lub CP-1250 spora część logiki stojącej za znakami specjalnymi jest
	złamana ponieważ na miejsce oryginalnych znaków ASCII zostały
	wprowadzone znaki środkowoeuropejskie.

Możesz zdefiniować swoje własne digrafy. Przykład: >

	:digraph a" ä

Definiuje to, że CTRL-K a" wprowadzi znak ä. Digrafy możesz też określić
liczbą w systemie dziesiętnym. To polecenie definiuje ten sam digraf: >

	:digraph a" 228

Więcej informacji o digrafach: |digraphs|
   Innym sposobem wprowadzania znaków specjalnych jest keymap. Więcej o tym
tu: |45.5|

==============================================================================
*24.10*	Polecenia trybu Normal

Tryb Insert oferuje ograniczoną liczbę komend. W trybie Normal masz ich
o wiele więcej. Jeśli chcesz użyć jednej z nich, zazwyczaj opuszczasz tryb
Insert przez <Esc>, wykonujesz polecenie trybu Normal i powracasz do trybu
Insert przez "i" lub "a".
   Jest szybszy sposób. CTRL-O {polecenie} możesz wykonać dowolne polecenie
trybu Normal w trybie Insert. Na przykład, żeby usunąć znaki od kursora do
końca linii: >

	CTRL-O D

Możesz w ten sposób wykonać tylko jedno polecenie trybu Normal. Ale możesz
określić rejestr albo mnożnik. Bardziej skomplikowany przykład: >

	CTRL-O "g3dw

Usuwa trzy wyrazy do rejestru g.

==============================================================================

Następny rozdział: |usr_25.txt|  Edycja sformatowanego tekstu

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
