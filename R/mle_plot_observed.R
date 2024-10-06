#' Plots Observed vs. Predicted MLE
#'
#' Plots observed values *vs.* predicted values. The predicted values are obtained
#' from the model with the parameters values estimated by maximum likelihood
#' estimation using simulated annealing.
#'
#' @param x List with the results of the simulated annealing algorithm for Maximum
#' Likelihood Estimation. See [likelihood::anneal()]
#' @param yvar The name of the column that contains the dependent variable
#' (the “observed” value). This column must be present in the `source_data`
#' of the `x` (results) list
#' @param annotate logical (default to TRUE), display the values of \eqn{R^2}
#' and slope of the regression of the observed on predicted values. See
#' [`likelihood::Simulated Annealing Algorithm`]
#' @param lab_x The text for the x-axis lab
#' @param lab_y The text for the y-axis lab
#' @param ... other ggplot2 parameters
#'
#' @export
#'
#' @importFrom rlang .data
#'
mle_plot_observed <- function(x, yvar, annotate = TRUE,
                              lab_x = "Observed",
                              lab_y = "Predicted", ...) {


  # Check that 'x' is a list and contains the required 'source_data' element
  if (!is.list(x) || !("source_data" %in% names(x))) {
    stop("'x' must be a list containing an element named 'source_data'")
  }

  # Check that 'source_data' within 'x' is a dataframe
  if (!is.data.frame(x$source_data)) {
    stop("The 'source_data' element of 'x' must be a data frame")
  }

  # Check that 'yvar' exists in the column names of 'source_data'
  if (!yvar %in% names(x$source_data)) {
    stop(paste("The variable 'yvar' ('", yvar, "') does not exist in the source data", sep = ""))
  }

  # Check that 'annotate' is a logical value
  if (!is.logical(annotate)) {
    stop("The 'annotate' argument must be a logical value")
  }

  # Check that 'lab_x' and 'lab_y' are character strings
  if (!is.character(lab_x)) {
    stop("The 'lab_x' argument must be a character value")
  }
  if (!is.character(lab_y)) {
    stop("The 'lab_y' argument must be a character value")
  }

  d <- x$source_data |>
    dplyr::mutate(residuals = !!dplyr::sym(yvar)  - .data$predicted) |>
    dplyr::rename(observed = !!dplyr::sym(yvar))

  # Check if the transformed data has the expected columns
  if (!("predicted" %in% names(d))) {
    stop("The 'predicted' column does not exist")
  }

  # Get model results
  model_results <- mle_format(x, yvar = yvar)

  # Check if model results have the required elements
  if (!is.list(model_results) || !("R2" %in% names(model_results)) || !("slope" %in% names(model_results))) {
    stop("The model results do not contain the required elements ('R2' or 'slope')")
  }

  max_value <- max(max(d$predicted, na.rm = TRUE), max(d$observed, na.rm = TRUE))
  max_range <- max(0, max_value)

  p <- ggplot2::ggplot(data = d,
                       ggplot2::aes(x = .data$predicted, y = .data$observed)) +
    ggplot2::labs(x = lab_x, y = lab_y) +
    ggplot2::geom_point() +
    ggplot2::geom_abline() +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid = ggplot2::element_blank()) +
    ggplot2::xlim(0, max_range) +
    ggplot2::ylim(0, max_range)

  if (annotate) {
    out_p <- p +
      ggplot2::annotate("text",
                        x = 0.01 * max_range, y = 0.9 * max_range,
                        label = paste("R^2~'='", sprintf("%.3f", model_results$R2), sep="~"),
                        hjust = 0, vjust = 0, parse = TRUE) +
      ggplot2::annotate("text",
                        x = 0.01 * max_range, y = 0.85 * max_range,
                        label = paste("Slope~'='", sprintf("%.4f", model_results$slope), sep="~"),
                        hjust = 0, vjust = 0, parse = TRUE)
  } else {
    out_p <- p
  }

  print(out_p)
}

