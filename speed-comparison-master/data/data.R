# analysis.r
library(tidyverse)
library(gridExtra)
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



analysis <- read.csv("analysis.csv")
analysis.long <- pivot_longer(analysis, cols=C:R, names_to = "language", values_to = "runtime")
ggplot(analysis.long, aes(x=language, y=log(runtime), group=Hardware, color=Hardware))+
  geom_point()+
  geom_line()+
  labs(title= "Interaction Graph",
       x= "Progamming Language",
       y= "Runtime")

anova <- aov(runtime~language + Hardware, analysis.long)
anova_log <- aov(log(runtime)~language + Hardware, analysis.long)
anova_log.residauls = resid(anova_log)
ggplot(data.frame(anova_log.residauls), aes(sample=(anova_log.residauls)))+
  stat_qq(col="coral")+
  stat_qq_line(col="blue")+
  labs(x="Quantiles", y="log(ms)")
shapiro.test(anova_log.residauls)


middleTRNew.before <-read.csv("middleTRNew/middleTRNewBefore.csv")
middleTRNew.before.long <- pivot_longer(middleTRNew.before, cols=everything(), names_to="language", values_to="runtime")
ggplot(middleTRNew.before.long, aes(x=language, y=log(runtime), color=language))+
  geom_point(alpha=0.3, position=position_jitter(height=1, width=0.3))+
  labs(x="Language", y="Runtime (log(ms))", title="Jittered Graph of Runtime for Programming Languages")

ggplot(middleTRNew.before.long, aes(sample=(runtime)))+
  stat_qq(col="green")+
  stat_qq_line(col="blue")+
  facet_wrap(~language, scales="free")+
  labs(x="quantiles", y="ms")

table_anova <- summary(anova_log)
table_anova
tableGrob(as.data.frame(table_anova))

shapiro = c()


#for (i in 1:7):
  #shapiro <- c(shapiro.test(pilot))