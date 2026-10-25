#' Download Project Observations by Year
#'
#' Downloads observations for a Minka project for a specified year and,
#'   optionally, month and day. This is a convenience wrapper around
#'   \code{\link{mnk_obs}}.
#' @param project_id Numeric project identifier or character project slug.
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
#' @export
#' @examples
#' \dontrun{
#' # Download all observations for project 419 for the year 2024
#' proj_data_2024 <- mnk_proj_obs(project_id = 419, year = 2024)
#'
#' # Download project observations for August 2025 without a record cap
#' proj_data_aug_2025 <- mnk_proj_obs(
#'   project_id = 419,
#'   year = 2025,
#'   month = 8,
#'   limit_download = FALSE
#' )
#' }
mnk_proj_obs <- function(project_id, year, month = NULL, day = NULL,
                         quiet = FALSE, limit_download = TRUE) {

  mnk_obs(
    project_id = project_id,
    year = year,
    month = month,
    day = day,
    quiet = quiet,
    limit_download = limit_download
  )
}
