#' Download Place Observations by Year
#'
#' This is a convenience wrapper for \code{\link{mnk_obs}} to
#' simplify downloading observations for a specific place, filtered by year and
#' optionally by month and day.
#'
#' @param place_id The numeric ID or slug of the Minka place.
#' @param year The numeric year for the query (required).
#' @param month (Optional) The numeric month (1-12). Defaults to NULL (all
#' months).
#' @param day (Optional) The numeric day (1-31). Defaults to NULL (all days).
#' @param quiet A logical value. If `TRUE`, all console messages will be
#' suppressed.
#' @param limit_download A logical value. If `TRUE` (default), the download is
#' capped at 10,000 records per query subdivision. If `FALSE`, it attempts to
#' download all records.
#'
#' @return A tibble with the observation columns documented in
#'   \code{\link{mnk_obs}}, plus \code{URL_image}, an alias for
#'   \code{url_picture_med}. Returns an empty tibble if no observations match.
#'
#' @examples
#' \dontrun{

#' # Download all observations for place 257 (Platja del Forum) for August 2025,
#' # attempting to get all records without a limit.
#' place_data_aug_2025 <- mnk_place_obs(place_id = 257, year = 2025, month = 8,
#' limit_download = FALSE)
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
