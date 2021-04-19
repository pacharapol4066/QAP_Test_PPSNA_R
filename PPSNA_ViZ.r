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
library(leiden)
library(RColorBrewer)

comment_nlp <- read_excel("./source/comment_cooc_jacc.xlsx")

rn1 <- as.matrix(comment_nlp[,1])
comment_nlp <- comment_nlp[2:497]
row.names(comment_nlp) <- rn1

adjmt <- as.matrix(comment_nlp)

total_occurrences <- colSums(adjmt)
G <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="undirected")

#V(G)$color <- "orange"
#tkplot(G, size=total_occurrences, canvas.width = 550, canvas.height = 450)

#lc <- cluster_louvain(G)
#membership(lc)
#communities(lc)

ldp <- leiden(G)
table(ldp)
node.cols <- brewer.pal(max(c(3, ldp)),"Pastel1")[ldp]
plot(G,layout=layout_with_kk, vertex.color = node.cols)


