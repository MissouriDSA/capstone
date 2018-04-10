library(plyr)
library(tidyverse)

#make sure it's a data frame!
df4 = as.data.frame(week_after_sb_1)
#strip down to actual tweet only
s4 <- df4$text

# check check
#summary(s4)
#str(s4)

#remove non-graphical characters
s4 <- iconv(s4, 'UTF-8', 'ASCII')
#remove non-graphical characters

s4<- tolower(s4)
#check
#head(s4,2)
#more cleaning
s4<- stringr::str_replace_all(s4, "@\\S+", "")
s4 <- stringr::str_replace_all(s4, "https?:[[:graph:]]+", "")
#check
#head(s4,3)

s4 <-stringr::str_replace_all(s4, "#", "")
#head(s4,3)
s4 <- stringr::str_replace_all(s4, "[[:punct:]]+\\b|\\b[[:punct:]]+", "")
#head(s4,3)

## MORE CLEANING
s4 <- stringr::str_replace_all(s4, "\\n+", "")
s4 <- stringr::str_replace_all(s4, "\\t+", "")
s4 <- stringr::str_replace_all(s4, "[[\\s]]+\\A|[[\\s]]+\\Z", "")
#head(s4,3)

#unlist to start tokenization
w4 <- unlist(strsplit(s4, "\\s+"), use.names = FALSE)
#head(w4,20)

## use stopwords list from rtweet
stopwords <- rtweet::stopwordslangs$word[rtweet::stopwordslangs$p > .999]

## remove stopwords
w4 <- lapply(w4, function(x) return(x[!tolower(x) %in% c("", stopwords)]))

## remove all non-letter characters and drop empty tokens
w4 <- lapply(w4, function(x) {
  x <- stringr::str_replace_all(x, "\\W", "")
  x[x != ""]
})
wds4 <- table(unlist(w4))
top_wds4 <- names(sort(wds4, decreasing=TRUE)[1:200])
#head(top_wds4, 20)

##Now let's get the count of the top words used ##
t4 <- wds4[names(wds4) %in% c(wds4)]
top4 <- data_frame(
  count= "Number",
  word=names(t4),
  n=as.integer(t4)
)
arrange(top4, desc(n))