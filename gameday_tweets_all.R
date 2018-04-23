tweets1 = as.data.frame(tweets_set1)
tweets2 = as.data.frame(tweets_set2)
tweets3 = as.data.frame(tweets_set3)

half = rbind(tweets1, tweets2)
all = rbind(half, tweets3)