
<!-- README.md is generated from README.Rmd. Please edit that file -->

# likelihoodTools: Tools for Managing Maximum Likelihood Estimation Results

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/ajpelu/likelihoodTools/graph/badge.svg)](https://app.codecov.io/gh/ajpelu/likelihoodTools)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/ajpelu/likelihoodTools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ajpelu/likelihoodTools/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The likelihoodTools package provides tools for managing and exploring
parameter estimation results derived from Maximum Likelihood Estimation
(MLE) using the
[likelihood](https://cran.r-project.org/web/packages/likelihood/index.html)
package. This package simplifies analysis workflows by offering
functions that support the organization, visualization, and summary of
MLE outcomes, aiding in deeper statistical insights.

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

## Key Features

- Tools for organizing MLE outputs.
- Functions to explore, visualize, and interpret parameter estimation
  results.
- Integrations with dplyr and ggplot2 for efficient data manipulation
  and visualization.

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

### A litle of history

The likelihood package was developed initially by [Charles
Canham](https://www.caryinstitute.org/science/our-scientists/dr-charles-d-canham)
and [Lora Murphy](https://www.caryinstitute.org/lora-murphy) from the
[Cary Institute of Ecosystem Studies](https://www.caryinstitute.org/)
(Milbrook, NY, US). The package was designed to facilitate the use of
maximum likelihood estimation in R, using simulated annealing as the
optimization routine. The implementation of simulated annealing was
adapted from Goffe, Ferrier, and Rogers (1994), and allows bounded
searches.

The likelihood package has been used in multiple scientific studies to
explore various aspects of tree forest ecology worldwide (*e.g*. Canham
and Uriarte 2006; Gómez-Aparicio et al. 2009, 2011; Gea-Izquierdo,
Fernández-de-Uña, and Cañellas 2013; Canham et al. 2006;
Fernández-de-Uña, Cañellas, and Gea-Izquierdo 2015). Despite its broad
use, it has lacked user-friendly tools for managing and exploring
parameter estimation results. This gap inspired the development of the
likelihoodTools package

## Funding

Antonio J. Pérez-Luque received funding from the Spanish Ministry of
Science and Innovation through the Juan de la Cierva postdoctoral
fellowship program. Grant JDC2022-050056-I funded by MCIN/AEI/
10.13039/501100011033 and by “European Union NextGenerationEU/PRTR

![](https://lh3.googleusercontent.com/d/1mMqNhNAeIlEyY_QTjZZ7bLtV96pg0ww-=w910-h417-rw)

![](https://lh3.googleusercontent.com/d/1un_9sdamX60exDR4GolN87mzWTNzf4C2=w910-h417-rw)

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-Canhametal2006NeighborhoodAnalyses" class="csl-entry">

Canham, Charles D., Michael J. Papaik, María Uriarte, William H.
McWilliams, Jennifer C. Jenkins, and Mark J. Twery. 2006. “Neighborhood
Analyses of Canopy Tree Competition Along Environmental Gradients in New
England Forests.” *Ecological Applications* 16 (2): 540–54.
[https://doi.org/10.1890/1051-0761(2006)016\[0540:NAOCTC\]2.0.CO;2](https://doi.org/10.1890/1051-0761(2006)016[0540:NAOCTC]2.0.CO;2).

</div>

<div id="ref-CanhamUriarte2006AnalysisNeighborhood" class="csl-entry">

Canham, Charles D., and María Uriarte. 2006. “Analysis of Neighborhood
Dynamics of Forest Ecosystems Using Likelihood Methods and Modeling.”
*Ecological Applications* 16 (1): 62–73.
<https://doi.org/10.1890/04-0657>.

</div>

<div id="ref-FernandezdeUnaetal2015StandCompetition" class="csl-entry">

Fernández-de-Uña, Laura, Isabel Cañellas, and Guillermo Gea-Izquierdo.
2015. “Stand Competition Determines How Different Tree Species Will Cope
with a Warming Climate.” *PLOS ONE* 10 (3, 3): e0122255.
<https://doi.org/10.1371/journal.pone.0122255>.

</div>

<div id="ref-GeaIzquierdoetal2013GrowthProjections" class="csl-entry">

Gea-Izquierdo, Guillermo, Laura Fernández-de-Uña, and Isabel Cañellas.
2013. “Growth Projections Reveal Local Vulnerability of Mediterranean
Oaks with Rising Temperatures.” *Forest Ecology and Management* 305:
282–93. <https://doi.org/10.1016/j.foreco.2013.05.058>.

</div>

<div id="ref-Goffeetal1994GlobalOptimization" class="csl-entry">

Goffe, William L., Gary D. Ferrier, and John Rogers. 1994. “Global
Optimization of Statistical Functions with Simulated Annealing.”
*Journal of Econometrics* 60 (1-2): 65–99.
<https://doi.org/10.1016/0304-4076(94)90038-8>.

</div>

<div id="ref-GomezAparicioetal2011DisentanglingRelative"
class="csl-entry">

Gómez-Aparicio, Lorena, Raúl García-Valdés, Paloma Ruíz-Benito, and
Miguel A. Zavala. 2011. “Disentangling the Relative Importance of
Climate, Size and Competition on Tree Growth in Iberian Forests:
Implications for Forest Management Under Global Change: Neighborhood
Models and Tree Growth Drivers.” *Global Change Biology* 17 (7):
2400–2414. <https://doi.org/10.1111/j.1365-2486.2011.02421.x>.

</div>

<div id="ref-GomezAparicioetal2009ArePine" class="csl-entry">

Gómez-Aparicio, Lorena, Miguel A. Zavala, Francisco J. Bonet, and Regino
Zamora. 2009. “Are Pine Plantations Valid Tools for Restoring
Mediterranean Forests? An Assessment Along Abiotic and Biotic
Gradients.” *Ecological Applications* 19 (8): 2124–41.
<https://doi.org/10.1890/08-1656.1>.

</div>

</div>
