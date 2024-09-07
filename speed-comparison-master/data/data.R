# analysis.r
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
ishango <- read.csv("ishango/pc2/pc2.csv")
ishango.c <- ishango$c
ishango.cpp <- ishango$cpp
ishango.java <- ishango$java
ishango.python <- ishango$python
ishango.ruby <- ishango$ruby
ishango.r <- ishango$r
