# Notes suite au debut de lecture de l'article

L'un des enjeux majeurs en neurosciences est d'acquerir une meilleure compréhension de la dynamique du cerveau et notamment d'identifier les connectivités fonctionnelles pouvant exister entre neurones au cours du temps.

## Finalité poursuivie dans l'article MTGAUE

Dans cet article, le but est de proposer (en supposant que l'activité des neurones se fait au moyen de processus de Poisson homogène) une méthodologie permettant de tester l'indépendance entre deux neurones, localement dans le temps.

## Outils utilisés

-   Processus de Poisson homogène
-   Tests d'hypothèses, Tests multiples (procédure de Benjamini et Hochberg), False Discovery Rate (FDR)
-   La notion de coincidence par "Mutiple shift"

## Présentation de chacun des outils

### La notion de coincidence par "Multiple shift"

#### Train de spikes

$h$ résolution d'acquisition des données (de l'ordre de $10^{-3}, 10^{-4}$)

Un train de spikes est une séquence de 0 et 1 notée $(H_n)_n$ où $H_i = 1$ traduit la présence d'un spike sur l'intervalle $[ih - \frac{h}{2}, ih + \frac{h}{2}]$

A une telle séquence, il est possible d'associer un processus ponctuel $N$ défini comme étant l'ensemble des ponts ih pour lesquels $H_i = 1$.

On note $N_1$ et $N_2$ les processus ponctuels, et $(H_n^1)_n$ et $(H_n^2)_n$ les séquences, associés respectivement au train de spikes du neurone 1 et du neurone 2 enregistrés simultanément.

On se limite à une fenêtre temporelle $W$ de longueur $T = nh$.

#### Notion de coincidence par multiple shift (cas symétrique)

Une coincidence est observée au temps $ih$ sur la fenêtre $W$ s'il existe un "shift" j dans $\{-d, \cdots, d\}$ où $d$ est un entier supérieur ou égal à 1, tel que $H_i^1 = H_{i+j}^2 = 1$

$1 \leq i+j \leq n$

Ainsi le nombre de coincidences est donné par :

$$X = \sum_{i=1}^n\sum_{|j| \leq d , 1 \leq i+j \leq n} \mathbb{1}_{H_i^1 = H_{i+j}^2 = 1} $$

et donc par un changement d'indice $k = i + j$

on obtient:

$$ X = \sum_{i=1}^n \sum_{k=1}^n \mathbb{1}_{|k - i| \leq d} \mathbb{1}_{H_i^1 = 1} \mathbb{1}_{H_k^2 = 1} $$

### Les tests multiples

Avant de parler de tests multiples, intéressons nous brièvement à la théorie des tests.

#### C'est quoi un test statistique ?

Un test statistique ou test d'hypothèse, est une procédure de décision entre deux hypothèses. Il s'agit d'une démarche consistant à rejeter ou ne pas rejeter une hypothèse, appelée hypothèse nulle en fonction d'un échantillon de données.

L'hypothèse nulle souvent notée $H_0$ est celle que l'on considère à priori vraie. Le but est de décider si cette hypothèse est à priori crédible. L'hypothèse alternative notée $H_1$ est l'hypothèse complémentaire à l'hypothèse nulle.

source : [page wikipédia Test statistique](https://fr.wikipedia.org/wiki/Test_statistique)

#### Risque de type I

C'est la probabilité $\alpha$ de rejeter $H_0$ à tort (alors que celle-ci est vraie). Cette erreur est souvent appelée risque $\alpha$.

La valeur seuil de $\alpha$ communément admise pour rejeter $H_0$ est de 0.05 (5%). Cette valeur de 5% est arbitraire.

Il existe aussi le risque de type II qui correspond à la probabilité de ne pas rejeter $H_0$ alors que celle ci est fausse (et donc $H_1$ est vraie). cette probabilité est souvent notée $\beta$

#### p-value

La p-value souvent notée $p$ est la probabilité d'obtenir des résultats en désaccord avec $H_0$.

Le grand principe d'un test est donc de calculer de rejeter l'hypothèse nulle $H_0$, tout en minimisant les chances de se tromper. Ainsi, quand nous comparons la p-valeur, associée à une statistique de test, à la loi de probabilité qu'elle suit et que nous rejetons $H_0$ au risque de 5%, dans la forme, nous prenons une décision mais, sur le fond, nous prenons également le risque de nous tromper avec une probabilité de 5%.

Imaginons désormais que pour une longue série de variables nous appliquons le même test au risque $\alpha$ de 5%. Il paraît évident que nous augmentons les chances de conclure à tort au rejet de $H_0$ au moins pour un certain nombre de variables testées.

C'est là que la théorie des tests multiples (ou comparaison multiples) intervient.

#### Tests multiples

Le grand principe des tests multiples est donc de corriger la liste des p-valeurs établies afin de rattraper les hypothèses $H_0$ rejetées à tort.

Définissons K le nombre d'hypothèses nulles $H_0^1, \cdots, H_0^K$ que nous pourrions également assimiler au test de l'hypothèse $H_0$ pour $K$ variables $X ^1, \cdots, X ^K$.

Enfin, posons $R$ le nombre d'hypothèses nulles rejetées et $m_0$ le nombre d'hypothèses nulles vraies.

$K - m_0$ représente donc le nombre d'hypothèses alternatives vraies.

Il existe deux grandes familles de tests multiples qui sont basées sur les deux taux d'erreur de type I. Ce sont:

-   Family Wise Error Rate : $FWER = \mathbb{P}(FP > 0) = 1 - \mathbb{P}(FP = 0)$ : Estimation de la probabilité d'avoir au moins un faux positif

-   False Discovery Rate : $FDR = \mathbb{E}(\frac{FP}{R}|R>0)$ : Taux moyen de faux positifs

NB: FP represente le nombre de faux positifs (le nombre de fois où on rejette $H_0$ alors que celle ci est vraie)

De plus, le taux d'erreur de type II est donnée par la Non Discovery Rate : $NDR = \mathbb{E}(\frac{FN}{K - R})$, FN : nombre de faux négatifs (le nombre de fois où on ne rejete pas $H_0$ alors que celle ci est fausse)

##### La procédure de Benjamini-Höchberg

La procédure de Benjamini-Höchberg a été inventée par Yoav Benjamini et Yosef Höchberg en 1995. Elle porte également le nom de méthode linéraire step-up de Benjamini-Höchberg.

Principe: Rejet de $H_0^1, \cdots, H_0^k$ pour le plus grand $k$ tel que $p_k \leq \frac{k}{K} \cdot \alpha \Rightarrow \alpha \geq \frac{K}{k} \cdot p_k.$

Où $p_k$ représente la p-valeur associée à la statistique de test calculée. Enfin, notons $\alpha$ le seuil de significativité fixé au préalable.

Algorithme associé:

-- Ranger les $p$ par ordre croissant

-- $p_K * = p_K$

-- $\forall k \in [K - 1, \cdots, 1], p_k * = min(p_{k + 1}*, \frac{K}{k} \cdot p_k)$

-- $p * = [p_1 *, \cdots, p_K *]$

### Processus de Poisson

Un processus de Poisson est un modèle mathématique modélisant des évènements aléatoires qui se reproduisent au cours du temps: naissances, pannes, désintégration radioactive.

#### Définition formelle processus de Poisson

On considère des évènements qui se produisent à des dates aléatoires, et on s'intéresse, pour tout $t > 0$ au nombre d'évènements qui se produisent au cours de l'intervalle $]0,t]$, que l'on note $N(t)$

On définit le processus de Poisson d'intensité $\lambda$ comme un processus $N(t)$ satisfaisant les conditions suivantes:

-   Le processus est à accroissements indépendants, ie : $\forall 0 \leq t_1 \leq t_2 \cdots < t_n$, les variables aléatoires $N(t_i) - N(t_{i-1})$, $i = 1, \cdots, n$ sont globalement indépendantes;

-   Le processus est à accroissements stationnaires, ie. $\forall t, h > 0$, la loi de $N(t+h) - N(t)$ ne dépend que de $h$;

-   $P(N(t+h) - N(t) \geq 1) = \lambda h + o(h)$ et $P(N(t+h) - N(t) \geq 2) = o(h)$

#### Propriété:

Soit $(N(t))_t$ est un processus de Poisson. $\forall t > 0$, $N(t)$ suit une loi de Poisson de paramètre $\lambda t$.

ie: $\forall n \geq 0$, $$\mathbb{P}(N_t = n) = \exp(-\lambda t) \frac{(\lambda t)^n}{n!}$$

Lorsqu'on observe un processus de Poisson, il est naturel de s'intéresser au temps d'attente entre les sauts. \#### Propriété:

Si $T_n$ désigne l'instant du n-ième saut, alors les variables $T_n - T_{n-1}$ sont iid de loi exponentielle de paramètre $\lambda$

Cette propriété assure l'homogénéïté d'un processus de Poisson.
