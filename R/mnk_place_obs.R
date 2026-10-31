#' Download Place Observations by Year
#'
#' Downloads observations for a Minka place for a specified year and,
#'   optionally, month and day. This is a convenience wrapper around
#'   \code{\link{mnk_obs}}.
#'
#' @param place_id The numeric ID or slug of the Minka place.
#' @param year Numeric year to query.
#' @param month Optional month from 1 to 12. Defaults to \code{NULL} (all
#'   months).
#' @param day Optional day from 1 to 31. Defaults to \code{NULL} (all days).
#' @param quiet Logical value. If \code{TRUE}, suppresses console messages.
#' @param limit_download Logical value. If \code{TRUE} (default), limits each
#'   query subdivision to 10,000 records. If \code{FALSE}, attempts to
#'   download all matching records.
#'
#' @return A tibble with the observation columns documented in
#'   \code{\link{mnk_obs}}, with an additional \code{URL_image} column when
#'   \code{url_picture_med} is present. This column contains the medium-size
#'   image URL. An empty tibble is returned if no observations match.
#'
#' @examples
#' \dontrun{

#' # Download place observations for August 2025 without a record cap
#' place_data_aug_2025 <- mnk_place_obs(
#'   place_id = 257,
#'   year = 2025,
#'   month = 8,
#'   limit_download = FALSE
#' )
#' }
#' @export
mnk_place_obs <- function(place_id, year, month = NULL, day = NULL, quiet = FALSE, limit_download = TRUE) {

  observations <- mnk_obs(
    place_id = place_id,
    year = year,
    month = month,
    day = day,
    quiet = quiet,
    limit_download = limit_download
  )

  if ("url_picture_med" %in% names(observations)) {
    observations$URL_image <- observations$url_picture_med
  }

  observations

}
