
# In[32]:

#### Typy zmiennych ####

### wszystkie wbudowane f-cje ###
### https://docs.python.org/2/library/functions.html

### wykonanie calego bloku:
### play na gorze lub Shift+Enter

## http://www.codeskulptor.org/#user39_a6JVgSOTty_3.py



## iterable:
## https://docs.python.org/2/glossary.html#term-iterable

## generator:
## https://docs.python.org/2/glossary.html#term-generator


# In[3]:

# 1. Liczby: int, long, float, complex

# int - liczby całkowite
12 + 14
12 - 4
15 * 4
15 / 4 # dzielenie calkowite!
15 // 4
2 ** 3 # potegowanie
5 % 3 # modulo
print type(123)
print type(-3)


# float
print type(123.0)
12.0 + 14.0
12.0 - 4 #konwersja typów
15.0 * 4.0
15.0 / 4.0 # dzielenie normalne
15.0 // 4.0 #dzielenie całkowitoliczbowe
2.0 ** 3.5
15.0 % 4 #też float!

# long - długi int
type(122L)
# complex - liczby zespolone
type(-3.14j) # j zamiast i !!

# konwersja typow
x = 7
y = 6.0
z = 8L
w = 7+9j
a, b = 2, 7 ## mozna wiele zm. przypisac za jednym zamachem
int(y)
int(z)
#int(w) # nie da sie!
complex(z, x)

# operacje do samych siebie
x += 3 # to samo co x = x + 3
print x
#pododbnie reszta operatorow
#-=, *=, /=, %=, **=, //= 

#nieskonczonosci, NaN
a = float('inf')
print a
b = float('-inf')
print b
c = float('nan')
print a

print a + b


#f-cje:
round(3.141592, 3)
abs(-3.3)
abs(w)
cmp(x, y) #1, jesli x>y, 0 ==, -1 <
max(1,7,3,-12)
min(45,-111,6.5,3)

#sprawdzenie typu
isinstance(5, int)
isinstance(5, str)

## zadanie:
## jak w jednej linii zrobic ponizsze:
temp = x
x = y
y = temp

#odp:
x, y = y, x
print x, y


# Out[3]:

#     <type 'int'>
#     <type 'int'>
#     <type 'float'>
#     10
#     inf
#     -inf
#     inf
#     nan
#     10 6.0
# 

# In[18]:

# 2. Napisy: str

type('Hello World')
type("Hello World")
s1 = "Hello World"
s2 = ''' To jest napis
wielolinijkowy. Biale znaki \n sa akceptowane
'''
print s2
s1[0] # numerujemy od zera!!!
s1[0:4] # dostajemy od 0 do 3 wlacznie
s1[6:] # od 6 do konca
s1[-1] # ostatni znak
s1[:-3] #od -2 do poczatku
s1[2:-3]
s2[2:-3]
s1 + ' a Kunegunda ma kota' #laczenie napisow
s1 * 3 #powielanie
len(s1) #dlugosc napisu
s1[0:11]
#s1[0] = 'F' #error! Napisy sa nie zmienialne!
s1 = 'F' + s1[1:]
print s1

'a' in s1
'e' in s1

print type(str(6))

#Py - obiektowy, wiec oprocz f-cji, mamy tez metody
#Sa to f-cje przypisane do konkretnego obiektu
#Roznia sie tylko wywolaniem - jesli mamy metode f i obiekt x,
#to nie wywolujemy jej f(x), tylko x.f()

#Metody zdefiniowane dla napisow:
s1.find("el") #zwraca indeks podnapisu w napisie
s1.count('l') #ile jest podnapisow w napisie
s1.replace("el", "ABC") #zastepuje podnapis innym
s2.split('\n')
# wiecej:
dir(s1)
dir('')
help(s1.rjust)
#s1.rjust? # w okienku na dole strony

s3 = 'dzisiaj jest %d. %s %d roku'
print s3 % (25, 'marca', 2015)

# %c - znak (litera)
# %s - napis
# %d - liczby calkowite
# %f - liczba rzeczywiste

#ponoc nowsze jest format, ale nie znam jeszcze :)
s3 = 'dzisiaj jest {0}. {1} {2} roku'
print s3.format(25, 'marca', 2015)


###Zadanie:
## wyszukac f-cje w dir, tak, zeby napis "four weddings and a funeral"
## zmienic na tytul, a nastepnie rozbic na pojedyncze slowa
s4 = "four weddings and a funeral"
s4.title()
s4.split(' ') # dostajemy liste - nastepny typ


# Out[18]:

#      To jest napis
#     wielolinijkowy. Biale znaki 
#      sa akceptowane
#     
#     Fello World
#     <type 'str'>
#     Help on built-in function rjust:
#     
#     rjust(...)
#         S.rjust(width[, fillchar]) -> string
#         
#         Return S right-justified in a string of length width. Padding is
#         done using the specified fill character (default is a space)
#     
#     dzisiaj jest 25. marca 2015 roku
#     dzisiaj jest 25. marca 2015 roku
#     dzisiaj jest {0}. {1} {2} roku
# 

#     ['four', 'weddings', 'and', 'a', 'funeral']

# In[5]:

# 3. Listy: list

lista = ['bcd', 786, 8.88, "ala", 22.3]
mala_lista = [123, 'ala']
lista1, lista2 = [1,2], ['ala', 'kaja']
type(lista)
print lista, mala_lista
lista[0] #numerowanie od 0!!!
lista[-2]
lista * 2
lista + mala_lista # z powtorzeniami

mala_lista[1] in lista

lista[1] = 773 #update listy
print lista

del lista[3]
print lista

lista = ["Ala", "ma", "psa", "kota", "zabe"]
zero, jeden, dwa, trzy, cztery = lista
print zero
print jeden
print dwa
print trzy
print cztery

lista2 = lista
lista[3] = 'mysz'
print "lista2:", lista2 #!!!
#jak to obejsc? 
lista2 = lista[:]
lista[2] = 'kota'
print "lista:", lista 
print "lista2:", lista2 

lista[3][2:]

len(lista)
sum([1, 4, 7, 12])
range(5)


# Cechy:
# 1. Sa zmienialne
# 2. Nie mają ustalonej dlugosci
# 3. Troche jak wektor w R, ale może miec wiele typow

#metody
dir(lista)
dir([])
lista.append('skowronka')
lista
lista.sort()
lista

#funkcje:
#cmp, len, max, min
print cmp(lista1, lista2)
#If elements are of the same type, perform the compare and return the result. 
#If elements are different types, check to see if they are numbers.
#
#    If numbers, perform numeric coercion if necessary and compare.
#    If either element is a number, then the other element is "larger" (numbers are "smallest").
#    Otherwise, types are sorted alphabetically by name.
#If we reached the end of one of the lists, the longer list is "larger." 
#If we exhaust both lists and share the same data, the result is a tie, meaning that 0 is returned.

#zagniezdzanie
M = [[1,2,3], [4,5,6], [7,8,9]]
M
M[2]
####Zadanie:
#jak dostac teraz 6?
M[1][2]

    
colors = ['red', 'blue', 'green', 'yellow']
print 'Choose', ', '.join(colors[:-1]),       'or', colors[-1]


# Out[5]:

#     ['bcd', 786, 8.88, 'ala', 22.3] [123, 'ala']
#     ['bcd', 773, 8.88, 'ala', 22.3]
#     ['bcd', 773, 8.88, 22.3]
#     Ala
#     ma
#     psa
#     kota
#     zabe
#     lista2: ['Ala', 'ma', 'psa', 'mysz', 'zabe']
#     lista: ['Ala', 'ma', 'kota', 'mysz', 'zabe']
#     lista2: ['Ala', 'ma', 'psa', 'mysz', 'zabe']
#     -1
#     Choose red, blue, green or yellow
# 

# In[6]:

# 4. Krotki: tuple

krotka = ("ala", 345, 'john', 8.6) #nawiasy okragle!!
#rozni sie od listy tylko tym, ze nie da sie jej zmienic
#Po co? Zazwyczaj nie używane. Czasem nie chcemy zmieniac obiektu,
#ktory podajemu w argumencie i wtedy zamiast listy warto podac krotke
len(krotka)
krotka + (5, 7)
#krotka[0] = 2 #error! 
#niezmienialne!
lista = list(krotka)
lista


# Out[6]:

#     ['ala', 345, 'john', 8.6]

# In[7]:

# 5. Słowniki: dictionary

#obiekt zwany z angielskiego mapa
#1. przechowywane wzgledem KLUCZA, a nie POZYCJI
#2. zmienialny
#3. bez ustalonej wielkosci (dlugosci)

mapa = {'imie': 'Natalia', 'nazwisko': 'Potocka', 'wiek': 23, 'wzrost': 166}
mapa
mapa['nazwisko']
mapa['wiek'] += 1
mapa
mapa['uczelnia'] = 'PW' #dodajemy rekord!
mapa
dir(mapa)
dir({})
mapa.viewkeys()
mapa.viewvalues()

#zagniezdzanie
slownik = {'czlowiek': {'imie': 'J', 'nazwisko': 'K'},
           'wykszt': ['inz', 'mgr'],
           'nr buta': 42,
           7: 33}
slownik
####zadanie: 
#jak dodac do wyksztalcenia doktorat?
#chcemy miec liste:
#
# {7: 33,
# 'czlowiek': {'imie': 'J', 'nazwisko': 'K'},
# 'nr buta': 42,
# 'wykszt': ['inz', 'mgr', 'dr']}
slownik['wykszt'].append('dr')
slownik


# Out[7]:

#     {7: 33,
#      'czlowiek': {'imie': 'J', 'nazwisko': 'K'},
#      'nr buta': 42,
#      'wykszt': ['inz', 'mgr', 'dr']}

# In[8]:

#6. Pliki: file

f = open('data.txt', 'w')
f.write("Warsztaty")
f.write(" z ")
f.write("Pythona")
string = ''' odbywaja sie dzisiaj \njak i jutro
 ale pojutrze juz nie :(
'''.split('\n')
f.writelines(string)
f.close() #!!!
dir(f)
#pwd()
#writelines expects a list of strings, while write expects a single string. 
#readlines zwraca listę, read - napis

#domyslnie jest 'r' == read
f = open('data.txt')
napis = f.read()
napis
napis.split(' ')
f.close()

#zalecane
#automatycznie zamyka plik po wykonaniu komend, 
#niewazne czy to, co w srodku sie wykona czy nie
with open('data.txt', 'r') as f:
    print f.readline()


# Out[8]:

#     Warsztaty z Pythona odbywaja sie dzisiaj jak i jutro ale pojutrze juz nie :(
# 

# In[9]:

#### Kontrola przeplywu ####


# In[10]:

#7. Wyrazenie warunkowe: if

# operatory porównawcze: ==, !=, <, <=, >, >=
# oparatory logiczne: and, or, not / in, not in

x = 5

if x > 7:
    print "x jest wieksze od 7"
elif x > 5:
    print "x jest wieksze od 5"
elif x > 3:
    print "x jest wieksze od 3"
else:
    print "x jest mniejsze lub rowne 3"
    
#if + switch naraz


# Falsz: False, "", 0, 0.0, [], (), {}
# Prawda: True, kazdy niepusty napis, kazda liczba inna niz 0, 
# wsz. niepuste listy, krotki i slowniki

dict = {}
if dict:
    print "Slownik nie jest pusty!"
else:
    print "Slownik jest pusty :("
#tzn. {} oznacza False
#podobnie dla {}, [], '', 0, 0.0, False, None

dict = {9: 3}
if dict:
    print "Slownik nie jest pusty!"
else:
    print "Slownik jest pusty :("


# Out[10]:

#     x jest wieksze od 3
#     Slownik jest pusty :(
#     Slownik nie jest pusty!
# 

# In[14]:

#8. Petle: while, for


x = 1
while x < 5:
    print x
    x += 1
else:
    print "x jest rowne", x
    
x = 'spam'
while x:
    print x
    x = x[1:]
    
for i in range(1,10): #numeruje tylko do 9!
    print i
    
    
#Iterable: niektore typy zmiennych w Py sa iterowalne, ang. sa tzw. iterables
#takimi typami są: napisy, listy, krotki, slowniki i pliki
#sa to obiekty, ktore moga zwracac jeden element na raz 
#i mozna uzywac ich w petli 


print "NAPISY"
for s in s1:
    print s
    
print "LISTY"
for l in lista:
    print l
    
print "KROTKI"
for k in krotka:
    print k
    
print "SLOWNIKI"
for s in slownik:
    print s

    
#pass, continue, break
for s in s1:
    if s == 'l':
        pass
    elif s == 'F':
        print 'H'
        continue
    elif s == 'W':
        break
    print s
    

#enumerate
print list(enumerate(slownik))

lista = [7, 12, 32, 17, 21, 90]
#list comprehension
a = [i for i, val in enumerate(lista) if not (val%2)]
# == which(lista%2 == 0) (in R)
print a

tt = [n ** 2 for n in range(10)]
print tt

#x for x in range(1, 10) if x % 2 else x * 100
#podobnie mozna przechodzic po listach i slownikach
#zadanie: jak zrobic to samo co powyzej, tj. potegi liczb 0-9
#ale tylko dla podstaw nieparzystych?
print [n ** 2 for n in range(10) if n % 2]


#czytanie duzych plikow - w ten sposob wczytujemy linia po linii
with open('data.txt', 'r') as f:
    for line in f:
        print line + ' koniec linii'


# Out[14]:

#     1
#     2
#     3
#     4
#     x jest rowne 5
#     spam
#     pam
#     am
#     m
#     1
#     2
#     3
#     4
#     5
#     6
#     7
#     8
#     9
#     NAPISY
#     F
#     e
#     l
#     l
#     o
#      
#     W
#     o
#     r
#     l
#     d
#     LISTY
#     7
#     12
#     32
#     17
#     21
#     90
#     KROTKI
#     ala
#     345
#     john
#     8.6
#     SLOWNIKI
#     czlowiek
#     nr buta
#     wykszt
#     7
#     H
#     e
#     l
#     l
#     o
#      
#     [(0, 'czlowiek'), (1, 'nr buta'), (2, 'wykszt'), (3, 7)]
#     [1, 2, 5]
#     [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
#     [1, 9, 25, 49, 81]
#     Warsztaty z Pythona odbywaja sie dzisiaj jak i jutro ale pojutrze juz nie :( koniec linii
# 

# In[ ]:

#### Funkcje ####


# In[80]:

# 9. Funkcje

def funkcja(x):
    print x # ta f-cja nic nie zwraca!
    
funkcja('ala ma kota')
y = funkcja('ala')
print y # ta f-cja nic nie zwraca!

def f2(a, b, c=1):
    return a ** b + c

f2(2, 3)
f2(2, 3, 7)
y = f2(2,3,4)
print y


# Out[80]:

#     ala ma kota
#     ala
#     None
#     12
# 

# In[ ]:

#### Biblioteki ####


# In[105]:

# 10. Biblioteki: module

from math import gamma #mozna jedna f-cje sciagnac
from math import * #mozna wszystko sciagnac i nie trzeba pisac nazwy modulu
import math #wszystko, ale trzeba pisac nazwe modulu

# funkcje: abs, ceil, cmp, exp, fabs, pi, e, sin, cos, pow, ...
# https://docs.python.org/2/library/math.html
dir(math)
#help(math)
print abs(-7)
print math.fabs(-7)
help(math.gamma)
#gamma(7) #nie dziala!
math.gamma(7)
math.cos(math.pi)


# Out[105]:

#     7
#     7.0
#     Help on built-in function gamma in module math:
#     
#     gamma(...)
#         gamma(x)
#         
#         Gamma function at x.
#     
# 

#     -1.0

# In[151]:

import random
#import random as rdm #mozna sobie nazwe skrocic

dir(random)

random.random() #losowa liczba z prz. [0,1)
random.uniform(3,8) #jednostajny [a,b], gdy a<=b
random.betavariate(1, 3) #rozklad beta
random.gauss(0, 1)

random.randrange(1, 10, 2) #miedzy 1 a 10, co 2

random.sample([1,2,7,8,13,3,9], 3) #wybieramy losowe 3

random.seed()
liczby = range(5)
random.shuffle(liczby) #zmienia wejsciowa liste
print liczby

random.seed(123)
liczby = range(5)
random.shuffle(liczby)
print liczby


# Out[151]:

#     [0, 4, 2, 3, 1]
#     [2, 3, 1, 4, 0]
# 

# In[113]:

import re

dir(re)

re.split(':|/|\.', 'http://www.rexamine.com/blog/')
re.sub('\W+', '!!', 'http://www.rexamine.com/blog/')

#wiecej na https://docs.python.org/2/library/re.html


# Out[113]:

#     'http!!www!!rexamine!!com!!blog!!'

# In[155]:

#konsola:
#ipython nbconvert --to python funkcje.ipynb
import funkcje #import z innych zrodel

funkcje.moja_funkcja(3)


# Out[155]:

#     10

# In[ ]:

#### Nastepnym razem:
# Analiza danych - NumPy, SciPy, matplotlib, scikit-learn, nltk

