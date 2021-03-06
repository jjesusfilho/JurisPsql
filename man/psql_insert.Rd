% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psql_insert.R
\name{psql_insert}
\alias{psql_insert}
\title{Insert data to existing table}
\usage{
psql_insert(con, tbl = NULL, data = NULL, batch_size = 50000)
}
\arguments{
\item{con}{connection}

\item{tbl}{existing table}

\item{data}{data.frame}

\item{batch_size}{number of rows to be inserted at a time.
Defaults to 50.000}
}
\value{
NULL if correctly inserted.
}
\description{
Insert data to existing table
}
\examples{
\dontrun{
con <- dbx::dbxConnect()
DBI::dbCreateTable(con, "consumidor", consumidor)
psql_insert(con, "consumidor", consumidor)
}
}
