# analysis.r
library(tidyverse)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
ishango <- read.csv("ishango/pc1/ishango_mean.csv")
ishango.c <- ishango$c
ishango.cpp <- ishango$cpp
ishango.java <- ishango$java
ishango.python <- ishango$python
ishango.ruby <- ishango$ruby
ishango.r <- ishango$r
<<<<<<< HEAD
test <- read.csv("ishango/pc2/pc2.csv")
=======

ishango_long <- pivot_longer(ishango, cols=everything(), names_to="language", values_to="runtime")
ggplot(ishango_long, aes(sample=runtime))+
  stat_qq(col="coral")+
  stat_qq_line(col="blue")+
  facet_wrap(~language, scales="free")
>>>>>>> 775a285 (added qqplots)
