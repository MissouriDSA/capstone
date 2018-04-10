# Combine the top 200 terms from each data set for a total set of 600 words#
DFtp1 = as.data.frame(top1)
DFtp2 = as.data.frame(top2)
DFtp3 = as.data.frame(top3)

DF_half <- rbind(DFtp1, DFtp2)
DF_all <- rbind(DF_half, DFtp3)

DF = DF_all

# Display top words of complete set #

arrange(DF, desc(n))

install.packages(sqldf)
library(sqldf)

p<-ggplot(data=DF, aes(x=word, y=n)) + geom_bar(stat = "identity")
p+coord_flip()

subwords <- subset(DF, n>20000, select=c(count, word, n))
p1<-ggplot(data = subwords, aes(x=word,y=n)) + geom_bar(stat="identity")
p1+coord_flip()

library("wordcloud")
set.seed(1234)
#first plot--all top words
wordcloud(words=DF$word, freq=DF$n, min.freq = 1, max.words = 600, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8,"Dark2"))
# plot with 200 words          
wordcloud(words=DF$word, freq=DF$n, min.freq = 100, max.words = 200, random.order = FALSE, rot.per = 0.5, colors = brewer.pal(6,"Set2"))
# plot with
wordcloud(words=DF$word, freq=DF$n, min.freq = 1, max.words = 50, random.order = FALSE, rot.per = 0.5, ordered.colors = FALSE, colors = brewer.pal(8,"Dark2"))

wordcloud(words=DF$word, freq=DF$n, min.freq = 50, max.words = 50, random.order = FALSE, rot.per = 0, colors = brewer.pal(8,"Dark2"))



# use leaflet to draw some maps
#library(leaflet)
#library(maps)
#m<-leaflet(mymap) %>% addTiles()

head(DF)

