#' Creates an index from columns assunto and julgados
#'
#' @param con connection
#' @param tbl table
#'
#' @return No R object is returned
#' @export
#'
#' @examples
#' \dontrun{
#' library(JurisPsql)
#' con <- dbx::dbxConnect()
#' dplyr::copy_to(con, "consumidor", consumidor)
#' psql_cjpg_tokenize(con, "consumidor")
#' }
psql_cjpg_tokenize <- function(con, tbl) {
  source <- list(a = c("assunto", "A"), j = c("julgado", "B"))
  target <- "document_tokens"
  idx <- paste0(tbl,"_idx")
  query <- glue::glue_sql("ALTER TABLE {`tbl`} ADD COLUMN {`target`} TSVECTOR", .con = con)

  res <- DBI::dbSendQuery(con, query)
  DBI::dbClearResult(res)

  query <- glue::glue_sql("UPDATE {`tbl`} SET
                         {`target`} = setweight(to_tsvector(coalesce({`source$a[1]`},'')), {source$a[2]}) ||
                         setweight(to_tsvector(coalesce({`source$j[1]`}, '')), {source$j[2]})", .con = con)

  res <- DBI::dbSendQuery(con, query)
  DBI::dbClearResult(res)

  query <- glue::glue_sql("CREATE INDEX {`idx`} ON {`tbl`} USING GIN ({`target`})", .con = con)

  res <- DBI::dbSendQuery(con, query)
  DBI::dbClearResult(res)
}
