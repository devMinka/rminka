#' Convert Minka Observations to sf
#'
#' Converts a data frame returned by \code{\link{mnk_obs}} into an \code{sf}
#' POINT object. Keeps selected columns and coerces \code{observed_on} to
#' \code{Date} when present.
#'
#' @param data A data frame or tibble with at least \code{latitude} and
#'   \code{longitude} columns, typically from \code{mnk_obs()}.
#' @param ... Columns to retain, using tidyselect syntax. \code{latitude} and
#'   \code{longitude} are always used to create geometry.
#' @param crs Coordinate reference system for the output. Defaults to 4326
#'   (WGS 84).
#' @param keep_coords Logical. If \code{TRUE}, retains \code{latitude} and
#'   \code{longitude} as columns in addition to geometry.
#' @return An \code{sf} object with POINT geometry (EPSG:4326 by default) and
#'   the selected attributes. Duplicate rows and rows with missing coordinates
#'   are dropped. An empty \code{sf} object is returned if no valid coordinates
#'   remain.
#' @seealso \code{\link{mnk_obs}} for downloading observations.
#'
#' @examples
#' \dontrun{
#' obs <- mnk_obs(
#'   taxon_name = "Parablennius pilicornis",
#'   year = 2024,
#'   month = 7
#' )
#' obs_sf <- mnk_obs_sf(obs, id, taxon_name, observed_on)
#' obs_sf
#' }
#' @export
mnk_obs_sf <- function(data, ..., crs = 4326, keep_coords = TRUE) {
  if (!inherits(data, "data.frame")) {
    stop("`data` must be a data.frame or tibble", call. = FALSE)
  }
  if (!all(c("latitude", "longitude") %in% names(data))) {
    stop("`data` must contain `latitude` and `longitude` columns", call. = FALSE)
  }
  if (!is.logical(keep_coords) || length(keep_coords) != 1 ||
      is.na(keep_coords)) {
    stop(
      "`keep_coords` must be a single, non-missing logical value",
      call. = FALSE
    )
  }

  out <- dplyr::select(
    data,
    ...,
    dplyr::all_of(c("latitude", "longitude")),
    dplyr::any_of("observed_on")
  )
  out <- dplyr::mutate(
    out,
    dplyr::across(dplyr::any_of("observed_on"), as.Date)
  )
  out <- dplyr::filter(
    out,
    !is.na(.data$latitude),
    !is.na(.data$longitude)
  )
  out <- dplyr::distinct(out)

  if (nrow(out) == 0) {
    if (!keep_coords) {
      out <- dplyr::select(out, -dplyr::all_of(c("latitude", "longitude")))
    }
    geometry <- sf::st_sfc(sf::st_point(), crs = crs)[0]
    return(sf::st_sf(out, geometry = geometry))
  }

  sf::st_as_sf(
    out,
    coords = c("longitude", "latitude"),
    crs = crs,
    remove = !keep_coords
  )
}
