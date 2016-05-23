######################################################  W Domu ###############################################################
install.packages("RGtk2")
install.packages("gWidgetsRGtk2", dep=TRUE)
install.packages("pmg", dep=TRUE)
install.packages("MASS")
options(guiToolkit = "RGtk2") # Aby każdy element tworzony wiedział,że ma się otwierać z biblioteką RGtk2
library(gWidgets)
library(MASS)
# Powinno też wyskoczyć pytanie o instalacje GTK+. Trzeba też to zainstalować

############################################################ Zaczynamy #################################################################
## Lista podstawowych elementów, które przydadzą się do tworzenia GUI. W tym momencie większość z nich jest bezużyteczna
## i jedyne co robi to się wyświetla. Służy to temu byśmy mogli zaznajomić się z różnymi klockami z których można zbudować interfejs,
## pod koniec skryptu jednak będziemy już je pełnoprawnie wykorzystywać

# Proste okienko informacyjne, Wypisuje nam wiadomość, Zmieniamy też tytuł okienka
gmessage("Hello world", title="Powitanie") 

# Okno z informacją o błędzie. Poprzez zmienną icon możemy zmieniać wyświetlany znak
gmessage("Błąd !", title="Uwaga", icon="error") 

# Podstawowe okno z wpisaniem danych , zmienna text odpowiada za to co będzie przekazane do programu
# jeśli klikniemy OK, możemy jej zadać wartość inicjalną
ginput("Jaka jest Twoja ulubiony samochód ?",text="Opel Astra", title="ginput", icon="question") 

# Okno, które daje 0-1 odpowiedź, tak lub nie. (Ok lub Cancel)
gconfirm("Czy chcesz uczestniczyć w warsztatach koła Data Science", title="gconfirm", icon="question") 

# Interaktywne przeglądanie folderów, zależnie od tego jaka wartość jest przy type, to po wybraniu 
# pliku dzieją się inne rzeczy"
gfile(type="open")
gfile(type="save")
setwd(gfile(type="selectdir")) # Ustawienie directory przy użyciu gfile

# Przycisk, który póki co służy tylko do klikania. Border tworzy lub usuwa ramkę (domyślnie tworzy)
# cont od słowa container, będzie na mówić gdzie w interfejsie ma znaleźć się dany element
# Póki nie mamy większego interfejsu a wyświetlamy tylko okno, wstawiamy wartość TRUE.
gbutton("Najbardziej bezwartościowy przycisk",border=F,cont=T) 

# Przyciski czasem mają ikony, np. "Ok" , tutaj możemy obejrzeć jak wygląda border =T
gbutton("ok",cont=T)  

# Prosta komenda do wypisywania tekstu
glabel("Prosta komenda do wypisywania tekstu", cont=T) 

# Jednolinijkowe okno do wpisania tekstu. W initial.msg wpisujemy podpowiedź dla użytkownika
# co powinien wpisać w to miejsce ( oczywiście możemy też nic nie wpisywać)
gedit(initial.msg="Jakie auto chcesz sprzedać ?", cont=T) 

# To samo co gedit tylko wielolinijkowe. Nie zapomnijmy o wartościach estetycznych programu.
# Możemy zmieniać wymiary okna za pomocą width i height, niestety nie dotyczy to wszystkich komend
gtext("Wypowiedz się o moim Oplu",width=1000,height=400,cont=TRUE) 

# Checkbox z jedną wartością do zaznaczenia. W use.togglebutton zmieniamy formę zaznaczenia
# Jeśli false to zaznaczamy ptaszkiem, jeśli T to wciskamy lub 'odciskamy' opcję
gcheckbox("Opel Astra", cont=TRUE)
gcheckbox("Opel Astra",use.togglebutton = T,cont=TRUE)

# gradio jest to wieloargumentowy checkbox z jedną opcją do wyboru. Przyjmuje wektor wartości do wybrania.
# Opcja selected wskazuję, która wartość jest zaznaczona początkowo ( wadą jest, że któraś musi,
# więc jeśli chcemy by można było nie zaznaczyć niczego, musimy wstawić kilka checkboxów) docelowo 
# zaznaczona jest pierwsza. Opcja horizontal wskazuje jak ustawione będą wartości pionowo czy poziomo
gradio(c("Opel Astra", "Golf II", "BMW 3"),selected=2,horizontal=T, cont=TRUE) 
gradio(c("Opel Astra", "Golf II", "BMW 3"),cont=TRUE)

# Teraz wieloargumentowy checkbox z wieloma argumentami do wyboru.
# Wektor checked mówi które mają być początkowo zaznaczone (czasem się przydaję, bo opcja jest zazwyczaj
# zaznacza, a tworzymy GUI by mniej klikać). use.table zmienia nam format wyświetlania
gcheckboxgroup(c("Opel Astra", "Golf II", "BMW 3"),checked=c(T,T,F),use.table=T,cont=TRUE) 
gcheckboxgroup(c("Opel Astra", "Golf II", "BMW 3"),use.table=F,cont=TRUE) 

# Wybór jednej z opcji za pomocą rozwijalnej listy. Zmienna editable pozwala edytować wartości. 
gdroplist(c("Opel Astra", "Golf II", "BMW 3"), cont=TRUE) 
gdroplist(c("Opel Astra", "Golf II", "BMW 3"), editable=TRUE, cont=TRUE) 

# Kolejna forma wyboru wartości. Tabela na której zaznaczamy co chcemy wybrać. Z ctrl możemy kilka
# jeśli opcja multiple ma wartość T
gtable(c("Opel Astra", "Golf II", "BMW 3"), multiple=TRUE, cont=TRUE) 

# Przy wielokolumnowych opcjach dochodzi funckja chosencol. Jeśli nasza tabela będzie służyła do wypisywania
# wartości to naciskając dany wiersz, opcja chosencol wskazuje, które kolumny z tego wiersza zostaną wypisane
gtable(mtcars, chosencol=6, multiple=TRUE, cont=TRUE) 

# Funkcja do edytowania dataframów
gdf(Cars93, cont=TRUE) 

# Pierwsza opcja z 'rodziny suwaków' dzięki którym możemy wybierać wartości liczbowe.
# from, to, by , czyli od, do, co ile. istnieje również funckja length.out w której wybieramy liczbę kroków
# lub along.with która daje tyle kroków ile wynosi długość parametru along.with  naraz może być tylko 1 
# by, length.out lub along.with). Opcja value to początkowa wartość
gslider(from=1990, to = 2016, by = 1,value=2000, cont=TRUE) 

# Inaczej wyglądjący suwak. Istnieje opcja digits mówiąca ile ma wyśiwetlać 
# cyfr po przecinku
gspinbutton(from=0, to = 300000, by = 10000 ,digits=2, cont=TRUE) # Inny typ "suwaka"

# Przechodzimy do prostego okna graficznego.
ggraphics(width=150,heigth=100,cont=TRUE) 
hist(rnorm(100))

# Przechodzimy teraz do jednego z ostanich zagadnień. Na podstawie elementu paska narzędzi 
# przedstawimy działanie handlerów, czyli funkcji działających np. po przyciśnięciu przycisku
# Zacznijmy od stworzenia 3 funkcji printujących.
o = function(h,...) print("Openuje") 
n = function(h,...) print("Newuje") 
q = function(h,...) print("Closuje") 
# funckja tworząca paski narzędzi, przyjmuje jako wejście listę. Lista składa się z definicji kolejnych okienek
# które będą w tym pasku narzędzi. Każda definicja to nazwa, ikona oraz handler,który definiuje nam co 
# przyciśnięcie tego przycisku będzie robić. 
pasek=list(open = list(handler=o, icon="open"), new  = list(handler=n, icon="new"), quit = list(handler=q, icon="close"))
gtoolbar(pasek, cont=TRUE) # Odpalamy toolbar i widzimy, że jak klikamy na przycisk to printuje

# Oprócz paska narzędzi możemy robić bardziej skomplikowane menu.
# Zaczynamy znowu od stworzenia kolejnych funckji
cu = function(h,...) print("Cutuje") 
co = function(h,...) print("Copyuje") 
#Tym razem robimy zagnieżdżone listy w listach. Jedna File zawiera narzędzia z poprzedniego toolbara.
# Kolejna Edit to nowe przed chwilą zdefiniowane funckje.
pasek.rozwij = list(File=list(open = list(handler=o,icon="open"), quit = list(handler=q,icon="close")) ,
             Edit = list(cut  = list(handler=cu), copy = list(handler=co)))
# Jak widać menu, może być naprawdę skomplikowane
gmenu(pasek.rozwij, cont=TRUE)  

# Teraz przejdziemy do okienka przeglądającego enviroment, klikając podwójnie na jakiś rekord
# funckja ta wykonuje nad elementem funckję podanną w zmiennej action. Domyślnie summary.
wektor<-c(1,2,3)
gvarbrowser(cont=TRUE) # Dla wektora poda summary
gvarbrowser(action="mean",cont=TRUE) # Dla wektora poda 2

# Teraz zobaczymy, że można wywoływać automatycznie, niektóre funckje
srednia<-NULL
ggenericwidget("mean", cont=TRUE) 
# wpisać x = wektor , assing = srednia. 
# Po wciśnieciu ok możemy wywołać średnią by zobaczyć, że policzyło
srednia
# dla heheszków jak wpiszemy wpiszcie to samo, lecz w argumencie [1:2]
ggenericwidget("mean", cont=TRUE) 

# Jedną z najważniejszych rzeczy, jest sczytywanie wartości ustawionych poprzez gadżety nauczone do tej pory
# Aby tego robić najpierw przypisujemy dany element do jakiejś zmiennej. W poniższym przypadku zmienna b
# będzie w sobie zawierała wyniki z gradio. Odpalmy gradio.
b <- gradio(c("Opel Astra", "Golf II", "BMW 3"), cont=TRUE) 
# Widzimy, że domyślnie zaznaczona jest pierwsza wartość.
# Spróbujmy ją wyciągnąć
svalue(b)    
# Otrzymaliśmy zaznaczoną wartość. Następnie przypiszemy zaznaczenie innej opcji
svalue(b) <- "Golf II"   
# W otwartym okienku możemy zauważyć zmianę, również znowu możemy wypisać
svalue(b) # Wszystko ok
# Jeśli nie chce nam przepisywać się nazw możemy zrobić to po indeksie
svalue(b,index=TRUE) <- 1 
svalue(b) # Widzimy, ze znowu Opel Astra
# Sam wektor b, bez komendy svalue przechowuje wszystko możliwości
b[1:3] 
# Możemy je zmieniać
b[1] <- "Opel Corsa"         
b[1:3] # Zmieniło się również w okienku

# Powrócmy jednak na koniec znowu do przypisywania akcji do danych elementów. Można to robić na 2 
# sposoby, zacznijmy od wcześniej już wspomnianego handlera. Nasz przycisk nie jest już bezużyteczny
gbutton("Tycnij mnie", cont=TRUE, handler = function(h,...) print("tyc")) 
# Możemy również wykorzystać przypisywaniej wartości opisane przed chwilą. Czy wiecie co się stanie ?
gbutton("Kto to przyciśnie ten fajny", cont=TRUE, handler = function(h,...) svalue(h$obj) <- "Jesteś fajny") 
# Wrócmy jednak do funckji gtable. Wcześniej tylko przeglądaliśmy mtcars. Teraz zrobimy coś użytecznego
# przyda nam się też opisana wcześniej funckja chosencol. Podwójne kliknięcie wypisze z danego wiersza 
# wybrane kolumny
gtable(mtcars, chosencol=1:6, multiple=TRUE, cont=TRUE, handler = function(h,...) print(svalue(h$obj))) 

# Na sam koniec skorzystamy z najczęściej używanej funckji addHandlerChanged. Wpisuję się ją po utworzeniu całego
# interfejsu. Dlatego podczas działania okienka możemy dopisać kolejne funkcje
# Stwórzmy więc zwykłe okno tekstowe
e = gedit("text", cont=TRUE) 
# Do wartości e przypisujemy handler, który przy każdym wciśnietym przycisku wywołuje funckje
addHandlerKeystroke(e, function(h,...) print("Wcisnąłem przycisk")) # 
addHandlerChanged(e, function(h,...) print("Enter to też przycisk, więc")) # To się wyświetli gdy klinkiemy coś w konsoli

# Przedstawiłem tu większość podstawowych elementów. Przejdziemy teraz do budowania 'poważniejszych' interfejsów
# Jeśli chciałbyś poznać większe możliwości tego pakietu. To polecam 2 strony:

#       https://cran.r-project.org/web/packages/gWidgets/gWidgets.       tutaj znajdziemy opis tej biblioteki.

#       https://www.r-project.org/conferences/useR-2007/program/presentations/verzani-1.pdf  Prezentacja twórcy tej biblioteki
#       na której wzorowany jest ten warsztat.

################################################ Budowanie interfejsu #######################################################

# W tym miejscu budowana będzie pierwszy interfejs na zajęciach. Dla osób nieuczestniczących zostanie po warsztatach wrzucona
# wersja z wpisanym kodem tutaj.

# W poprzednim przykładzie użyliśmy tylko jednej funckji gtable, co jeśli chcemy wstawić wykres, miejsce 
# do wczytywania danych, suwaki itp ?
# Teraz nauczymy się jak tworzyć okna i wypełniać je różnymi elementami
# Zacznijmy od stworzenia okna przy pomocy funckji gwindow
win = gwindow("Button box")
# Teraz dodajemy 2 przyciski, tym razem w końcu wykorzystamy opcję cont, czyli przypiszemy przycski
# do danego okna
gbutton("cancel", cont=win)
gbutton("ok", cont=win)

# Możemy też wykorzystać funckję ggroup do której dodamy te same przyciski.
# Przy okazji zrobimy przerwę pomiędzy przyciskami za pomocą addSpring
win = gwindow("Button box") 
g = ggroup(cont = win)
gbutton("cancel", cont=g)
addSpring(g)
gbutton("ok", cont=g)

# Zaznaczenie funckji expand=T 
win = gwindow("Button box")
g = ggroup(cont = win)
gbutton("cancel", cont=g, expand=T)
gbutton("ok", cont=g)

# Przy pomocy glayout możemy precyzować położenie 
win = gwindow("glayout") 
tbl = glayout(cont=win)
tbl[1,1] <- gbutton("1,1", cont=tbl)
tbl[1,2:3] <- gbutton("1,2:3", cont=tbl)
tbl[2:3,1:2] <- gbutton("2:3,1:2\n", cont=tbl)
tbl[2:9,10] <- gbutton("2:9,10", cont=tbl)
visible(tbl) <- TRUE  

# Opcja gnotebook tworzy kolejne zakładki
win = gwindow("gnotebook") 
nb = gnotebook(cont=win)
gbutton("button", cont=nb, label = "tab label")
gbutton("button 2", cont=nb, label = "tab label 2")

# W jednej grupie możemy stworzyć kilka framów
win = gwindow("gframe") 
gp = ggroup(cont=win)
g = gframe("Text label", cont=gp)
gbutton("click me", cont=g)

# gexpand group umożliwia stworzenie chowanego frame
win = gwindow("gexpandgroup") 
g = gexpandgroup("Click to toggle", cont=win)
gbutton("click me", cont=g)

# opcja panedgroup to nic innego jak tworzenie kilku grup obok siebie
win = gwindow("gpanedgroup") 
pg = gpanedgroup(cont=win)
gbutton("button 1", cont=pg)
gbutton("button 2", cont=pg)

# W tym miejscu będą znowu kodowane przykłady na żywo. Oraz zadane zadanie do zrobienia. W wersji po warsztatych
# zostaną wpisane tutaj te kody.

################################################ Wykorzystanie biblioteki pmg ######################################################
# upewnij się że jest zainstalowana ta biblioteka. PMG to skrót od Poor Man GUI. Ta sama osoba, która tworzyła poprzednią bibliotekę
# stworzyła uproszczony gotowy interfejs. Wystarczy użyć poniższej komendy i możemy odkrywać tę bibliotekę interaktywnie
require(pmg)
# Osoby, które nie będą uczestniczyły w warsztatach, mogą wzorować się na prezentacji twórcy:
#       https://www.r-project.org/conferences/useR-2007/program/presentations/verzani-2.pdf

################################################# Niespodzianka jeśli starczy czasu ###################################################







