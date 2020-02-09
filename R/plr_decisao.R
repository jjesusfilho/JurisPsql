#' Cria PostgreSQL função para classificar decisões
#'
#' @param con conexão
#' @param tbl tabela
#' @param texto julgado. Colocar entre aspas.
#'
#' @return
#' @export
#'
#' @examples
plr_decisao <- function(con,tbl,texto){

  decisao <- "decisao"

  query <- glue::glue_sql('CREATE EXTENSION IF NOT EXISTS PLR',.con=con)

  RPostgres::dbExecute(con,query)

  query <- glue::glue_sql('CREATE OR REPLACE FUNCTION plr_decisao(text) RETURNS text AS
  $$
  tjsp::classificar_decisao2(arg1)
  $$
  language PLR
  ',.con=con)

  RPostgres::dbExecute(con,query)

  query <- glue::glue_sql('ALTER TABLE {`tbl`) ADD COLUMN {`decisao`} text',.con=con)

  RPostgres::dbExecute(con,query)

  query <- glue::glue_sql('UPDATE {`tbl`} SET {`decisao`} = plr_decisao({`texto`}',.con = con)

  RPostgres::dbExecute(con,query)
}
