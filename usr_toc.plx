*usr_toc.txt*  For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		 VIM PODRĘCZNIK UŻYTKOWNIKA - Bram Moolenaar
			   tłum. Mikołaj Machowski

				 Spis treści			*user-manual*

==============================================================================
Przegląd ~

Początki
|usr_01.txt|  O manualach
|usr_02.txt|  Pierwsze kroki w Vimie
|usr_03.txt|  Poruszanie się
|usr_04.txt|  Małe zmiany
|usr_05.txt|  Personalizacja ustawień Vima
|usr_06.txt|  Podświetlanie składni
|usr_07.txt|  Edycja więcej niż jednego pliku
|usr_08.txt|  Dzielenie okna
|usr_09.txt|  GUI
|usr_10.txt|  Duże zmiany
|usr_11.txt|  Odzyskiwanie plików po awarii
|usr_12.txt|  Sztuczki

Efektywna edycja
|usr_20.txt|  Linia poleceń dla power-users
|usr_21.txt|  Tam i z powrotem
|usr_22.txt|  Znajdywanie plików do edycji
|usr_23.txt|  Edycja trochę innych plików
|usr_24.txt|  Szybkie wpisywanie
|usr_25.txt|  Edycja sformatowanego tekstu
|usr_26.txt|  Powtarzanie
|usr_27.txt|  Polecenia szukania i wzorce
|usr_28.txt|  Zwijanie
|usr_29.txt|  Poruszanie się po programach
|usr_30.txt|  Edycja programów
|usr_31.txt|  Eksploracja GUI

Dostrajanie Vima
|usr_40.txt|  Tworzenie poleceń
|usr_41.txt|  Pisanie skryptów Vima
|usr_42.txt|  Dodawanie menu
|usr_43.txt|  Typy plików
|usr_44.txt|  Tworzenie własnego schematu podświetlania
|usr_45.txt|  Wybór języka

Uruchamianie Vima
|usr_90.txt|  Instalacja Vima


Podręcznik użytkownia jest dostępny jako jeden, gotowy do druku plik html:

	http://www.erebus.demon.nl/Vim/ (ang.)
	
==============================================================================
Początki ~

Przeczytaj ten rozdział od początku by nauczyć się podstawowych komend.

|usr_01.txt|  O manualach
		|01.1|	Dwa manuale
		|01.2|	Vim zainstalowany
		|01.3|	Vimtutor
		|01.4|	Prawa autorskie

|usr_02.txt|  Pierwsze kroki w Vimie
		|02.1|	Pierwsze uruchomienie Vima
		|02.2|	Wprowadzanie tekstu
		|02.3|	Poruszanie się
		|02.4|	Usuwanie znaków
		|02.5|	Undo i redo
		|02.6|	Inne polecenia edycji
		|02.7|	Wychodzenie
		|02.8|	System pomocy

|usr_03.txt|  Poruszanie się
		|03.1|	Poruszanie się po wyrazach
		|03.2|	Przejście do początku lub końca linii
		|03.3|	Przejście do znaku
		|03.4|	Znajdowanie pary
		|03.5|	Przejście do żądanej linii
		|03.6|	Gdzie ja jestem?
		|03.7|	Przewijanie
		|03.8|	Proste poszukiwania
		|03.9|	Proste wzorce poszukiwania
		|03.10|	Zakładki

|usr_04.txt|  Małe zmiany
		|04.1|	Operatory i ruchy
		|04.2|	Zmiana tekstu
		|04.3|	Powtarzanie zmiany
		|04.4|	Tryb Visual
		|04.5|	Przenoszenie tekstu
		|04.6|	Kopiowanie tekstu
		|04.7|	Schowek
		|04.8|	Obiekty tekstowe
		|04.9|	Tryb replace
		|04.10|	Podsumowanie

|usr_05.txt|  Personalizacja ustawień Vima
		|05.1|	Plik Vimrc
		|05.2|	Przykładowy Vimrc z komentarzami
		|05.3|	Proste mapowania
		|05.4|	Dodawanie wtyczki
		|05.5|	Dodawanie pliku pomocy
		|05.6|	Okno opcji
		|05.7|	Często używane opcje

|usr_06.txt|  Podświetlanie składni
		|06.1|	Włączanie podświetlania
		|06.2|	Brak koloru lub zły kolor?
		|06.3|	Różne kolory
		|06.4|	Z kolorami czy bez kolorów?
		|06.5|	Drukowanie z kolorami
		|06.6|	Dalsza lektura

|usr_07.txt|  Edycja więcej niż jednego pliku
		|07.1|	Edytuj inny plik
		|07.2|	Lista plików
		|07.3|	Skakanie z pliku do pliku
		|07.4|	Pliki awaryjne
		|07.5|	Kopiowanie tekstu między plikami
		|07.6|	Podgląd pliku
		|07.7|	Zmiana nazwy pliku

|usr_08.txt|  Dzielenie okna
		|08.1|	Podział okna
		|08.2|	Podział okna z innym plikiem
		|08.3|	Wielkość okna
		|08.4|	Pionowy podział
		|08.5|	Przenoszenie okien
		|08.6|	Polecenia dla wszystkich okien
		|08.7|	Porównywanie z Vimdiff
		|08.8|	Różne

|usr_09.txt|  GUI
		|09.1|	Części GUI
		|09.2|	Mysz
		|09.3|	Schowek
		|09.4|	Tryb select

|usr_10.txt|  Duże zmiany
		|10.1|	Nagrywanie i odtwarzanie poleceń
		|10.2|	Zamiana
		|10.3|	Zasięg poleceń
		|10.4|	Komenda global
		|10.5|	Tryb Visual Block
		|10.6|	Odczytywanie i zapisywanie części pliku
		|10.7|	Formatowanie tekstu
		|10.8|	Zmiana wielkości litery
		|10.9|	Używanie zewnętrznych programów

|usr_11.txt|  Odzyskiwanie plików po awarii
		|11.1|	Podstawy odzyskiwania
		|11.2|	Gdzie jest plik wymiany?
		|11.3|	Awaria czy nie?
		|11.4|	Dalsza lektura

|usr_12.txt|  Sztuczki
		|12.1|	Zamiana słowa
		|12.2|	Zamiana "ostatnie, piersze" na "pierwsze ostatnie"
		|12.3|	Sortowanie listy
		|12.4|	Zamiana kolejności linii
		|12.5|	Liczenie słów
		|12.6|	Znalezienie strony man
		|12.7|	Pozbywanie się whitespaces
		|12.8|	Znalezienie gdzie jest używane dane słowo

==============================================================================
Efektywna edycja ~

Tematy mogą być czytane niezależnie.

|usr_20.txt|  Linia poleceń dla power-users
		|20.1|	Edycja linii poleceń
		|20.2|	Skróty w linii poleceń
		|20.3|	Uzupełnianie linii poleceń
		|20.4|	Historia linii poleceń
		|20.5|	Okno linii poleceń

|usr_21.txt|  Tam i z powrotem
		|21.1|	Zawieś i przywróć
		|21.2|	Wykonywanie poleceń powłoki
		|21.3|	Zapamiętywanie informacji; Viminfo
		|21.4|	Sesje (session)
		|21.5|	Widoki (view)
		|21.6|	Modelines

|usr_22.txt|  Znajdywanie plików do edycji
		|22.1|	Eksplorator plików
		|22.2|	Katalog bieżący
		|22.3|	Odnajdywanie pliku
		|22.4|	Lista buforów

|usr_23.txt|  Edycja trochę innych plików
		|23.1|	Pliki DOS-a, Mac-a i Uniksa
		|23.2|	Pliki w Internecie
		|23.3|	Pliki zaszyfrowane
		|23.4|	Pliki binarne
		|23.5|	Pliki skompresowane

|usr_24.txt|  Szybkie wpisywanie
		|24.1|	Wprowadzanie poprawek
		|24.2|	Pokazywanie elementów parujących
		|24.3|	Uzupełnianie
		|24.4|	Powtarzanie wprowadzania
		|24.5|	Kopiowanie z innej linii
		|24.6|	Wprowadzanie rejestru
		|24.7|	Skróty
		|24.8|	Znaki specjalne
		|24.9|	Digraphs
		|24.10|	Polecenia trybu normal

|usr_25.txt|  Edycja sformatowanego tekstu
		|25.1|	Łamanie linii
		|25.2|	Wyrównywanie tekstu
		|25.3|	Wcięcia i tabulatory
		|25.4|	Długie linie
		|25.5|	Edycja tablic

|usr_26.txt|  Powtarzanie
		|26.1|	Powtarzanie w trybie Visual
		|26.2|	Dodaj i odejmij
		|26.3|	Zmiana w wielu plikach
		|26.4|	Używanie Vima ze skryptu powłoki

|usr_27.txt|  Polecenia wyszukiwania i wzorce
		|27.1|	Ignorowanie wielkości znaków
		|27.2|	Zawijanie wokół końca pliku
		|27.3|	Offset
		|27.4|	Wielokrotne dopasowanie
		|27.5|	Operator OR
		|27.6|	Zasięg znaków
		|27.7|	Klasy znaków
		|27.8|	Dopasowanie końca linii
		|27.9|	Przykłady

|usr_28.txt|  Zwijanie
		|28.1|	Czym jest zwijanie?
		|28.2|	Ręczne zwijanie
		|28.3|	Praca ze zwiniętymi obszarami
		|28.4|	Zachowywanie i odzyskiwanie zwiniętych obszarów
		|28.5|	Zwijanie według wcięcia
		|28.6|	Zwijanie według zaznaczeń
		|28.7|	Zwijanie według składni
		|28.8|	Zwijanie według wyrażeń
		|28.9|	Zwijanie niezmienionych linii
		|28.10| jakiej metody zwijania użyć?

|usr_29.txt|  Poruszanie się po programach
		|29.1|	Znaczniki
		|29.2|	Okno podglądu
		|29.3|	Poruszanie się w programie
		|29.4|	Znajdywanie globalnych identyfikatorów
		|29.5|	Znajdywanie lokalnych identyfikatorów

|usr_30.txt|  Edycja programów
		|30.1|	Kompilacja
		|30.2|	Wcięcia w plikach C
		|30.3|	Automatyczne wcięcia
		|30.4|	Inne wcięcia
		|30.5|	Tabulatory i spacje
		|30.6|	Formatowanie komentarzy

|usr_31.txt|  Eksploracja GUI
		|31.1|	Przeglądanie plików
		|31.2|	Potwierdzanie
		|31.3|	Skróty menu
		|31.4|	Pozycja i wielkość okna Vima
		|31.5|	Różne

==============================================================================
Dostrajanie Vima ~

Spraw by Vim pracował tak jak lubisz.

|usr_40.txt|  Tworzenie poleceń
		|40.1|	Mapowanie klawiszy
		|40.2|	Definiowanie komend linii poleceń
		|40.3|	Autokomendy

|usr_41.txt|  Pisanie skryptu Vima
		|41.1|	Wstęp
		|41.2|	Zmienne
		|41.3|	Wyrażenia
		|41.4|	Warunki (if, elseif, else)
		|41.5|	Wykonywanie wyrażeń
		|41.6|	Funkcje
		|41.7|	Definiowanie funkcji
		|41.8|	Wyjątki
		|41.9|	Różne uwagi
		|41.10|	Pisanie wtyczki
		|41.11|	Pisanie wtyczki dla typu pliku (ftplugin)
		|41.12|	Pisanie wtyczki dla kompilatora

|usr_42.txt|  Dodawanie menu
		|42.1|	Wstęp
		|42.2|	Polecenia menu
		|42.3|	Różne
		|42.4|	Pasek narzędzi i menu kontekstowe

|usr_43.txt|  Typy plików
		|43.1|	Wtyczki dla typów plików (ftplugin)
		|43.2|	Dodawanie typu pliku

|usr_44.txt|  Tworzenie własnego schematu podświetlania
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

|usr_45.txt|  Wybór języka
		|45.1|	Język komunikatów
		|45.2|	Język menu
		|45.3|	Używanie innych kodowań
		|45.4|	Pliki z różnymi kodowaniami
		|45.5|	Wprowadzanie specyficzne dla języka

==============================================================================
Uruchamianie Vima ~

Zanim będziesz mógł użyć Vima.

|usr_90.txt|  Instalacja Vima
		|90.1|	Unix
		|90.2|	MS-Windows
		|90.3|	Uaktualnianie programu
		|90.4|	Zwykłe problemy przy instalacji
		|90.5|	Odinstalowywanie Vima

==============================================================================

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
