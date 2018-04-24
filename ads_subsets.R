library(ggplot2)
library(tidyverse)
library(scales)
show_col(hue_pal()(18))

sb_simple = as.data.frame(SuperBowlLive_simple)
#sb_simple <- sb_simple[ -c(12:16)]
auto <- sb_simple[sb_simple$Business=="Auto",]
auto <- na.omit(auto)

cellular <- sb_simple[sb_simple$Business=="Cellular",] %>% na.omit(cellular)
clothing <- sb_simple[sb_simple$Business=="Clothing",] %>% na.omit(clothing)
electronics <- sb_simple[sb_simple$Business=="Electronics",] %>% na.omit(electronics)
financial <- sb_simple[sb_simple$Business=="Financial",] %>% na.omit(financial)
food <- sb_simple[sb_simple$Business=="Food",] %>% na.omit(food)
gaming <- sb_simple[sb_simple$Business=="Gaming",] %>% na.omit(gaming)
home <- sb_simple[sb_simple$Business=="Home",] %>% na.omit(home)
lifestyle <- sb_simple[sb_simple$Business=="Lifestyle",] %>% na.omit(lifestyle)
media <- sb_simple[sb_simple$Business=="Media",] %>% na.omit(media)
movie <- sb_simple[sb_simple$Business=="Movie",] %>% na.omit(movie)
news <- sb_simple[sb_simple$Business=="News",] %>% na.omit(news)
sports <- sb_simple[sb_simple$Business=="Sports",] %>% na.omit(sports)
travel <- sb_simple[sb_simple$Business=="Travel",] %>% na.omit(travel)
tv <- sb_simple[sb_simple$Business=="TV",] %>% na.omit(tv)

## Now let's plot some business-specific charts!!!
auto_plot <- ggplot(data=auto) + geom_bar(mapping = aes(x=Commercial, fill=Business))
auto_plot
ggplot(data=auto) + geom_point(mapping = aes(x=Commercial, y=Quarter, fill=Business, color=Corporation))

#overall ads by industry by quarter
p1 <- ggplot(data=sb_simple) + geom_point(aes(x=Commercial, y=Quarter, color=Business))
p1 + labs(title="Breaking down ads by quarter",x="Ads by Industry", y="Ads per Quarter")

p2 <- ggplot(data=sb_simple) + geom_point(aes(x=Commercial, y=Quarter, shape=Women_Speak, color=Business))
p2 + labs(title="Which industry lets women speak?",x="Ads Sequentially Aired", y="Ads by Quarter")

ggplot(data=auto) + geom_bar(mapping = aes(x=Commercial, fill=Business, width=1)) 
ggplot(data=sb_simple) + geom_bar(mapping = aes(x=Commercial, fill=Business)) + facet_grid(Business ~ .) + labs(y=NULL) 

facet <- ggplot(data=sb_simple) + geom_point(mapping = aes(x=Commercial,y=Business, colour=Business)) + facet_grid(Business ~ ., scales="free",space="free")
facet + theme(
  axis.text.y = element_blank(),
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=45),
  strip.text.y=element_text(angle=0),
  legend.position = "none")

women_talk<-ggplot(data=sb_simple) + geom_point(mapping = aes(x=Commercial,y=Business, colour=Women_Speak)) + scale_color_manual(values=c("#377eb8","#A9A9A9","#FF1493"))
women_talk
w_facet<-women_talk + facet_grid(Business ~ ., scales="free",space="free")
facet2 <- ggplot(data=sb_simple) + geom_point(mapping = aes(x=Commercial,y=Business, colour=Women_Speak)) + scale_fill_manual(values=c("#377eb8","#FF1493","#A9A9A9")) + facet_grid(Business ~ ., scales="free",space="free")

w_facet + theme(
  axis.text.y = element_blank(),
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=45),
  strip.text.y=element_text(angle=0))

#################
women_corp<-ggplot(data=sb_simple) + geom_point(mapping = aes(x=Corporation,y=Women_Speak, colour=Women_Speak)) + scale_color_manual(values=c("#377eb8","#FF1493"))
wf<-women_corp + facet_grid(Business ~ ., scales="free",space="free")
#################
women_corp + theme(
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=90),
  strip.text.y=element_text(angle=0))
############
wf + theme(
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=90),
  strip.text.y=element_text(angle=0))
##############

wc2<-ggplot(data=sb_simple) + geom_point(mapping = aes(x=Corporation,y=Business, colour=Women_Speak)) + scale_color_manual(values=c("#377eb8","#FF1493"))

wc3<-wc2 + facet_wrap(~Women_Speak, nrow=2)

wc3 + theme(
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=90),
  strip.text.y=element_text(angle=0))

wf2 + theme(
  axis.ticks.y = element_blank(),
  axis.text.x = element_text(angle=90),
  strip.text.y=element_text(angle=0))

ggplot(data=auto) + geom_point(aes(Corporation,Category, color=Women_Speak, size=3)) + scale_color_manual(values=c("#377eb8","#FF1493"))
ff<-ggplot(data=sb_simple) + geom_point(aes(Category, Corporation, color=Women_Speak))+ scale_color_manual(values=c("#377eb8","000000", "#FF1493"))
ff

ff2<-ggplot(data=sb_simple) + geom_point(aes(Category, Corporation, color=Business))
ff2

ff4<-ggplot(data=sb_simple) + geom_point(aes(Time, Corporation, color=Business))
ff4
