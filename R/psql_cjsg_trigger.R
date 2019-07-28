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

psql_cjpg_trigger <- function(con,tbl,config="pg_catalog.portuguese"){

  a<-"A"
  b<-"B"

  f_name<-paste0(tbl,"_trigger()")

  q<-glue::glue_sql("CREATE FUNCTION {DBI::SQL(f_name)} RETURNS trigger AS '
begin
  new.document_token :=
     setweight(to_tsvector({`config`}, coalesce(new.assunto,'')), {`a`}) ||
     setweight(to_tsvector({`config`}, coalesce(new.julgado,'')), {`b`});
  return new;
end
' LANGUAGE plpgsql;",.con=con)

  RPostgres::dbExecute(con,q)

  q <- glue::glue_sql("
CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
    ON {`tbl`} FOR EACH ROW EXECUTE FUNCTION {DBI::SQL(f_name)}
",.con=con)


  RPostgres::dbExecute(con,q)

}
