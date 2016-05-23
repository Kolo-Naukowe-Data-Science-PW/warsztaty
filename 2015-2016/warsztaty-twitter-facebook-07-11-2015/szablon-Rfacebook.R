install.packages("Rfacebook")
install.packages("stringi")

library("Rfacebook")
library("stringi")

# https://developers.facebook.com
# https://developers.facebook.com/tools/explorer

token <- "xxxxxxxxxxxxxxxx"

### STRONA

## Informacje
strona <- "kolonaukowedatascience"
(info_strona <- getUsers(user = strona, token = token))

## Posty
id_strona <- info_strona$id
posty_strona <- getPage(page = id_strona, token = token, since = "2014-10-01",
      until = paste0(Sys.Date(), "T23:59:59"), feed = TRUE) #lub zamiast dat dac n = duza liczba

## Komentarze i lajki
posty_komentarze_likes_strona <- lapply(posty_strona$id, getPost, token = token)

## Proste statystyki

# Średnia używanych znaków (na posta)
(srednia_znaki_post <- mean(stri_length(posty_strona$message), na.rm = TRUE))

# Liczności wystąpień lajków
table(posty_strona$likes_count)
# Średnia zdobytych lajków (na posta)
(srednia_likes_post <- mean(posty_strona$likes_count))
# Najbardziej lubiany post
posty_strona[posty_strona$likes_count == max(posty_strona$likes_count), ]
# Lajkujący
likes_stalkers <- lapply(posty_komentarze_likes_strona, function(elem){
      elem$likes$from_name
   })
likes_stalkers <- sort(table(unlist(likes_stalkers)), decreasing = TRUE)
likes_stalkers[1]

# Liczności wystąpień komentarzy
table(posty_strona$comments_count)
# Średnia zdobytych komentarzy (na posta)
(srednia_komentarz_post <- mean(posty_strona$comments_count))
# Najczęściej komentowany post
posty_strona[posty_strona$comments_count == max(posty_strona$comments_count), ]
# Komentujący
komentarze_stalkers <- lapply(posty_komentarze_likes_strona, function(elem){
      elem$comments$from_name
   })
komentarze_stalkers <- sort(table(unlist(komentarze_stalkers)), decreasing = TRUE)
komentarze_stalkers[1]

# Liczności wystąpień udostępnień
table(posty_strona$shares_count)
# Średnia zdobytych udostępnień (na posta)
(srednia_udostepnienie_post <- mean(posty_strona$shares_count))
# Najczęściej udostępniany post
posty_strona[posty_strona$shares_count == max(posty_strona$shares_count), ]


### GRUPY PUBLICZNE

## Informacje
nazwa_grupy <- "uzytkownicyR"
(grupa <- searchGroup(nazwa_grupy, token))

## Posty
posty_grupa <- getGroup(group_id = grupa$id, token = token,
   since = "2014-10-01", until = paste0(Sys.Date(), "T23:59:59"))

## Komentarze i lajki
posty_komentarze_likes_grupa <- lapply(posty_grupa$id, getPost, token = token)

likes_stalkers_grupa <- lapply(posty_komentarze_likes_grupa, function(elem){
      elem$likes$from_name
   })
likes_stalkers_grupa <- sort(table(unlist(likes_stalkers_grupa)), decreasing = TRUE)
likes_stalkers_grupa[1]

komentarze_stalkers_grupa <- lapply(posty_komentarze_likes_grupa, function(elem){
      elem$comments$from_name
   })
komentarze_stalkers_grupa <- sort(table(unlist(komentarze_stalkers_grupa)), decreasing = TRUE)
komentarze_stalkers_grupa[1]

### UŻYTKOWNICY

## http://findmyfbid.com/

## Informacje

uzytkownik_id <- "998234996869035"
(uzytkownik <- getUsers(user = uzytkownik_id, token = token, private_info = TRUE))

### AKTUALIZACJA STATUSU

updateStatus(text = "Test R w RStudio", token = token, link = "https://www.r-project.org/Rlogo.png")
