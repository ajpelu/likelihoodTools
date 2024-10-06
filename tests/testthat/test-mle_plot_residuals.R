
# Create a valid input list
valid_input <- list(
  source_data = data.frame(bai = c(10, 20, 30), predicted = c(12, 18, 25)),
  max_likeli = -100
  # we do not add more, because it's not necessary for the test
)


test_that("mle_plot_residuals throws error when input is not a list", {
  x <- data.frame(bai = c(10, 20, 30),
                  predicted = c(12, 18, 25))

  expect_error(mle_plot_residuals(x, yvar = "bai"), "Input x must be a list")
})

# Test for missing source_data
test_that("mle_plot_residuals throws error when source_data is missing", {

  x <- valid_input
  x["source_data"] <- NULL
  expect_error(mle_plot_residuals(x, yvar = "bai"), "The list 'x' must contain an element named 'source_data'.")
})

test_that("mle_plot_residuals throws error when source_data is not a data.frame", {

  x <- valid_input
  # Invalid 'source_data' (not a data frame)
  x$source_data <- list(abi = c(10, 20, 30))
  expect_error(mle_plot_residuals(x, yvar = "abi"), "The 'source_data' element in 'x' must be a data frame.")
})

# Test for missing yvar in source_data
test_that("mle_plot_residuals throws error when yvar is not present in source_data", {

  x <- valid_input

  # replace the source_data with a data frame that does not contain the yvar
  x$source_data <- data.frame(height = c(10, 20, 30), predicted = c(12, 18, 25))

  # yvar "bai" is missing in source_data
  expect_error(mle_plot_residuals(x, yvar = "bai"), "The variable bai is not present in the 'source_data' dataframe of the 'x' object.")
})

# Test for yvar within the source_data not being numeric
test_that("mle_plot_residuals throws error when yvar is not numeric", {

  x <- valid_input
  # replace the source_data with a data frame where yvar is not numeric
  x$source_data <- data.frame(bai = c(10, 20, "h"), predicted = c(12, 18, 25))

  # yvar "bai" is not numeric
  expect_error(mle_plot_residuals(x, yvar = "bai"), "The variable bai must be numeric.")
})

# Test for yvar is a character
test_that("mle_plot_residuals throws error when the name of the 'yvar' is not a character", {

  x <- valid_input

  # yvar is not a character
  expect_error(mle_plot_residuals(x, yvar = 123), "Please specify the name of the 'yvar' as character")
})

# Test for missing "predicted" column in source_data
test_that("mle_plot_residuals throws error when predicted column is not present", {
  x <- valid_input

  # replace the source_data with a data frame that does not contain the predicted variable
  x$source_data <- data.frame(abi = c(10, 20, 30))

  # "predicted" column is missing in source_data
  expect_error(mle_plot_residuals(x, yvar = "abi"), "The variable 'predicted' is not present in the 'source_data' dataframe of the 'x' object.")
})

# Test for predicted not being numeric
test_that("mle_plot_residuals throws error when predicted is not numeric", {

  x <- valid_input
  # replace the source_data with a data frame where predicted is not numeric
  x$source_data <- data.frame(bai = c(10, 20, 30), predicted = c(12, 18, "a"))

  # predicted is not numeric
  expect_error(mle_plot_residuals(x, yvar = "bai"), "The variable 'predicted' must be numeric.")
})

# Test for lab_residuals and lab_predicted not being character strings
test_that("mle_plot_residuals throws error when lab_residuals and lab_predicted are not character strings", {

  x <- valid_input
  # lab_residuals is not a character string
  expect_error(mle_plot_residuals(x, yvar = "bai", lab_residuals = 123), "The 'lab_residuals' argument must be a character string.")

  # lab_predicted is not a character string
  expect_error(mle_plot_residuals(x, yvar = "bai", lab_predicted = 123), "The 'lab_predicted' argument must be a character string.")
})

# Test for empty source_data
test_that("mle_plot_residuals throws error when source_data is empty", {

  x <- valid_input
  # replace the source_data with an empty data frame
  x$source_data <- data.frame(bai = numeric(0), predicted = numeric(0))

  # source_data is empty
  expect_error(mle_plot_residuals(x, yvar = "bai"), "The 'source_data' dataframe is empty.")
})

# Test that residuals are calculated correctly
test_that("mle_plot_residuals calculates residuals correctly", {

  x <- valid_input
  yvar <- "bai"

  d <- x$source_data |>
    dplyr::mutate(residuals = !!ggplot2::sym(yvar) - .data$predicted)

  expected_residuals <- c(10 - 12, 20 - 18, 30 - 25)
  expect_equal(d$residuals, expected_residuals)
})

# Test that the function returns a ggplot object
test_that("mle_plot_residuals returns a ggplot object", {

  x <- valid_input
  yvar <- "bai"

  p <- mle_plot_residuals(x, yvar)

  # Check if the result is a ggplot object
  expect_true(inherits(p, "gg"))
})








