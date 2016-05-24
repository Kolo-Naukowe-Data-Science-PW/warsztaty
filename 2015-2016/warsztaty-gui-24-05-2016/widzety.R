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

# Będziemy chcieli stworzyć funkcję do przeglądania dostępnych bibliotek oraz ich ładowania lub wyłączania
# Docelowo będzie to gtable, który jako itemy przyjmuje listę z nazwą dostępnych bibliotek
# oraz True jeśli jest załadowana i False jeśli nie, a jako handler funckję która po podwójnym kliknięciu 
# dołączy nam bibliotekę i zmieni wartość z T na F i na odwrót, zależnie od działania

# Zacznijmy od stworzenia funckji która ściągnie 
getPackages = function(...) {
    # Przypisujemy do tej zmiennej listę wszystkich dostępnych bibliotek
    allPackages = .packages(all.available=TRUE)
    # operator %in% zwraca wektor logiczny, który jeśli znajdzie element występujący
    # w .packages() w allPackages to przypisuje mu TRUE jeśli nie to FALSE
    # Dla przykładu c(1,2,3) %in% 1 zwróci TRUE FALSE FALSE
    loaded = allPackages %in% .packages()
    # Tworzymy teraz oczekiwanego data frame
    data.frame(Package=allPackages,loaded=loaded,
               stringsAsFactors=FALSE)
}
# dla zobaczenia wyników można puścić komendę getPackages

# Przechodzimy teraz do tworzenia handlera
packageHandler = function(h,...) {
    # Wpierw pobieramy wszystkie wybrane biblioteki, bez drop=F dostalibyśmy tylko ich nazwy
    # a tak razem z informacją o załadowaniu
    packages = svalue(h$obj, drop=FALSE) 
    # Tutaj musimy zastosować pętle bo użytkownik może zaznaczyć kilka bibliotek 
    for(i in 1:nrow(packages)) {
        if(packages[i,2] == TRUE) { # Jeśli biblioteka jest załadowana to
            # Tworzymy nazwę package:nazwa biblioteki
            pkg = paste("package:",packages[i,1],sep="")
            # I detachujemy
            detach(pos = match(pkg, search()))
        } else { # Jeśli bibliotek nie jest załadowana
            require(packages[i,1], character.only=TRUE) # To ją dodajemy
        }
    }
    #  Na końcu robimy aktualizację listy (zmienią nam się True na Falsy i na odwrót)
    h$obj[,] = getPackages() 
}

# Pozostaje nam tylko napisać ostateczny gtable
packageList = gtable(
    items = getPackages(),
    sort.columns = 1:2,
    handler = packageHandler,
    container = TRUE
)
# I puścić cały kod od początku tego zagadnienia. Możemy interaktynie ładować biblioteki


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

#W tym momencie jesteśmy gotowi na prawdziwe interfejsy !!!!
# Pierwszym naszym tworem będzie interaktywne rysowanie funckji kwadratowej
# Tworzymy okno
win = gwindow("Funkcja kwadratowa")
# Następnie umieszczamy w nim paned group, czyli miejsce na kilka grup obok siebie
pg = gpanedgroup(cont=win)  
# Pierwsza grupa będzie odpowiadała za wczytywanie współczynników do funckji
gg.arg = ggroup( cont=pg)
# Druga grupa będzie odpowiedzialna za bieżące rysowanie wykresów funckji
gg.plot =ggroup( cont=pg)
# gstatusbar jest czymś podobnym do paska statusu w przeglądarkach lub paska 
# podpowiedzi w programach. Uwaga na container
gstatusbar("Ustaw współczynniki funkcji kwadratowej",cont=win)

# Zajmijmy się tworzeniem okna do wczytywania współczynników a,b,c
# Najpierw tworzymy frame, który oddzieli nam miejsce od wpisywania
gg.arg.f=gframe("Współczynniki funkcji kwadratowej",cont=gg.arg)
# PRzechodzimy do layoutu
tbl = glayout(cont=gg.arg.f)
# Tworzymy 3 suwaki to ustawiania wartości parametrów. 
tbl[1,1, anchor=c(1,0)] <- "a"
tbl[1,4:20] <- (a<-gslider(from= (-3), to = 3, by = 0.1, cont=tbl))
tbl[8,1, anchor=c(1,0)] <- "b"
tbl[8,4:20] <- (b<-gslider(from= (-3), to = 3, by = 0.1, cont=tbl))
tbl[16,1, anchor=c(1,0)] <- "c"
tbl[16,4:20] <- (c<-gslider(from= (-3), to = 3, by = 0.1, cont=tbl))
# W tym momencie możemy już odpalić napisaną część i pozmieniać ułożenie

# Przechodzimy do tworzenia grame na grafikę
gg.plot.f=gframe("Wykres",cont=gg.plot)
gg<-ggraphics(cont=gg.plot.f)
visible(gg)<-T

# Wygląd interfejsu jest gotowy. Teraz trzeba dopisać jego funkcjonalności
# Zacznijmy od funkcji która sczyta wartości parametrów i jako wyjście 
# przekaże x i y
take.arguments<-function(...){
    x<-seq(-5,5,0.1) # Dobrane przykładowo
    l<-list(x,y=(svalue(a)*x^2+svalue(b)*x+svalue(c)))
    return(l)
}

# Dodajemy pierwszy handler, który na zmianę parametru a narysuje wykres
# zauważmy że zmienna a jest przypisana do suwaka pierwszego 
ID<-addHandlerChanged(a, handler=function(h,...) {
    l<-take.arguments()
    plot(x=l[[1]],y=l[[2]],xlim=c(-5,5),ylim=c(-5,5),xlab="x",ylab="ax^2+bx+c")
})
# To samo dla parametru b
ID.2<-addHandlerChanged(b, handler=function(h,...) {
    l<-take.arguments()
    plot(x=l[[1]],y=l[[2]],xlim=c(-5,5),ylim=c(-5,5),xlab="x",ylab="ax^2+bx+c")
})
# I c
ID.3<-addHandlerChanged(c, handler=function(h,...) {
    l<-take.arguments()
    plot(x=l[[1]],y=l[[2]],xlim=c(-5,5),ylim=c(-5,5),xlab="x",ylab="ax^2+bx+c")
})
# Odpalamy cały napisany kod i odkrywamy za co odpowiadają czynniki przy funkcji kwadratowej

# Poniższy zadanie podczas warsztatów zostało zadane jako zadanie do zrobienia.
# Przedstawiam swoje rozwiązanie.
# Należy napisać program, który pobiera w różny sposób wektor x i y. Program  ma mieć 3 przyciski
# po kliknięciu jednego jest rysowany wykres y od x i narysowaywana linia regresji, po kliknięciu
# 2 mają się pojawić wykresy dopasowania regresji, a po 3 ma się wyświetlać w danych okienkach
# wartości wyrazu wolnego i współczynnika lini regresji, oraz wartość r-kwadrat

win = gwindow("Regresja liniowa")
pg = gpanedgroup(cont=win,expand=T)

gg.data=ggroup(cont=pg)
gg.data.f=gframe("Zakres danych",cont=gg.data)
tbl = glayout(cont=gg.data.f)
tbl[1,1, anchor=c(1,0)] <- "X"
tbl[1,2:20] <- (a<-gdroplist(c(ls()), cont=tbl)) 
tbl[8,1, anchor=c(1,0)] <- "Y"
tbl[8,2:20] <- (b<-gedit(initial.msg="Tu wpisz dane y", cont=tbl))
tbl[14,10, anchor=c(1,0)] <-(c<-gbutton("Model liniowy",cont=tbl))
tbl[16,10, anchor=c(1,0)] <-(d<-gbutton("Wykresy dopasowania",cont=tbl))
tbl[18,10, anchor=c(1,0)] <-(e<-gbutton("Wyniki",cont=tbl))

gg.plot.f=gframe("Wykres",cont=pg)
gg.p<-ggraphics(cont=gg.plot.f)
visible(gg.p)<-T

gg.results.f=gframe("Wyniki",cont=gg.data)
tbl.1 = glayout(cont=gg.results.f)
tbl.1[5,1, anchor=c(1,0)] <- "Wyraz wolny"
tbl.1[5,2:5] <- (f<-gedit(cont=tbl.1))
tbl.1[7,1, anchor=c(1,0)] <- "Współczynnik przy X"
tbl.1[7,2:5] <- (g<-gedit(cont=tbl.1))
tbl.1[9,1, anchor=c(1,0)] <- "r-kwadrat"
tbl.1[9,2:5] <- (i<-gedit(cont=tbl.1))

take.arguments<-function(...){
    x<-eval(parse(text = svalue(a)))
    y<-eval(parse(text = svalue(b)))
    l<-list(x,y)
    return(l)
}
ID<-addHandlerChanged(c, handler=function(h,...) {
    l<-take.arguments()
    model<-lm(l[[2]]~l[[1]])
    plot(l[[1]],l[[2]])
    abline(model)
})
ID.2<-addHandlerChanged(d, handler=function(h,...) {
    l<-take.arguments()
    model<-lm(l[[2]]~l[[1]])
    par(mfrow=c(2,2))
    plot(model)
    par(mfrow=c(1,1))
})
ID.3<-addHandlerChanged(e, handler=function(h,...) {
    l<-take.arguments()
    model<-lm(l[[2]]~l[[1]])
    svalue(f)<-model$coef[[1]]
    svalue(g)<-model$coef[[2]]
    svalue(i)<-summary(model)$r.squared
})

# Przetestujmy teraz jakieś dane
x<-c(1,2,3,5,5,6,7,8,9,10)
y<-c(0,2,2,4,5,5,8,9,9,12)
# Odpalmy cały kod, pod x wstawmy x i pod y,y

################################################ Wykorzystanie biblioteki pmg ######################################################
# upewnij się że jest zainstalowana ta biblioteka. PMG to skrót od Poor Man GUI. Ta sama osoba, która tworzyła poprzednią bibliotekę
# stworzyła uproszczony gotowy interfejs. Wystarczy użyć poniższej komendy i możemy odkrywać tę bibliotekę interaktywnie
require(pmg)
# Osoby, które nie będą uczestniczyły w warsztatach, mogą wzorować się na prezentacji twórcy:
#       https://www.r-project.org/conferences/useR-2007/program/presentations/verzani-2.pdf

################################################# Niespodzianka jeśli starczy czasu ###################################################