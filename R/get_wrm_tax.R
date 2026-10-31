#' Get WoRMS Taxonomy
#'
#' Retrieves taxonomic information from the World Register of Marine Species
#' (WoRMS) for a scientific name and returns the first exact-name match.
#'
#' @param scientific_name A single, non-empty character string containing a
#'   scientific name, such as \code{"Diplodus sargus"}.
#'
#' @return A one-row tibble with taxonomic and habitat information.
#'   \code{NULL} is returned invisibly if no taxon is found or the request or
#'   response cannot be processed. The tibble contains the following columns:
#' \describe{
#' \item{valid_AphiaID}{WoRMS AphiaID, integer.}
#' \item{valid_name}{Accepted scientific name, character.}
#' \item{rank}{Taxonomic rank, character.}
#' \item{kingdom}{Kingdom, character.}
#' \item{phylum}{Phylum, character.}
#' \item{class}{Class, character.}
#' \item{order}{Order, character.}
#' \item{family}{Family, character.}
#' \item{genus}{Genus, character.}
#' \item{isMarine}{Marine habitat flag, logical.}
#' \item{isBrackish}{Brackish-water habitat flag, logical.}
#' \item{isFreshwater}{Freshwater habitat flag, logical.}
#' \item{isTerrestrial}{Terrestrial habitat flag, logical.}
#' \item{isExtinct}{Extinct flag, logical.}
#' }
#'
#' @examples
#' \dontrun{
#' # Retrieve taxonomy for a species
#' get_wrm_tax("Diplodus sargus")
#'
#' # Retrieve taxonomy for a genus
#' get_wrm_tax("Diplodus")
#' }
#' @export
get_wrm_tax <- function(scientific_name) {

  if (is.null(scientific_name) || !is.character(scientific_name) ||
      length(scientific_name) != 1L || is.na(scientific_name) ||
      !nzchar(trimws(scientific_name))) {
    stop(
      "'scientific_name' must be a single non-empty character string.",
      call. = FALSE
    )
  }

  encoded_name <- utils::URLencode(scientific_name, reserved = TRUE)

  api_url <- sprintf(
    "https://www.marinespecies.org/rest/AphiaRecordsByName/%s?like=false&marine_only=false&offset=1",
    encoded_name
  )

  response <- tryCatch({
    httr::GET(url = api_url)
  }, error = function(e) {
    message("Network error: WoRMS API is unavailable or unreachable. ", e$message)
    return(NULL)
  })

  if (is.null(response)) return(invisible(NULL))

  if (httr::http_error(response)) {
    status <- httr::status_code(response)
    message("WoRMS API request failed. Status code: ", status)
    return(invisible(NULL))
  }

  response_content <- httr::content(response, as = "text", encoding = "UTF-8")

  if (nchar(response_content) <= 2) {
    message("No taxon found for the scientific name: '", scientific_name, "'.")
    return(invisible(NULL))
  }

  parsed_json <- tryCatch(
    jsonlite::fromJSON(response_content, simplifyVector = FALSE),
    error = function(e) {
      message("Unable to parse WoRMS API response: ", conditionMessage(e))
      NULL
    }
  )

  if (is.null(parsed_json) || length(parsed_json) == 0) {
    message("API returned an empty or invalid response for: '", scientific_name, "'.")
    return(invisible(NULL))
  }

  if (!is.list(parsed_json) || !is.list(parsed_json[[1]])) {
    message("WoRMS API returned an unexpected response for: '",
            scientific_name, "'.")
    return(invisible(NULL))
  }

  taxon_data <- parsed_json[[1]]

  output_tibble <- tibble::tibble(
    valid_AphiaID = as.integer(
      `%||%`(taxon_data$valid_AphiaID, NA_integer_)
    ),
    valid_name = `%||%`(taxon_data$valid_name, NA_character_),
    rank = `%||%`(taxon_data$rank, NA_character_),
    kingdom = `%||%`(taxon_data$kingdom, NA_character_),
    phylum = `%||%`(taxon_data$phylum, NA_character_),
    class = `%||%`(taxon_data$class, NA_character_),
    order = `%||%`(taxon_data$order, NA_character_),
    family = `%||%`(taxon_data$family, NA_character_),
    genus = `%||%`(taxon_data$genus, NA_character_),
    isMarine = as.logical(`%||%`(taxon_data$isMarine, NA)),
    isBrackish = as.logical(`%||%`(taxon_data$isBrackish, NA)),
    isFreshwater = as.logical(`%||%`(taxon_data$isFreshwater, NA)),
    isTerrestrial = as.logical(`%||%`(taxon_data$isTerrestrial, NA)),
    isExtinct = as.logical(`%||%`(taxon_data$isExtinct, NA))
  )

  return(output_tibble)
}
