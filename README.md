
<!-- README.md is generated from README.Rmd. Please edit that file -->

# JurisPsql

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/jjesusfilho/JurisPsql.svg?branch=master)](https://travis-ci.org/jjesusfilho/JurisPsql)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jjesusfilho/JurisPsql?branch=master&svg=true)](https://ci.appveyor.com/project/jjesusfilho/JurisPsql)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The goal of JurisPsql is to provide functions to manipulate Brazilian
legal databases from R.

Most of the functions are primarily concern with jurimetric needs not
found in the `dbplyr` package.

## Installation

You can install the development version with:

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
