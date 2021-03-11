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
comment_nlp <- comment_nlp[2:338]
row.names(comment_nlp) <- rn1

adjmt <- as.matrix(comment_nlp)

total_occurrences <- colSums(adjmt)
G <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="upper")

#par(mar=c(1,1,1,1))
#plot(G,vertex.size=total_occurrences*0.005,layout=layout_with_kk)

#V(G)$color <- "orange"
#tkplot(G, size=total_occurrences*0.005, canvas.width = 550, canvas.height = 450)

#lc <- cluster_louvain(G)
#membership(lc)
#communities(lc)

par(mar=c(1,1,1,1))
net <- networkPlot(adjmt , cluster = "louvain", n = vcount(G), type = "mds")
net2VOSviewer(net, vos.path = "VOS")

