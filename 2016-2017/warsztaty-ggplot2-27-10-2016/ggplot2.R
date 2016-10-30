### Warsztaty z ggplot2 by Krzysztof Rudaś ###

install.packages("ggplot2")
library(ggplot2)

art_data <- data.frame(HEIGHT=c('very small','small','medium','high','very high'),NUMBER = c(5,15,30,12,7))
p<-art_data$NUMBER
names(p)<-art_data$HEIGHT
barplot(p)
l<-art_data$HEIGHT
m<-art_data$NUMBER

art_data2 <- data.frame(HEIGHT=c(rep('very small',5),rep('small',15),rep('medium',30),rep('high',12),rep('very high',7)))
#barplot?????

ggplot(data = art_data2,aes(x=HEIGHT))+geom_bar()

qplot(wt, mpg, data=mtcars, geom="line")
qplot(wt, mpg, data=mtcars, geom="point")
#podstawowe typy wykresów:
ggplot(data = mtcars,aes(x=wt,y=mpg))+geom_line()
ggplot(data = mtcars,aes(x=wt,y=mpg))+geom_point()
ggplot(data = mtcars,aes(x=am))+geom_bar()
ggplot(data = mtcars,aes(x="",y=mpg))+geom_boxplot()
ggplot(data = mtcars,aes(x=as.factor(cyl),y=mpg))+geom_boxplot()


#ogólna składnia

#najpierw data, pozniej aes najpierw to co dla osi x pozniej to co dla y na końcu dodajemy jaki typ wykresu chcemy

install.packages("nycflights13")
library(nycflights13)
nycflights13
airports
head(flights)


#Zad 1 zaimplementować kilka podstawowych wykresów na jednym ze zbiorów z nycflights13

#grupowanie, kolorowanie
ggplot(data = mtcars,aes(x=wt,y=mpg,group=cyl))+geom_line()
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=cyl))+geom_line()
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_line()

ggplot(data = mtcars,aes(x=wt,y=mpg,group=as.factor(cyl)))+geom_line()

#ustawianie kolorów
cbPalette <- c("black","yellow","red")
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_line()+scale_colour_manual(values=cbPalette)
cbPalette2 <- c("#0000FF", "#00FF00", "#FF0000")
cbPalette3 <- c("#999999", "#E69F00", "#56B4E9")
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_line()+scale_colour_manual(values=cbPalette2)
#odcienie szarości
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_point()
ggplot(data = mtcars,aes(x=wt,y=mpg,alpha = qsec))+geom_point()
#wypełnianie
ggplot(data = mtcars,aes(x=am,fill=as.factor(am)))+geom_bar()+scale_fill_manual(values=cbPalette2)

#łączenie typów wykresów
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_line()+geom_point()+scale_colour_manual(values=cbPalette2)

ggplot(data = mtcars,aes(x=am,y=gear,fill=as.factor(am)))+geom_bar(stat='identity')+scale_fill_manual(values=cbPalette2)+geom_point()

#zad 2 przeprowadzić analizę wybranego zagadnienia przy podziale na grupy.

#Szczególowe właściwości poszczególnych geom coś tam

#geom_point
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_point()+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_point(size=2)+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg))+geom_point(aes(size=qsec/10))
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(mtcars$cyl)))+geom_point(aes(size=qsec/10))
ggplot(data = mtcars,aes(x=wt,y=mpg,size=qsec/10,colour=as.factor(cyl)))+geom_point()

ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_point(shape=12)+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl)))+geom_point(shape=12)+scale_colour_manual(values=cbPalette2)

ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl),shape=as.factor(cyl)))+geom_point(size=2,shape=12)+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl),shape=as.factor(cyl)))+geom_point(size=2)+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg,colour=as.factor(cyl),shape=as.factor(cyl),size=qsec/10))+geom_point()+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=mpg,shape=as.factor(cyl)))+geom_point()+ scale_shape(solid = FALSE)
ggplot(data = mtcars,aes(x=wt,y=mpg,shape=as.factor(cyl))) + geom_point(colour="black", size = 4.5) +
  geom_point(colour="cyan", size = 4) +
  geom_point(aes(shape = factor(cyl)))

#zad3 na zbiorze nyc_flights zrobić jakieś fajne analizki punktowe

#geom_line

ggplot(data = mtcars,aes(x=wt,y=disp,colour=as.factor(cyl)))+geom_line()+scale_colour_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=wt,y=disp,colour=mpg))+geom_line()+scale_colour_gradient(low='pink',high='red')
ggplot(data = mtcars,aes(x=wt,y=disp))+geom_line(size =3)
ggplot(data = mtcars,aes(x=wt,y=disp))+geom_line(linetype = 2)
ggplot(data = mtcars,aes(x=wt,y=disp))+geom_line(arrow = arrow())
ggplot(data = mtcars,aes(x=wt,y=disp))+ geom_line(arrow = arrow(angle = 15, ends = "both", type = "closed"))
ggplot(data = mtcars,aes(x=wt,y=disp))+geom_line(size =3,colour = 'pink')+geom_line(linetype=2)

#zad4 na zbiorze nyc_flights zrobić jakieś fajne analizki liniowe

#geom_bar
ggplot(data = mtcars,aes(x=cyl))+geom_bar()
ggplot(data = mtcars,aes(x=cyl))+geom_bar(width=0.3)
ggplot(data = mtcars,aes(x=cyl))+geom_bar(width=0.3)+ coord_flip()
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+scale_fill_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar(colour='black')+scale_fill_manual(values=cbPalette2)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(am)))+geom_bar()
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(am)))+geom_bar(position="dodge")
ggplot(data = mtcars, aes(x=cyl)) + geom_bar() +facet_wrap(~ am)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(am)))+geom_bar()+ scale_fill_brewer()
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(am)))+geom_bar()+ scale_fill_brewer(palette = 2)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(am)))+geom_bar()+ scale_fill_grey()

#zad5 na zbiorze nyc_flights zrobić jakieś fajne analizki słupkowe

#legendy,tytuły i inne drobiazgi

#legendy
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+scale_fill_manual(values=cbPalette2)+guides(fill=FALSE)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+scale_fill_manual(values=cbPalette2,guide=FALSE)
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + theme(legend.position="none")
#kolejność
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+scale_fill_discrete(breaks=c(8,6,4))
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + guides(fill = guide_legend(reverse=TRUE))
#chowanie 
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + guides(fill=guide_legend(title=NULL))
#zmienianie
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + scale_fill_discrete(name="cyl",labels=c("small", "medium", "big"))
#zmiana pozycji
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+ theme(legend.position="top")

ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+ theme(legend.position=c(.5, .5))
#legenda bez obwódek
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+geom_bar(colour="black")
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+geom_bar(colour="black", show.legend=FALSE)

#tytuły osie

ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + ggtitle("wykres\nwykres")
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + ggtitle("wykres\nwykres")
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + ggtitle("wykres\nwykres")+theme(plot.title = element_text(lineheight=.8, face="bold"))
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + scale_x_discrete("cyl2") +scale_y_continuous("ilość")
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+  labs(x = "",  y = "")
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar()+  xlab("ple")+ylab("ble")
#obrót na osi
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
#ścinanie i rozszerzanie
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() +ylim(0, 10) 
ggplot(data = mtcars,aes(x=cyl,fill=as.factor(cyl)))+geom_bar() + expand_limits(y=c(0,20)) 

