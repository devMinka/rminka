#' @title Download User Observations by Year
#' @description Downloads observations for a specific user, filtered by year
#'   and optionally by month and day. This is a convenience wrapper for
#'   \code{\link{mnk_obs}}.
#' @param user_id A user identifier, either numeric ID or character login.
#' @param year The year to query, as a single integer.
#' @param month Optional month to filter, integer from 1 to 12. Defaults to
#'   `NULL`.
#' @param day Optional day to filter, integer from 1 to 31. Defaults to `NULL`.
#' @param quiet Logical; if `TRUE`, suppresses console messages.
#' @param limit_download Logical; if `TRUE` (default), caps each query
#'   subdivision at 10,000 records. If `FALSE`, attempts to retrieve all
#'   records.
#' @return A tibble with the observation columns documented in
#'   \code{\link{mnk_obs}}. Returns an empty tibble if no observations match.
#' @examples
#' \dontrun{
#' # Download the first 10,000 observations for user 4 in 2024
#' mnk_user_obs(user_id = 4, year = 2024)
#'
#' # Download all observations for August 2024 without record cap
#' mnk_user_obs(user_id = 4, year = 2024, month = 8, limit_download = FALSE)
#' }
#' @export
mnk_user_obs <- function(user_id, year, month = NULL, day = NULL,
                         quiet = FALSE, limit_download = TRUE) {
  mnk_obs(
    user_id = user_id,
    year = year,
    month = month,
    day = day,
    quiet = quiet,
    limit_download = limit_download
  )
}
