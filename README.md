
<!-- README.md is generated from README.Rmd. Please edit that file -->

# likelihoodTools: Tools for Managing Maximum Likelihood Estimation Results

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/ajpelu/likelihoodTools/graph/badge.svg)](https://app.codecov.io/gh/ajpelu/likelihoodTools)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

The likelihoodTools package provides tools for managing and exploring
parameter estimation results derived from Maximum Likelihood Estimation
(MLE) using the
[likelihood](https://cran.r-project.org/web/packages/likelihood/index.html)
package. This package simplifies analysis workflows by offering
functions that support the organization, visualization, and summary of
MLE outcomes, aiding in deeper statistical insights.

## Installation

You can install the development version of likelihoodTools from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ajpelu/likelihoodTools")
```

## Key Features

- Tools for organizing MLE outputs.
- Functions to explore, visualize, and interpret parameter estimation
  results.
- Integrations with dplyr and ggplot2 for efficient data manipulation
  and visualization.

## Dependencies

likelihoodTools imports dplyr, ggplot2, and rlang for streamlined data
manipulation, plotting, and enhanced compatibility with tidyverse
workflows.

## Target Audience

Ideal for statisticians, data analysts, and researchers working with
Maximum Likelihood Estimation who seek to streamline their analysis
process.
