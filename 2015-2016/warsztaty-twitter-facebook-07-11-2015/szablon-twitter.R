install.packages("ROAuth")
install.packages("streamR")
install.packages("stringi")
install.packages("tm")
install.packages("maps")

library("ROAuth")
library("streamR")
library("stringi")
library("tm")
library("maps")

# https://apps.twitter.com/

### Autoryzacja

library("ROAuth")

## Zmienne
request_URL <- "https://api.twitter.com/oauth/request_token"
access_URL <- "https://api.twitter.com/oauth/access_token"
auth_URL <- "https://api.twitter.com/oauth/authorize"
consumer_key <- "xxxxxxxxxxxxxxxxx"
consumer_secret <- "xxxxxxxxxxxxxxxxx"
oauth_key <- "xxxxxxxxxxxxxxxxx"
oauth_secret <- "xxxxxxxxxxxxxxxxx"

## Zmienna łącząca
tw_oauth <- OAuthFactory$new(consumerKey = consumer_key, consumerSecret = consumer_secret,
      oauthKey = oauth_key, oauthSecret = oauth_secret, requestURL = request_URL,
      accessURL = access_URL, authURL = auth_URL)

## Autoryzacja ręczna
tw_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package="RCurl"))

## Zapis/Wczytanie pliku z autoryzacją
save(tw_oauth, file = paste0(getwd(), "/tw_oauth"))
load(paste0(getwd(), "/tw_oauth"))

### Tweety

library("streamR")
library("stringi")
library("tm")

## Pobieranie

# filterStream(file.name = NULL, track = NULL,
#     follow = NULL, locations = NULL, language = NULL,
#     timeout = 0, tweets = NULL, oauth = NULL,
#     verbose = TRUE)

filterStream(file.name = paste0("tweety-", Sys.Date(), ".json"),
   track = c("James Bond", "james bond", "Bond", "bond", "007", "Spectre",
      "spectre", "Daniel Craig", "daniel craig", "Craig", "craig"),
   language = NULL, timeout = 60*60, tweets = NULL, oauth = tw_oauth) #pobieranie 60minut

## Parsowanie

# parseTweets(tweets, simplify = FALSE, verbose = TRUE)

tweets <- parseTweets(paste0("tweety-", Sys.Date(), ".json"),
   simplify = FALSE)

## Obróbka danych

head(tweets)
names(tweets)

# Kraje
sort(table(tweets$country), decreasing = TRUE)

# Strefa czasowa - tutaj widać skąd pisane, nawet jeśli nie dali geolokalizacji
sort(table(tweets$time_zone), decreasing = TRUE)

# Lokalizacje - bardzo duża kreatywność (np. The United States of Cebuland)
sort(table(tweets$location), decreasing = TRUE)

# Opis użytkownika - bardzo duża kreatywność
tweets$description

# Urządzenia
tweets$source <- stri_extract_all_regex(tweets$source, "(?<=>).+(?=<)", simplify = TRUE)
sort(table(tweets$source), decreasing = TRUE)

# Język użytkownika
sort(table(tweets$user_lang), decreasing = TRUE)

# Ile zostało retweetowanych dalej
sum(tweets$retweeted)

# Można na mapie dać jak są geolokalizacje
library("maps")
map(mar=c(0,0,0,0))
points(tweets$lon, tweets$lat, col="red", pch=".", cex=4)

# Tekst
tweets_pl <- tweets[tweets$lang == "pl",]
text <- tweets_pl$text

# Najczęstsze słowa
words <- unlist(stri_extract_all_words(text))
stopwords_pl <- unlist(read.table("stopwords_pl.txt", stringsAsFactors = FALSE), use.names = FALSE)
words <- removeWords(words, stopwords("english")) #angielski
words <- removeWords(words, stopwords_pl) #polski
words <- words[words != ""]
head(sort(table(words), decreasing = TRUE), 20)

# Liczba znaków (max to 140 znakóW)
signs <- stri_length(text)
mean(signs) # średnio
min(signs) # minimum
max(signs) # maximum

# Ile już retweetów
(retweets <- sum(stri_detect_regex(text, "^RT |^rt ")))
