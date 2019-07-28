#' PostgreSQL full-text search
#'
#' @param con connection
#' @param tbl table
#' @param assuntos vector of subjects to filter. Defaults do all subjects
#' @param foros vectos of courts to filter. Defaults to all courts.
#' @param query words to be searched. Separate by "&" (AND), "|" (OR),
#'     or "<->" (FOLLOWED BY) to search for more than one word.
#'
#' @return A data.frame with the cjpg decisions according to
#' @export
#'
#' @examples
#' \dontrun{
#' dplyr::copy_to(con, "consumidor", consumidor)
#' df <- psql_cjpg_query(con, "consumidor", "contrato & alguel")
#' df <- psql_cjpg_query(con, "consumidor", "contrato | alguel")
#' # Search for Julgo Procedente separated by up to 3 words:
#' df <- psql_cjpg_query(con, "consumidor", "julgo <3> procedente")
#' }
psql_cjpg_query <- function(con, tbl, query,assuntos=NULL,foros=NULL) {
  target <- "document_tokens"

  if (!is.null(assuntos) & !is.null(foros)){
  q <- glue::glue_sql("SELECT processo,classe,assunto,comarca,foro,vara,disponibilizacao, julgado FROM {`tbl`}
                        WHERE {`tbl`}.assunto IN ({assuntos*})
                        AND {`tbl`}.foro IN ({foros*})
                       AND {`tbl`}.{`target`} @@ websearch_to_tsquery({query})", .con = con)
  } else if (!is.null(assuntos) & is.null(foros)){

  q <- glue::glue_sql("SELECT processo,classe,assunto,comarca,foro,vara,disponibilizacao, julgado FROM {`tbl`}
                        WHERE {`tbl`}.assunto IN ({assuntos*})
                        AND {`tbl`}.{`target`} @@ websearch_to_tsquery({query})", .con = con)
  } else if (is.null(assuntos) & !is.null(foros)) {

    q <- glue::glue_sql("SELECT processo,classe,assunto,comarca,foro,vara,disponibilizacao, julgado FROM {`tbl`}
                        WHERE {`tbl`}.foro IN ({foros*})
                       AND {`tbl`}.{`target`} @@ websearch_to_tsquery({query})", .con = con)

  } else

  q <- glue::glue_sql("SELECT processo,classe,assunto,comarca,foro,vara,disponibilizacao, julgado FROM {`tbl`}

                       WHERE {`tbl`}.{`target`} @@ websearch_to_tsquery({query})", .con = con)

  df <- DBI::dbGetQuery(con, q)
}
