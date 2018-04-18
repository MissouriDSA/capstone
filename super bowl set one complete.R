library(plyr)
library(tidyverse)

sb_tweets_1 <- readRDS('sb_tweets_1')

df1 = as.data.frame(sb_tweets_1)

s1 <- df1$text
summary(s1)
str(s1)

#remove non-graphical characters
s1 <- iconv(s1, 'UTF-8', 'ASCII')
#remove non-graphical characters

s1<- tolower(s1)
head(s1,2)

s1<- stringr::str_replace_all(s1, "@\\S+", "")
s1 <- stringr::str_replace_all(s1, "https?:[[:graph:]]+", "")
head(s1,3)

s1 <-stringr::str_replace_all(s1, "#", "")
head(s1,3)
s1 <- stringr::str_replace_all(s1, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
head(s1,3)


s1 <- stringr::str_replace_all(s1, "\\n+", "")
s1 <- stringr::str_replace_all(s1, "\\t+", "")
s1 <- stringr::str_replace_all(s1, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
head(s1,3)

w1 <- unlist(strsplit(s1, "\\s+"), use.names = FALSE)
head(w1,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
ws1 <- lapply(w1, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
ws1 <- lapply(ws1, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds1 <- table(unlist(ws1))
top_wds1 <- names(sort(wds1, decreasing=TRUE)[1:200])
head(top_wds1, 20)

t1 <- wds1[names(wds1) %in% c(top_wds1)]
top1 <- data_frame(
  count= "Number",
  word=names(t1),
  n=as.integer(t1)
)
arrange(top1, desc(n))