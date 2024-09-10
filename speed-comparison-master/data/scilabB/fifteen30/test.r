this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
test <- read.csv("scilabB.csv", sep=",")

