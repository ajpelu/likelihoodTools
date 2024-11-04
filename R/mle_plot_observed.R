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
#' @return A `ggplot` object displaying the observed vs. predicted values,
#' with optional annotations for \eqn{R^2} and regression slope.
#'
#' @export
#'
#' @importFrom rlang .data sym
#'
mle_plot_observed <- function(x, yvar, annotate = TRUE,
                              lab_x = "Observed",
                              lab_y = "Predicted", ...) {


  # check input is a list
  if (!inherits(x, "list")) {
    stop("Input x must be a list")
  }

  # Check if the list contains the source_data element
  if (!"source_data" %in% names(x)) {
    stop("The list 'x' must contain an element named 'source_data'.")
  }

  # Check if source_data is a data.frame
  if (!inherits(x$source_data, "data.frame")) {
    stop("The 'source_data' element in 'x' must be a data frame.")
  }

  # Check if yvar is a character
  if (!is.character(yvar)) {
    stop("Please specify the name of the 'yvar' as character")
  }

  # Check if yvar exists in the source_data
  if (!yvar %in% names(x$source_data)) {
    stop(paste("The variable", yvar, "is not present in the 'source_data' dataframe of the 'x' object."))
  }

  # Ensure that yvar is numeric
  if (!is.numeric(x$source_data[[yvar]])) {
    stop(paste("The variable", yvar, "must be numeric."))
  }

  # Check if the predicted column is in the source_data
  if (!"predicted" %in% names(x$source_data)) {
    stop("The variable 'predicted' is not present in the 'source_data' dataframe of the 'x' object.")
  }

  # Ensure that predicted is numeric
  if (!is.numeric(x$source_data$predicted)) {
    stop("The variable 'predicted' must be numeric.")
  }

  # Ensure lab_x and lab_predicted are character strings
  if (!is.character(lab_x)) {
    stop("The 'lab_x' argument must be a character string.")
  }

  if (!is.character(lab_y)) {
    stop("The 'lab_y' argument must be a character string.")
  }

  # Prevent plotting if no data is present in the source_data
  if (nrow(x$source_data) == 0) {
    stop("The 'source_data' dataframe is empty.")
  }

  # Check that 'annotate' is a logical value
  if (!is.logical(annotate)) {
    stop("The 'annotate' argument must be a logical value")
  }

  d <- x$source_data |>
    dplyr::mutate(residuals = !!rlang::sym(yvar)  - .data$predicted) |>
    dplyr::rename(observed = !!rlang::sym(yvar))

  # Get model results
  model_results <- mle_format(x, yvar = yvar)

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

  return(out_p)
}

