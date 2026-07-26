# Download Minka Observations by Last Update Date

Downloads observation data from the Minka API filtering by last update
date. It automatically subdivides requests by month and day to avoid the
10,000 record limit per request imposed by the Minka API.

## Usage

``` r
mnk_obs_update(day_update, ..., quiet = FALSE, limit_download = TRUE)
```

## Arguments

- day_update:

  Date from which to retrieve updated observations. Character string in
  `"yyyy-mm-dd"` format or a `Date` object. Observations with
  `updated_at >= day_update` will be returned.

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

  Logical. If `TRUE`, suppresses console progress messages. Default
  `FALSE`.

- limit_download:

  Logical. If `TRUE` (default), each subdivided request is capped at
  10,000 records as per API limitation.

## Value

A `tibble` with one row per observation and the same columns documented
in [`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).
Returns an empty tibble if no data is found.

## Details

This is a wrapper around
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) that
uses the `updated_at` filter. If the total number of records since
`day_update` exceeds 10,000, the function splits the query by
year/month, and if necessary, by day.

## See also

[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md),
[`mnk_obs_byday`](https://devminka.github.io/rminka/reference/mnk_obs_byday.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Download all observations updated since a date
obs <- mnk_obs_update("2026-03-31", taxon_name = "Diplodus vulgaris")

# Use with bounds (must be EPSG:4326)
barcelona <- c(41.5, 2.3, 41.2, 2.0)
obs_bc <- mnk_obs_update("2024-01-01",
  bounds = barcelona, quiet = TRUE)
} # }
```
