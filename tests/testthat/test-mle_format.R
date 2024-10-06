
# Create a valid input list
valid_input <- list(
  source_data = data.frame(bai = c(10, 20, 30), predicted = c(12, 18, 25)),
  max_likeli = -100,
  best_pars = list(a = 5, b = 2, c = 3),
  aic_corr = 210.5,
  aic = 212.0,
  R2 = 0.85,
  slope = 1.02
)


# Test for correct behavior with valid input
test_that("mle_format returns correct dataframe with valid input", {

  x <- valid_input
  result <- mle_format(x, yvar = "bai")

  # Check that the result is a dataframe
  expect_s3_class(result, "data.frame")

  # Check that all expected columns are present
  expect_true(all(c("max_likeli", "n_params", "aic_cor", "aic", "R2", "slope", "rmse") %in% names(result)))

  # Check values
  expect_equal(result$max_likeli, -100)
  expect_equal(result$n_params, 3) # since best_pars has 2 elements
  expect_equal(result$aic_cor, 210.5)
  expect_equal(result$aic, 212.0)
  expect_equal(result$R2, 0.85)
  expect_equal(result$slope, 1.02)

  # Check that rmse is computed correctly
  expect_equal(result$rmse, sqrt(sum((x$source_data$bai - x$source_data$predicted)^2)/(nrow(x$source_data)-1)))
})

# Test for missing required elements in input list
## Define the required elements for the list
required_elements <- c("max_likeli", "best_pars", "aic_corr", "aic", "R2", "slope")

# Generate all possible combinations of elements to remove
combinations_to_remove <- expand.grid(lapply(required_elements, function(x) c(TRUE, FALSE)))
colnames(combinations_to_remove) <- required_elements

# Remove the row with all values TRUE
combinations_to_remove <- combinations_to_remove[!apply(combinations_to_remove, 1, all), ]

# Test each combination of missing elements
test_that("mle_format throws error when required elements are missing in different combinations", {
  for (i in 1:nrow(combinations_to_remove)) {

    x <- valid_input

    # Get the current combination
    combination <- combinations_to_remove[i, ]

    # Get the missing elements for this combination
    missing_elements <- required_elements[!combination]

    # Remove the missing elements from the input list
    x[missing_elements] <- NULL

    # Create the expected error message
    error_message <- paste("Input list x is missing the following elements:", paste(missing_elements, collapse = ", "))

    # Run the test
    expect_error(mle_format(x, yvar = "bai"), error_message)
  }
})


# Test for missing source_data
test_that("mle_format throws error when source_data is missing", {

  x <- valid_input
  x["source_data"] <- NULL
  expect_error(mle_format(x, yvar = "bai"), "Input list x is missing the following elements: source_data")
})

test_that("mle_format throws error when source_data is not a data.frame", {

  x <- valid_input
  # Invalid 'source_data' (not a data frame)
  x$source_data <- list(abi = c(10, 20, 30))
  expect_error(mle_format(x, yvar = "abi"), "source_data must be a data frame")
})


# Test for missing yvar in source_data
test_that("mle_format throws error when yvar is not present in source_data", {

  x <- valid_input

  # replace the source_data with a data frame that does not contain the yvar
  x$source_data <- data.frame(height = c(10, 20, 30), predicted = c(12, 18, 25))

  # yvar "bai" is missing in source_data
  expect_error(mle_format(x, yvar = "bai"), "The variable bai is not present in the `source_data` dataframe of the `x` object`.")
})


# Test for missing "predicted" column in source_data
test_that("mle_format throws error when predicted column is not present", {
  x <- valid_input

  # replace the source_data with a data frame that does not contain the predicted variable
  x$source_data <- data.frame(abi = c(10, 20, 30))

  # "predicted" column is missing in source_data
  expect_error(mle_format(x, yvar = "abi"), 'The variable "predicted" is not present in the `source_data` dataframe of the results object `x`.')
})

# Test for invalid RMSE calculation
test_that("mle_format throws error when RMSE calculation fails", {

  x <- valid_input
  # create source data with NA values
  x$source_data <- data.frame(bai = c(10, 20, NA), predicted = c(12, 18, 25))

  # RMSE calculation should fail due to NA values
  expect_error(mle_format(x, yvar = "bai"), "Error in computing RMSE.")
})
