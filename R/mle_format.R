#' Extract and format results from Simulated Annealing (Maximum Likelihood Estimation)
#'
#' @param x List with the results of the simulated annealing algorithm for Maximum
#' Likelihood Estimation. See [likelihood::anneal()]
#' @param yvar The name of the column that contains the dependent variable
#' (the “observed” value). This column must be present in the `source_data`
#' of the `x` (results) list
#'
#' @return A dataframe with outputs from the results of the simulated
#' annealing maximum parameter estimation. This dataframe contains the following
#' columns (see help in [likelihood::anneal]):
#'
#' * `max_likeli` The maximum likelihood value of the model
#' * `n_params` The number of the estimated parameters
#' * `aic_corr` The value of Akaike's Information Criterion “corrected” for
#' small sample size. See the [`likelihood::Simulated Annealing Algorithm`] help
#' page of the [likelihood] package for more information.
#' * `aic` The value of Akaike's Information Criterion. See the
#' [`likelihood::Simulated Annealing Algorithm`] help page of the [likelihood]
#' package for more information.
#' `slope` Slope of observed values linearly regressed on those predicted by
#' model, using the parameter maximum likelihood estimates. The intercept is
#' forced at zero.
#' * `R2`	Proportion of variance explained by the model relative to that explained
#' by the simple mean of the data.
#'
#' * `rmse` Root Mean Square Error, *i.e.* the standard deviation of the residuals.
#' It is computed as:
#'
#' \deqn{RMSE=\sqrt{ \frac{\sum_{i=1}^{N}(obs_i - exp_i)^2}{n -1}}}
#'
#' @examples
#'
#' # Get the results of the maximum likelihood estimation from the example in
#' # the anneal function of the likelihood pkg.
#'
#' library(likelihood)
#' data(crown_rad)
#' dataset <- crown_rad
#'
#' # Create our model function
#' modelfun <- function (a, b, DBH) {a + b * DBH}
#'
#' # Compute the MLE of the parameters
#' results <- anneal(model = modelfun,
#'   par = list(a = 0, b = 0),
#'   var = list(DBH = "DBH", x = "Radius", mean = "predicted",
#'              sd = 0.815585, log = TRUE),
#'   source_data = dataset,
#'   par_lo = list(a = 0, b = 0),
#'   par_hi = list(a = 50, b = 50),
#'   pdf = dnorm,
#'   dep_var = "Radius",
#'   max_iter = 20000,
#'   show_display = FALSE)
#'
#' # Format the results
#' mle_format(results, yvar = "DBH")
#'
#' @export
#'
mle_format <- function(x, yvar) {

  if (!inherits(x, "list")) {
    stop("Input x must be a list.")
  }

  # Check that the list has the required elements
  required_elements <- c("source_data", "max_likeli", "best_pars", "aic_corr", "aic", "R2", "slope")
  missing_elements <- setdiff(required_elements, names(x))
  if (length(missing_elements) > 0) {
    stop(paste("Input list x is missing the following elements:", paste(missing_elements, collapse = ", ")))
  }

  # Check if source_data is a data.frame
  if (!inherits(x$source_data, "data.frame")) {
    stop("x$source_data must be a data frame.")
  }
  # Check if yvar is in the source_data
  if (!yvar %in% names(x$source_data)) {
    stop(paste("The variable", yvar, "is not present in the `source_data` dataframe of the `x` object`."))
  }

  # Check if "predicted" column is in the source_data
  if (!"predicted" %in% names(x$source_data)) {
    stop('The variable "predicted" is not present in the `source_data` dataframe of the results object `x`.')
  }

  # compute RMSE
  x$source_data$residual <- x$source_data[[yvar]] - x$source_data[["predicted"]]
  rmse <- sqrt(sum(x$source_data$residual^2)/(length(x$source_data$residual)-1))

  # Check if RMSE calculation resulted in a numeric value
  if (!is.numeric(rmse) || is.na(rmse)) {
    stop("Error in computing RMSE.")
  }

  out <- data.frame(
    max_likeli = x$max_likeli,
    n_params = length(x$best_pars),
    aic_cor = x$aic_corr,
    aic = x$aic,
    R2 = x$R2,
    slope = x$slope,
    rmse = rmse
  )

  return(out)
}



