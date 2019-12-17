*usr_12.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				   Sztuczki


Przez kombinację kilku komend możesz z Vimem zrobić prawie wszystko. W tym
rozdziale kilka takich kombinacji zostanie pokazanych. Używamy tu komend
przedstawionych w poprzednich rozdziałach i paru nowych.

|12.1|	Zamiana słowa
|12.2|	Zamiana "Ostatnie, Piersze" na "Pierwsze Ostatnie"
|12.3|	Sortowanie listy
|12.4|	Zamiana kolejności linii
|12.5|	Liczenie słów
|12.6|	Znalezienie strony man
|12.7|	Pozbywanie się whitespaces
|12.8|	Znalezienie gdzie jest używane dane słowo

 Następny rozdział: |usr_20.txt|  Linia poleceń dla power-users
Poprzedni rozdział: |usr_11.txt|  Odzyskiwanie plików po awarii
       Spis treści: |usr_toc.txt|

==============================================================================
*12.1*	Zamiana słowa

Komenda zamiany może być użyta do zamiany wszystkich wystąpień wyrazu przez
inny wyraz: >

	:%s/trzy/3/g

Zasięg "%" oznacza zamianę we wszystkich liniach. Flaga "g" na końcu pozwala
na zamianę wszystkich wyrazów w linii.
   Nie jest to jednak dobry sposób jeśli plik zawiera także "trzykroć".
Mogłoby być zastąpione przez "3kroć". By tego uniknąć użyj "\>" dla
dopasowania końca wyrazu: >

	:%s/trzy\>/3/g

Oczywiście, ciągle będzie błąd w "łotrzy". "\<" dopasuje początek wyrazu: >

	:%s/\<trzy\>/3/g

Jeśli piszesz program możesz chcieć zastąpić "trzy" w komentarzach, ale nie
w kodzie. Ponieważ jest to trudne do określenia dodaj flagę "c" dla uzyskania
potwierdzenia przy każdej zamianie: >

	:%s/\<trzy\>/3/gc


ZAMIANA W KILKU PLIKACH

Przypuśćmy, że chcesz zamienić wyraz w więcej niż jednym pliku. Możesz
otwierać każdy plik i wpisywać polecenie ręcznie. O wiele szybsze jest
nagrywanie i odtwarzanie poleceń.
   Przyjmijmy, że masz katalog z plikami C++, wszystkie kończą się na ".cpp".
Jest tam funkcja "GetResp", którą chcesz zastąpić "GetAnswer".

	vim *.cpp		Zacznij Vima definiując listę argumentów tak
				by zawierała wszystkie pliki C++. Jesteś teraz
				w pierwszym pliku.
	qq			Zacznij nagrywać do rejestru q.
	:%s/\<GetResp\>/GetAnswer/g
				Zrób zamianę w pierwszym pliku.
	:wnext			Zapisz plik i przejdź do następnego.
	q			Zakończ nagrywanie.
	@q			Wykonaj rejestr q. Odtworzy on zamianę
				i ":wnext". Możesz sprawdzić czy nie powoduje
				to komunikatu błędu.
	999@q			Wykonaj rejestr q na pozostałych plikach.

W ostatnim pliku dostaniesz komunikat błędu ponieważ ":wnext" nie może przejść
do następnego pliku. To kończy wykonywanie.

	Note:
	W czasie odgrywania nagranej sekwencji błąd kończy wykonywanie.
	Dlatego upewnij się, że nie dostajesz komunikatu błędu w czasie
	nagrywania.

Jest jeden haczyk: jeśli jeden z plików nie zawiera wyrazu "GetResp" otrzymasz
wiadomość komunikat błędu i zamiana zostanie zakończona. By tego uniknąć dodaj
flagę "e" do polecenia zamiany: >

	:%s/\<GetResp\>/GetAnswer/ge

Flaga "e" mówi poleceniu ":substitute", że nie znalezienie dopasowania nie
jest błędem.

==============================================================================
*12.2*	Zamiana "Ostatnie, Pierwsze" na "Pierwsze Ostatnie"

Masz listę nazwisk w takiej postaci:

	Nowak, Jan~
	Kowalski, Piotr~

Chcesz ją zmienić na taką:

	Jan Nowak~
	Piotr Kowalski~

Możesz to zrobić jednym poleceniem: >

	:%s/\([^,]*\), \(.*\)/\2 \1/

Rozbijmy to na części. Zaczyna się oczywiście poleceniem zamiany. "%" to
zasięg, który obejmuje cały plik. Zamiana jest dokonywana w każdej linii
w całym pliku.
   Argumenty dla polecenia zamiany to "/z/do/". Slashe oddzielają wzorzec "z"
i łańcuch "do". Wzorzec "z" zawiera:

							\([^,]*\), \(.*\) ~

Pierwsza część pomiędzy \( \) dopasowuje "Ostatnie"	\(     \)
	dopasuj wszystko z wyjątkiem przecinka		  [^,]
	dowolną ilość razy				      *
	dopasowuje dosłownie ", "				 ,
Druga część między \( \) dopasowuje "Pierwsze"			   \(  \)
	dowolny znak						     .
	dowolną ilość razy					      *

W części "do" mamy "\2" i "\1". To są odwołania wsteczne. Odwołują się do
tekstu dopasowanego przez \( \) we wzorcu. "\2" odwołuje się do tekstu
dopasowanego przez drugie "\( \)", które jest "Pierwszym" imieniem. "\1"
odwołuje się do pierwszego "\( \)", które jest "Ostatnim" imieniem.
   Możesz użyć do dziewięciu odwołań wstecznych w części "do" polecenia
zamiany. "\0" to cały dopasowany wzorzec. Jest jeszcze kilka specjalnych
atomów w poleceniu zamiany, zobacz |sub-replace-special|.

==============================================================================
*12.3*	Sortowanie listy

W Makefile często masz do czynienia z listą plików:

	OBJS = \ ~
		version.o \ ~
		pch.o \ ~
		getopt.o \ ~
		util.o \ ~
		getopt1.o \ ~
		inp.o \ ~
		patch.o \ ~
		backup.o ~

By posortować taką listę, przefiltruj tekst przez zewnętrzny program sort: >

	/^OBJS
	j
	:.,/^$/-1!sort

Idzie do pierwszej linii, gdzie "OBJS" jest pierwszym elementem w linii. Potem
idzie jedną linię w dół i filtruje linie dopóki nie napotka pustej linii.
Możesz również wybrać linie w trybie Visual i potem użyć "!sort". Jest to
łatwiejsze do zrobienia, ale wymaga więcej roboty przy wielu liniach.
   Rezultat:

	OBJS = \ ~
		backup.o ~
		getopt.o \ ~
		getopt1.o \ ~
		inp.o \ ~
		patch.o \ ~
		pch.o \ ~
		util.o \ ~
		version.o \ ~

Zauważ, że backslash na końcu każdej linii jest użyty do wskazania kontynuacji
linii. Po sortowaniu umiejscowienie backslashy jest nieprawidłowe! Linia
"backup.o", która była na końcu nie miała backslasha. Teraz, kiedy znajduje
się w innym miejscu musi go mieć.
   Najprostszym rozwiązaniem jest dodanie go przez "A \<Esc>". Możesz zachować
backslash w ostatniej linii jeśli upewnisz się, że występuje po nim pusta
linia. Dzięki temu problem już się nie pojawi.

==============================================================================
*12.4*	Zamiana kolejności linii

Polecenie |:global| może być połączone z poleceniem |:move| dla przeniesienia
wszystkich linii przed pierwszą linię czego rezultatem będzie odwrócenie
pliku. Polecenie brzmi: >

	:global/^/m 0

Skrócone: >

	:g/^/m 0

Wyrażenie regularne "^" dopasowuje początek linii (nawet jeśli linia jest
pusta). Polecenie |:move| przenosi dopasowaną linię za mityczną zerową linię,
tak więc bieżąca dopasowana linia staje się pierwszą linię w pliku. Ponieważ
polecenie |:global| nie jest zmieszane zmienioną numeracją linii, |:global|
kontynuuje by dopasować wszystkie pozostałe linie pliku i pakuje każdą z nich
jako pierwszą.

Sztuczka ta działa także na zasięgu. Najpierw przejdź powyżej pierwszej linii
i zaznacz ją "mt". Później przejdź do ostatniej linii w zasięgu i wpisz: >

	:'t+1,.g/^/m 't

==============================================================================
*12.5*	Liczenie słów

Czasami musisz napisać tekst z ograniczeniem maksymalnej liczby słów. Vim może
policzyć słowa za ciebie.
   Jeśli chcesz policzyć słowa w całym pliku użyj polecenia: >

	g CTRL-G

Nie wpisuj spacji po g, służy ona tylko łatwiejszemu odczytaniu polecenia.
   Wynik wygląda podobnie:

	Col 1 of 0; Line 141 of 157; Word 748 of 774; Byte 4489 of 4976 ~

Widzisz tu na którym słowie jesteś (748) i całkowitą liczbę słów w pliku
(774).

Jeśli chcesz policzyć słowa tylko w części pliku możesz przejść na początek
interesującej cię części, wpisać "gCTRL-G", przejść do końca, wpisać "gCTRL-G"
znowu, a potem policzyć w pamięci różnice pozycji. To dobre ćwiczenie, ale
jest prostszy sposób. W trybie Visual wybierz tekst, w którym chcesz policzyć
wyrazy. Wpisz gCTRL-G. Rezultat:

	Selected 5 of 293 Lines; 70 of 1884 Words; 359 of 10928 Bytes ~

Inne sposoby liczenia słów, linii i innych rzeczy, zobacz |count-items|.

==============================================================================
*12.6*	Znalezienie strony man				*find-manpage*

Edytując skrypt powłoki lub program C, używasz poleceń i funkcji dla których
możesz znaleźć strony man (na systemach Uniksowych). Za pierwszym razem użyjmy
prostszego sposobu: przenieś kursor na słowo, na którego temat chcesz znaleźć
pomoc i wciśnij >

	K

Vim uruchomi zewnętrzny program "man" ze słowem pod kursorem jako argumentem.
Jeśli strona man zostanie znaleziona, będzie pokazana. Używany jest normalny
pager do przewijania strony (najczęściej program "more"). Kiedy dojdziesz do
końca, wciśnięcie <Enter> przeniesie cię z powrotem do Vima.

Wadą tej metody jest to, że nie możesz zobaczyć strony man i tekstu na którym
pracujesz w tym samym czasie. Jest sposób na to by strona man pojawiła się
w oknie Vima. Najpierw załaduj wtyczkę typu pliku dla man; >

	:source $VIMRUNTIME/ftplugin/man.vim

Dodaj to polecenie do twojego pliku vimrc jeśli chcesz robić to częściej.
Teraz możesz użyć polecenia ":Man" do otwarcia okna ze stroną man: >

	:Man csh

Możesz przewijać tekst (w dodatku tekst jest odpowiednio podświetlony).
Pozwala to szybciej znaleźć pomoc, której szukasz. Dzięki CTRL-Ww możesz
skoczyć do okna w którym jest plik nad którym pracujesz.
   By znaleźć stronę man w żądanej sekcji, wstaw najpierw numer sekcji. Na
przykład, do znalezienia "echo" w sekcji 3: >

	:Man 3 echo

Do skoku do innej strony man, która pojawia się w tekście w typowej formie
"word(1)", wciśnij CTRL-]. Dalsze polecenia ":Man" użyją tego samego okna.


Stronę man dla słowa pod kursorem pokaże: >

	\K

(Jeśli przedefiniowałeś <Leader>, użyj jego w miejsce backslasha).
Na przykład, chcesz wiedzieć wartość zwracaną przez "strstr()" podczas
edytowania tej linii:

	if (strstr(input, "aap") == ) ~

Przenieś kursor gdzieś na "strstr" i wpisz "\K". Otworzy się okno ze stroną
man dla strstr().

==============================================================================
*12.7*	Pozbywanie się białych znaków

Część ludzi uważa spacje i znaki tabulacji na końcu linii za bezużyteczne
i brzydkie. Żeby usunąć białe znaki z końca każdej linii, wykonaj
następujące polecenie: >

	:%s/\s\+$//

Użyty jest zasięg "%", więc polecenie będzie działało w całym pliku. Wzorzec,
który będzie dopasowywało polecenie ":substitute" to "\s\+$". Znajduje on
znaki odstępu (\s), 1 lub więcej z nich (\+), przed znakiem końca linii ($).
Później wyjaśnimy jak możesz pisać takie wzorce |usr_27.txt|.
   Część "do" polecenia zamiany jest pusta: "//". Dlatego zmieni dopasowane
elementy na nic, w efekcie usuwając dopasowane białe znaki.

Innym bezsensownym użyciem spacji jest umieszczenie jest przed znakiem
tabulacji. Często może być ona usunięta bez zmiany ilości kolumn. Ale nie
zawsze! Dlatego najlepiej zrobić to ręcznie. Użyj tego polecenia poszukiwania:
>
	/ 	

Nie możesz tego zobaczyć, ale jest spacja przed znakiem tabulacji w tym
poleceniu (jest to "/<Space><Tab>"). Teraz użyj "x" by usunąć spację
i sprawdzić czy ilość kolumn nie uległa zmianie. Wciśnij "n" by znaleźć
następne dopasowanie. Powtarzaj to, dopóki nie zostaną znalezione wszystkie
dopasowania.

==============================================================================
*12.8*	Znalezienie gdzie jest używane dane słowo

Jeśli używasz Uniksa, możesz użyć kombinacji Vima i polecenia grep, żeby
edytować wszystkie pliki, które zawierają żądane słowo. Jest to szczególnie
użyteczne jeśli pracujesz nad programem i chcesz zobaczyć lub edytować pliki,
które zawierają jakąś zmienną.
   Przypuśćmy, że chcesz edytować wszystkie pliki C, które zawierają wyraz
"frame_counter". Żeby to zrobić użyj: >

	vim `grep -l frame_counter *.c`

Przyjrzyjmy się bliżej temu poleceniu. Komenda grep szuka w zestawie plików
danego słowa. Ponieważ dodano argument -l, polecenie zwróci tylko listę plików
zawierających słowo, a nie wydrukuje dopasowane linie. Szukane słowo to
"frame_counter". Właściwie może być to dowolne wyrażenie regularne. (pamiętaj,
że grep używa trochę innych wyrażeń regularnych niż Vim.)
   Całe polecenie jest zamknięte w odwrotnych cudzysłowach (`). Mówi to
powłoce Uniksa, żeby wykonać polecenie i udawać, że rezultaty zostały wpisane
w linię poleceń. Tak więc wynikiem grep jest lista plików, które to pliki są
dodane do linii poleceń Vima. To z kolei skutkuje tym, że Vim edytuje pliki,
które były na liście będącej wynikiem programu grep. Możesz potem użyć takich
poleceń jak ":next" i ":first" do przeglądania plików.


ZNAJDYWANIE LINII

Polecenie powyżej tylko znajduje pliki, w których słowo zostało znalezione.
Ciągle musisz znaleźć słowo w pliku.
   Vim ma wbudowane polecenie, którego możes użyć do przeszukiwania zestawu
plikow dla żądanego łańcucha.  Jeśli chcesz znaleźć wszystkie wystąpienia
"error_string" we wszystkich plikach C, wydaj polecenie: >

	:grep error_string *.c

Vim odszuka łańcuch "error_string" we wszystkich żądanych plikach (*.c).
Edytor otworzy pierwszy plik gdzie dopasowanie zostało znalezione i kursor
zostanie umieszczony na pierwszej pasującej linii. Żeby przejść do następnej
pasującej linii (nieważne w którym pliku), użyj polecenia ":cnext". Poprzednie
dopasowanie znajdziesz dzięki ":cprev". Polecenie ":clist" wylistuje wszystkie
dopasowania i objaśni gdzie są.
   Polecenie ":grep" używa zewnętrznego programu grep (na Uniksach) lub
findstr (na Windowsach). Możesz to zmienić ustawiając opcję 'grepprg'.

==============================================================================

Następny rozdział: |usr_20.txt|  Linia poleceń dla power-users

Copyright: zobacz |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
