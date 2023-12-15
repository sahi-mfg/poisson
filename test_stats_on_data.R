data1 <- read.table("data/1.txt")
data2 <- read.table("data/2.txt")
data3 <- read.table("data/3.txt")

data <- rbind(data1, data2, data3)

data <- data[order(data$V1), ]

# On calcule les temps inter-arrivées
temps_inter_arrivee <- diff(data$V1)

lamba_hat <- 1 / mean(temps_inter_arrivee)

# test de Kolmogorov-Smirnov
ks.test(temps_inter_arrivee, "pexp", lambda_hat)
