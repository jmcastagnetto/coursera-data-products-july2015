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

# Very slight modification from http://stackoverflow.com/a/19990107
ggQQ = function(lm) {
  # extract standardized residuals from the fit
  d <- data.frame(std.resid = rstandard(lm))
  # calculate 1Q/4Q line
  y <- quantile(d$std.resid[!is.na(d$std.resid)], c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y)/diff(x)
  int <- y[1L] - slope * x[1L]

  p <- ggplot(data=d, aes(sample=std.resid)) +
    stat_qq(shape=1, size=3) +           # open circles
    labs(title="Normal Q-Q",             # plot title
         x="Theoretical Quantiles",      # x-axis label
         y="Standardized Residuals") +   # y-axis label
    geom_abline(slope = slope, intercept = int, linetype="dashed") + # dashed reference line
    theme_light()
  return(p)
}

ggQQ(m2)

library(GGally)
ggpairs(gf[c("ch", "fh", "mh", "gender")], binwidth=10)
