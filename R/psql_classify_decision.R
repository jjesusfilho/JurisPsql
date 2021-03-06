#' Creates a new column giving a one word conclusion of the decision
#'
#' @param con connection
#' @param tbl table with the whole decision text
#' @param decision decision text
#' @param conclusion name of new column
#'
#' @return it just adds to specified table a new column
#' @export
#'
#' @examples
#' \dontrun{
#' con <- DBI::dbConnect(RPostgres::Postgres())
#' data(consumidor)
#' dplyr::copy_to(con, "consumidor", consumidor)
#' psql_classify_decision(con, "consumidor", "julgado", "decisao")
#' }
psql_classify_decision <- function(con, tbl = NULL, decision = NULL, conclusion = NULL) {
  v1 <- "% parcial%"
  v2 <- "% procedente em parte%"
  v3 <- "% procedente %"
  v4 <- "% condeno %"
  v5 <- "% improcedente%"
  v6 <- "% prejudicad%"
  v7 <- "% nulo %"
  v8 <- "% anul%"
  v9 <- "% extint%"

  parcial <- "parcial"
  procedente <- "procedente"
  improcedente <- "improcedente"
  prejudicado <- "prejudicado"
  nulo <- "nulo"
  extinto <- "extinto"
  nulo <- NULL

  query <- glue::glue_sql(
    "ALTER TABLE {`tbl`} ADD {`conclusion`} text",
    .con = con
  )

  res <- DBI::dbSendQuery(con, query)
  DBI::dbClearResult(res)

  query <- glue::glue_sql(
    "UPDATE {`tbl`}
  SET {`conclusion`} =
  CASE WHEN {`tbl`}.{`decision`} ILIKE {v1} THEN {parcial}
  WHEN {`tbl`}.{`decision`} ILIKE  {v2} THEN {parcial}
  WHEN {`tbl`}.{`decision`} ILIKE  {v3} THEN {procedente}
  WHEN {`tbl`}.{`decision`} ILIKE  {v4} THEN {procedente}
  WHEN {`tbl`}.{`decision`} ILIKE  {v5} THEN {improcedente}
  WHEN {`tbl`}.{`decision`} ILIKE  {v6} THEN {prejudicado}
  WHEN {`tbl`}.{`decision`} ILIKE  {v7} THEN {nulo}
  WHEN {`tbl`}.{`decision`} ILIKE  {v8} THEN {nulo}
  WHEN {`tbl`}.{`decision`} ILIKE  {v9} THEN {extinto}
  ELSE {nulo}
  END",
    .con = con
  )


  res <- DBI::dbSendQuery(con, query)
  res <- DBI::dbClearResult(res)
}
