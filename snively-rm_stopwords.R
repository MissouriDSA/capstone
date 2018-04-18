## remove stopwords (using stop words supplied by tidytext pkg)
rm_stopwords <- function(x, stopwords = NULL) {
  wordbreakor <- function(x) {
    x <- paste(x, collapse = "\\b|\\b")
    paste0("\\b", x, "\\b")
  }
  if (is.null(stopwords)) {
    if (!requireNamespace("tidytext", quietly = TRUE)) {
      install.packages("tidytext")
    }
    stopwords <- c(
      tidytext::stop_words$word[tidytext::stop_words$lexicon == "SMART"],
      0:9
    )
  }
  stopwords <- wordbreakor(stopwords)
  x <- gsub(stopwords, "", x, perl = TRUE, ignore.case = TRUE)
  trim_ws(x)
}
## trim white space function
trim_ws <- function(x) {
  x <- gsub("\\s{2,}", " ", x)
  gsub("^\\s|\\s$", "", x)
}


## get some tweets to test function on (uncomment next line to test)
#x <- rtweet::search_tweets("lang:en")

## use rm_stopwords function (uncomment next line to test)
#rm_stopwords(x$text)
