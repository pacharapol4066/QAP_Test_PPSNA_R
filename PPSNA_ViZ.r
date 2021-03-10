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


#comment_nlp_meiji <- read_excel("D:/development_TestCase/Master_PJ_DRMABS/Datasource/matrix_meiji_r.xlsx")
comment_nlp_meiji <- read_excel("D:/development_TestCase/Product-Position-SNA/Datasource/comment_cooc_freq.xlsx")
row_names <- as.matrix(comment_nlp_meiji[,1])
comment_nlp_meiji <- comment_nlp_meiji[2:171]
row.names(comment_nlp_meiji) <- row_names
adjmt <- as.matrix(comment_nlp_meiji)

total_occurrences <- colSums(adjmt)
G <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="upper")
par(mar=c(1,1,1,1))
plot(G,vertex.size=total_occurrences*0.1,layout=layout_with_kk)

V(G)$color <- "orange"
tkplot(G, canvas.width = 550, canvas.height = 450)

#lc <- cluster_louvain(G)
#membership(lc)
#communities(lc)

par(mar=c(1,1,1,1))
net <- networkPlot(adjmt , cluster = "louvain", n = vcount(G), type = "mds")
net2VOSviewer(net)

