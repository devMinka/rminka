# Convert Minka Observations to sf

Converts a tibble returned by
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) into
an sf POINT object. Keeps selected columns and coerces `observed_on` to
Date when present.

## Usage

``` r
mnk_obs_sf(data, ..., crs = 4326, keep_coords = TRUE)
```

## Arguments

- data:

  a data frame or tibble with at least `latitude` and `longitude`
  columns, typically from
  [`mnk_obs()`](https://devminka.github.io/rminka/reference/mnk_obs.md).

- ...:

  columns to retain, using tidyselect syntax. `latitude` and `longitude`
  are always added for geometry.

- crs:

  coordinate reference system for the output, defaults to 4326 (WGS84).

- keep_coords:

  logical. If TRUE, retains `latitude` and `longitude` as regular
  columns in addition to geometry.

## Value

an sf object with POINT geometry (EPSG:4326 by default) and the selected
attributes. Returns an empty sf object if no valid coordinates are
present.

## See also

[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) for
downloading observations.

## Examples

``` r
if (FALSE) { # \dontrun{
obs <- mnk_obs(taxon_name = "Parablennius pilicornis", year = 2024)
obs_sf <- mnk_obs_sf(obs, id, taxon_name, observed_on)
obs_sf
} # }
```
