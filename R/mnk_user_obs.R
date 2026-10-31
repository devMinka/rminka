#' @title Download User Observations by Year
#' @description Downloads observations for a user for a specified year and,
#'   optionally, month and day. This is a convenience wrapper around
#'   \code{\link{mnk_obs}}.
#' @param user_id Numeric user identifier or character login name.
#' @param year Numeric year to query.
#' @param month Optional month to query, from 1 to 12. Defaults to
#'   \code{NULL} (all months).
#' @param day Optional day to query, from 1 to 31. Defaults to \code{NULL}
#'   (all days).
#' @param quiet Logical value. If \code{TRUE}, suppresses console messages.
#' @param limit_download Logical value. If \code{TRUE} (default), limits each
#'   query subdivision to 10,000 records. If \code{FALSE}, attempts to
#'   download all matching records.
#' @return A tibble with the observation columns documented in
#'   \code{\link{mnk_obs}}. An empty tibble is returned if no observations
#'   match.
#' @examples
#' \dontrun{
#' # Download up to 10,000 observations for user 4 in 2024
#' mnk_user_obs(user_id = 4, year = 2024)
#'
#' # Download observations for August 2024 without a record cap
#' mnk_user_obs(
#'   user_id = 4,
#'   year = 2024,
#'   month = 8,
#'   limit_download = FALSE
#' )
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
