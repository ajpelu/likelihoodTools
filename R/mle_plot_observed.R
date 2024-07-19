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
#' @param ...
#'
#' @export
#'
mle_plot_observed <- function(x, yvar, annotate = TRUE,
                              lab_x = "Observed",
                              lab_y = "Predicted", ...) {

  d <- x$source_data |>
    dplyr::mutate(residuals = !!dplyr::sym(yvar)  - predicted) |>
    dplyr::rename(observed = !!dplyr::sym(yvar))

  model_results <- mle_format(x, yvar = "rat")

  max_value <- max(max(d$predicted, na.rm = TRUE), max(d$observed, na.rm = TRUE))
  max_range <- max(0, max_value)

  p <- ggplot2::ggplot(d, aes(x = predicted, y = observed)) +
    ggplot2::labs(x = lab_x, y = lab_y) +
    ggplot2::geom_point() +
    ggplot2::geom_abline() +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid = element_blank()) +
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

