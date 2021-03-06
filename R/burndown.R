#' Calculate storypoints ans status of the Cards of a specific Board
#'
#' Calculates storypoints of released cards on a specific board
#'
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param board_id An integer. The number of the board you want to inspect as specified in
#' the URL: https://<organisation>.upwave.io/board/<board_id>/view/
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @return A list containing a data.frame with all storypoints and the status per card and
#' the numeric sum_storypoints.
#' @export
#'
#' @examples upwaver::storypoints_and_status_released(
#' "4597", 14351, "807a0c3451c04602b4dbfdc0338a65f7")
storypoints_and_status_released <- function(organisation, board_id, token) {
  cards <- upwaver::list_cards(organisation, board_id, token)$results
  if (length(cards) >= 100) {stop("More than 100 cards on board, calculation of storypoints may be wrong.")}

  df <- data.frame(title = character(length(cards)),
                   status = numeric(length(cards)),
                   storypoints = character(length(cards)),
                   stringsAsFactors = F)
  for (i in 1:length(cards)) {
    # state 0: Not specified, 1: Not started, 2: In progress, 3: Completed
    df[i, 1] <- cards[[i]]$title
    df[i, 2] <- cards[[i]]$state
    if (cards[[i]]$state == 3) {
      description <- cards[[i]]$description
      df[i, 3] <- aufwand(description)
    } else {
      df[i, 3] <- "Active" # active tasks
    }
  }
  return(list(storypoints_status = df,
              sum_storypoints = sum(as.numeric(df$storypoints[df$storypoints != "Active"]))))
}


#' Calculate storypoints ans status of the Cards of a specific Board
#'
#' Calculates storypoints (of active Cards, which are Cards that haven't been completed
#' yet) and status in the backlog of an 'Upwave' board.
#' Storypoints have to be specified in the description (directly beneath the title) of
#' each card with a string of the form: "Aufwand: X SP" or "Aufwand: X AT". This is not
#' part of the 'Upwave' API but an additional functionality.
#'
#' @param organisation A character. The name of the organisation as specified in the URL:
#' https://<organisation>.upwave.io
#' @param board_id An integer. The number of the board you want to inspect as specified in
#' the URL: https://<organisation>.upwave.io/board/<board_id>/view/
#' @param token A character. The API token to access boards on upwave.io. The token can be
#' obtained by visiting your account settings. Click your profile image, select "Settings"
#' and find your API-Key in the "Account" tab.
#'
#' @return A list containing a data.frame with all storypoints and the status per card and
#' the numeric sum_storypoints.
#' @export
#'
#' @examples
#' upwaver::storypoints_and_status("4597", 14351, "807a0c3451c04602b4dbfdc0338a65f7")
storypoints_and_status <- function(organisation, board_id, token) {
  cards <- upwaver::list_cards(organisation, board_id, token)$results
  cards <- lapply(cards, function(x){x$description <- gsub("<.*?>", "", x$description); x})
  cards <- lapply(cards, function(x){x$description <- gsub("\\&\\#\\d{5};", "", x$description); x})
  if (length(cards) >= 100) {stop("More than 100 cards on board, calculation of storypoints may be wrong.")}

  df <- data.frame(title = character(length(cards)),
                   status = numeric(length(cards)),
                   storypoints = character(length(cards)),
                   stringsAsFactors = F)
  for (i in 1:length(cards)) {
    # state 0: Not specified, 1: Not started, 2: In progress, 3: Completed
    df[i, 1] <- cards[[i]]$title
    df[i, 2] <- cards[[i]]$state
    if (cards[[i]]$state != 3) {
      description <- cards[[i]]$description
      df[i, 3] <- aufwand(description)
    } else {
      df[i, 3] <- "Completed" # completed tasks
    }
  }
  return(list(storypoints_status = df,
              sum_storypoints = sum(as.numeric(df$storypoints[df$storypoints != "Completed"]))))
}


#' Calculates the effort of a given card (given by its description)
#'
#' aufwand() parses the description of a card for tags like "Aufwand: 10 AT" or
#' "Aufwand: 10 SP".
#'
#' @param description A string extracted from an 'Upwave' card
#'
#' @return An integer
aufwand <- function(description) {
  assertthat::is.string(description)

  aufwand <- strsplit(description, split = "Aufwand: ")[[1]][2]
  aufwand <- strsplit(aufwand, split = "[ SP| AT]")[[1]][1]
  if(is.na(aufwand)) {aufwand <- 0}
  assertthat::assert_that(assertthat::noNA(aufwand))

  return(as.numeric(aufwand))
}
