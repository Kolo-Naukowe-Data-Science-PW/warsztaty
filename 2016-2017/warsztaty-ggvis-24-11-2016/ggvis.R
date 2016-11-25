### Warsztaty z ggvis by Krzysztof Rudaś ###

install.packages('ggvis')
library(ggvis)

#wykresy statyczne

#podstawy:

st<-as.data.frame(Seatbelts)
p <- ggvis(st, x = ~drivers, y = ~DriversKilled)
layer_points(p)

st %>% ggvis(~drivers, ~DriversKilled, stroke = ~VanKilled) %>% layer_points()
st %>% ggvis(~drivers, ~DriversKilled, stroke = ~as.factor(VanKilled)) %>% layer_points()

st %>% ggvis(~drivers, ~DriversKilled, fill = ~VanKilled) %>% layer_points()
st %>% ggvis(~drivers, ~DriversKilled, fill = ~as.factor(VanKilled)) %>% layer_points()

st %>% ggvis(~drivers, ~DriversKilled, size = ~as.factor(VanKilled)) %>% layer_points() #źle
st %>% ggvis(~drivers, ~DriversKilled, size = ~VanKilled) %>% layer_points() 

st %>% ggvis(~drivers, ~DriversKilled, shape = ~as.factor(VanKilled)) %>% layer_points() 
st %>% ggvis(~drivers, ~DriversKilled, shape = ~VanKilled) %>% layer_points() #źle 
st %>% ggvis(~drivers, ~DriversKilled, shape := "cross") %>% layer_points()
st %>% ggvis(~drivers, ~DriversKilled, opacity :=0.2) %>% layer_points()

st %>% ggvis(~drivers, ~DriversKilled, fill := "pink",stroke := 'black') %>% layer_points()

#Zad1
#Zwizualizować fajne zależności punktowe ze zbioru auta2012.

install.packages("PogromcyDanych")
library(PogromcyDanych)
auta2012[1:10000,]

#rodzaje layerów
st$year<-1:nrow(st)
st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points()
st %>% ggvis(~year, ~DriversKilled) %>% layer_paths()

t <- seq(0, 2 * pi, length = 100)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths(fill := "blue")

st %>% ggvis(~year, ~DriversKilled) %>% layer_ribbons()
st %>% ggvis(~year, ~DriversKilled-10,y2=~DriversKilled+10) %>% layer_ribbons()


st$text<-c(rep("a",nrow(st)/2),rep("b",nrow(st)/2))
st %>% ggvis(~drivers, ~DriversKilled,text := ~text) %>% layer_text()


t <- seq(0, 2 * pi, length = 20)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths()

#line_paths + sort po x
t <- seq(0, 2 * pi, length = 20)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_lines()

st %>% ggvis(~VanKilled) %>% layer_histograms()
st %>% ggvis(~drivers, ~DriversKilled) %>% layer_smooths()
st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points() %>% layer_smooths(stroke :='red')

#Zad2 na zbiore auta 2012 zrobić jakiś inny ładny statyczny wykres


#Osie i legendy

st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points() %>%
   add_axis("x", title = "jezdzacy") %>%
   add_axis("y", title = "juz nie")

st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points() %>%
   add_axis("x", subdivide = 3, values = seq(1000, 3000, by = 100)) %>%
   add_axis("y", subdivide = 1, values = seq(60, 210, by = 10))

st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points() %>%
   add_axis("x", subdivide = 3, values = seq(1000, 3000, by = 100),orient = 'top') %>%
   add_axis("y", subdivide = 1, values = seq(60, 210, by = 10),orient = 'right')

st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points() %>% add_axis("x")%>%
   add_axis("x", subdivide = 3, values = seq(1000, 3000, by = 100), offset = 40) 

st %>% ggvis(~drivers, ~DriversKilled) %>% layer_points() %>% add_axis("x")%>%
   add_axis("x", subdivide = 3, values = seq(1000, 3000, by = 100))

st %>% ggvis(~drivers, ~DriversKilled,size=~VanKilled,fill=~VanKilled)%>% layer_points()
st %>% ggvis(~drivers, ~DriversKilled,size=~VanKilled,fill=~VanKilled)%>% layer_points()%>% 
   add_legend(c("size", "fill"))
st %>% ggvis(~drivers, ~DriversKilled,size=~VanKilled,fill=~VanKilled)%>% layer_points()%>% 
   add_legend(title = "rozne",c("size", "fill"))

#Zad3 na zbiore auta 2012 zrobić jakiś inny ładny statyczny wykres z legendą i ładnymi osiami

#Wykresy dynamiczne

st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points(size := input_slider(10, 100, value = 100))
st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points(size := input_slider(10, 100, value = 100)) %>% 
   layer_smooths(stroke :='red',span = input_slider(0.5, 1, value = 1))
st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points(size := input_slider(10, 100, value = 100)) %>% 
   layer_smooths(span = input_slider(0.5, 1, value = 1),stroke := input_select(c('red','green','blue')))
st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points(size := input_slider(10, 100, value = 100)) %>% 
   layer_smooths(span = input_slider(0.5, 1, value = 1),stroke := input_radiobuttons(c('red','green','blue')))
st %>% ggvis(~drivers, ~DriversKilled)%>% layer_points(size := input_slider(10, 100, value = 100)) %>% 
   layer_smooths(span = input_slider(0.5, 1, value = 1),stroke := input_text(value='blue'))

#input_slider
#input_checkbox()
#input_checkboxgroup()
#input_numeric()
#input_radiobuttons()
#input_select()
#input_text()

#Zad4 
#Na zbiorze auta 2012 zrobić jakiś inny ładny dynamiczny wykres z legendą i ładnymi osiami