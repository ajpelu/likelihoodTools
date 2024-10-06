#' Plots Residuals vs. Predicted MLE
#'
#' Plots residuals (observed - residuals) values *vs.* predicted values. The
#' predicted values are obtained from the model with the parameters values
#' estimated by maximum likelihood estimation using simulated annealing.
#'
#' @param x List with the results of the simulated annealing algorithm for Maximum
#' Likelihood Estimation. See [likelihood::anneal()]
#' @param yvar The name of the column that contains the dependent variable
#' (the “observed” value). This column must be present in the `source_data`
#' of the `x` (results) list
#' @param lab_predicted The text for the predicted axis lab (x-axis)
#' @param lab_residuals The text for the residual axis lab (y-axis)
#' @param ... other ggplot2 parameters
#' @export
#'
#' @importFrom rlang .data
#'
mle_plot_residuals <- function(x, yvar, lab_residuals = "Residuals",
                           lab_predicted = "Predicted", ...) {
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
    stop("yvar must be a character")
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
    stop("The `predicted` column is not present in the `source_data` dataframe of the `x` object`.")
  }

  # Ensure that predicted is numeric
  if (!is.numeric(x$source_data$predicted)) {
    stop("The 'predicted' column must be numeric.")
  }

  # Ensure lab_residuals and lab_predicted are character strings
  if (!is.character(lab_residuals)) {
    stop("The 'lab_residuals' argument must be a character string.")
  }

  if (!is.character(lab_predicted)) {
    stop("The 'lab_predicted' argument must be a character string.")
  }

  # Prevent plotting if no data is present in the source_data
  if (nrow(x$source_data) == 0) {
    stop("The 'source_data' dataframe is empty.")
  }

  d <- x$source_data |>
    dplyr::mutate(residuals = !!ggplot2::sym(yvar) - .data$predicted) |>
    dplyr::rename(observed = !!ggplot2::sym(yvar))

  # Check if residuals is numeric
  if (!is.numeric(d$residuals)) {
    stop("Residuals must be numeric.")
  }

  out <- ggplot2::ggplot(data = d,
                         ggplot2::aes(x = .data$predicted, y = .data$residuals)) +
    ggplot2::labs(x = lab_predicted, y = lab_residuals) +
    ggplot2::geom_point() +
    ggplot2::geom_hline(yintercept = 0) +
    ggplot2::xlim(0, NA) +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid = ggplot2::element_blank())

  print(out)
}


