# Download Place Observations by Year

Downloads observations for a Minka place for a specified year and,
optionally, month and day. This is a convenience wrapper around
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).

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

  Numeric year to query.

- month:

  Optional month from 1 to 12. Defaults to `NULL` (all months).

- day:

  Optional day from 1 to 31. Defaults to `NULL` (all days).

- quiet:

  Logical value. If `TRUE`, suppresses console messages.

- limit_download:

  Logical value. If `TRUE` (default), limits each query subdivision to
  10,000 records. If `FALSE`, attempts to download all matching records.

## Value

A tibble with the observation columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md),
with an additional `URL_image` column when `url_picture_med` is present.
This column contains the medium-size image URL. An empty tibble is
returned if no observations match.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download place observations for August 2025 without a record cap
place_data_aug_2025 <- mnk_place_obs(
  place_id = 257,
  year = 2025,
  month = 8,
  limit_download = FALSE
)
} # }
```
