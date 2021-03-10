library(readxl)
library(igraph)
library(sna)

f_jacc <- read_excel("D:/development_TestCase/QAP_Test_PPSNA_R/source/comment_robust_jaccard.xlsx")
f_lift <- read_excel("D:/development_TestCase/QAP_Test_PPSNA_R/source/comment_robust_lift.xlsx")
f_incu <- read_excel("D:/development_TestCase/QAP_Test_PPSNA_R/source/comment_robust_incur.xlsx")
f_cosi <- read_excel("D:/development_TestCase/QAP_Test_PPSNA_R/source/comment_robust_cosine.xlsx")

rn1 <- as.matrix(f_jacc[,1])
f_jacc <- f_jacc[2:8]
row.names(f_jacc) <- rn1

rn2 <- as.matrix(f_lift[,1])
f_lift <- f_lift[2:8]
row.names(f_lift) <- rn2

rn3 <- as.matrix(f_incu[,1])
f_incu <- f_incu[2:8]
row.names(f_incu) <- rn3

rn4 <- as.matrix(f_cosi[,1])
f_cosi <- f_cosi[2:8]
row.names(f_cosi) <- rn4

adjm_jacc <- as.matrix(f_jacc)
adjm_lift <- as.matrix(f_lift)
adjm_incu <- as.matrix(f_incu)
adjm_cosi <- as.matrix(f_cosi)

#g <- array(dim=c(4,7,7))
#g[1,,] <- adjm_jacc
#g[2,,] <- adjm_lift
#g[3,,] <- adjm_incu
#g[4,,] <- adjm_cosi


g <- list(adjm_jacc,adjm_lift,adjm_incu,adjm_cosi)

#Perform qap tests of graph correlation
q.12<-qaptest(g,gcor,g1=1,g2=2, reps=1000)
q.13<-qaptest(g,gcor,g1=1,g2=3, reps=1000)
q.14<-qaptest(g,gcor,g1=1,g2=4, reps=1000)
q.23<-qaptest(g,gcor,g1=2,g2=3, reps=1000)
q.24<-qaptest(g,gcor,g1=2,g2=4, reps=1000)
q.34<-qaptest(g,gcor,g1=3,g2=4, reps=1000)

summary(q.12) # Jacc vs Lift
summary(q.13) # Jacc vs Incursion
summary(q.14) # Jacc vs Cosine
summary(q.23) # Lift vs Incursion
summary(q.24) # Lift vs Cosine
summary(q.34) # Incursion vs Cosine


# Second Methods to test
gcor(adjm_jacc,adjm_lift) # Jacc vs Lift
gcor(adjm_jacc,adjm_incu) # Jacc vs Incursion
gcor(adjm_jacc,adjm_cosi) # Jacc vs Cosine
gcor(adjm_lift,adjm_incu) # Lift vs Incursion
gcor(adjm_lift,adjm_cosi) # Lift vs Cosine
gcor(adjm_incu,adjm_cosi) # Incursion vs Cosine

