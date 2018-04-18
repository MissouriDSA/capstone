library(plyr)
library(tidyverse)

sb_tweets_2 <- readRDS('sb_tweets_2')

df2 = as.data.frame(sb_tweets_2)

s2 <- df2$text
summary(s2)
str(s2)

#remove non-graphical characters
s2 <- iconv(s2, 'UTF-8', 'ASCII')
#remove non-graphical characters

s2<- tolower(s2)
head(s2,2)

s2<- stringr::str_replace_all(s2, "@\\S+", "")
s2 <- stringr::str_replace_all(s2, "https?:[[:graph:]]+", "")
head(s2,3)

s2 <-stringr::str_replace_all(s2, "#", "")
head(s2,3)
s2 <- stringr::str_replace_all(s2, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
head(s2,3)


s2 <- stringr::str_replace_all(s2, "\\n+", "")
s2 <- stringr::str_replace_all(s2, "\\t+", "")
s2 <- stringr::str_replace_all(s2, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
head(s2,3)

w2 <- unlist(strsplit(s2, "\\s+"), use.names = FALSE)
head(w2,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
ws2 <- lapply(w2, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
ws2 <- lapply(ws2, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds2 <- table(unlist(w2))
top_wds2 <- names(sort(wds2, decreasing=TRUE)[1:200])
head(top_wds2,20)

##Now let's get the count of the top words used ##
t2 <- wds2[names(wds2) %in% c(top_wds2)]
top2 <- data_frame(
  count= "Number",
  word=names(t2),
  n=as.integer(t2)
)
arrange(top2, desc(n))