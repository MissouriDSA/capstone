library(plyr)
library(tidyverse)
library(rtweet)

#make sure it's a data frame!
df6 = as.data.frame(week_after_sb_3)
#strip down to actual tweet only
s6 <- df6$text

# check check
#summary(s6)
#str(s6)

#remove non-graphical characters
s6 <- iconv(s6, 'UTF-8', 'ASCII')
#remove non-graphical characters

s6<- tolower(s6)
#check
#head(s6,2)
#more cleaning
s6<- stringr::str_replace_all(s6, "@\\S+", "")
s6 <- stringr::str_replace_all(s6, "https?:[[:graph:]]+", "")
#check
#head(s6,3)

s6 <-stringr::str_replace_all(s6, "#", "")
#head(s6,3)
s6 <- stringr::str_replace_all(s6, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
#head(s6,3)

## MORE CLEANING
s6 <- stringr::str_replace_all(s6, "\\n+", "")
s6 <- stringr::str_replace_all(s6, "\\t+", "")
s6 <- stringr::str_replace_all(s6, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
#head(s6,3)

#unlist to start tokenization
w6 <- unlist(strsplit(s6, "\\s+"), use.names = FALSE)
#head(w6,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
w6 <- lapply(w6, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
w6 <- lapply(w6, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds6 <- table(unlist(w6))
top_wds6 <- names(sort(wds6, decreasing=TRUE)[1:200])
#head(top_wds6, 20)

##Now let's get the count of the top words used ##
t6 <- wds6[names(wds6) %in% c(wds6)]
top6 <- data_frame(
  count= "Number",
  word=names(t6),
  n=as.integer(t6)
)
arrange(top6, desc(n))