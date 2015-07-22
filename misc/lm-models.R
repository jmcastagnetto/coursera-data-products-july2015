library(HistData)
data("GaltonFamilies")
gf <- GaltonFamilies

# convert from inches to cm
library(dplyr)
gf <- gf %>% mutate(fh=father*2.54,
                    mh=mother*2.54,
                    mph=midparentHeight*2.54,
                    ch=childHeight*2.54)

str(gf)
summary(gf)

m0 <- lm(ch ~ mph, data=gf)
summary(m0)
p0 <- predict(m0)

m1 <- lm(ch ~ fh + mh + gender + children, data=gf)
summary(m1)
p1 <- predict(m1)

m2 <- lm(ch ~ fh + mh + gender, data=gf)
summary(m2)
p2 <- predict(m2)

m3 <- lm(ch ~ mph + gender, data=gf)
summary(m3)
p3 <- predict(m3)

plot(gf$ch ~ p1, col=gf$gender, pch=(as.numeric(gf$gender) + 20))
plot(gf$ch ~ p2, col=gf$gender)
plot(gf$ch ~ p3, col=gf$gender)

library(GGally)
ggpairs(gf[c("ch", "fh", "mh", "gender")], binwidth=10)
