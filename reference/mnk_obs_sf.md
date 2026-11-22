# Convert Minka Observations to sf

Converts a data frame returned by
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) into
an `sf` POINT object. Keeps selected columns and coerces `observed_on`
to `Date` when present.

## Usage

``` r
mnk_obs_sf(data, ..., crs = 4326, keep_coords = TRUE)
```

## Arguments

- data:

  A data frame or tibble with at least `latitude` and `longitude`
  columns, typically from
  [`mnk_obs()`](https://devminka.github.io/rminka/reference/mnk_obs.md).

- ...:

  Columns to retain, using tidyselect syntax. `latitude` and `longitude`
  are always used to create geometry.

- crs:

  Coordinate reference system for the output. Defaults to 4326 (WGS 84).

- keep_coords:

  Logical. If `TRUE`, retains `latitude` and `longitude` as columns in
  addition to geometry.

## Value

An `sf` object with POINT geometry (EPSG:4326 by default) and the
selected attributes. Duplicate rows and rows with missing coordinates
are dropped. An empty `sf` object is returned if no valid coordinates
remain.

## See also

[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) for
downloading observations.

## Examples

``` r
obs <- data.frame(
  id = 1,
  latitude = 41,
  longitude = 2,
  observed_on = "2024-07-01",
  taxon_name = "Parablennius pilicornis"
)
obs_sf <- mnk_obs_sf(obs, id, taxon_name)
obs_sf
#> Simple feature collection with 1 feature and 5 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 2 ymin: 41 xmax: 2 ymax: 41
#> Geodetic CRS:  WGS 84
#>   id              taxon_name latitude longitude observed_on     geometry
#> 1  1 Parablennius pilicornis       41         2  2024-07-01 POINT (2 41)
```
