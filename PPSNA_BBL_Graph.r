library(igraph)
library(bibliometrix)

data(scientometrics)
NetMatrix <- biblioNetwork(scientometrics, analysis = "co-occurrences", 
                           network = "authors", sep = ";")

par(mar=c(1,1,1,1))
net <- networkPlot(NetMatrix, n=230, normalize = "association", type="kamada" , labelsize=1, cluster = "louvain")

aa <- as.matrix(NetMatrix)
par(mar=c(1,1,1,1))
net2 <- networkPlot(aa, n=230, normalize = "association", type="kamada", labelsize=1, cluster = "louvain")
