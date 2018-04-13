install.packages("twitteR")
tweets.df <- all
write_as_csv(all, "C:/Users/Matt/Documents/ApptoMap/tweets.csv")

library(leaflet)
library(maps)
mymap<- read.csv("C:/Users/Matt/Documents/ApptoMap/tweets.csv", stringsAsFactors=FALSE)
m <- leaflet(mymap) %>% addTiles()


m %>% addCircles(lng = ~longitude, 
                 lat = ~latitude, 
                 popup = mymap$type, 
                 weight = 8, 
                 radius = 40, 
                 color = "#fb3004", 
                 stroke = TRUE, 
                 fillOpacity = 0.6) 
