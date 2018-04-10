
setwd("/Users/Matt/Desktop/DSA/Capstone")
sb2 <- read.csv("SuperBowlPOST.csv", stringsAsFactors = FALSE)
sb2 <- sb2$hashtags

wa1 <- sb2[1:24]
wa2 <- sb2[25:50]
wa3 <- sb2[51:67]

token <- twitter_token

rt_2wa1 <- rtweet:::search_tweets(
  paste(wa1, collapse = " OR "),
  until = "2018-02-17", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_2wa1, "2weeksLater1.rds")
Sys.sleep(15 * 60)

rt_2wa2 <- rtweet:::search_tweets(
  paste(wa2, collapse = " OR "),
  until = "2018-02-17", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_2wa2, "2weeksLater2.rds")
Sys.sleep(15 * 60)

rt_2wa3 <- rtweet:::search_tweets(
  paste(wa3, collapse = " OR "),
  until = "2018-02-17", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_2wa3, "2weeksLater3.rds")
Sys.sleep(15 * 60)