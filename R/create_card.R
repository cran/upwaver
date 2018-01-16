#' Create a new card on a specified UpWave board
#'
#' create_card_from_excel() adds a new card in the most-left column of the given board.
#' The Information of the card are taken from an excel file.
#'
#' @param excel_file A character. The path to an excel-file providing informations for user-stories;
#' expected columns: US-ID, name, description
#' @param sheet An integer or a character. The sheet of the excel-file providing informations for user-stories;
#' expected columns: US-ID, name, description
#' @param line_number An integer. The line number in the spreadsheet starting from 0 --> SLC: Why not 1?!
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param board_id An integer. The board number, the card has to be created in
#' @param board_name A character. The board name, the card has to be created in
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @export
#'
#' @examples
#' \dontrun{create_card_from_excel(excel_file = "path_to_your_excel_file", sheet = (sheetno. or sheetname),
#' line_number = linenr, organisation = "your_organisation", board_id = your_board_id,
#' board_name = "your_board_name", "token = your_api_token")}
create_card_from_excel <- function(excel_file, sheet, line_number, organisation,
                                   board_id, board_name, token) {
  name_by_board_id <- board_details(organisation, board_id, token)$title
  if (length(name_by_board_id) == 0) {
    stop(paste0("Board ", board_name, " does not exist"))
  }
  assertthat::assert_that(name_by_board_id == board_name)

  url <- paste0("https://", organisation, ".upwave.io/api/cards/")

  df <- XLConnect::readWorksheetFromFile(excel_file,
                                         sheet= sheet,
                                         startRow = 1,
                                         endCol = 100)

  data <- df[line_number,]

  json <- list(description = paste0("<h1>US",data$US.ID," - ",
                                    data$name, "</h1><p>",
                                    data$description, "</p>"),
               board = board_id)

  httr::POST(url, httr::content_type("application/json"),
             httr::add_headers(Authorization = paste0("Token ", token)),
             body = json, encode = "json")
}
