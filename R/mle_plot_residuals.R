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

  mpg <- hp <- mpg_div_hp <- NULL

  d <- x$source_data |>
    dplyr::mutate(residuals = !!ggplot2::sym(yvar) - .data$predicted) |>
    dplyr::rename(observed = !!ggplot2::sym(yvar))


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


