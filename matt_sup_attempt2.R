sb2 <- read.csv("SuperBowlPOST.csv", stringsAsFactors = FALSE)
sb2 <- sb2$hashtags

wa1 <- sb2[1:24]
wa2 <- sb2[25:50]
wa3 <- sb2[51:67]

token <- twitter_token

rt_wa1 <- rtweet:::search_tweets(
  paste(wa1, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_wa1, "week_after_sb_1.rds")
Sys.sleep(15 * 60)

rt_wa2 <- rtweet:::search_tweets(
  paste(wa2, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_wa2, "week_after_sb_2.rds")
Sys.sleep(15 * 60)

rt_wa3 <- rtweet:::search_tweets(
  paste(wa3, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt_wa3, "week_after_sb_3.rds")
Sys.sleep(15 * 60)