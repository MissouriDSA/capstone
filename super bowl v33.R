half <- rbind(top_wds1,top_wds2)
str(half)
summary(half)
str(top_wds1)
summary(t1)
str(t1)
tt1 = as.data.frame(t1)
ttt1 = as.data.frame(top1)

str(ttt1)
str(tt1)
head(tt1)

head(tt1, 20)
head(ttt1, 20)

ttt2 = as.data.frame(top2)
ttt3 = as.data.frame(top3)

half <- rbind(ttt1,ttt2)
all <- rbind(half,ttt3)
head(all)
arrange(all, desc(n))
