library(readxl)
library(sna)

f_lift <- read_excel("D:/development_TestCase/Product-Position-SNA_R/source/comment_robust_lift.xlsx")
f_jacc <- read_excel("D:/development_TestCase/Product-Position-SNA_R/source/comment_robust_jaccard.xlsx")
f_incu <- read_excel("D:/development_TestCase/Product-Position-SNA_R/source/comment_robust_incur.xlsx")
f_cosi <- read_excel("D:/development_TestCase/Product-Position-SNA_R/source/comment_robust_cosine.xlsx")

rn1 <- as.matrix(f_jacc[,1])
f_jacc <- f_jacc[2:6]
row.names(f_jacc) <- rn1

rn2 <- as.matrix(f_lift[,1])
f_lift <- f_lift[2:6]
row.names(f_lift) <- rn2

rn3 <- as.matrix(f_incu[,1])
f_incu <- f_incu[2:6]
row.names(f_incu) <- rn3

rn4 <- as.matrix(f_cosi[,1])
f_cosi <- f_cosi[2:6]
row.names(f_cosi) <- rn4

g <- list(f_lift,f_jacc,f_incu,f_cosi)

#Perform qap tests of graph correlation
q.12<-qaptest(g,gcor,g1=1,g2=2)
summary(q.12)

q.13<-qaptest(g,gcor,g1=1,g2=3)
summary(q.13)

q.14<-qaptest(g,gcor,g1=1,g2=4)
summary(q.14)

q.23<-qaptest(g,gcor,g1=2,g2=3)
summary(q.23)

q.24<-qaptest(g,gcor,g1=2,g2=4)
summary(q.24)

q.34<-qaptest(g,gcor,g1=3,g2=4)
summary(q.34)
