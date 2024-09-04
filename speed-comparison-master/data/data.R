# analysis.r
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
mac_c <- read.csv("macM1/c0.1.csv")
mac_java <- read.csv("macM1/java0.1.csv")

log_mac_java <- log(mac_java)
log_mac_c <- log(mac_c)

sqrt_mac_c <- sqrt(mac_c)
sqrt_mac_java <- sqrt(mac_java)
