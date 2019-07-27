
<!-- README.md is generated from README.Rmd. Please edit that file -->

# JurisPsql <img src='man/figures/logo.png' align="right" height="117" />

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
found in the `dbplyr` package, but they are useful to whoever works
texts too.

## Installation

You can install the development version with:

``` r
devtools::install_github("jjesusfilho/JurisPsql")
```

## Usage

I will be adding new functions little by little, but right now there are
two very useful features, which are the decision classifier and the
decision text search.

I have added a sample dataset of consumers’ rights court decisions for
you to play with the functions.

``` r

library(JurisPsql)

con <- DBI::dbConnect(RPostgres::Postgres())

data(consumidor)

dplyr::copy_to(con,"consumidor",consumidor)

psql_classify_decision(con,"consumidor","julgado","decisao")
```

## Decision-text search

I have implemented full-text search through the following functions:

\-`psql_write_cjpg`: Creates a new table, writes a dataframe to it,
creates a primary key to the table, creates an inverted weighted index
on columns `assunto` and `julgado`, and also creates a trigger to
reindex the same table every time the table is updated or gets inserted
with new rows.

  - `psql_cjpg_tokenize`: Creates an inverted weighted index from a cjpg
    table.

  - `psql_cjpg_insert`: Inserts new rows to a table. The whole table is
    automatically reindexed once new rows are inserted.

  - `psql_cjpg_trigger`: Adds a trigger to a cjpg table to reindex it
    every time it gets updated or inserted with new rows.

  - `psql_cjpg_query`: Queries words or phrases the same way you would
    do it with Google ou Bing.

I have worked with Elasticsearch and Solr before, but I am convinced
that with PostgreSQL we have the best of the three worlds (sql, nosql
and search engine), no need to use either nosql like Mongodb or search
engines like Elasticsearch and Solr.

This feature is particularly important to improve full-text search on
text decisions and also on panel opinions (acórdãos in Portuguese).

Depending on your PostgreSQL configuration it might take a long time if
the number of documents is large. I have indexed 700.000 judicial
decisions with minimal PostgreSQL config and it took several minutes.

``` r
con <- DBI::dbConnect(RPostgres::Postgres())

psql_write_cjpg(con,"consumidor",consumidor)
```

Once the indexing is over, you can use the function `psql_cjpg_query` to
search for words or phrases the same way you do with any web search
engine like Bing or Google. You can also include it in your shinyapp to
allow users to do search.

Please note that the ‘JurisPsql’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
