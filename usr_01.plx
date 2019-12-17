*usr_01.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 O manualach


Ten rozdział stanowi wprowadzenie do manuali Vima. Przeczytaj go, żeby poznać
sposób w jaki objaśniają one obsługę Vima.

|01.1|	Dwa manuale
|01.2|	Vim zainstalowany
|01.3|	Vimtutor
|01.4|	Prawa autorskie

Następny rozdział: |usr_02.txt|  Pierwsze kroki w Vimie
      Spis treści: |usr_toc.txt|

==============================================================================
*01.1*	Dwa manuale

Dokumentacja Vima składa się z dwóch części:

1. Podręcznik użytkownika
   Wyjaśnienia na przykładach, od prostych do skomplikowanych. Czyta się go od
   początku do końca tak jak książkę.

2. Przewodnik encyklopedyczny
   Dokładny opis jak wszystko działa.

Notacja używana w manualach jest wyjaśniona tu: |notation|


SKAKANIE PO MANUALACH

Tekst zawiera hiperłącza pomiędzy dwoma częściami pozwalając na szybkie
przełączanie między opisem zadania a precyzyjnym opisem poleceń oraz opcji do
tego użytych. Używa się do tego dwóch komend:

	CTRL-]  by skoczyć do tematu pod kursorem.
	CTRL-O  by skoczyć z powrotem (powtórzenie cofa dalej w historii)

Wiele łączy jest zamkniętych w pionowych kreskach, jak |bars|. Nazwa opcji
w pojedynczych cudzysłowach jak 'number', polecenie w podwójnych cudzysłowach
jak ":write" i każde inne słowo może być użyte jako łącze. Spróbuj: najedź
kursorem na CTRL-] i wciśnij CTRL-].

Inne tematy pomocy mogą być znalezione przez polecenie ":help", zobacz
|help.txt|.

==============================================================================
*01.2*	Vim zainstalowany

Manuale najczęściej przyjmują, że Vim został prawidłowo zainstalowany. Jeśli
jeszcze tego nie zrobiłeś lub Vim nie działa prawidłowo (np.: pliki nie są
znajdowane lub w GUI nie pokazują się menu) najpierw przeczytaj rozdział
o instalacji: |usr_90.txt|.
							*not-compatible*
Podręczniki często też przyjmują, że używasz Vima z wyłączoną kompatybilnością
Vi. Dla większości poleceń nie ma to znaczenia, ale czasem jest ważne, np.
przy wielokrotnym undo. Prostym sposobem uzyskania pewności, że używa się
prawidłowych ustawień jest skopiowanie przykładowego pliku vimrc. Jeśli robisz
to wewnątrz Vima nie musisz wiedzieć gdzie plik dokładnie się znajduje.
Sposób zależy od systemu jakiego używasz:

Unix: >
	:!cp -i $VIMRUNTIME/vimrc_example.vim ~/.vimrc
MS-DOS, MS-Windows, OS/2: >
	:!copy $VIMRUNTIME/vimrc_example.vim $VIM/_vimrc
Amiga: >
	:!copy $VIMRUNTIME/vimrc_example.vim $VIM/.vimrc

Jeśli plik vimrc już istnieje prawdopodobnie zechcesz go zachować.

Jeśli teraz rozpoczynasz Vima, opcja 'compatible' powinna być wyłączona. 
Można to sprawdzić poleceniem: >

	:set compatible?

Jeśli odpowiedź brzmi "nocompatible" wszystko w porządku. Jeśli odpowiedzią
jest "compatible" mogą pojawić się kłopoty. Konieczne jest znalezienie
odpowiedzi dlaczego opcja cały czas jest ustawiona. Prawdopodobnie plik, który
został wcześniej zapisany nie został znaleziony. Możesz to sprawdzić: >

	:scriptnames

Jeśli .vimrc (_vimrc) nie znajduje się na liście, trzeba sprawdzić jego
położenie i nazwę. Jeśli jest na liście, istnieje inne miejsce gdzie opcja
'compatible' została z powrotem włączona.

Więcej informacji dają |vimrc| i |compatible-default|.

	Note:
	Ten podręcznik uczy tego jak używać Vima w normalny sposób. Istnieje
	alternatywa nazywana "evim" (easy Vim - łatwy Vim). Jest to cały czas
	Vim, ale używany w sposób, który przypomina edytor typu Notepad.
	Zawsze pozostaje w trybie Insert, i z tego powodu odczucia są całkiem
	inne. Nie jest on opisany w Podręczniku Użytkownika ponieważ powinien
	być prawie całkowicie do użycia bez pomocy. Zobacz |evim-keys|.

==============================================================================
*01.3*	Vimtutor					*tutor* *vimtutor*

Zamiast czytania tekstu (nudne!) można użyć vimtutora by nauczyć się
pierwszych poleceń Vima. Vimtutor to 30 minutowy interaktywny przewodnik,
który uczy podstawowych poleceń i zachowań Vima.

Na Uniksie i w MS-Windows, jeśli Vim został prawidłowo zainstalowany,
wydaje się polecenie powłoki: >

	vimtutor

Polecenie to tworzy kopię pliku tutor, żeby można go było edytować bez ryzyka
zniszczenia oryginału.
   Istnieje kilka przetłumaczonych wersji tutora (także polska). Do
sprawdzenia czy jest wersja dla danego języka używa się dwuliterowego kodu
języka. Dla polskiego: >

	vimtutor pl

Na OpenVMS, jeśli Vim został prawidłowo zainstalowany, możesz wejść do
vimtutor z linii poleceń: >

	@VIM:vimtutor

Istnieje możliwość dodania dwuliterowego kodu języka.



Na innych systemach potrzeba trochę pracy:

1. Kopia pliku tutor. Można to zrobić z Vimem (on wie gdzie co znaleźć): >
>
	vim -u NONE -c 'e $VIMRUNTIME/tutor/tutor' -c 'w! TUTORCOPY' -c 'q'
<
   To polecenie zapisuje plik "TUTORCOPY" w bieżącym katalogu. By użyć
przetłumaczonej wersji tutora, trzeba dodać dwuliterowy kod języka do nazwy
pliku. Dla polskiego: >

	vim -u NONE -c 'e $VIMRUNTIME/tutor/tutor.pl' -c 'w! TUTORCOPY' -c 'q'
<
2. Edycja skopiowanego pliku z Vimem: >

	vim -u NONE -c 'set nocp' TUTORCOPY
<
   Dodatkowe argumenty dają pewność, że Vim zacznie w odpowiednim nastroju.

3. Usuń skopiowany plik kiedy z nim skończysz: >
>
	del TUTORCOPY
<
==============================================================================
*01.4*	Prawa autorskie 				*manual-copyright*

The Vim user manual and reference manual are Copyright (c) 1988-2003 by Bram
Moolenaar. This material may be distributed only subject to the terms and
conditions set forth in the Open Publication License, v1.0 or later.  The
latest version is presently available at:
	     http://www.opencontent.org/openpub/

Copyright (c) 1988-2003 by Bram Moolenaar na Vim Podręcznik Użytkownika
i Przewodnik Encyklopedyczny. Materiały te mogą być rozprowadzane jedynie na
warunkach przedstawionych w Open Publication License, v1.0 lub późniejsza.
Ostatnia wersja jest dostępna:
	     http://www.opencontent.org/openpub/

Copyright (c) 2003 by Mikołaj Machowski for Polish translation of Vim Users
Manual. This material may be distributed only subject to the terms and
conditions set forth in the Open Publication License, v1.0 or later.  The
latest version is presently available at:
	     http://www.opencontent.org/openpub/

Osoby, które pomagają w tworzeniu podręczników muszą się zgodzić na powyższą
notkę o prawach autorskich.

							*tłumacz* *translator*
Wszelkie uwagi co do tłumaczenia: literówki, błędy stylistyczne, gramatyczne
oraz zachwyty należy kierować na adres: Mikołaj Machowski <mikmach@wp.pl>.

							*frombook*
Fragmenty Podręcznika Użytkownika pochodzą z książki "Vi IMproved - Vim"
napisanej przez Steve'a Oualline'a (opublikowanej przez New Riders Publishing,
ISBN: 0735710015). Open Publication License stosuje się także do tej książki.
Tylko wybrane fragmenty są włączone i zostały one zmodyfikowane (np.: usunięto
ilustracje, zaktualizowano tekst dla Vim 6.0 i poprawiono błędy).  Brak
znacznika |frombook| nie znaczy, że tekst nie pochodzi z książki.

Duże podziękowania należą się Steve'owi Oualline'owi i New Riders za stworzenie tej
książki i opublikowanie jej pod OPL! Była ona wielką pomocą przy pisaniu
Podręcznika Użytkownika. Nie tylko przez dostarczenie dosłownego tekstu, ale
także przez ton i styl.

Jeśli zarabiasz dzięki sprzedaży podręczników bardzo proszę o donację części
zysku na rzecz ofiar AIDS w Ugandzie. Zobacz |iccf|.

==============================================================================

Następny rozdział: |usr_02.txt|  Pierwsze kroki w Vimie

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
