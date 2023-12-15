data1 <- read.table("data/data1.txt")
data2 <- read.table("data/data2.txt")
data3 <- read.table("data/data3.txt")

data <- rbind(data1, data2, data3)
data <- as.data.frame(data)
colnames(data) <- "V1"
# On calcule les temps inter-arrivées
temps_inter_arrivee <- diff(data$V1)

lambda_hat <- 1 / mean(temps_inter_arrivee)

# test de Kolmogorov-Smirnov
ks.test(temps_inter_arrivee, "pexp", lambda_hat)
