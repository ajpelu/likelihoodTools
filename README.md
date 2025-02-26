
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <span style="color:#43839f">likelihoodTools</span> <img src="man/figures/logo_likelihoodtools.png" align="right" width="240"/>

# Tools for Managing Maximum Likelihood Estimation Results

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/ajpelu/likelihoodTools/graph/badge.svg)](https://app.codecov.io/gh/ajpelu/likelihoodTools)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/ajpelu/likelihoodTools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ajpelu/likelihoodTools/actions/workflows/R-CMD-check.yaml)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![HitCount](https://hits.dwyl.com/ajpelu/likelihoodTools.svg?style=flat-square)](https://hits.dwyl.com/ajpelu/ajpelu/likelihoodTools)
<!-- badges: end -->

The likelihoodTools package provides tools for managing and exploring
parameter estimation results derived from Maximum Likelihood Estimation
(MLE) using the
[likelihood](https://CRAN.R-project.org/package=likelihood) package.
This package simplifies analysis workflows by offering functions that
support the organization, visualization, and summary of MLE outcomes,
aiding in deeper statistical insights.

The package is designed to simplify the exploration and interpretation
of MLE results, providing a comprehensive set of tools for managing
parameter estimation outcomes.

## Installation

You can install the development version of likelihoodTools from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ajpelu/likelihoodTools")
```

## Usage

See the [Get Started
vignette](https://ajpelu.github.io/likelihoodTools/articles/get_started.html)
for a comprehensive introduction to the package.

### Key Features

- Tools for organizing MLE outputs.
- Functions to explore, visualize, and interpret parameter estimation
  results.
- Integrations with dplyr and ggplot2 for efficient data manipulation
  and visualization.

### A litle of history

The likelihood package was developed initially by [Charles
Canham](https://www.caryinstitute.org/science/our-scientists/dr-charles-d-canham)
and [Lora Murphy](https://www.caryinstitute.org/lora-murphy) from the
[Cary Institute of Ecosystem Studies](https://www.caryinstitute.org/)
(Milbrook, NY, US). The package was designed to facilitate the use of
maximum likelihood estimation in R, using simulated annealing as the
optimization routine. The implementation of simulated annealing was
adapted from Goffe et al. (1994), and allows bounded searches.

The likelihood package has been used in multiple scientific studies to
explore various aspects of tree forest ecology worldwide (*e.g*. Canham
and Uriarte 2006, Canham et al. 2006, Gómez-Aparicio et al. 2009, 2011,
Gea-Izquierdo et al. 2013, Fernández-de-Uña et al. 2015). Despite its
broad use, it has lacked user-friendly tools for managing and exploring
parameter estimation results. This gap inspired the development of the
likelihoodTools package

## Citation

If using this package, please cite it:

``` r
citation("likelihoodTools")
To cite package 'likelihoodTools' in publications use:

  Pérez-Luque AJ (2024). _likelihoodTools: Tools for managing results
  from Maximum Likelihood Estimation_. R package version 0.1.0,
  <https://ajpelu.github.io/likelihoodTools/>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {likelihoodTools: Tools for managing results from Maximum Likelihood Estimation},
    author = {Antonio Jesús Pérez-Luque},
    year = {2024},
    url = {https://ajpelu.github.io/likelihoodTools/},
    note = {R package version 0.1.0},
  }
```

## Funding

Antonio J. Pérez-Luque received funding from the Spanish Ministry of
Science and Innovation through the Juan de la Cierva postdoctoral
fellowship program. Grant JDC2022-050056-I funded by MCIN/AEI/
10.13039/501100011033 and by “European Union NextGenerationEU/PRTR

![](https://lh3.googleusercontent.com/d/1mMqNhNAeIlEyY_QTjZZ7bLtV96pg0ww-=w910-h417-rw)

![](https://lh3.googleusercontent.com/d/1un_9sdamX60exDR4GolN87mzWTNzf4C2=w910-h417-rw)

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0" line-spacing="2">

<div id="ref-Canhametal2006NeighborhoodAnalyses" class="csl-entry">

Canham, C. D., M. J. Papaik, M. Uriarte, W. H. McWilliams, J. C.
Jenkins, and M. J. Twery. 2006. [Neighborhood analyses of canopy tree
competition along environmental gradients in new england
forests](https://doi.org/10.1890/1051-0761(2006)016[0540:NAOCTC]2.0.CO;2).
Ecological Applications 16:540–554.

</div>

<div id="ref-CanhamUriarte2006AnalysisNeighborhood" class="csl-entry">

Canham, C. D., and M. Uriarte. 2006. [Analysis of neighborhood dynamics
of forest ecosystems using likelihood methods and
modeling](https://doi.org/10.1890/04-0657). Ecological Applications
16:62–73.

</div>

<div id="ref-FernandezdeUnaetal2015StandCompetition" class="csl-entry">

Fernández-de-Uña, L., I. Cañellas, and G. Gea-Izquierdo. 2015. [Stand
competition determines how different tree species will cope with a
warming climate](https://doi.org/10.1371/journal.pone.0122255). PLOS ONE
10:e0122255.

</div>

<div id="ref-GeaIzquierdoetal2013GrowthProjections" class="csl-entry">

Gea-Izquierdo, G., L. Fernández-de-Uña, and I. Cañellas. 2013. [Growth
projections reveal local vulnerability of Mediterranean oaks with rising
temperatures](https://doi.org/10.1016/j.foreco.2013.05.058). Forest
Ecology and Management 305:282–293.

</div>

<div id="ref-Goffeetal1994GlobalOptimization" class="csl-entry">

Goffe, W. L., G. D. Ferrier, and J. Rogers. 1994. [Global optimization
of statistical functions with simulated
annealing](https://doi.org/10.1016/0304-4076(94)90038-8). Journal of
Econometrics 60:65–99.

</div>

<div id="ref-GomezAparicioetal2011DisentanglingRelative"
class="csl-entry">

Gómez-Aparicio, L., R. García-Valdés, P. Ruíz-Benito, and M. A. Zavala.
2011. [Disentangling the relative importance of climate, size and
competition on tree growth in iberian forests: Implications for forest
management under global change: Neighborhood models and tree growth
drivers](https://doi.org/10.1111/j.1365-2486.2011.02421.x). Global
Change Biology 17:2400–2414.

</div>

<div id="ref-GomezAparicioetal2009ArePine" class="csl-entry">

Gómez-Aparicio, L., M. A. Zavala, F. J. Bonet, and R. Zamora. 2009. [Are
pine plantations valid tools for restoring Mediterranean forests? An
assessment along abiotic and biotic
gradients](https://doi.org/10.1890/08-1656.1). Ecological Applications
19:2124–2141.

</div>

</div>
