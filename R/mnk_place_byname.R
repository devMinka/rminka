#' Search Minka Places by Name
#'
#' Retrieves places whose name contains a given string from the Minka API.
#'
#' @details Queries the \code{/v1/places/autocomplete} endpoint.
#' @param query A single non-empty character string contained in a place name.
#'
#' @return A tibble with one row per matching place. Returns an empty tibble
#'   with the columns listed below if no matches are found. Returns
#'   \code{NULL} invisibly if the API returns an empty body or an HTTP error.
#'   Columns are:
#' \describe{
#' \item{place_id}{Place identifier, integer.}
#' \item{slug}{URL slug, character.}
#' \item{name}{Place name, character.}
#' \item{area}{Bounding box area, numeric.}
#' \item{display_name}{Full display name, character.}
#' \item{location_latitud}{Latitude in decimal degrees, numeric.}
#' \item{location_longitud}{Longitude in decimal degrees, numeric.}
#' }
#'
#' @examples
#' \dontrun{
#' places <- mnk_place_byname(query = "Sant Feliu")
#' }
#' @export
mnk_place_byname <- function(query) {

  if (missing(query) || is.null(query) || !is.character(query) ||
      length(query) != 1 || is.na(query) || !nzchar(trimws(query))) {
    stop("You must provide a non-empty 'query' string.", call. = FALSE)
  }

  base_url <- "https://api.minka-sdg.org"
  empty_res <- tibble::tibble(
    place_id = integer(),
    slug = character(),
    name = character(),
    area = double(),
    display_name = character(),
    location_latitud = double(),
    location_longitud = double()
  )

  q_enc <- utils::URLencode(query, reserved = TRUE)
  q_path <- paste0("/v1/places/autocomplete?q=", q_enc)

  response <- httr::GET(base_url, path = q_path)

  if (httr::http_error(response)) {
    message("Minka API request failed. Status code: ", httr::status_code(response))
    return(invisible(NULL))
  }

  response_content <- httr::content(response, as = "text", encoding = "UTF-8")
  if (nchar(response_content) == 0) {
    message("API returned an empty response.")
    return(invisible(NULL))
  }

  parsed_json <- jsonlite::fromJSON(response_content, simplifyVector = FALSE)
  if (!is.list(parsed_json$results) || length(parsed_json$results) == 0) {
    message("No places found for your query.")
    return(empty_res)
  }

  purrr::map_dfr(parsed_json$results, function(x) {
    loc_str <-  `%||%`(x$location, NA_character_)
    loc_parts <- suppressWarnings(as.numeric(strsplit(loc_str, ",", fixed = TRUE)[[1]]))
    lat <- if (length(loc_parts)==2) loc_parts[1] else NA_real_
    lon <- if (length(loc_parts)==2) loc_parts[2] else NA_real_

    tibble::tibble(
      place_id = suppressWarnings(as.integer( `%||%`(x$id, NA_integer_))),
      slug = `%||%`(x$slug, NA_character_),
      name =  `%||%`(x$name, NA_character_),
      area = suppressWarnings(as.numeric( `%||%`(x$bbox_area, NA_real_))),
      display_name =  `%||%`(x$display_name, NA_character_),
      location_latitud = lat,
      location_longitud = lon
    )
  })
}
