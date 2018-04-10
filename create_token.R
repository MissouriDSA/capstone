install.packages("rtweet")
library(rtweet)
## whatever name you assigned to your created app
appname <- "sb_token"

## api key (example below is not a real key)
key <- "1i5JXKD6VjsCmKhFSQJyv9QiV"

## api secret (example below is not a real key)
secret <- "vkFCL4FTkUC3w67wDvDmdVbcvHJiqr1nSCefPXrKEorTY1D44v"

## create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)
##
## path of home directory
home_directory <- path.expand("~/")

## combine with name for token
file_name <- file.path(home_directory, "twitter_token.rds")

## save token to home directory
saveRDS(twitter_token, file = file_name)

##
## On my mac, the .Renviron text looks like this:
##TWITTER_PAT=/Users/Matt/Documents/.rtweet_token.rds

## assuming you followed the procodures to create "file_name"
##     from the previous code chunk, then the code below should
##     create and save your environment variable.
cat(paste0("TWITTER_PAT=", file_name),
    file = file.path(home_directory, ".Renviron"),
    append = TRUE)