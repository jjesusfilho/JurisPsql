#' Adds trigger to cjpg table
#'
#' @description This function adds a trigger to a cjpg table retokenize
#'     the text the same table every time it is updated or new data is
#'     inserted to it.
#'
#' @param con connection
#' @param tbl table name
#' @param config defaults to portuguese
#'
#' @return query result is cleared after trigger creation
#' @export
#'

psql_cjpg_trigger <- function(con, tbl, config = "pg_catalog.portuguese") {
  tbl <- "tbl"

  source <- list(a = c("assunto", "A"), j = c("julgado", "B"))
  target <- "document_tokens"
  config <- "pg_catalog.portuguese"

  query <- glue::glue_sql("
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
ON {`tbl`} FOR EACH ROW EXECUTE FUNCTION
tsvector_update_trigger({`target`},{`config`},{`source$a[1]`},{`source$j[1]`})", .con = con)

  res <- DBI::dbSendQuery(con, query)

  DBI::dbClearResult(res)
}
