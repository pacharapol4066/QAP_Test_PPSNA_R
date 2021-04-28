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
library(visNetwork)
#library(leiden)
#library(RColorBrewer)

comment_nlp <- read_excel("./source/comment_cooc_jacc.xlsx")

rn1 <- as.matrix(comment_nlp[,1])
comment_nlp <- comment_nlp[2:497]
row.names(comment_nlp) <- rn1

adjmt <- as.matrix(comment_nlp)

total_occurrences <- colSums(adjmt)
G <- graph_from_adjacency_matrix(adjmt, weighted=TRUE, mode="max")

# Pruning
filter_G <- delete.vertices(G,which(degree(G)<150))
filter_G <- delete.edges(filter_G,which((E(filter_G)$weight<=0.05)))

# Louvain
cluster <- cluster_louvain(filter_G)
cluster_df <- as.matrix(as.list(membership(cluster)))
cluster_df <- as.data.frame(cluster_df)
cluster_df$label <- rownames(cluster_df)
data <- toVisNetworkData(filter_G)
n_nodes <- merge(x = data$nodes, y = cluster_df, by = "label", all.x = TRUE)
colnames(n_nodes)[3] <- "group"
visNetwork(nodes = n_nodes, edges = data$edges, width="100%") %>%
  visInteraction(dragNodes = FALSE, dragView = TRUE, zoomView = TRUE) %>% 
    visPhysics(stabilization = TRUE)

par(mar=c(1,1,1,1))
plot(cluster, simplify(filter_G),vertex.size=degree(filter_G)/10 +1, layout=layout_with_kk)

#membership(lc)
#communities(lc)
#V(filter_G)$color <- "orange"
#tkplot(filter_G, size=total_occurrences, canvas.width = 550, canvas.height = 450)


# Leiden
#ldp <- leiden(G)
#table(ldp)
#node.cols <- brewer.pal(max(c(3, ldp)),"Pastel1")[ldp]
#plot(G, vertex.size=degree(G)/10, layout=layout_with_kk, vertex.color=node.cols)

# Girwan-Newman (computationally very expensive algorithm, not recommend)
#gnw <- edge.betweenness.community(G)
#sizes(gnw)
#plot(gnw, G, layout=layout_with_kk)

