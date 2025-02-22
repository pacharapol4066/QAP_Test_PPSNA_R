library(readxl)
library(igraph)
library(sna)

f_jacc <- read_excel("./source/comment_robust_jaccard.xlsx")
f_lift <- read_excel("./source/comment_robust_lift.xlsx")
f_incu <- read_excel("./source/comment_robust_incur.xlsx")
f_cosi <- read_excel("./source/comment_robust_cosine.xlsx")
f_assoc <- read_excel("./source/comment_robust_assoc.xlsx")
f_ques <- read_excel("./source/cooc_questionaire.xlsx")
f_cros <- read_excel("./source/cooc_nlp_crossValid.xlsx")

f_pop1 <- read_excel("./source/poportion1.xlsx")
f_pop2 <- read_excel("./source/poportion2.xlsx")
f_pop3 <- read_excel("./source/poportion3.xlsx")
f_pop4 <- read_excel("./source/poportion4.xlsx")

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

rn5 <- as.matrix(f_ques[,1])
f_ques <- f_ques[2:8]
row.names(f_ques) <- rn5

rn6 <- as.matrix(f_cros[,1])
f_cros <- f_cros[2:8]
row.names(f_cros) <- rn6

rn7 <- as.matrix(f_pop1[,1])
f_pop1 <- f_pop1[2:8]
row.names(f_pop1) <- rn7

rn8 <- as.matrix(f_pop2[,1])
f_pop2 <- f_pop2[2:8]
row.names(f_pop2) <- rn8

rn9 <- as.matrix(f_pop3[,1])
f_pop3 <- f_pop3[2:8]
row.names(f_pop3) <- rn9

rn10 <- as.matrix(f_pop4[,1])
f_pop4 <- f_pop4[2:8]
row.names(f_pop4) <- rn10

rn11 <- as.matrix(f_assoc[,1])
f_assoc <- f_assoc[2:8]
row.names(f_assoc) <- rn11

adjm_jacc <- as.matrix(f_jacc)
adjm_lift <- as.matrix(f_lift)
adjm_incu <- as.matrix(f_incu)
adjm_cosi <- as.matrix(f_cosi)
adjm_ques <- as.matrix(f_ques)
adjm_cros <- as.matrix(f_cros)
adjm_assoc <- as.matrix(f_assoc)

adjm_pop1 <- as.matrix(f_pop1)
adjm_pop2 <- as.matrix(f_pop2)
adjm_pop3 <- as.matrix(f_pop3)
adjm_pop4 <- as.matrix(f_pop4)

#g <- array(dim=c(4,7,7))
#g[1,,] <- adjm_jacc
#g[2,,] <- adjm_lift
#g[3,,] <- adjm_incu
#g[4,,] <- adjm_cosi


g <- list(adjm_jacc,adjm_lift,adjm_incu,adjm_cosi,adjm_assoc)
g2 <- list(adjm_ques,adjm_cros)
g3 <- list(adjm_jacc,adjm_pop1,adjm_pop2,adjm_pop3,adjm_pop4)

# 1.Substitute method QAP Test
q.12<-qaptest(g,gcor,g1=1,g2=2, reps=1000)
q.13<-qaptest(g,gcor,g1=1,g2=3, reps=1000)
q.14<-qaptest(g,gcor,g1=1,g2=4, reps=1000)
q.15<-qaptest(g,gcor,g1=1,g2=5, reps=1000)
q.23<-qaptest(g,gcor,g1=2,g2=3, reps=1000)
q.24<-qaptest(g,gcor,g1=2,g2=4, reps=1000)
q.25<-qaptest(g,gcor,g1=2,g2=5, reps=1000)
q.34<-qaptest(g,gcor,g1=3,g2=4, reps=1000)
q.35<-qaptest(g,gcor,g1=3,g2=5, reps=1000)
q.45<-qaptest(g,gcor,g1=4,g2=5, reps=1000)

# 1.Substitute method QAP Test
summary(q.12) # Jacc vs Lift
summary(q.13) # Jacc vs Incursion
summary(q.14) # Jacc vs Cosine
summary(q.15) # Jacc vs Assoc
summary(q.23) # Lift vs Incursion
summary(q.24) # Lift vs Cosine
summary(q.25) # Lift vs Assoc
summary(q.34) # Incursion vs Cosine
summary(q.35) # Incursion vs Assoc
summary(q.45) # Cosine vs Assoc

# 1.Substitute method QAP Test
gcor(adjm_jacc,adjm_lift) # Jacc vs Lift
gcor(adjm_jacc,adjm_incu) # Jacc vs Incursion
gcor(adjm_jacc,adjm_cosi) # Jacc vs Cosine
gcor(adjm_jacc,adjm_assoc)# Jacc vs Assoc
gcor(adjm_lift,adjm_incu) # Lift vs Incursion
gcor(adjm_lift,adjm_cosi) # Lift vs Cosine
gcor(adjm_lift,adjm_assoc)# Lift vs Assoc
gcor(adjm_incu,adjm_cosi) # Incursion vs Cosine
gcor(adjm_incu,adjm_assoc) # Incursion vs Assoc
gcor(adjm_cosi,adjm_assoc) # Cosine vs Assoc

# 2.Cross Validation
q.99<-qaptest(g2,gcor,g1=1,g2=2, reps=1000)
summary(q.99)
gcor(adjm_ques,adjm_cros)

# 3.proportion QAP Test
q.p12<-qaptest(g3,gcor,g1=1,g2=2, reps=1000)
q.p13<-qaptest(g3,gcor,g1=1,g2=3, reps=1000)
q.p14<-qaptest(g3,gcor,g1=1,g2=4, reps=1000)
q.p15<-qaptest(g3,gcor,g1=1,g2=5, reps=1000)

# 3.proportion QAP Test
summary(q.p12) # proportion Full vs 1/16
summary(q.p13) # proportion Full vs 1/8
summary(q.p14) # proportion Full vs 1/4
summary(q.p15) # proportion Full vs 1/2

# 3.proportion QAP Test
gcor(adjm_jacc,adjm_pop1) # proportion Full vs 1/16
gcor(adjm_jacc,adjm_pop2) # proportion Full vs 1/8
gcor(adjm_jacc,adjm_pop3) # proportion Full vs 1/4
gcor(adjm_jacc,adjm_pop4) # proportion Full vs 1/2

