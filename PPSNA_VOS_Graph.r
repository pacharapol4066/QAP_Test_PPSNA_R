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
row.names(comment_nlp) <- rn1

adjmt <- as.matrix(comment_nlp)

total_occurrences <- colSums(adjmt)
G <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="upper")

par(mar=c(1,1,1,1))
net <- networkPlot(adjmt , cluster = "louvain", n = vcount(G), type = "mds")
net2VOSviewer(net, vos.path = "VOS")

