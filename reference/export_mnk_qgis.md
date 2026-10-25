# Export sf Minka Objects to a GeoPackage for QGIS

Writes one or more `sf` objects to a GeoPackage (`.gpkg`), with one
layer per object. The function prepares the data for QGIS by repairing
invalid geometries, dropping Z/M dimensions, removing unsupported
list-columns, and transforming each layer to a target CRS.

## Usage

``` r
export_mnk_qgis(..., file = NULL, crs = 4326, overwrite = TRUE)
```

## Arguments

- ...:

  One or more objects of class `sf`. Each object must have a unique,
  non-empty name, which is used as its layer name in the GeoPackage. For
  example, use `export_mnk_qgis(points = pts, polygons = polys)`.

- file:

  A single, non-empty character path for the output GeoPackage. A simple
  filename is saved in the current working directory. The `.gpkg`
  extension is added if missing.

- crs:

  Coordinate reference system to transform to before writing. Accepts
  any value supported by
  [`sf::st_transform()`](https://r-spatial.github.io/sf/reference/st_transform.html),
  such as `4326` or `"EPSG:4326"`. Defaults to `4326` (WGS 84).

- overwrite:

  A single logical value. If `TRUE` and `file` exists, the file is
  deleted before writing. If `FALSE` and the file exists, layers are
  appended; writing fails if a layer name already exists. Defaults to
  `TRUE`.

## Value

Invisibly returns the normalized path to the written GeoPackage. Called
for its side effect of writing the file.

## Details

Before changing the output file, the function checks that all inputs are
named `sf` objects and that the layer names are unique. It then performs
the following steps for each layer:

1.  Transform to `crs` with
    [`sf::st_transform()`](https://r-spatial.github.io/sf/reference/st_transform.html).

2.  Drop Z and M dimensions with
    [`sf::st_zm()`](https://r-spatial.github.io/sf/reference/st_zm.html).

3.  Repair invalid geometries with
    [`sf::st_make_valid()`](https://r-spatial.github.io/sf/reference/valid.html).

4.  Remove non-geometry list-columns, which GDAL cannot write to GPKG.

5.  Write the layer with
    [`sf::st_write()`](https://r-spatial.github.io/sf/reference/st_write.html)
    using the GPKG driver.

If `overwrite = TRUE`, the existing file is removed first. If the file
cannot be removed (e.g., it is open in QGIS), the function stops with an
informative error.

## Examples

``` r
points <- sf::st_as_sf(
  data.frame(id = 1:2, x = c(0.8, 0.9), y = c(40.9, 41.0)),
  coords = c("x", "y"),
  crs = 4326
)
polygon <- sf::st_as_sf(
  sf::st_sfc(
    sf::st_polygon(list(rbind(
      c(0.7, 40.8), c(1.0, 40.8), c(1.0, 41.1),
      c(0.7, 41.1), c(0.7, 40.8)
    ))),
    crs = 4326
  )
)
output_file <- tempfile(fileext = ".gpkg")
export_mnk_qgis(points = points, area = polygon, file = output_file)
unlink(output_file)
```
