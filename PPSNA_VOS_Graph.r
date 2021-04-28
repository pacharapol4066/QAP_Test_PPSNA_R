# install.package(readr)
# install.package(quanteda)
# install.package(bibliometrix)
# install.package(igraph)
# install.package(CINNA)

library(readxl)
library(quanteda)
library(igraph)
library(bibliometrix)
library(CINNA)


comment_nlp <- read_excel("./source/comment_cooc_freq.xlsx")

rn1 <- as.matrix(comment_nlp[,1])
comment_nlp <- comment_nlp[2:497]
#comment_nlp <- comment_nlp[2:13]
row.names(comment_nlp) <- rn1

adjmt <- as.matrix.data.frame(comment_nlp)

#total_occurrences <- colSums(adjmt)
G1 <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="max")
#plot(G1, layout=layout_with_kk)

par(mar=c(1,1,1,1))
net <- networkPlot(adjmt, normalize=NULL, n=vcount(G1), type="kamada")
net2VOSviewer(net, vos.path = "VOS")

