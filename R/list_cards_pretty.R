#' #' Save all cards from a board to a data.frame
#' #'
#' #' @param organisation A character
#' #' @param board_id A character
#' #' @param token A character
#' #'
#' #' @export
#' #'
#' #' @examples
#' #' organisation <- "4597"
#' #' board_id <- 14351
#' #' token_sqc <- "807a0c3451c04602b4dbfdc0338a65f7"
#' #' upwaver::list_cards_pretty(organisation, board_id, token_sqc)
#' list_cards_pretty <- function(organisation, board_id, token) {
#'   stop("Does not work with new Upwaver API.")
#'   # upwaver <- list_cards(organisation, board_id, token)
#'   # ff <- upwaver$results
#'   #
#'   # n <- length(ff)
#'   # all_cards <- data.frame(id = character(n),
#'   #                         title = character(n),
#'   #                         text = character(n),
#'   #                         tasks = character(n), stringsAsFactors = FALSE)
#'   #
#'   # for (i in 1:n) {
#'   #   card <- ff[[i]]
#'   #   all_cards$id[i] <- card$id
#'   #   all_cards$title[i] <- card$title
#'   #
#'   #   # description
#'   #   textline <- card$description
#'   #   splits <- gregexpr("<.*?>", textline)[[1]]
#'   #   len <- attributes(splits)$match.length
#'   #   textline <- substr(textline, splits[2] + len[2], nchar(textline))
#'   #   all_cards$text[i] <- gsub("<.*?>", "", textline)
#'   #
#'   #   # tasks:
#'   Most probably this line needs to be changed with the new API endpoints. SCN
#'   #   url <- paste0("https://", organisation, ".upwave.io/api/tasklistitems/?card=", card$id)
#'   #   upwaver_tasks <- content_as_list(request(url, token))$results
#'   #   task_list <- c()
#'   #   if (length(upwaver_tasks) > 0) {
#'   #     for (k in 1:length(upwaver_tasks)) {
#'   #       task_list <- c(task_list, upwaver_tasks[[k]]$description)
#'   #     }
#'   #     all_cards$tasks[i] <- paste(task_list, collapse="<br>")
#'   #   } else {
#'   #     all_cards$tasks[i] <- ""
#'   #   }
#'   # }
#'   # all_cards
#' }
#'
#'
#'
