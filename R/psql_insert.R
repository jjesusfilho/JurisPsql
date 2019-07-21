#' Insert data to existing table
#'
#' @param con connection
#' @param tbl existing table
#' @param data data.frame
#' @param batch_size number of rows to be inserted at a time.
#'     Defaults to 50.000
#'
#' @return NULL if correctly inserted.
#' @export
#'
#' @examples
#' \dontrun{
#' con <- dbx::dbxConnect()
#' DBI::dbCreateTable(con,"consumidor",consumidor)
#' psql_insert(con,"consumidor",consumidor)
#' }
psql_insert <- function(con,tbl=NULL,data=NULL,batch_size=50000) {

  if (is.null(tbl)) {
    stop("You must provide an existing table to insert data")

  }

  if (is.null(data)) {
    stop("You must provide the data to be inserted")

  }
  dbx::dbxInsert(con=con,table = tbl,records=data,batch_size = batch_size)


}
