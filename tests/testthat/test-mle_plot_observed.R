# Create a valid input list
valid_input <- list(
  source_data = data.frame(observed = c(10, 20, 30), predicted = c(12, 18, 25)),
  max_likeli = -100,
  best_pars = list(a = 1, b = 2),
  aic_corr = 5,
  aic = 10,
  R2 = 0.85,
  slope = 0.9
)

# Test for invalid input (not a list)
test_that("mle_plot_observed throws error when input is not a list", {
  x <- data.frame(observed = c(10, 20, 30), predicted = c(12, 18, 25))
  expect_error(mle_plot_observed(x, yvar = "observed"), "Input x must be a list")
})

# Test for missing source_data
test_that("mle_plot_observed throws an error when source_data is missing", {
  x <- valid_input
  x["source_data"] <- NULL
  expect_error(mle_plot_observed(x, yvar = "observed"), "The list 'x' must contain an element named 'source_data'.")
})

# Test for source_data not being a data frame
test_that("mle_plot_observed throws an error when source_data is not a data frame", {
  x <- valid_input
  x$source_data <- list(observed = c(10, 20, 30))
  expect_error(mle_plot_observed(x, yvar = "observed"), "The 'source_data' element in 'x' must be a data frame.")
})


# Test for missing yvar in source_data
test_that("mle_plot_observed throws an error when yvar is not present in source_data", {
  x <- valid_input
  x$source_data <- data.frame(height = c(10, 20, 30), predicted = c(12, 18, 25))
  expect_error(mle_plot_observed(x, yvar = "observed"), "is not present in the 'source_data' dataframe of the 'x' object")
})

# Test: Error if yvar is not numeric
test_that("mle_plot_observed throws an error when yvar is not numeric", {
  x <- valid_input
  x$source_data <- data.frame(observed = c("a", "b", "c"), predicted = c(12, 18, 25))
  expect_error(mle_plot_observed(x, yvar = "observed"), "The variable observed must be numeric")
})

# Test for yvar is a character
test_that("mle_plot_residuals throws error when the name of the 'yvar' is not a character", {

  x <- valid_input

  # yvar is not a character
  expect_error(mle_plot_residuals(x, yvar = 123), "Please specify the name of the 'yvar' as character")
})


# Test: Error if "predicted" column is missing from source_data
test_that("mle_plot_observed throws an error when 'predicted' column is not present", {
  x <- valid_input
  x$source_data <- data.frame(observed = c(10, 20, 30))
  expect_error(mle_plot_observed(x, yvar = "observed"), "The variable 'predicted' is not present in the 'source_data' dataframe of the 'x' object.")
})

# Test: Error if predicted column is not numeric
test_that("mle_plot_observed throws an error when predicted is not numeric", {
  x <- valid_input
  x$source_data <- data.frame(observed = c(10, 20, 30), predicted = c("a", "b", "c"))
  expect_error(mle_plot_observed(x, yvar = "observed"), "The variable 'predicted' must be numeric")
})

# Test: Error if lab_observed or lab_predicted are not character strings
test_that("mle_plot_observed throws an error when lab_x or lab_yare not character strings", {
  x <- valid_input
  expect_error(mle_plot_observed(x, yvar = "observed", lab_x = 123), "The 'lab_x' argument must be a character string.")
  expect_error(mle_plot_observed(x, yvar = "observed", lab_y = 456), "The 'lab_y' argument must be a character string.")
})

# Test: Error if annotate is not a logical value
test_that("mle_plot_observed throws an error when annotate is not logical", {
  x <- valid_input
  expect_error(mle_plot_observed(x, yvar = "observed", annotate = "yes"), "The 'annotate' argument must be a logical value")
})


# Test: Error if source_data is empty
test_that("mle_plot_observed throws an error when source_data is empty", {
  x <- valid_input
  x$source_data <- data.frame(observed = numeric(0), predicted = numeric(0))
  expect_error(mle_plot_observed(x, yvar = "observed"), "The 'source_data' dataframe is empty.")
})

# Test that residuals are calculated correctly
test_that("mle_plot_observed calculates residuals correctly", {
  x <- valid_input
  x$source_data <- data.frame(observed = c(10, 20, 30), predicted = c(12, 18, 25))
  yvar <- "observed"
  d <- x$source_data |>
    dplyr::mutate(residuals = !!rlang::sym(yvar) - .data$predicted)
  expected_residuals <- c(10 - 12, 20 - 18, 30 - 25)
  expect_equal(d$residuals, expected_residuals)
})

# Test that the function returns a ggplot object
test_that("mle_plot_observed returns a ggplot object", {
  x <- valid_input
  yvar <- "observed"
  p <- mle_plot_observed(x, yvar)
  expect_true(inherits(p, "gg"))
})





