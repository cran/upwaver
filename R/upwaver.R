#' Information about your organisation's boards
#'
#' list_boards() is a wrapper around "List Boards" as specified in the 'Upwave' API
#' https://www.upwave.io/api/. It returns information for your organisation's
#' boards as id's, title's, time of creation and the users who created the boards.
#'
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @return A list
#' @export
#'
#' @examples list_boards("ims-fhs", "a44fa67c5df2acc9836058ffca870d7b78b017cb")
list_boards <- function(organisation, token) {
  url <- paste0("https://", organisation, ".upwave.io/api/boards/")
  return(content_as_list(request(url, token)))
}


#' Information about a specific board
#'
#' board_details() is a wrapper around "board_details" as specified in the 'Upwave' API
#' https://www.upwave.io/api/. It returns detailed information about a specific board such
#' as id, title, purpose, background image, creation time, creator, columns, rows and colors.
#'
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param board_id An integer. The number of the board you want to inspect as specified in
#' the URL: https://<organisation>.upwave.io/board/<board_id>/view/
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @return A list
#' @export
#'
#' @examples board_details("ims-fhs", 14351, "a44fa67c5df2acc9836058ffca870d7b78b017cb")
board_details <- function(organisation, board_id, token) {
  url <- paste0("https://", organisation, ".upwave.io/api/boards/", board_id, "/")
  return(content_as_list(request(url, token)))
}


#' Information about the cards on a board
#'
#' list_cards() is wrapper around "List Cards" as specified in the 'Upwave' API
#' https://www.upwave.io/api/. It returns detailed Information about each card of a specific
#' board as card id, title, board id, description, due_dt, state, color, assigned, ...
#'
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param board_id An integer. The number of the board you want to inspect as specified in
#' the URL: https://<organisation>.upwave.io/board/<board_id>/view/
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @return A list
#' @export
#'
#' @examples list_cards("ims-fhs", 14351, "a44fa67c5df2acc9836058ffca870d7b78b017cb")
list_cards <- function(organisation, board_id, token) {
  url <- paste0("https://", organisation, ".upwave.io/api/cards/?board=", board_id)
  return(content_as_list(request(url, token)))
}


#' Create a correct request for the 'Upwave' API
#'
#' request() is an internal function that invokes a GET request with a token according to
#' https://www.upwave.io/api/
#'
#' @param url an URL
#' @param token an authentication token
#'
#' @return request
request <- function(url, token) {
  return(httr::GET(url, httr::add_headers(Authorization = paste0("Token ", token))))
}

#' Transform the answer of a 'Upwave' API request to a list
#'
#' content_as_list() is an internal function that extracts content from a request and
#' coerces it to a list format
#'
#' @param response An object of class "response"; response of a GET request
#'
#' @return A list
content_as_list <- function(response) {
  json <- httr::content(response, as = "text")
  return(rjson::fromJSON(json))
}
