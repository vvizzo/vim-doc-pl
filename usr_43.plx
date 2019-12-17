*usr_43.txt*	For Vim version 6.3.  Last change: wt maj 19 20:00 2004 C ł

		VIM PODRĘCZNIK UŻYTKOWNIKA - by Bram Moolenaar
			   tłum. Mikołaj Machowski

		      Używanie typów plików (filetypes)


Kiedy edytujesz plik określownego typu, na przykład C lub skrypt powłoki,
często używasz tego samego zestawu opcji lub mapowań. Szybko się zmęczysz ich
ręcznym ustawianiem za każdym razem. Ten rozdział wyjaśnia jak robić to
automatycznie.

[MM: Będę używał angielskiego terminu filetype]

|43.1|	Wtyczki dla filetype
|43.2|	Dodawanie filetype

 Następny rozdział: |usr_44.txt|  Tworzenie własnego schematu podświetlania
Poprzedni rozdział: |usr_42.txt|  Dodawanie nowych menu
       Spis treści: |usr_toc.txt|

==============================================================================
*43.1*	Wtyczki dla filetype  				*filetype-plugin*

Jak zacząć używać wtyczek filetype zostało opisane tu: |add-filetype-plugin|.
Prawdopodobnie jednak nie jesteś usatysfakcjonoway domyślnymi ustawieniami
ponieważ są bardzo ograniczone (umyślnie). Przypuśćmy, że dla plików C chcesz
ustawić opcję 'softtabstop' na 4 i zdefiniować mapowanie dla wstawienia
3 linijkowego komentarza. Możesz to zrobić w dwóch krokach:

							*your-runtime-dir*

1. Stwórz własny katalog runtime. Na systemach uniksowych jest to zazwyczaj
   "~/.vim". W tym katalogu utwórz katalog "ftplugin": >

	mkdir ~/.vim
	mkdir ~/.vim/ftplugin
<
   Jeśli nie używasz Uniksa, sprawdź wartość opcji 'runtimepath' by zobaczyć
   gdzie Vim będzie szukał katalogu "ftplugin": >

	set runtimepath
<
   Normalnie powinieneś skorzystać z pierwszego katalogu (przed pierwszym
   przecinkiem). Możesz również dodać nazwę katalogu do opcji 'runtimepath'
   w twoim pliku |vimrc| jeśli nie podoba ci się domyślna wartość.

2. Stwórz plik "~/.vim/ftplugin/c.vim", z zawartością: >

	setlocal softtabstop=4
	noremap <buffer> <LocalLeader>c o/**************<CR><CR>/<Esc>

Zacznij teraz edycję pliku C. Powinieneś zaobserwować, że opcja 'softtabstop'
jest teraz ustawiona na 4. Ale jeśli będziesz edytował inny plik zostanie ona
zresetowana do domyślnego ). Dzieje się tak dzięki użytej komendzie
":setlocal". Ustawia ona opcję 'softtabstop' wyłącznie lokalnie dla bufora.
Jak tylko zaczniesz edytować plik w innym buforze zostanie ona ustawiona na
wartość właściwą temu buforowi. Dla nowego bufora uzyska domyślną wartość lub
wartość z ostatniego polecenia ":set".

Podobnie mapowanie dla "\c" zniknie podczas edycji innego bufora. Komenda
":map <buffer>" tworzy mapowanie, które jest lokalne dla bieżącego bufora.
Działa to dla dowolnej komendy mapującej: ":map!", ":vmap", etc.
|<LocalLeader>| w mapowaniu jest zastąpiony przez wartość "maplocalleader".

Przykłady wtyczek filetype możesz znaleźć w katalogu: >

	$VIMRUNTIME/ftplugin/

Więcej szczegółów o pisaniu wtyczek filetype znajduje się tu:
|write-plugin|.

==============================================================================
*43.2*	Dodawanie filetype

Jeśli używasz typu pliku, który nie jest rozpoznawany przez Vima wyjaśnimy tu
jak możesz go rozpoznać. Potrzebujesz własnego katalogu runtime. Sprawdź
|your-runtime-dir| powyżej.

Utwórz plik "filetype.vim", który będzie zawieraż autokomedy dla twojego typu
pliku. (Autokomendy zostały opisane w sekcji |40.3|.) Przykład: >

	augroup filetypedetect
	au BufNewFile,BufRead *.xyz	setf xyz
	augroup END

Spowoduje rozpoznanie wszystkich plików zakończonych na ".xyz" jako typ pliku
(filetype) "xyz". Komenda ":augroup" kwalifikuje tę autokomendę do grupy
"filetypedetect". Pozwala również usunąć wszystkie autokomedy dla detekcji
typu pliku przez ":filetype off". Komenda "setf" ustawi opcję 'filetype' dla
tego argumentu jeśli nie stało się to wcześniej. Upewnie się również, że
'filetype' nie zostało ustawione dwukrotnie.

Możesz ustalić wiele różnych sposobów dla ustalenia nazwy twojego pliku. Można
do tego celu użyć również nazw katalogów. Sprawdź |autocmd-patterns|. Na
przykład pliki w katalogu "/usr/share/scripts/" wszystkie będą plikami "ruby"
nawet nie mając spodziewanego rozszerzenia. Dodaj to do przykładu powyżej: >

	augroup filetypedetect
	au BufNewFile,BufRead *.xyz			setf xyz
	au BufNewFile,BufRead /usr/share/scripts/*	setf ruby
	augroup END

Jednak jeśli edytujesz plik /usr/share/scripts/README.txt nie jest to plik
ruby. Niebezpieczeństwo wzorca kończącego się "*" jest takie, że może
dopasować zbyt wiele plików. By uniknąć problemów z tym związanych wstaw plik
filetype.vim do innego katalogu, tego, który znajduje się na końcu
'runtimepath'. Na przykład dla uniksów powinieneś użyć
"~/.vim/after/filetype.vim".
   Teraz możesz wstawić wykrywanie plików tekstowych w ~/.vim/filetype.vim: >

	augroup filetypedetect
	au BufNewFile,BufRead *.txt			setf text
	augroup END

Ten plik zostanie znaleziony najpierw w 'runtimepath'. Teraz użyj tej grupy
w ~/.vim/after/filetype.vim, która zostanie znaleziona na końcu: >

	augroup filetypedetect
	au BufNewFile,BufRead /usr/share/scripts/*	setf ruby
	augroup END

Co się teraz stanie? Vim będzie po kolei szukał plików "filetype.vim" w każdym
z katalogów w 'runtimepath'. Najpierw zostanie znalezione ~/.vim/filetype.vim.
Autokomenda wyłapująca pliki *.txt jest tu zdefiniowana. Później Vim znajduje
plik filetype.vim w $VIMRUNTIME, który jest w połowie 'runtimepath'.
Ostatecznie znajdowany jest ~/.vim/after/filetype.vim i autokomenda do
wykrywania plików ruby w /usr/share/scripts zostaje dodana.
   Kiedy teraz edytujesz plik /usr/share/scripts/README.txt, autokomendy są
sprawdzone w kolejności w jakiej zostały zdefiniowane. Wzorzec *.txt pasuje,
więc wykonywane jest "setf text" by ustawić typ pliku na "text". Wzorzec dla
ruby też pasuje, więc wykonywane jest "setf ruby". Ale ponieważ 'filetype'
zostało już ustawione na "text" nic się nie dzieje.
   Kiedy edytujesz plik /usr/share/scripts/foobar sprawdzane są te same
autokomendy. Pasuje tylko ta dla ruby i "setf ruby" ustawia 'filetype' na
ruby.


ROZPOZNAWANIE POPRZEZ ZAWARTOŚĆ

Jeśli twój plik nie może być rozpoznany porzez jego nazwę, może być rozpoznany
porzez swoją zawartość. Na przykład wiele skryptów zaczyna się podobną linią:

	#!/bin/xyz ~

By rozpoznać ten skrypt stwórz plik "scripts.vim" w twoim katalogu runtime (to
samo miejsce gdzie został umieszczony filetype.vim). Może on wyglądać tak: >

	if did_filetype()
	  finish
	endif
	if getline(1) =~ '^#!.*[/\\]xyz\>'
	  setf xyz
	endif

Po pierwsze sprawdza on przed did_filetype() czy nie został już ustalony typ
pliku. Uniak się w ten sposób marnowania czasu na sprawdzanie pliku gdy
"setf" nic już nie zrobi.
   Plik scripts.vim jest wczytywany poprzez autokomendę w domyślnym pliku
filetype.vim. Stąd kolejność sprawdzania jest następująca:

	1. pliki filetype.vim przed $VIMRUNTIME w 'runtimepath'
	2. pierwsza część $VIMRUNTIME/filetype.vim
	3. wszystkie pliki scripts.vim w 'runtimepath'
	4. pozostała część $VIMRUNTIME/filetype.vim
	5. plii filetype.vim po $VIMRUNTIME w 'runtimepath'

Jeśli nie jest to wystarczające, dodaj autokomendę, która dopasowuje wszystkie
pliki i wykonuje skrypt lub funkcję by sprawdzić zawartość pliku.

==============================================================================

Następny rozdział: |usr_44.txt|  Tworzenie własnego schematu podświetlania

Copyright: see |manual-copyright|  vim:tw=78:ts=8:ft=help:norl:
