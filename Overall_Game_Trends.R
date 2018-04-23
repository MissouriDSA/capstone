library(tidyverse)
library(rtweet)
library(wordcloud)

live = as.data.frame(SuperBowlLive_additions)

sbdf = as.data.frame(sb)
sbdf <- sbdf[1:67,]

library(wordcloud)
set.seed(123)

#hashtag cloud
wordcloud(words = sbdf, scale = c(3,0.8),max.words = Inf, random.order = FALSE, random.color = TRUE, rot.per = 0, colors=brewer.pal(11,"Spectral"),ordered.colors = FALSE,use.r.layout = FALSE,fixed.asp = TRUE)

brandsDF = as.data.frame(brands)

#brand cloud
wordcloud(words=brands$brand_names, freq = brands$n, min.freq = 0,scale = c(1.7,0.5), max.words = Inf, random.order = FALSE, random.color = TRUE, rot.per = 0, colors=brewer.pal(11,"Spectral"),ordered.colors = FALSE,use.r.layout = FALSE,fixed.asp = TRUE)
#
#we should repeat this later with mentions added in ###
#
library(ggplot2)

a <- ggplot(data=live) + geom_bar(mapping = aes(x=Quarter,fill=Women_Speak),position="dodge") 
##
a2<- a + scale_fill_manual(values=c("#377eb8","#FF1493","#A9A9A9")) 
a2
##nope, use scale_x_continuous
#a2 + scale_x_discrete(labels=c("0"="Pregame","1"="1st","2"="Second","3"="Third","4"="Fourth","5"="Postgame"))

a2 + scale_x_continuous(name="Did women feature in commercials throughout the game?",breaks=c(0,1,1.5,2,2.5,3,3.5,4,5),labels=c("0"="Pregame","1"="1st","1.5"="1.5","2"="Second","2.5"="Halftime","3"="Third","3.5"="3.5","4"="Fourth","5"="Postgame"))

a3 <- ggplot(data=live) + geom_bar(mapping = aes(x=Quarter,fill=Category))
a3+ scale_x_continuous(name="What kind of commercials appeared the most?",breaks=c(0,1,1.5,2,2.5,3,3.5,4,5),labels=c("0"="Pregame","1"="1st","1.5"="1.5","2"="Second","2.5"="Halftime","3"="Third","3.5"="3.5","4"="Fourth","5"="Postgame"))

a4 <- ggplot(data=live) + geom_bar(mapping = aes(x=Block,fill=Category))
a4+ scale_x_continuous(name="Was each commercial block varied by type?")

a5 <- ggplot(data=live) +geom_bar(mapping = aes(x=Category, fill=Category), width = 1) + coord_polar(theta = "x")+theme(legend.position = "none")
a5
##
a6 <-ggplot(data=live) +geom_bar(mapping = aes(x=factor(1), fill=Women_Speak), width = 1) + coord_polar(theta = "y")+theme_void()
a6 + scale_fill_manual(values=c("#377eb8","#FF1493","#A9A9A9"))
##

a7 <- ggplot(data=live) + geom_bar(mapping = aes(x=Commercial, fill=Business)) 
quarters <- scale_x_continuous(name="Enter Title Here",breaks=c(0,1,1.5,2,2.5,3,3.5,4,5),labels=c("0"="Pregame","1"="1st","1.5"="1.5","2"="Second","2.5"="Halftime","3"="Third","3.5"="3.5","4"="Fourth","5"="Postgame"))
a7 + quarters
a7
a8 <- ggplot(data=live) + geom_bar(mapping = aes(x=factor(1), fill=Business), width = 1) + coord_polar(theta = "y") + theme_void() 
a8


auto <- live[live$Business=="Auto",]
auto <- na.omit(auto)



b <- ggplot(data=live) + geom_bar(mapping = aes(x=Quarter,fill=Category),position="dodge") 
b
c <- ggplot(data=live) + geom_bar(mapping = aes(x=Quarter,fill=Category),position="stack")
c

install.packages("twitteR")
tweets.df <- all
write_as_csv(all, "C:/Users/Matt/Documents/ApptoMap/tweets.csv")

library(leaflet)
library(maps)
read.csv("C:/Users/Matt/Documents/ApptoMap/tweets.csv", stringsAsFactors=FALSE)
