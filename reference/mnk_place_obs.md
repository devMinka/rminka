# Download Place Observations by Year

This is a convenience wrapper for
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md) to
simplify downloading observations for a specific place, filtered by year
and optionally by month and day.

## Usage

``` r
mnk_place_obs(
  place_id,
  year,
  month = NULL,
  day = NULL,
  quiet = FALSE,
  limit_download = TRUE
)
```

## Arguments

- place_id:

  The numeric ID or slug of the Minka place.

- year:

  The numeric year for the query (required).

- month:

  (Optional) The numeric month (1-12). Defaults to NULL (all months).

- day:

  (Optional) The numeric day (1-31). Defaults to NULL (all days).

- quiet:

  A logical value. If \`TRUE\`, all console messages will be suppressed.

- limit_download:

  A logical value. If \`TRUE\` (default), the download is capped at
  10,000 records per query subdivision. If \`FALSE\`, it attempts to
  download all records.

## Value

A tibble with the observation columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md),
plus `URL_image`, an alias for `url_picture_med`. Returns an empty
tibble if no observations match.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download all observations for place 257 (Platja del Forum) for August 2025,
# attempting to get all records without a limit.
place_data_aug_2025 <- mnk_place_obs(place_id = 257, year = 2025, month = 8,
limit_download = FALSE)
} # }
```
