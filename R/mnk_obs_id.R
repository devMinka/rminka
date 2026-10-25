
#' Get Minka Observation Details
#'
#' Retrieves full details for a single Minka observation by its identifier.
#' The Minka API response is flattened into a tibble.
#'
#' @param id A single non-empty character or numeric value identifying the
#'   Minka observation.
#' @param meta Logical value reserved for future use. It is currently ignored.
#'
#' @return A one-row tibble containing the flattened Minka API response, with
#'   fields for the taxon, observer, photos, identifications, and quality
#'   metrics. Key fields include:
#'   \describe{
#'     \item{id}{Observation identifier, integer.}
#'     \item{uuid}{Unique identifier, character.}
#'     \item{observed_on}{Observation date, character.}
#'     \item{created_at}{Creation date, character.}
#'     \item{updated_at}{Last update, character.}
#'     \item{quality_grade}{Quality grade, character.}
#'     \item{latitude}{Latitude in WGS84, numeric.}
#'     \item{longitude}{Longitude in WGS84, numeric.}
#'     \item{taxon.id}{Taxon identifier, integer.}
#'     \item{taxon.name}{Scientific name, character.}
#'     \item{taxon.rank}{Taxonomic rank, character.}
#'     \item{user.id}{Observer identifier, integer.}
#'     \item{user.login}{Observer login, character.}
#'     \item{photos}{List-column containing photo metadata.}
#'     \item{identifications}{List-column containing identifications.}
#'   }
#'   \code{NULL} is returned invisibly if the observation is not found, the
#'   response is empty or has an unexpected structure, or the API returns an
#'   HTTP error. Invalid JSON raises an error.
#'
#' @examples
#' \dontrun{
#' obs <- mnk_obs_id(id = 3546)
#' obs$id
#' obs$species_guess
#' obs$quality_grade
#' }
#' @export
mnk_obs_id <- function(id, meta = FALSE) {

  valid_type <- is.character(id) || is.numeric(id)
  if (!valid_type || length(id) != 1L || is.na(id[1]) ||
      (is.numeric(id) && !is.finite(id))) {
    stop(
      "You must provide a single, non-empty, non-NA ID for the observation.",
      call. = FALSE
    )
  }

  id_char <- as.character(id)
  if (!nzchar(trimws(id_char))) {
    stop(
      "You must provide a single, non-empty, non-NA ID for the observation.",
      call. = FALSE
    )
  }

  base_url <- "https://api.minka-sdg.org"
  api_path <- "/v1/observations/"
  q_path <- paste0(api_path, id_char)

  response <- httr::GET(base_url, path = q_path)

  if (httr::http_error(response)) {
    status <- httr::status_code(response)
    message("Minka API request failed for observation ID ", id_char,
            ". Status code: ", status)
    return(invisible(NULL))
  }

  response_content <- httr::content(response, as = "text", encoding = "UTF-8")

  if (nchar(response_content) == 0 || response_content == "null") {
    message("API returned an empty or null response for observation ID ", id_char, ".")
    return(invisible(NULL))
  }

  parsed_json_full <- tryCatch({
    jsonlite::fromJSON(response_content, simplifyVector = TRUE, flatten = TRUE)
  }, error = function(e) {
    stop("Failed to parse JSON response for observation ID ", id_char, ": ", e$message)
  })

  if (!is.list(parsed_json_full) && !is.data.frame(parsed_json_full)) {
    message("No data found or unexpected JSON structure (atomic type) for observation ID ",
            id_char, ".")
    return(invisible(NULL))
  }

  if (!is.null(parsed_json_full$results) &&
      is.data.frame(parsed_json_full$results) &&
      nrow(parsed_json_full$results) > 0) {
    df_result <- parsed_json_full$results
    if (nrow(df_result) > 1) {
      warning("Multiple observations found for ID ", id_char, ". Returning only the first one.")
      df_result <- df_result[1, ]
    }
  } else if (is.data.frame(parsed_json_full) && nrow(parsed_json_full) > 0) {
    df_result <- parsed_json_full
  } else {
    message("No data found or unexpected JSON structure for observation ID ", id_char, ".")
    return(invisible(NULL))
  }

  tibble::as_tibble(df_result)
}
