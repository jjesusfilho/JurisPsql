#' \code{JurisPsql} package
#'
#' Manipulates PostgreSQL Legal Databases
#'
#'
#' @docType package
#' @name JurisPsql
#' @importFrom magrittr %>% %<>%
#' @importFrom rlang :=
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1")

  utils::globalVariables(c("DO_TOKEN"))
