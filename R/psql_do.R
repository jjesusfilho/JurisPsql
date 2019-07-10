#' Retrives database information
#'
#' @param token you get this token from your digital ocean
#'     account.
#' @details
#' @return a list with all details about the database.
#' @export
#'
psql_do<-function(token=NULL){
  url<-"https://api.digitalocean.com/v2/databases"

  if (is.null(token)) {
    response<-httr::GET(url,httr::add_headers(Authorization=Sys.getenv(DO_TOKEN)),httr::content_type_json()) %>%
      httr::content("text") %>%
      jsonlite::fromJSON()
  } else {

    response<-httr::GET(url,httr::add_headers(Authorization=token),httr::content_type_json()) %>%
                          httr::content("text") %>%
                          jsonlite::fromJSON()
  }

}
