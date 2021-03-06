
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
found in the `dbplyr` package, but they are useful to whoever works with
texts.

## Installation

You can install the development version with:

``` r
devtools::install_github("jjesusfilho/JurisPsql")
```

## Usage

New functions will be added little by little, but right now there are
two very useful features, which are the decision classifier and the
decision text search.

There is a sample dataset of consumers’ rights court decisions to play
with.

``` r

library(JurisPsql)

con <- DBI::dbConnect(RPostgres::Postgres())

dplyr::copy_to(con,"consumidor",consumidor)

psql_classify_decision(con,"consumidor",julgado,"decisao")
```

## Decision-text search

Full-text search is implemented through the following functions:

  - `psql_write_cjpg`: Creates a new table, writes a dataframe to it,
    creates a primary key to the table, creates a weighted inverted
    index on columns `assunto` and `julgado`, and also builds a trigger
    to reindex the same table every time the table is updated or gets
    inserted with new rows.

  - `psql_cjpg_tokenize`: Creates an weighted inverted index from a cjpg
    table.

  - `psql_cjpg_insert`: Inserts new rows to a table. The whole table is
    automatically reindexed once new rows are inserted.

  - `psql_cjpg_trigger`: Adds a trigger to a cjpg table to reindex it
    every time it gets updated or inserted with new rows.

  - `psql_cjpg_query`: Queries words or phrases the same way you would
    do it with Google ou Bing.

This feature is particularly important to improve full-text search on
text decisions and also on panel opinions (acórdãos in Portuguese).

Depending on your PostgreSQL configuration it might take a long time if
the number of documents is large. It took around one hour to index
700.000 judicial decisions .

I have worked with Elasticsearch and Solr before, but I am convinced
that with PostgreSQL we have the best of the three worlds (sql, nosql
and search engine), no need to use either nosql like Mongodb or search
engines like Elasticsearch and Solr.

``` r
con <- DBI::dbConnect(RPostgres::Postgres())

psql_write_cjpg(con,"consumidor",consumidor)
```

Once the indexing is done, you can use the function `psql_cjpg_query` to
search for words or phrases the same way you would do with any web
search engine like Bing or Google. You can also include it in your
shinyapp to allow users to do search.

Function `psql_cjpg_query` allows faceting by subjects (assuntos) and
also by courts (foros). Dates will be included pretty soon.

Please note that the ‘JurisPsql’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
