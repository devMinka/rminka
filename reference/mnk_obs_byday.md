# Download Minka Observations by Date Range

Downloads observation data from the Minka API for a specified date
range. When the result set exceeds 10,000 records, requests are
automatically subdivided by month or day to respect the API limit.

## Usage

``` r
mnk_obs_byday(d1, d2, ..., quiet = FALSE, limit_download = TRUE)
```

## Arguments

- d1:

  Start date in `YYYY-MM-DD` format.

- d2:

  End date in `YYYY-MM-DD` format.

- ...:

  Arguments passed on to
  [`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md)

  `query`

  :   a generic query string for the 'q' parameter.

  `taxon_name`

  :   a character string with the taxon name (common or scientific).

  `taxon_id`

  :   a numeric ID for the taxon.

  `user_id`

  :   a numeric ID for a specific user.

  `project_id`

  :   a numeric ID for a specific project.

  `place_id`

  :   a numeric ID for a specific place.

  `endemic`

  :   a logical value. Filters for endemic species.

  `introduced`

  :   a logical value. Filters for introduced species.

  `threatened`

  :   a logical value. Filters for threatened species.

  `quality`

  :   a character string. Must be 'casual' or 'research'.

  `geo`

  :   a logical value. If TRUE, filters for observations with
      coordinates.

  `annotation`

  :   a numeric vector of length 2 (term_id, term_value_id).

  `bounds`

  :   a bounding box. Accepts an sf object with CRS EPSG:4326 (WGS84) or
      a numeric vector c(nelat, nelng, swlat, swlng).

- quiet:

  Logical. If `TRUE`, suppresses console messages.

- limit_download:

  Logical. If `TRUE` (default), each request is capped at 10,000
  records. If `FALSE`, the function attempts to download all records.

## Value

A tibble with one row per observation and the fields returned by
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md),
except that photos are represented by `url_picture` (medium resolution)
and `url_picture_original`. The result also includes `species_guess`.
Returns an empty tibble if no data is found.

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
