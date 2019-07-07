
<!-- README.md is generated from README.Rmd. Please edit that file -->

# JurisPsql

<!-- badges: start -->

<!-- badges: end -->

The goal of JurisPsql is to provide functions to manipulate Brazilian
legal databases from R.

Most of the functions are primarily concern with jurimetric needs not
found in the `dbplyr` package.

## Installation

You can install the released version of JurisPsql from
[CRAN](https://CRAN.R-project.org) with:

``` r
pak::pkg_install("jjesusfilho/JurisPsql")
```

## Usage

I will be adding new functions little by little, but right now there is
one very usufull function, which is the decision classifier.

``` r

library(JurisPsql)

con <- DBI::dbConnect(RPostgres::Postgres())

data(consumidor)

dplyr::copy_to(con,"consumidor",consumidor)

psql_classify_decision(con,"consumidor","julgado","decisao")
```

Please note that the ‘JurisPsql’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
