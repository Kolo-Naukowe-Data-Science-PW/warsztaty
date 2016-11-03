### Warsztaty z plotly by Krzysztof Rudaś ###

library(plotly)
library(forecast)
plot_ly(z = ~volcano)
#podstawowy wykres ggplota
mtcars
p <- ggplot(mtcars, aes(wt, qsec)) + geom_line()
#podstawowe przejście na plotly
gg <- ggplotly(p)
#co się ma wyswietlać na wykresie
style(gg, hoverinfo = "none")
style(gg, hoverinfo = "x")
style(gg, hoverinfo = "y")
#dodanie suwaczka
rangeslider(gg)
#czy jadąc wzdłuż osi x czy y
layout(gg, hovermode = "x")
layout(gg, hovermode = "y")
layout(gg, hovermode = "z")

#Zad 1 ze zbioru nycflights13 zrobić jakiś ładny wykres w plotly


#jakie dane użyte do robienia wykresu?
p %>% ggplotly()
p %>% ggplotly(originalData = TRUE) %>% plotly_data()
# tak naprawdę z tych danych rzeźbi ggplot
p %>% ggplotly(originalData = FALSE) %>% plotly_data()

fun1<-function(p) {
  p %>% slice(which.max(y)) %>%
    add_annotations("Max", ax = 60)

}
fun2<-function(p) {
  p %>% slice(which.min(y)) %>%
    add_annotations("Min", ax = 60)
}
fun3<-function(p) {
  p %>% slice(which.max(qsec)) %>%
    add_annotations("Max", ax = 60)
  
}
fun4<-function(p) {
  p %>% slice(which.min(qsec)) %>%
    add_annotations("Min", ax = 60)
}
p %>% ggplotly(originalData = FALSE) %>% add_fun(fun1) %>% add_fun(fun2)
p %>% ggplotly(originalData = TRUE) %>% add_fun(fun1) %>% add_fun(fun2)#?le
p %>% ggplotly(originalData = TRUE) %>% add_fun(fun3) %>% add_fun(fun4)

# Zad 2 na zbiorze nycflights13 zrobić zacny wykres w ggplocie przerobić na plotly 
# i wyszukać punkty charakterystyczne

#większa ilość layerów

p<-ggplot(mtcars, aes(x = wt, y = qsec)) +
  geom_line() + geom_smooth()
#dane do rysowania smooth
p %>%
  ggplotly(layerData = 2, originalData = FALSE) %>%
  plotly_data()
#dane do rysowania line
p %>%
  ggplotly(layerData = 1, originalData = FALSE) %>%
  plotly_data()
#dane nieprzetworzone
p %>%
  ggplotly(originalData = TRUE) %>%
  plotly_data()


fun1<-function(p) {
  p %>% slice(which.max(se)) %>%
    add_segments(x = ~x, xend = ~x, y = ~ymin, yend = ~ymax) %>%
    add_annotations("Maximum przedzia?u", ax = 60)
}
fun2<-function(p) {
  p %>% slice(which.min(se)) %>%
    add_segments(x = ~x, xend = ~x, y = ~ymin, yend = ~ymax) %>%
    add_annotations("Minimum przedzia?u")
}
fun3<-function(p) {
  p %>% slice(which.max(y)) %>%
    add_annotations("Max", ax = 60)
  
}
fun4<-function(p) {
  p %>% slice(which.min(y)) %>%
    add_annotations("Min", ax = 60)
}
p %>%
  ggplotly(layerData = 2, originalData = F) %>%
  add_fun(fun1) %>% add_fun(fun2) %>%add_fun(fun3) %>% add_fun(fun4)


 
#dane o wykresach
library(listviewer)
plotly_json(p)
#inny sposób na rysowanie wykresów


iris
library(dplyr)
iris$row1<-rep(1:50,3)
ir <- group_by(iris, Species)

# initiate a plotly object with date on x and median on y
p <- plot_ly(ir, x = ~row1, y = ~Petal.Length)
# plotly_data() returns data associated with a plotly object, note the group attribute!
plotly_data(p)

add_lines(
  add_lines(p, alpha = 0.2, name = "iryski", hoverinfo = "none"),
  name = "setosa", data = filter(iris, Species == "setosa")
)
#inaczej
p1 <- iris %>%
  group_by(Species) %>%
  plot_ly(x = ~row1, y = ~Petal.Length) %>%
  add_lines(alpha = 0.2, name = "iryski", hoverinfo = "none")

p1 %>%
    filter(Species == "setosa") %>%
    add_lines(name = "Setosa")


fun1 <- function(p) {
  p%>% filter(Species == "setosa") %>% add_lines(name = "Setosa")
}

fun2 <- function(p) {
  p%>% filter(Species == "virginica") %>% add_lines(name = "Virginica")
}


p1 %>%
  add_fun(fun1) %>%
  add_fun(fun2)





fun_species <- function(p, species) {
  p %>% filter(Species == species) %>% add_lines(name = species)
}



fun_iqr <- function(p) {
  p %>%
    group_by(row1) %>% 
    summarise(
      m = median(Petal.Length, na.rm = TRUE)
    ) %>%
    add_lines(y = ~m, name = "median", color = I("black"))
}

p1 %>%
  add_fun(fun_iqr) %>%
  add_fun(fun_species, "setosa") %>%
  add_fun(fun_species, "virginica")
#zad 3 na zbiorze nycflights zrobić plotly bez używania ggplotly z fajnymi layerami


#Scatter plots
subplot(
  plot_ly(mtcars, x = ~wt, y = ~qsec, name = "default"),
  plot_ly(mtcars, x = ~wt, y = ~qsec) %>% add_markers(alpha = 0.2, name = "alpha"),
  plot_ly(mtcars, x = ~wt, y = ~qsec) %>% add_markers(symbol = I(1), name = "hollow")
)


plot_ly(mtcars, x = ~wt, y = ~qsec, symbol = ~cyl, symbols = 1:3, name = "cyl")


p <- plot_ly(mtcars, x = ~wt, y = ~qsec, alpha = 0.3) 
subplot(
  add_markers(p, symbol = ~cyl, name = "bez rozroznienia"),
  add_markers(p, symbol = ~factor(cyl), color = I("black"))
)

subplot(
  add_markers(p, size = ~cyl, name = "normalny"),
  add_markers(p, size = ~cyl, sizes = c(1, 500), name = "zwiekszony")
)


plot_ly(mtcars, x = ~wt, y = ~qsec, z = ~cyl) %>%
  add_markers(color = ~cyl)

#Zad4 na nyc_flights ładne scatterploty poproszę

#linear plots

plot_ly(mtcars, x = ~wt, y = ~qsec ) %>%
  add_lines()
plot_ly(mtcars, x = ~wt,y = ~qsec,size = c(1000)) %>% add_lines(name= 'linia')
plot_ly(mtcars, x = ~wt,y = ~qsec,color = ~as.factor(cyl)
,colors = c("red","green","blue")) %>% add_lines(name= 'linia')

plot_ly(mtcars, x = ~wt,y = ~qsec) %>% add_lines(name= 'linia')%>%
  add_trace(y = ~qsec,mode = 'marker',name= 'kropki',color = ~as.factor(cyl))



cc <- count(mtcars,  cyl,gear)
# number of diamonds by cut (nn)
cc2 <- left_join(cc, count(cc, cyl, wt = n))
#Zad5 na nyc_flights ładne liniowe poproszę
cc2 %>%mutate(prop = n / nn)
#bar plots



plot_ly(mtcars, x = ~mpg, color = ~cyl) %>%
  add_histogram()
plot_ly(mtcars, x = ~mpg, color = ~as.factor(cyl)) %>%
  add_histogram()
cc2 %>%mutate(prop = n / nn)%>%plot_ly(x = ~cyl,y = ~prop) %>%
  add_bars()

#Zad 6 ładne barploty