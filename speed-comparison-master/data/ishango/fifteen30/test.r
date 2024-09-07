this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
test.c <- read.csv("c.csv")
test.c <- test.c$c
test.cpp <- read.csv("cpp.csv")
test.cpp <- test.cpp$cpp