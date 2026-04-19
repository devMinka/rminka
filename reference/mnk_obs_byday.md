# Download Minka Observations by Date Range

Downloads observation data from the Minka API for a specified date
range. Subdivides requests by month or day automatically to avoid the
10,000 record API limit.

## Usage

``` r
mnk_obs_byday(d1, d2, ..., quiet = FALSE, limit_download = TRUE)
```

## Arguments

- d1:

  start date in 'yyyy-mm-dd' format.

- d2:

  end date in 'yyyy-mm-dd' format.

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

  a logical value. If TRUE, suppresses console messages.

- limit_download:

  a logical value. If TRUE (default), each subdivided request is capped
  at 10,000 records.

## Value

a tibble with one row per observation and the same columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).
Returns an empty tibble if no data is found.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download observations between two dates
obs <- mnk_obs_byday("2024-03-01", "2024-03-31",
taxon_name = "Diplodus sargus")

# Use with bounds (must be EPSG:4326)
barcelona <- c(41.5, 2.3, 41.2, 2.0)
obs_bc <- mnk_obs_byday("2024-01-01", "2024-01-07",
bounds = barcelona, quiet = TRUE)
} # }
```
