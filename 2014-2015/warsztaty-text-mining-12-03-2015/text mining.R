### R code from vignette source 'tm.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Init
###################################################
library("tm")
data("crude")


###################################################
### code chunk number 2: Ovid
###################################################
txt <- system.file("texts", "txt", package = "tm")
(ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
                 readerControl = list(language = "lat")))


###################################################
### code chunk number 3: VectorSource
###################################################
docs <- c("This is a text.", "This another one.")
VCorpus(VectorSource(docs))


###################################################
### code chunk number 4: Reuters
###################################################
reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- VCorpus(DirSource(reut21578),
                   readerControl = list(reader = readReut21578XMLasPlain))
reuters1 <- reuters[1]

###################################################
### code chunk number 5: tm.Rnw:117-118 (eval = FALSE)
###################################################
## writeCorpus(ovid)


###################################################
### code chunk number 6: tm.Rnw:128-129
###################################################
inspect(ovid[1:2])


###################################################
### code chunk number 7: tm.Rnw:133-135
###################################################
meta(ovid[[2]], "id")
identical(ovid[[2]], ovid[["ovid_2.txt"]])


###################################################
### code chunk number 8: tm.Rnw:149-150
###################################################
reuters <- tm_map(reuters, stripWhitespace)


###################################################
### code chunk number 9: tm.Rnw:155-156
###################################################
reuters <- tm_map(reuters, content_transformer(tolower))


###################################################
### code chunk number 10: Stopwords
###################################################
reuters <- tm_map(reuters, removeWords, stopwords("english"))


###################################################
### code chunk number 11: Stemming
###################################################
reuters <- tm_map(reuters, stemDocument)

inspect(reuters1[1])
inspect(reuters[1])

###################################################
### code chunk number 12: tm.Rnw:187-190
###################################################
idx <- meta(reuters, "id") == '237' &
  meta(reuters, "heading") == 'INDONESIA SEEN AT CROSSROADS OVER ECONOMIC CHANGE'
reuters[idx]
inspect(reuters[idx])

###################################################
### code chunk number 13: DublinCore
###################################################
DublinCore(crude[[1]], "Creator") <- "Ano Nymous"
meta(crude[[1]])




###################################################
### code chunk number 15: tm.Rnw:242-244
###################################################
dtm <- DocumentTermMatrix(reuters)
dtm
inspect(dtm[5:10, 740:743])


###################################################
### code chunk number 16: tm.Rnw:253-254
###################################################
findFreqTerms(dtm, 5)


###################################################
### code chunk number 17: tm.Rnw:259-260
###################################################
findAssocs(dtm, "opec", 0.8)


###################################################
### code chunk number 18: tm.Rnw:268-269
###################################################
inspect(removeSparseTerms(dtm, 0.4))


###################################################
### code chunk number 19: tm.Rnw:283-285
###################################################
inspect(DocumentTermMatrix(reuters,
                           list(dictionary = c("prices", "crude", "oil"))))

#wazenie
inspect(weightTf(dtm)[1:10,1:10])



####################################################################




library(stringi)

id <- c(12642756,12642753,12641809,12637123,12642414,12642408)
opis <- character(6)

for(i in 1:6){
  opis[i] <- stri_extract_first_regex(stri_flatten(
    readLines(sprintf(
      "http://www.americanbookstore.pl/x_C_I__P_%s-12610001.html",id[i])),col=""),
                                      "(?<=Description of book:&nbsp;<font class=bluebok>).+?(?=</font><br>)")
}
opis[6]

docs <- Corpus(VectorSource(opis))

inspect(docs[1]) 

docs1 <- tm_map(docs, PlainTextDocument)
docs1 <- tm_map(docs1, stripWhitespace)
docs1 <- tm_map(docs1, tolower)
docs1 <- tm_map(docs1, removeWords, stopwords("english"))
docs1 <- tm_map(docs1, removePunctuation)

inspect(docs[1])
inspect(docs1[1])

docs1 <- tm_map(docs1, PlainTextDocument)

TDM <- DocumentTermMatrix(docs1)
rownames(TDM) <- c("H1","H2","GoT1","GoT2","W1","W2")

dist(TDM)


