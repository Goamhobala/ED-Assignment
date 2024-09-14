# analysis.r
library(tidyverse)
library(gridExtra)
library(kableExtra)
library(qqplotr)
library(formattable)
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
  stat_qq(col="coral") +
  stat_qq_line(col="blue") +
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
analysis.long <- pivot_longer(analysis, cols=C:R, names_to = "Language", values_to = "Runtime")
analysis_interaction <- ggplot(analysis.long, aes(x=Language, y=log(Runtime), group=Hardware, color=Hardware))+
  geom_point()+
  geom_line()+
  labs(title= "Interaction Graph",
       x= "Progamming Language",
       y= "Runtime")

anova <- aov(Runtime~Language + Hardware, analysis.long)
anova_log <- aov(log(Runtime)~Language + Hardware, analysis.long)
anova_log.residauls = residuals(anova_log)
anova_qq <- ggplot(data.frame(anova_log.residauls), aes(sample=(anova_log.residauls)))+
  geom_qq(col="firebrick", size=2.5)+
  geom_qq_line(col="deepskyblue4", size=1, alpha=0.75)+
  labs(x="Quantile", y="Runtime log(ms)")
  

anova_residuals_fitted <- ggplot(anova_log,aes(x=fitted(anova_log), y=anova_log.residauls))+
  geom_point(col="firebrick")+
  geom_smooth(col="deepskyblue4", size=1, alpha=0, )

frame <- data.frame(summary(anova_log)[[1]])
colnames(frame) <- c("Df", "Sum sq", "Mean sq", "F value", "Pr(>F)")
frame$'Pr(>F)' <- ifelse(is.na(frame$'Pr(>F)'), "", '< 0.0001')
frame$'F value' <- as.numeric(frame$'F value')
frame$'F value' <- ifelse(is.na(frame$'F value'), "", round(frame$'F value', digits=4) )

kable(frame, format="markdown", escape=FALSE, digits=4, align=c("r", "r", "r", "r", "r", "r")) %>% kable_styling(latex_options = "striped")
shapiro.test(anova_log.residauls)


middleTRNew.before <-read.csv("middleTRNew/middleTRNewBefore.csv")
middleTRNew.before.long <- pivot_longer(middleTRNew.before, cols=everything(), names_to="language", values_to="runtime")
ggplot(middleTRNew.before.long, aes(x=language, y=log(runtime), color=language))+
  geom_point(alpha=0.3, position=position_jitter(height=1, width=0.3))+
  labs(x="Language", y="Runtime (log(ms))", title="Jittered Graph of Runtime for Programming Languages")


shapiro = c()

# pairwise comparisons
analysis_mean = read.csv("analysis_mean.csv")
kable(data.frame(analysis_mean), format="pandoc")

analysis_tukey = read.csv("analysis_tukey.csv")
HSD = 0.2535
# Ensure analysis_tukey is a data frame
analysis_tukey <- data.frame(analysis_tukey)

# Define a colour formatter function
colour_cell <- formatter("span", 
                         style = x ~ style(
                           background = ifelse(x < HSD & x > 0, "#a10505","#025c78"),
                           background = ifelse(x == 0,"white" , "" ),
                           color = "white",
                           text_align="right"
                         ))

# Apply formattable with correct syntax
table_tukey <- formattable(analysis_tukey, 
                           list(DIFFERENCE = formatter("span",style= x~ style("font-weight" = "bold")),
                                C = colour_cell,
                                CPP = colour_cell,
                                Java = colour_cell,
                                Python = colour_cell,
                                Ruby = colour_cell,
                                R = colour_cell))

# Display the formatted table
table_tukey

# Display the formatted table
table_tukey

#for (i in 1:7):
  #shapiro <- c(shapiro.test(pilot))