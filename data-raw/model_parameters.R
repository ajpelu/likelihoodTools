
# Define our model function
modelfun <- function(MG, a, b, c, d)
{
  tmed_effect <- a + b /(1 + exp(- c *( bai_pinus$tmed - d )))
  MG * tmed_effect
}


gamma_pdf <- function(x,mean,scale) { shape <- mean/scale
loglh <- log(dgamma(x,shape=shape,scale=scale,log=F))
return(loglh)
}

par <- list(MG = 10, a = 0.5, b = 0.5, c = -1.5, d = 15, scale = 2)
par_lo <- list(MG = 0, a = -.5, b = 1.5, c = -3, d = 0, scale = 0.1)
par_hi <-  list(MG = 30, a = 1, b = 1, c = 2, d = 20, scale = 10)


# Create the list for the parameters to estimate and set the initial values for
# each parameter
# par <- list(MG = 18, OTmed = 10.2, Tb = 1.7)
# par_lo <- list(MG = 0.001, OTmed = 0, Tb = 0.1)
# par_hi <- list(MG = 25, OTmed = 20, Tb = 5)

var=list(mean = "predicted", x = "bai", tmed = "tmed")

set.seed(1234)
model_results <- anneal(
  model = modelfun,
  var = var,
  source_data = bai_pinus,
  par = par,
  par_lo = par_lo,
  par_hi = par_hi,
  pdf = gamma_pdf,
  dep_var = "bai",
  initial_temp = 5,
  temp_red = 0.975,
  max_iter = 30000,
  show_display = TRUE
)


### Ejemplo de funcionamiento:
#













#### Example from anneal

## Set up our dataset
data(crown_rad)
dataset <- crown_rad

## Create our model function
modelfun <- function (a, b, DBH) {a + b * DBH}

## Create the list for the parameters to estimate and
## set initial values for a and b
par <- list(a = 0, b = 0)

## Create a place to put all the other data needed by
## the model and PDF, and indicate that DBH comes from
## the column marked "DBH" in the dataset
var <- list(DBH = "DBH")

## Set bounds and initial search ranges within which to search for parameters
par_lo <- list(a = 0, b = 0)
par_hi <- list(a = 50, b = 50)

## We'll use the normal probability density function -
## add the options for it to our parameter list
## "x" value in PDF is observed value
var$x <- "Radius"

## Mean in normal PDF
var$mean <- "predicted"
var$sd <- 0.815585

## Have it calculate log likelihood
var$log <- TRUE

results<-anneal(model = modelfun, par = par, var = var,
                source_data = dataset, par_lo = par_lo, par_hi = par_hi,
                pdf = dnorm, dep_var = "Radius", max_iter = 20000)

## Alternately: reference crown_rad$DBH directly in the function without
## using var
modelfun <- function (a, b) {a + b * crown_rad$DBH}
var <- list(x = "Radius",
            mean = "predicted",
            sd = 0.815585,
            log = TRUE)
results<-anneal(model = modelfun, par = par, var = var,
                source_data = dataset, par_lo = par_lo, par_hi = par_hi,
                pdf = dnorm, dep_var = "Radius", max_iter = 20000)





 data(crown_rad)
 dataset <- crown_rad
 ## Create our model function
 modelfun <- function (a, b, DBH) {a + b * DBH}
 ## Create the list for the parameters to estimate and


  results<-anneal(model = modelfun,
    par = list(a = 0, b = 0),
    var = list(DBH = "DBH", x = "Radius", mean = "predicted", sd = 0.815585, log = TRUE),
    source_data = dataset,
    par_lo = list(a = 0, b = 0),
    par_hi = list(a = 50, b = 50),
    pdf = dnorm,
    dep_var = "Radius", max_iter = 20000,
    show_display = TRUE)



bai_pinus |>
  ggplot(aes(x = tmed, y = bai)) +
  geom_point()
