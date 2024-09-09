# analysis.r
library(tidyverse)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Before CLT
ishango.before <- read.csv("ishango/noCLT/ishango.csv")
ishango.before.long <- pivot_longer(ishango.before, cols=everything(), names_to="language", values_to="runtime")
ggplot(ishango.before.long, aes(sample=(runtime)))+
  stat_qq(col="green")+
  stat_qq_line(col="blue")+
  facet_wrap(~language, scales="free")+
  labs(x="quantiles", y="ms")

# After CLT
ishango.after <- read.csv("ishango/fifteen30/ishango_mean.csv")

ishango.after.long <- pivot_longer(ishango.after, cols=everything(), names_to="language", values_to="runtime")
ggplot(ishango.after.long, aes(sample=(runtime)))+
  stat_qq(col="coral")+
  stat_qq_line(col="blue")+
  facet_wrap(~language, scales="free")+
  labs(x="quantiles", y="ms")


pilot <- read.csv("pilotData.csv")
pilot.long <- pivot_longer(pilot, cols=C:R, names_to = "language", values_to = "runtime")
ggplot(pilot.long, aes(x=language, y=log(runtime), group=Hardware, color=Hardware))+
  geom_point()+
  geom_line()+
  labs(title= "Interaction Graph",
       x= "Progamming Language",
       y= "Runtime")

anova <- aov(runtime~language+Hardware, pilot.long)
anova_log <- aov(log(runtime)~language+Hardware, pilot.long)