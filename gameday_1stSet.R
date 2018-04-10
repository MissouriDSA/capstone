library(plyr)
library(tidyverse)

df1 = as.data.frame(rt1sb)

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
head(s,3)

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
w1 <- lapply(w1, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
w1 <- lapply(w1, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds1 <- table(unlist(w1))
top_wds1 <- names(sort(wds1, decreasing=TRUE)[1:200])
head(top_wds1, 20)

###### test of set 1 complete, moving to merge and re-run
###### TOO LARGE TO COMPUTE ON LAPTOP ##############
#df2 = as.data.frame(set2)
#df3 = as.data.frame(set3)

#sb_half <- rbind(df, df2)
#sb_all <- rbind(sb_half, df3)

#sb = sb_all

#sb<- tolower(sb)

#sb<- stringr::str_replace_all(sb, "@\\S+", "")
#sb <- stringr::str_replace_all(sb, "https?:[[:graph:]]+", "")

#sb <-stringr::str_replace_all(sb, "#", "")

#sb <- stringr::str_replace_all(sb, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
## remove stopwords
#sbw <- lapply(sbw, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
#sbw <- lapply(sbw, function(x) {
#  x <- stringr::str_replace_all(x, "\\W", "")
#  x[x != ""]
#})
#sbwds <- table(unlist(sbw))
#top_sbwds <- names(sort(sbwds, decreasing=TRUE)[1:200])
#head(top_sbwds)
#sb <- stringr::str_replace_all(sb, "\\n+", "")
#sb <- stringr::str_replace_all(sb, "\\t+", "")
#sb <- stringr::str_replace_all(sb, "[[\\s]]+\\A|[[\\s]]+\\Z", "")


#sbw <- unlist(strsplit(sb, "\\s+"), use.names = FALSE)

###### TOO LARGE TO COMPUTE ON LAPTOP ##############



t1 <- wds1[names(wds1) %in% c(top_wds1)]
top1 <- data_frame(
  count= "Number",
  word=names(t1),
  n=as.integer(t1)
)
arrange(top1, desc(n))
)        