#' Search Minka Projects by Name
#'
#' Retrieves projects whose title contains a given string from the Minka API.
#'
#' @details Queries the \code{/v1/projects/autocomplete} endpoint. This
#'   function is mainly used to obtain project identifiers for other functions.
#' @param query A single non-empty character string contained in a project
#'   title.
#' @return A tibble with one row per matching project. If the API response
#'   contains no projects or has an unexpected format, the function returns an
#'   empty tibble with the columns listed below. If the API returns no content
#'   or an HTTP error, it returns \code{NULL} invisibly.
#'   Columns are:
#' \describe{
#' \item{id}{Project identifier, integer.}
#' \item{title}{Project title, character.}
#' \item{place_id}{Associated place identifier, integer or `NA`.}
#' \item{slug}{URL slug, character.}
#' \item{created_at}{Creation timestamp, character.}
#' \item{updated_at}{Last update timestamp, character.}
#' \item{project_type}{Project type, character.}
#' \item{description}{Project description, character.}
#' }
#' @examples
#' \dontrun{
#' # Search for projects containing "Biomarato 2025"
#' mnk_proj_byname(query = "Biomarato 2025")
#' }
#' @export
mnk_proj_byname <- function(query) {

  if (missing(query) || is.null(query) || !is.character(query) ||
      length(query) != 1 || is.na(query) || !nzchar(trimws(query))) {
    stop(
      "You must provide a single, non-empty, non-NA character 'query' for the project search.",
      call. = FALSE
    )
  }

  base_url <- "https://api.minka-sdg.org"

  empty_res <- tibble::tibble(
    id = integer(),
    title = character(),
    place_id = integer(),
    slug = character(),
    created_at = character(),
    updated_at = character(),
    project_type = character(),
    description = character()
  )

  q_enc <- utils::URLencode(query, reserved = TRUE)
  q_path <- paste0("/v1/projects/autocomplete?q=", q_enc)

  response <- httr::GET(base_url, path = q_path)

  if (httr::http_error(response)) {
    status <- httr::status_code(response)
    message("Minka API request failed for query '", query, "'. Status code: ", status)
    return(invisible(NULL))
  }

  content <- httr::content(response, as = "parsed", encoding = "UTF-8")

  if (is.null(content)) {
    message("API returned an empty or null response for query '", query, "'.")
    return(invisible(NULL))
  }

  if (!is.list(content) || !is.list(content$results) ||
      length(content$results) == 0) {
    message("No projects found for query '", query, "'.")
    return(empty_res)
  }

  purrr::map_dfr(content$results, function(x) tibble::tibble(
    id = `%||%`(x$id, NA_integer_),
    title = `%||%`(x$title, NA_character_),
    place_id = `%||%`(x$place_id, NA_integer_),
    slug = `%||%`(x$slug, NA_character_),
    created_at = `%||%`(x$created_at, NA_character_),
    updated_at = `%||%`(x$updated_at, NA_character_),
    project_type = `%||%`(x$project_type, NA_character_),
    description = `%||%`(x$description, NA_character_)
  ))
}
