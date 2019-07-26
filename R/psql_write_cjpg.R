#' Create and write a cjpg table to a tjsp database
#'
#' @description This function firstly creates a table based on the
#'     data columns to be written. Then it adds a primary key called
#'     document_idx. Secondly, it inserts the data rows. After that it
#'     creates an inverted index called document_tokens based on GIN algo.
#'
#' @param con a connection
#' @param tbl table name
#' @param data cjpg data.frame to be written.
#'
#' @return returns NULL if everything went well
#' @export
#'
#' @examples
#' \dontrun{
#' con <- dbx::dbxConnect()
#' psql(con, "consumidor", consumidor)
#' }
psql_write_cjpg <- function(con = NULL, tbl = NULL, data = NULL) {
  if (is.null(con)) {
    stop("Please provide a connection")
  }

  if (is.null(tbl)) {
    stop("You must provide an existing table to insert data")
  }

  if (is.null(data)) {
    stop("You must provide the data to be inserted")
  }

  DBI::dbCreateTable(con, tbl, data)

  psql_add_pkey(con, tbl)
  psql_insert(con, tbl, data = data)
  psql_cjpg_tokenize(con, tbl)
}
