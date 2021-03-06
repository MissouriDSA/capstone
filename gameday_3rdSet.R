library(plyr)
library(tidyverse)

df3 = as.data.frame(sb_tweets_3)

s3 <- df3$text
summary(s3)
str(s3)

#remove non-graphical characters
s3 <- iconv(s3, 'UTF-8', 'ASCII')
#remove non-graphical characters

s3<- tolower(s3)
head(s3,2)

s3<- stringr::str_replace_all(s3, "@\\S+", "")
s3 <- stringr::str_replace_all(s3, "https?:[[:graph:]]+", "")
head(s3,3)

s3 <-stringr::str_replace_all(s3, "#", "")
head(s3,3)
s3 <- stringr::str_replace_all(s3, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
head(s3,3)


s3 <- stringr::str_replace_all(s3, "\\n+", "")
s3 <- stringr::str_replace_all(s3, "\\t+", "")
s3 <- stringr::str_replace_all(s3, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
head(s3,3)

w3 <- unlist(strsplit(s3, "\\s+"), use.names = FALSE)
head(w3,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
ws3 <- lapply(w3, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
ws3 <- lapply(ws3, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds3 <- table(unlist(w3))
top_wds3 <- names(sort(wds3, decreasing=TRUE)[1:200])
head(top_wds3,20)

##Now let's get the count of the top words used ##
t3 <- wds2[names(wds3) %in% c(top_wds2)]
top3 <- data_frame(
  count= "Number",
  word=names(t3),
  n=as.integer(t3)
)
arrange(top3, desc(n))