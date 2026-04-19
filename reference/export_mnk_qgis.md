# Export sf Minka Objects to a GeoPackage for QGIS

Writes one or more `sf` objects to a GeoPackage (`.gpkg`) with one layer
per object. The function is designed for a smooth QGIS workflow: it
ensures valid geometries, drops Z/M dimensions, removes list-columns
that GDAL cannot write, and transforms to a target CRS.

## Usage

``` r
export_mnk_qgis(..., file = NULL, crs = 4326, overwrite = TRUE)
```

## Arguments

- ...:

  One or more objects of class `sf`. Each object must be named; the name
  is used as the layer name in the GeoPackage (e.g.,
  `export_mnk_qgis(points = pts, polygons = polys)`).

- file:

  Character. Path to the output GeoPackage. It is highly recommended to
  provide a full path. If a simple filename is provided, it will be
  saved in the current working directory. The `.gpkg` extension is added
  if missing.

- crs:

  CRS to transform to before writing. Accepts anything valid for
  [`sf::st_transform()`](https://r-spatial.github.io/sf/reference/st_transform.html)
  (e.g., `4326` or `"EPSG:4326"`). Default is `4326` (WGS 84).

- overwrite:

  Logical. If `TRUE` and `file` exists, the file is deleted before
  writing. If `FALSE` and the file exists, the function appends layers
  (and will error if a layer name already exists). Default is `TRUE`.

## Value

Invisibly returns the normalized path to the written GeoPackage. Called
for its side effect of writing the file.

## Details

The function performs the following steps for each layer:

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
if (FALSE) { # \dontrun{
library(sf)

# points
pts <- st_as_sf(data.frame(id = 1:2, x = c(0.8, 0.9), y = c(40.9, 41.0)),
coords = c("x", "y"), crs = 4326)

# polygon
poly <- st_as_sf(st_sfc(
st_polygon(list(rbind(c(0.7,40.8), c(1.0,40.8), c(1.0,41.1),
c(0.7,41.1), c(0.7,40.8)))),
crs = 4326))
# The names of the layers will be exampl_points and  exampl_area
export_mnk_qgis(exampl_points = pts, exampl_area = poly,
file = tempfile(fileext = ".gpkg"))
} # }
```
