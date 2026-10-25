# Download Minka Observations by Date Range

Downloads observation data from the Minka API for a specified date
range. When the result set exceeds 10,000 records, requests are
subdivided by month or day to respect the API result limit.

## Usage

``` r
mnk_obs_byday(d1, d2, ..., quiet = FALSE, limit_download = TRUE)
```

## Arguments

- d1:

  Start date in `YYYY-MM-DD` format.

- d2:

  End date in `YYYY-MM-DD` format. Must be on or after `d1`.

- ...:

  Arguments passed on to
  [`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md)

  `query`

  :   A general search string passed to the API's `q` parameter.

  `taxon_name`

  :   A common or scientific taxon name.

  `taxon_id`

  :   A numeric identifier for a taxon.

  `user_id`

  :   A numeric identifier or login name for a user.

  `project_id`

  :   A numeric identifier or slug for a project.

  `place_id`

  :   A numeric identifier or slug for a place.

  `endemic`

  :   Logical value indicating whether to filter for endemic species.

  `introduced`

  :   Logical value indicating whether to filter for introduced species.

  `threatened`

  :   Logical value indicating whether to filter for threatened species.

  `quality`

  :   Quality grade to include: `"casual"` or `"research"`.

  `geo`

  :   Logical value. If `TRUE`, filters for observations with
      coordinates.

  `annotation`

  :   Numeric vector of length two containing a term ID and a term value
      ID.

  `bounds`

  :   Bounding box, supplied as an `sf` object in EPSG:4326 (WGS 84) or
      as a numeric vector in the order `c(nelat, nelng, swlat, swlng)`.

- quiet:

  Logical value. If `TRUE`, suppresses console messages.

- limit_download:

  Logical value. If `TRUE` (default), each request is capped at 10,000
  records. If `FALSE`, the function attempts to download all records.

## Value

A tibble with one row per observation and the fields returned by
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md),
except that photos are represented by `url_picture` (medium resolution)
and `url_picture_original`. The result also includes `species_guess`. An
empty tibble is returned if no observations are found.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download observations of a taxon during March 2024
obs <- mnk_obs_byday(
  d1 = "2024-03-01",
  d2 = "2024-03-31",
  taxon_name = "Diplodus sargus"
)

# Download observations within a bounding box during the first week of 2024
# Bounds are ordered north latitude, east longitude, south latitude,
# and west longitude.
barcelona <- c(41.5, 2.3, 41.2, 2.0)
obs_bc <- mnk_obs_byday(
  d1 = "2024-01-01",
  d2 = "2024-01-07",
  bounds = barcelona,
  quiet = TRUE
)
} # }
```
