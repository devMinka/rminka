#' @title Get Project Users with Metadata
#' @description Retrieves the user identifiers associated with a Minka project
#'   and returns each user's profile metadata in a tibble using
#'   \code{mnk_user_info()}. The result has sixteen columns. A project lookup
#'   that fails because of a network or HTTP error returns a zero-row tibble.
#'   Network or HTTP errors for individual user lookups produce rows containing
#'   \code{NA} values.
#' @param project_id A single non-empty character string or finite numeric
#'   value giving the project identifier. Missing values and blank strings are
#'   not accepted.
#' @return A tibble with one row per project participant and the following
#'   sixteen columns:
#' \describe{
#' \item{id}{Integer. User identifier.}
#' \item{login}{Character. Username.}
#' \item{name}{Character. Full name.}
#' \item{created_at}{POSIXct. Account creation time.}
#' \item{observations_count}{Integer. Number of observations.}
#' \item{identifications_count}{Integer. Number of identifications.}
#' \item{species_count}{Integer. Number of observed species.}
#' \item{activity_count}{Integer. Total activity count.}
#' \item{journal_posts_count}{Integer. Number of journal posts.}
#' \item{orcid}{Character. ORCID identifier.}
#' \item{icon_url}{Character. URL of profile icon.}
#' \item{site_id}{Integer. Site identifier.}
#' \item{roles}{List. User roles.}
#' \item{spam}{Logical. Spam flag.}
#' \item{suspended}{Logical. Suspension flag.}
#' \item{universal_search_rank}{Integer. Search rank.}
#' }
#' @details The function queries the project endpoint, extracts its user
#'   identifiers, and retrieves each user's metadata with
#'   \code{mnk_user_info()}.
#' @seealso \code{\link{mnk_user_info}}, \code{\link{mnk_proj_info}}
#' @examples
#' \dontrun{
#' users <- mnk_proj_user(420)
#' dplyr::glimpse(users)
#' }
#' @export
mnk_proj_user <- function(project_id = NULL) {

  if (is.null(project_id)) stop("You must provide 'project_id'.", call. = FALSE)
  valid_character_id <- is.character(project_id) &&
    length(project_id) == 1 &&
    !is.na(project_id) &&
    nzchar(trimws(project_id))
  valid_numeric_id <- is.numeric(project_id) &&
    length(project_id) == 1 &&
    !is.na(project_id) &&
    is.finite(project_id)
  if (!valid_character_id && !valid_numeric_id) {
    stop(
      "'project_id' must be a single non-empty character string or finite number.",
      call. = FALSE
    )
  }

  empty_users <- tibble::tibble(
    id = integer(),
    login = character(),
    name = character(),
    created_at = as.POSIXct(character()),
    observations_count = integer(),
    identifications_count = integer(),
    species_count = integer(),
    activity_count = integer(),
    journal_posts_count = integer(),
    orcid = character(),
    icon_url = character(),
    site_id = integer(),
    roles = list(),
    spam = logical(),
    suspended = logical(),
    universal_search_rank = integer()
  )

  resp <- tryCatch(
    httr::GET("https://api.minka-sdg.org", path = "v1/projects",
              query = list(id = as.character(project_id))),
    error = function(e) { message("Network error: ", e$message); NULL }
  )

  if (is.null(resp) || httr::http_error(resp)) {
    if (!is.null(resp)) message("Status: ", httr::status_code(resp))
    return(empty_users)
  }

  txt <- httr::content(resp, as = "text", encoding = "UTF-8")
  if (!nzchar(txt) || txt == "null") return(empty_users)

  js <- jsonlite::fromJSON(txt, simplifyVector = FALSE)
  if (is.null(js$results) || length(js$results) == 0) return(empty_users)

  ids <- unlist(js$results[[1]]$user_ids %||% list())
  if (length(ids) == 0) return(empty_users)

  purrr::map_dfr(as.integer(ids), mnk_user_info)
}
