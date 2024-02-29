# Simulation en fonction du nombres d'évènements

# n: nombre d'évènements
simul_poisson <- function(n, lambda) {
  temps_inter_arrivee <- cumsum(rexp(n, lambda))
  occurences <- c(0, temps_inter_arrivee)

  return(occurences)
}


# simulation d'un processus de Poisson de paramètre 5 et de taille 20
t_20_5 <- simul_poisson(20, 5)
t_20_6 <- simul_poisson(20, 6)
t_20_10 <- simul_poisson(20, 10)
t_20_1 <- simul_poisson(20, 50)

events_number <- c(0:20)

# affichage du nombre d'évènements en fonction du temps
plot(t_20_5, events_number, type = "s", ylab = "N(t)", xlab = "t", col = "red")
lines(t_20_6, events_number, type = "s", col = "black")
lines(t_20_10, events_number, type = "s", col = "blue")
lines(t_20_1, events_number, type = "s", col = "green")

legend("topright",
  legend = c(
    "lambda = 5", "lambda = 6", "lambda = 10", "lambda = 50"
  ),
  col = c("red", "black", "blue", "green"),
  lty = 1, cex = 0.8
)


# Simulation en fonction du temps
simul_poisson_temps <- function(temps, lambda) {
  occurences <- c(0)
  temps_inter_arrivee <- rexp(1, lambda)

  while (temps_inter_arrivee < temps) {
    occurences <- c(occurences, temps_inter_arrivee)
    temps_inter_arrivee <- temps_inter_arrivee + rexp(1, lambda)
  }

  return(occurences)
}

t <- simul_poisson_temps(100, 10)
plot(t, type = "s", ylab = "N(t)", xlab = "t", col = "red")

# test statistique (de Kolmogorov-Smirnov) pour vérifier
# qu'on a bien un processus de poisson
# On regarde si les temps inter-arrivées suivent une loi exponentielle
# de paramètre 1/lambda
ks.test(diff(t), "pexp", 1 / 10)
