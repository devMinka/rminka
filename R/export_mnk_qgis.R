#' Export sf Minka Objects to a GeoPackage for QGIS
#'
#' Writes one or more \code{sf} objects to a GeoPackage (\code{.gpkg}), with
#' one layer per object. The function prepares the data for QGIS by repairing
#' invalid geometries, dropping Z/M dimensions, removing unsupported
#' list-columns, and transforming each layer to a target CRS.
#'
#' @param ... One or more objects of class \code{sf}. Each object must have a
#'   unique, non-empty name, which is used as its layer name in the GeoPackage.
#'   For example, use \code{export_mnk_qgis(points = pts, polygons = polys)}.
#' @param file A single, non-empty character path for the output GeoPackage.
#'   A simple filename is saved in the current working directory. The
#'   \code{.gpkg} extension is added if missing.
#' @param crs CRS to transform to before writing. Accepts anything valid for
#' \code{sf::st_transform()} (e.g., \code{4326} or \code{"EPSG:4326"}).
#' Default is \code{4326} (WGS 84).
#' @param overwrite A single logical value. If \code{TRUE} and \code{file}
#'   exists, the file is deleted before writing. If \code{FALSE} and the file
#'   exists, layers are appended; writing fails if a layer name already exists.
#'   Defaults to \code{TRUE}.
#'
#' @return Invisibly returns the normalized path to the written GeoPackage.
#' Called for its side effect of writing the file.
#'
#' @details
#' Before changing the output file, the function checks that all inputs are
#' named \code{sf} objects and that the layer names are unique. It then
#' performs the following steps for each layer:
#' \enumerate{
#' \item Transform to \code{crs} with \code{sf::st_transform()}.
#' \item Drop Z and M dimensions with \code{sf::st_zm()}.
#' \item Repair invalid geometries with \code{sf::st_make_valid()}.
#' \item Remove non-geometry list-columns, which GDAL cannot write to GPKG.
#' \item Write the layer with \code{sf::st_write()} using the GPKG driver.
#' }
#' If \code{overwrite = TRUE}, the existing file is removed first. If the file
#' cannot be removed (e.g., it is open in QGIS), the function stops with an
#' informative error.
#'
#' @examples
#' points <- sf::st_as_sf(
#'   data.frame(id = 1:2, x = c(0.8, 0.9), y = c(40.9, 41.0)),
#'   coords = c("x", "y"),
#'   crs = 4326
#' )
#' polygon <- sf::st_as_sf(
#'   sf::st_sfc(
#'     sf::st_polygon(list(rbind(
#'       c(0.7, 40.8), c(1.0, 40.8), c(1.0, 41.1),
#'       c(0.7, 41.1), c(0.7, 40.8)
#'     ))),
#'     crs = 4326
#'   )
#' )
#' output_file <- tempfile(fileext = ".gpkg")
#' export_mnk_qgis(points = points, area = polygon, file = output_file)
#' unlink(output_file)
#'
#' @export
export_mnk_qgis <- function(..., file = NULL, crs = 4326, overwrite = TRUE) {

  if (is.null(file) || !is.character(file) || length(file) != 1L ||
      is.na(file) || !nzchar(trimws(file))) {
    stop("'file' must be a single, non-empty character path.", call. = FALSE)
  }
  if (!is.logical(overwrite) || length(overwrite) != 1L || is.na(overwrite)) {
    stop("'overwrite' must be a single TRUE or FALSE value.", call. = FALSE)
  }

  layers <- list(...)
  if (length(layers) == 0L) {
    stop("Provide at least one sf object.", call. = FALSE)
  }

  layer_names <- names(layers)
  if (is.null(layer_names) || anyNA(layer_names) ||
      any(!nzchar(trimws(layer_names)))) {
    stop("All inputs must have non-empty names.", call. = FALSE)
  }
  if (anyDuplicated(layer_names)) {
    stop("All layer names must be unique.", call. = FALSE)
  }

  for (nm in layer_names) {
    if (!inherits(layers[[nm]], "sf")) {
      stop("Object '", nm, "' is not an sf object.", call. = FALSE)
    }
  }

  if (!grepl("\\.gpkg$", file, ignore.case = TRUE)) {
    file <- paste0(file, ".gpkg")
  }

  if (file.exists(file) && overwrite) {
    unlink(file)
    if (file.exists(file)) {
      stop("Cannot remove existing file '", file,
           "'. Close it in QGIS or choose another path.", call. = FALSE)
    }
  }

  for (nm in layer_names) {
    x <- layers[[nm]]

    x <- sf::st_transform(x, crs)
    x <- sf::st_zm(x, drop = TRUE, what = "ZM")

    if (any(!sf::st_is_valid(x))) {
      x <- suppressWarnings(sf::st_make_valid(x))
    }

    is_list_col <- vapply(x, is.list, logical(1))
    is_sfc_col <- vapply(x, inherits, logical(1), what = "sfc")
    drop_cols <- is_list_col & !is_sfc_col
    if (any(drop_cols)) {
      x <- x[, !drop_cols, drop = FALSE]
    }

    sf::st_write(
      obj = x,
      dsn = file,
      layer = nm,
      driver = "GPKG",
      append = file.exists(file),
      delete_layer = overwrite,
      quiet = TRUE
    )
  }

  invisible(normalizePath(file, winslash = "/", mustWork = FALSE))
}
