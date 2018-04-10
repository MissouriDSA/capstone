library(plyr)
library(tidyverse)
library(rtweet)

#make sure it's a data frame!
df5 = as.data.frame(week_after_sb_2)
#strip down to actual tweet only
s5 <- df5$text

# check check
#summary(s5)
#str(s5)

#remove non-graphical characters
s5 <- iconv(s5, 'UTF-8', 'ASCII')
#remove non-graphical characters

s5<- tolower(s5)
#check
#head(s5,2)
#more cleaning
s5<- stringr::str_replace_all(s5, "@\\S+", "")
s5 <- stringr::str_replace_all(s5, "https?:[[:graph:]]+", "")
#check
#head(s5,3)

s5 <-stringr::str_replace_all(s5, "#", "")
#head(s5,3)
s5 <- stringr::str_replace_all(s5, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
#head(s5,3)

## MORE CLEANING
s5 <- stringr::str_replace_all(s5, "\\n+", "")
s5 <- stringr::str_replace_all(s5, "\\t+", "")
s5 <- stringr::str_replace_all(s5, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
#head(s5,3)

#unlist to start tokenization
w5 <- unlist(strsplit(s5, "\\s+"), use.names = FALSE)
#head(w5,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
w5 <- lapply(w5, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
w5 <- lapply(w5, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds5 <- table(unlist(w5))
top_wds5 <- names(sort(wds5, decreasing=TRUE)[1:200])
#head(top_wds5, 20)

##Now let's get the count of the top words used ##
t5 <- wds5[names(wds5) %in% c(wds5)]
top5 <- data_frame(
  count= "Number",
  word=names(t5),
  n=as.integer(t5)
)
arrange(top5, desc(n))