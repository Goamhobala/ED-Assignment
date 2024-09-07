# analysis.r
library(tidyverse)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
ishango <- read.csv("ishango/heavy/ishango_mean.csv")
ishango.c <- ishango$c
ishango.cpp <- ishango$cpp
ishango.java <- ishango$java
ishango.python <- ishango$python
ishango.ruby <- ishango$ruby
ishango.r <- ishango$r

ishango_long <- pivot_longer(ishango, cols=everything(), names_to="language", values_to="runtime")
ggplot(ishango_long, aes(sample=(runtime)))+
  stat_qq(col="coral")+
  stat_qq_line(col="blue")+
  facet_wrap(~language, scales="free")+
  labs(x="quantiles", y="ms")