# municipiosesperanza
Municipal Level Spatial Empirical Bayesian Rates of COVID-19 spread

Estos mapas presentan tasas espaciales empíricas bayesianas sobre la prevalencia del COVID-19 en los municipios en México.

Los mapas incluyen estimaciones de la tasa de positividad, la mortalidad por caso, tanto para los pacientes con pruebas positivas al COVID-19 como para la totalidad de los pacientes bajo estudio, así como el orígen de las pruebas que provienen de la red de vigilancia epidemiológica del sistema sentinela (USMER).

La positividad es muy alta en los municipios del sureste, incluyendo toda la península de Yucatán, Tabasco y Chiapas. Tambien se aprecia que si bien no se sabe mucho sobre lo que está sucediendo en Oaxaca, hay un corredor de alta positividad en municipios que van desde Guerrero (en el sur), pasando por la Ciudad de México, hacia la Huasteca (en el norte). Existe, en contraste, una franja en el centro, desde el Bajío hasta el norte del país, con relativamente menos prevalencia de pruebas positivas. Finalmente, en el noreoeste se vuelve a presentar un alto grado de positividad. Vale la pena recordar que las pruebas tendrán resultados más positivos si hay relativamente más personas infectadas, o si se están realizando relativamente pocas pruebas. 

La tasa de fatalidad por caso (ya sea la general, o específica a COVID-19) se concentra en lugares específicos sobre todo en el sur y el oriente y en algunos estados del norte. Municipios en algunos estados relativamente pobres muestran que han logrado mantener vivos a los pacientes infectados, pero hay que recordar que muchos de ellos tienen pocos casos. 

El último mapa tiene que ver con el sistema centinela de vigilancia epidemiológica. Los casos que llegan a los hospitales y clínicas del país están siendo estudiados porque los pacientes se acercan al sistema de salud a buscar atención al tener indicios o sospecha de estar enfermos. En cambio, en los 475 establecimientos USMER se realiza una muestra sistemática (no aleatoria) de cada décimo paciente, independientemente de si presenta enfermedad grave o los protocolos muestren indicios que justifiquen la prueba. Es lo más parecido a una muestra en el sentido estadístico. Los pacientes USMER no se comportan de manera distinta a los del resto de los establecimientos de salud, pero el mapa sugiere que hay fuertes diferencias regionales en la prevalencia de muestras que provienen del sistema de vigilancia epidemiológica. Fortalecer esa vigilancia sería crucial para saber si los municipios que reanuden actividad económica muestren indicios de brotes nuevos, antes de que se salgan de control. 

El repositorio incluye archivos:

muncovidcollapse.do Sintaxis en STATA para colapsar la base de datos de repositorio COVID19MEXICO a nivel municipal
CovidMunicipal.gal pesos espaciales para ser usados en GeoDA de contiguidad reina orden 2
covidmunicipalrates.csv archivo con la base de datos de tasas espaciales empiricas bayesianas

Para la metodologia de las tasas espaciales empiricas bayesianas consultar la documentacion de GeoDA. La seccion relevante es la siguiente:

Empirical Bayes (EB) Smoothed Rate Map
Borrowing strength
As mentioned in the introduction, rates have an intrinsic variance instability, which may lead to the identification of spurious outliers. In order to correct for this, we can use smoothing approaches (also called shrinkage estimators), which improve on the precision of the crude rate by borrowing strength from the other observations. This idea goes back to the fundamental contributions of James and Stein (the so-called James-Stein paradox), who showed that in some instances biased estimators may have better precision in a mean squared error sense.

GeoDa includes three methods to smooth the rates: an Empirical Bayes approach, a spatial averaging approach, and a combination between the two. We will consider the spatial approaches after we discuss distance-based spatial weights. Here, we focus on the Empirical Bayes (EB) method. First, we provide some formal background on the principles behind smoothing and shrinkage estimators.

Bayes Law
The formal logic behind the idea of smoothing is situated in a Bayesian framework, in which the distribution of a random variable is updated after observing data. The principle behind this is the so-called Bayes Law, which follows from the decomposition of a joint probability (or density) into two conditional probabilities:
P[AB]=P[A|B]×P[B]=P[B|A]×P[A],
where A and B are random events, and | stands for the conditional probability of one event, given a value for the other. The second equality yields the formal expression of Bayes law as:
P[A|B]=P[B|A]×P[A]P[B].
In most instances in practice, the denominator in this expression can be ignored, and the equality sign is replaced by a proportionality sign:7
P[A|B]∝P[B|A]×P[A].
In the context of estimation and inference, the A typically stands for a parameter (or a set of parameters) and B stands for the data. The general strategy is to update what we know about the parameter A a priori (reflected in the prior distribution P[A]), after observing the data B, to yield a posterior distribution, P[A|B]. The link between the prior and posterior distribution is established through the likelihood, P[B|A]. Using a more conventional notation with say π as the parameter and y as the observations, this gives:8
P[π|y]∝P[y|π]×P[π].

The Poisson-Gamma model
For each particular estimation problem, we need to specify distributions for the prior and the likelihood in such a way that a proper posterior distribution results. In the context of rate estimation, the standard approach is to specify a Poisson distribution for the observed count of events (conditional upon the risk parameter), and a Gamma distribution for the prior of the risk parameter π. This is referred to as the Poisson-Gamma model.9

In this model, the prior distribution for the (unknown) risk parameter π is Gamma(α,β), where α and β are the shape and scale parameters of the Gamma distribution. In terms of the more familiar notions of mean and variance, this implies:
E[π]=α/β,
and
Var[π]=α/β2.
Using standard Bayesian principles, the combination of a Gamma prior for the risk parameter with a Poisson distribution for the count of events (O) yields the posterior distribution as Gamma(O+α,P+β). The new shape and scale parameters yield the mean and variance of the posterior distribution for the risk parameter as:
E[π]=O+αP+β,
and
Var[π]=O+α(P+β)2.
Different values for the α and β parameters (reflecting more or less precise prior information) will yield smoothed rate estimates from the posterior distribution. In other words, the new risk estimate adjusts the crude rate with parameters from the prior Gamma distribution.

The Empirical Bayes approach
In the Empirical Bayes approach, values for α and β of the prior Gamma distribution are estimated from the actual data. The smoothed rate is then expressed as a weighted average of the crude rate, say r, and the prior estimate, say θ. The latter is estimated as a reference rate, typically the overall statewide average or some other standard.

In essense, the EB technique consists of computing a weighted average between the raw rate for each county and the state average, with weights proportional to the underlying population at risk. Simply put, small counties (i.e., with a small population at risk) will tend to have their rates adjusted considerably, whereas for larger counties the rates will barely change.10

More formally, the EB estimate for the risk in location i is:
πEBi=wiri+(1−wi)θ.
In this expression, the weights are:
wi=σ2(σ2+μ/Pi),
with Pi as the population at risk in area i, and μ and σ2 as the mean and variance of the prior distribution.11

In the empirical Bayes approach, the mean μ and variance σ2 of the prior (which determine the scale and shape parameters of the Gamma distribution) are estimated from the data.

For μ this estimate is simply the reference rate (the same reference used in the computation of the SMR), ∑i=ni=1Oi/∑i=ni=1Pi. The estimate of the variance is a bit more complex:
σ2=∑i=ni=1Pi(ri−μ)2∑i=ni=1Pi−μ∑i=ni=1Pi/n.
While easy to calculate, the estimate for the variance can yield negative values. In such instances, the conventional approach is to set σ2 to zero. As a result, the weight wi becomes zero, which in essence equates the smoothed rate estimate to the reference rate.
