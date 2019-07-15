
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
legal PostgreSQL databases from R.

Most of the functions are primarily concern with jurimetric needs not
found in the `dbplyr` package.

## Installation

You can install the development version with:

``` r
devtools::install_github("jjesusfilho/JurisPsql")
```

Obs. You must have a recent version of devtools installed, because this
package imports my `tjsp` package which is only on Github.

## Usage

I will be adding new functions little by little, but right now there is
one very useful function, which is the decision classifier.

``` r

library(JurisPsql)

con <- DBI::dbConnect(RPostgres::Postgres())

data(consumidor)

dplyr::copy_to(con,"consumidor",consumidor)

psql_classify_decision(con,"consumidor","julgado","decisao")
```

## Full-text search

I have implemented full-text search through the functions
`psql_cjpg_tokenize` and `psql_cjpg_query`. I still have some features
to implement but they are working well and I really think that with
PostgreSQL you have the best of both worlds, no need to use
elasticsearch or solr.

Please note that the ‘JurisPsql’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
