#' Generate Short Name from Scientific Name
#'
#' Creates an abbreviation from a scientific name by taking the first three
#' letters of each word, converting them to lowercase, and joining them with
#' periods. Each name must contain one to three words.
#' @param scientific_name A character vector of scientific names. Each element
#'   must contain one to three words. Missing and blank values are not allowed.
#' @return A character vector of the same length as `scientific_name`. Each
#'   element contains the abbreviation formed by the first three lowercase
#'   letters of each word, separated by periods. For example, "Diplodus sargus"
#'   returns "dip.sar" and "Diplodus sargus sargus" returns "dip.sar.sar".
#'   An error is signaled if the input is not a non-empty character vector,
#'   contains missing or blank values, or has more than three words per name.
#' @examples
#' shrt_name("Diplodus sargus")
#' shrt_name("Diplodus sargus sargus")
#' shrt_name(c("Diplodus cervinus", "Diplodus vulgaris", "Diplodus sargus"))
#' @export
shrt_name <- function(scientific_name) {
  if (!is.character(scientific_name) || length(scientific_name) == 0) {
    stop("Input must be a non-empty character string or vector.", call. = FALSE)
  }

  if (anyNA(scientific_name)) {
    stop("Input cannot contain NA or empty strings.", call. = FALSE)
  }

  normalized_names <- stringr::str_squish(scientific_name)
  if (any(!nzchar(normalized_names))) {
    stop("Input cannot contain NA or empty strings.", call. = FALSE)
  }

  words <- stringr::str_split(normalized_names, "\\s+")
  if (any(lengths(words) > 3)) {
    stop("Each scientific name must contain between 1 and 3 words.", call. = FALSE)
  }

  purrr::map_chr(words, function(name_words) {
    abbreviation <- stringr::str_sub(
      stringr::str_to_lower(name_words),
      1,
      3
    )
    paste(abbreviation, collapse = ".")
  })
}
