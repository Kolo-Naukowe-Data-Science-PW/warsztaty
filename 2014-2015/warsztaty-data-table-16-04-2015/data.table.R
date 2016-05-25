##################### Warsztaty data.table ##########################
##################### Krzysztof Rudaś ############################ 

#Zacznijmy od ramek danych

#implementacja

df<-data.frame(A=c("a","a","b","b","c","d","d","d"),B=c(1,2,3,4,4,3,2,5),C=c(5,5,5,3,2,1,2,2))
df

#dlugosci kolumn muszą być takie same

df1<-data.frame(A=c("a","a","b","b","c","d","d","d"),B=c(1,2,3,4,4,3),C=c(5,5,5,3,2,1,2))

#atrybuty
attributes(df)

#row.names muszą być unikatowe
attributes(df)$row.names=rep(0L,8)

df #błąd

#wracamy do unikatowych nazw
attributes(df)$row.names=1:8

df #teraz działa

#mamy klasę factorów dla kolumn typu character 
df$A
class(df[,1])

#remedium
df<-data.frame(A=c("a","a","b","b","c","d","d","d"),B=c(1,2,3,4,4,3,2,5),C=c(5,5,5,3,2,1,2,2),stringsAsFactors = FALSE)
df[,1]
class(df[,1])

#przegląd informacji

.Internal(inspect(df))

#a teraz data.table
install.packages("data.table")
library(data.table)

dt<-data.table(A=c("a","a","b","b","c","d","d","d"),B=c(1,2,3,4,4,3,2,5),C=c(5,5,5,3,2,1,2,2))
attributes(dt)
dt
#Jaka jest różnica w outputach?

#Nie są nam potrzebne nazwy wierszy.

#Czy kolumny stringów to faktory

dt$A
class(dt$A)

#Nie, nie trzeba bawić się w stringsAsFactors

#Przeglad

.Internal(inspect(dt))
length(dt)
truelength(dt) #100 #dłoguść wektora zaalokowanaw pamięci

#A mamy tylko trzy kolumny (przydatne przy wstawianiu nowych kolumn,
#nie trzeba tego robić dynamicznie).

#Podajcie kilka różnic między .Internal(inspect(x)) dla x=df i x=dt





#class
#truelength

#Jakie operacje można wykonywać na data.frame

#Wybór wierszy
df[df$A == "d",]

#Wybór kolumn
df[,c("A","B")]

#Ewentualnie jedno i drugie

df[df$A == "d",c("A","B")]

#Zadania nr.1

# 1. Wybrać wszystkie dane które mają wartość kolumny B >2 i <4
# 2. Policzyć średnią dla wartości kolumny B
# 3. Znaleźć wartość maksymalną dla wartości kolumny C, wsród tych obserwacji
#    które w kolumnie A mają wartość "d"







#1. 
df[df$B>2&df$B<4,]
#2.
mean(df[,"B"])
#3.
max(df[df$A=="d","C"])


# Podsumowujac dla ramek mamy mozliwość wyboru wierszy  i kolumn (df[i,j], 
# możemy manewrować i i j)

#A jak to jest w przypadku data.table
# mamy trzy argumenty (dt[i,j,by]) teraz po krótce opowiem za co każdy 
# odpowiada

# -i wybór wierszy na których będziemy pracować
# -j możemy wybierać i liczyć coś na kolumnach ale także je dodawać, usuwać,
# aktualizować
# -by grupowanie, np. chcemy policzyć średnią dla kolumny B, ale dla każdego 
# typu A oddzielnie

# przypomina SQL

# Korzyści:

# - szybciej operacje są wykonywane niż dla data.frame
# - prostota kodu




#Wiersze

dt[B == 2L] #wybiera te wiersze, które mają dla kolumny B wartość 2

df[df$B == 2L,]

#dla data.table zmiana naz wierszy

dt
#wyszukiwanie wiersza trzeciego i drugiego

dt[3:2]
df[3:2,]

#Wybór wiersza nr 4

df["4",]
dt["4"] #brak klucza (pozniej sie dowiemy o co chodzi)

library(PogromcyDanych)
dt1<-as.data.table(auta2012)
dt1 #wyświetla pięć pierwszych wierszy i pięć ostatnich (gdy liczba wierszy >100)

#Zadania 2

#1. wybrać te dane które dotyczą samochodów marki Volkswagen, które mają 
#   moc silnika >100
#2. Wybrać dane dotyczące marki Toyota, ale nie będące modelem Yaris
#3. Przebieg w km i pojemnośc skokowa dają w sumie wynik powyżej 180 000
#4. Wszystkie dane porządkowane po Cenie w kolejności rosnącej 
#   (przyda się funkcja order)
#5. Wszystkie dane porządkowane po Cenie w kolejności malejącej 
#   (przyda się funkcja order)
#6. Wybrać dane aut, które mają informację o Przebiegu






#1. 
dt1[Marka=="Volkswagen"&KM>100]
#2.
dt1[Marka=="Toyota"& Model!="Yaris"]
#3.
dt1[(Przebieg.w.km+Pojemnosc.skokowa)>180000]
#4.
dt1[order(Cena)]
#5.
dt1[order(-Cena)]
#6.
dt1[Przebieg.w.km>=0]


#Kolumny
#Wybór kolumny B
df[,"B"]

dt[,B]

#Wybór kolumny B, ale zapisz jako data.frame/data.table

df[,"B",drop=FALSE]

dt[,.(B)]

dt[,list(B)]

#Gdy więcej kolumn

df[,c("B","C")]

dt[,.(B,C)]

#Wybierzmy maksimum po kolumnie B

max(df[,"B"])

dt[,max(B)]

#Zadania 3

#1. Znajdź i wypisz jako wektor kolumnę Marka
#2. Znajdź i wypisz jako data.table kolumnę Model
#3. Wypisz data.table z kolumnami Marka,Model,Cena,Cena.w.PLN.(dokładnie w tej kolejności)
#4. Wypisz data.table z kolumnami Marka,Model, zmieniając nazwy na Marki,Modele
#5. Ile średnio złotych kosztuje samochód (w PLN)?




#1.
dt1[,Marka]
#2.
dt1[,.(Model)]
#3.
dt1[,.(Marka,Model,Cena,Cena.w.PLN)]
#4.
dt1[,.(Marki=Marka,Modele=Model)]
#5.
dt1[,.(CenaSr=mean(Cena.w.PLN))]


#Kolumny można wybierać również tak jak z data.frame

df[,"B",drop=FALSE]

dt[,"B",with=FALSE]

#Wiersze i kolumny

#Chcemy uzyskać sumę wartości kolumny B dla danych mających wartość "d" w kolumnie A

sum(df[df$A=="d","B"])

dt[A=="d",sum(B)]

#Zadania 4

#1. Zapisz w postaci wektora cenę wszystkich samochodów o roku produkcji 2006
#2. Zapisz w postaci tablicy danych informacje o marce i modelu dla mocy silnika=100
#3. Wylicz średnią cenę, dla wszystkich samochodów marki Volkswagen, ale nie mających
# modelu Golf
#4. Wylicz średnią z wektora różnic między ceną a ceną w PLN, dla Samochodów mających 
# moc silnika >100 i przebieg w km >150 000 i <200 000
#5. Oblicz różnicę między maksimum ceny dla Samochodów Volkswagen Golf, a minimum ceny
# Samochodów Opel Astra
#6. Oblicz sumę stu najniższych cen dla Fiatów 126
#7. Przedstaw za pomocą data.frameowego sposobu Modele samochodów Volkswagen i Toyota






#1.
dt1[Rok.produkcji==2006,Cena]
#2.
dt1[KM==100,.(Marka,Model)]
#3.
dt1[Marka=="Volkswagen"&Model!="Golf",mean(Cena)]
#4.
dt1[KM>100&150000<Przebieg.w.km&Przebieg.w.km<200000,mean(Cena-Cena.w.PLN)]
#5.
dt1[Marka=="Volkswagen"&Model=="Golf",max(Cena)]-dt1[Marka=="Opel"&Model=="Astra",min(Cena)]
#6.
d<-dt1[Marka=="Fiat"&Model=="126",.(Cena)]
d
d[order(Cena)[1:100],sum(Cena)]
#7.
unique(dt1[dt1$Marka=="Toyota"|Marka=="Volkswagen","Model",with=FALSE])

#grupowanie

#policzmy sumę elementów kolumny B dla każdego typu z kolumny A
dt
dt[,sum(B),A]

#a teraz to samo tylko dla wartości kolumny C>3

dt[C>3,.(Suma=sum(B)),A]

#Zadania 5
#1. Zlicz ile jest samochdoW dla każdego modelu.
#2. Oblicz srednią cenę dspośród cen minimalnych samochodów marki Toyota,
# dla każdego z modeli tej marki
#3. policz medianę cen dzieląc dane ze względu na markę i model



#1.
dt1[,length(Cena),Model]
#2.
d<-dt1[Marka=="Toyota",.(Cenamin=min(Cena)),Model]
d[,mean(Cenamin)]
#3.
dt1[,median(Cena),.(Marka,Model)]

#Nadawanie kolejności w grupowaniu

# Policzmy sumę dla kolumny B ze względu na kolumnę A 
# z zachowaniem porządku alfabetycznego dla grupy A

g<-data.table(A=c("b","a"),B=c(1,2))
g[, B, keyby=A]

#Łańcuchowanie

#Uporządkujmy w w innej kolejności

#Wracamy do dt
dt

dt[,.(B=sum(B)),A][order(-B)]

#Co ciekawe w argumencie by też możliwe są wyrażenia

dt[, sum(B),.(A=="a"|A=="b")]

#Można je nazywać
dt[, sum(B),.(pier=(A=="a"|A=="b"))]
dt1
#Zadania 6
#1. przedstaw średnie ceny dla każdego modelu Volkswagena 
# (modele mają być podane w kolejności alfabetycznej)
#2. Wyznacz 3 pierwsze marki z najwyższymi cenami samochodów
#3. Wyznacz średnie lat produkcji dla marki Volkswagen, grupując po modelach.p
#4. Znajdź maksymalną cenę dla samochodów pochodzących z Niemiec lub Polski
# i dla samochodów pochodzących z innych państw
#5. Znajdź średnia cenę dla każdej marki samochodu
# grupując dla każdej marki dodatkowo po roku produkcji 
# (interesują nas samochody wyprodukowane po 2008) 




#1.
dt1[Marka=="Volkswagen",mean(Cena),keyby=Model]
#2.
dt1[,.(B=max(Cena)),Marka][order(-B)][1:3,Marka]
#3.
dt1[Marka=="Volkswagen",mean(Rok.produkcji),keyby=Model]
#4.
dt1[,max(Cena),.(Kraj.pochodzenia=="Niemcy"|Kraj.pochodzenia=="Polska")]

#5.
d<-dt1[Rok.produkcji>2008]
dt1[Rok.produkcji>2008,mean(Cena),.(Marka,Rok.produkcji)]

#Agregacje po większej liczbie kolumn

#Chcemy policzyć średnie dla kolumn B i C dla każdego typu z kolumny A
#SD przechowuje wszystkie kolumny poza tymi używanymi w by
dt
dt[,lapply(.SD, mean),by=A]
#Można wybrać, które kolumny mają być w SD
dt[,lapply(.SD, mean),by=A,.SDcols=c("B")]

#Zadania 7

#1. Policz mediany dla Ceny i lat produkcji grupując po modelach.
# 
#2. Znajdź maksymalny (ze względu na cenę) wiersz dla każdej Marki, 
# marki niech będą posegregowane alfabetycznie




dt1[,lapply(.SD, median),by=Model,.SDcols=c("Cena","Rok.produkcji")]
dt1[,.SD[which.max(Cena)],keyby=Marka]

#Dodatki
#Coś jak tidyr

# Chcemy, żebywartości dla kolumn B i C były w jednej kolumnie, którą
# nazwiemy val, kolumna A daje nam literkę, która była pierwotnie 
# przyporządkowana do danej wartości

dt[, .(val=c(B,C))]#zle
dt[, .(val=c(B,C)),A]#ok

#Listy wartosci
dt[, .(list(c(B,C))),by=A]

#Dodawanie usuwanie, aktualizacja kolumn


#Dodawanie

#Na dwa sposoby
#1 sposób

(dt[, c("D") := list(rep(0,8))])
#2 sposób

(dt[, `:=`(D = rep(0,8) )])

#Aktualizowanie

#Chcemy podmienic wartosci kolumn C i D dla wierszy gdzie mamy "b" w kolumnie A
dt
(dt[A=="b", 3:4 := 2])
(dt[A=="b", `:=`(D = 2, C = 2)])

#Dodawanie kolumn z grupowaniem

(dt[,E:=mean(C)-max(D)+B,A])

#Usuwanie
dt[,E:=NULL]
dt
#Zadania 8 

#1. Dodaj nową kolumnę która policzy medianę dla cen aut ze względu na markę nazwij ją Mediana
#2. Dodaj nową kolumnę która policzy medianę dla cen aut ze względu na markę nazwij ją Srednia
#3. Dodaj nową kolumnę która zwraca większą wartość dla średniej (1) lub dla mediany (0) nazwij ja czy
#4. usun kolumnę czy.
#5. Zmien wartosci kolumn, mediana i srednia



#1.
dt1[,Mediana:=median(Cena),Marka]
#2.
dt1[,Srednia:=mean(Cena),Marka]
#3.
dt1[,czy:=mean(Cena)>median(Cena)]
#4.
dt1[,czy:=NULL]
#5.
temp<-dt1[,Srednia]
temp2<-dt1[,Mediana]
dt1[, `:=`(Srednia = temp2, Mediana = temp)]

#aktualizacja tabelek za pomocą set
# Zmiana wartosci
dt
set(dt, i=3:4, j=1L, value="Krzysiek")
# Zmiana nazwy kolumn
setnames(dt, "D","Dominika")
dt
#Zmiana kolejsnoći kolumn

setcolorder(dt, c("A", "C", "B"))#błąd trzeba podać wszystkie
setcolorder(dt, c("A", "C", "B","Dominika"))
dt

#Kolejnosc wierszy

setorder(dt, ‐A, B)
setorderv(dt, c("B", "C"), order=c(‐1L, 1L))

#Zadania 9

#1. Stworz kopię dt1 i nazwij ja dt2
#2. Wszystkie wartosci Volvo zmien na krzysiek
#3. Zamień kolumnę Marka na Rudas
#4. Zrob to tak aby Krzysiek był na wierzchu

#1.
dt2<-dt1
#2.
p<-which(dt2[,Marka]=="Volvo")
set(dt2,i=which(dt2[,Marka]=="Volvo"),j=7L, value="krzysiek")
#3.
setnames(dt2, "Marka","Rudas")
dt2
#4.
setorder(dt2, -Rudas)

#Klucze

dt<-data.table(A=c("b","a","b","c","d","d","b","a"),B=c(1,2,3,4,4,3,2,5),C=c(5,5,5,3,2,1,2,2))
#Wstawianie klucza
setkey(dt,A)
dt
#Gdzie klucz
key(dt)
attributes(dt)$sorted
#klucze mogą mieć nieunikatowe wartości
#Umożliwia nam stosowanie list i . na wierszach
d<-dt[list("c")]
key(d)#klucze są dziedziczone

#argument mult
dt
dt[.(c("a", "b")),mult="first"]
dt[.(c("a", "b")),mult="last"]

#Nic nie przeszkadza aby klucze były na więcej niż jednej kolumnie

setkey(dt, A, B)
#Fakultatywnie
setkeyv(dt, c("A", "B"))
dt
# Najpierw sortuje kolumnę A, a potem tam gdzie może kolumnę b

dt[.("b", 3)]
dt[.("b")]#jak nie podajemy drugiego to domyślnie
dt[.("b", 1:3)]
dt[.("a", 1:3)]#Tam gdzie nie ma wartosci C wyrzuca NA
# remedium
dt[.("a", 1:3),nomatch=0L]#usuwawiersze z NA
#Można normalnie po kolumnach przeglądać
dt[.("a"), .(A, B)]
#Z by też nie ma problemu
dt[.(c("d", "b")),sum(C), by=A]
#Wstawianie/aktualizacja kolumn też ok
dt[.(c("d", "b")),B := mean(B), by=A]
dt

#Zadania 10

#1. stwórz kopię dt1
#2. dodaj klucz na kolumny (marka,model)
#3. wyszukaj wszystkie samochody typu Volvo i wysumuj cenę po modelach
#4  wyszukaj Marki typu Volkswagen i Toyota i ich modele
#5. W powyższym Wybierz modele Yaris i Golf
#6. W powyższym zamień Yaris na Corolla

#1.
dt2<-dt1
#2.
dt1<-as.data.table(auta2012)
setkey(dt2,Marka,Model)
#3.
dt2[.("Volvo"),sum(Cena),Model]
#4.
dt2[.(c("Volkswagen","Toyota")),Model]
#5.
dt2[.(c("Volkswagen","Toyota"),c("Golf","Yaris"))]
#6.
d<-dt2[.(c("Volkswagen","Toyota"),c("Golf","Yaris"))]
p<-which(d[,Model]=="Yaris")
set(d,i=p,j=8L, value="Corolla")
d

#Łączenie z innymi tabelkami

dt<-data.table(A=c("b","a","b","c","d","d","b","a"),B=c(1,2,3,4,4,3,2,5),C=c(5,5,5,3,2,1,2,2))
#Wstawianie klucza
setkey(dt,A)
#Można dodawać listy, można też data.table
dtpom<-list(B=c("a","b"))
dt[dtpom]
#Dodajmy kolumnę, której nie ma
dtpom2<-list(B=c("a","b"),D=c(1,2))
dt[dtpom2]
dt[dtpom2, mult="first"]
#Dodajmy wiersz ktorego nie ma w pierwotnej
dtpom3<-list(B=c("a","b","q"),D=c(1,2,4))
dt[dtpom3]
dt[dtpom3, mult="first"]
dt[dtpom3, mult="first",nomatch=0L]
#Doczepianie wybranych kolumn
dtpom4<-data.table(A=c("a","b","q"),D=c(1,2,4),E=c(4,5,6))
dt[dtpom4, .(A, B, C,i.E)]
dt[dtpom4, E := i.E]
dt

#Zadania 11

dt<-data.table(A=c("b","a","b","c","d","d","b","a"),B=c(7,2,2,4,4,3,5,5),C=c(7,5,12,3,2,1,6,2))
dtpom4<-data.table(A=c("a","b","q"),D=c(1,2,4),E=c(4,5,6))

#1. Dodać klucz na A w dt
#2. Połączyć dwie dt z dtpom4
#3. Usunąć NA
#4. Wybrać te wiersze które nie są wspóne dla dt dtpom4 (antijoin)
#5. Do dt doczepić kolumnę D ale pozbyć się kolumny B

#1.
setkey(dt,A)
#2.
dt[dtpom4]
#3.
dt[dtpom4,nomatch=0L]
#4.
dt[!dtpom4]
#5.
dt[dtpom4,.(A,C,i.D)]
dt
#Rolling Joins
setkey(dt,A,B)
dt[.("b",4)] #W data table nie ma wiersza, ktory ma dla kolumny A wartosc "b" i dla koumny B wartosc 4 
# dlatego w C mamy NA

#Jak wypelnic NA?

dt[.("b",4),roll=Inf]#Daje ta wartosc dla C, ktora byla w wierszu, ktory dla koumny A ma "b" 
#i dla kolumny B ma wartośc najbliżej 4, ale mniejszą od niej
dt[.("b",4),roll=-Inf]#Daje ta wartosc dla C, ktora byla w wierszu, ktory dla koumny A ma "b" 
#i dla kolumny B ma wartośc najbliżej 4, ale wiekszą od niej
dt[.("b",4),roll="nearest"]#Daje ta wartosc dla C, ktora byla w wierszu, ktory dla koumny A ma "b" 
#i dla kolumny B ma wartośc najbliżej 4

#Overlapping Joins
dt<-data.table(A=c(10,22,39,31),B=c(18,24,45,33)) #tabela z przedzialami badanymi
subject<-data.table(A=c(11,21,15,41),B=c(20,30,40,50))# tabela z kontrolnymi przedziałami
setkey(subject,A,B)
setkey(dt,A,B)
foverlaps(dt, subject, type="within") #w których przedziałach kontrolnych znajdują się przedziały badane
