sb <- read.csv("SuperBowlPOST.csv", stringsAsFactors = FALSE)
sb <- sb$hashtags

sb1 <- sb[1:24]
sb2 <- sb[25:50]
sb3 <- sb[51:88]

token <- rtweet:::system_tokens()[[3]]

rt1sb <- rtweet:::search_tweets(
  paste(sb1, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt1sb, "rt1sb.rds")

rt2sb <- rtweet:::search_tweets(
  paste(sb2, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt2sb, "rt2sb.rds")

rt3sb <- rtweet:::search_tweets(
  paste(sb3, collapse = " OR "),
  until = "2018-02-05", n = 3e5,
  token = token,
  retryonratelimit = TRUE)
saveRDS(rt3sb, "rt3sb.rds")