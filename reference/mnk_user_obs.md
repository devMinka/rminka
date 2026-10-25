# Download User Observations by Year

Downloads observations for a user for a specified year and, optionally,
month and day. This is a convenience wrapper around
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).

## Usage

``` r
mnk_user_obs(
  user_id,
  year,
  month = NULL,
  day = NULL,
  quiet = FALSE,
  limit_download = TRUE
)
```

## Arguments

- user_id:

  Numeric user identifier or character login name.

- year:

  Numeric year to query.

- month:

  Optional month to query, from 1 to 12. Defaults to `NULL` (all
  months).

- day:

  Optional day to query, from 1 to 31. Defaults to `NULL` (all days).

- quiet:

  Logical value. If `TRUE`, suppresses console messages.

- limit_download:

  Logical value. If `TRUE` (default), limits each query subdivision to
  10,000 records. If `FALSE`, attempts to download all matching records.

## Value

A tibble with the observation columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md). An
empty tibble is returned if no observations match.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download up to 10,000 observations for user 4 in 2024
mnk_user_obs(user_id = 4, year = 2024)

# Download observations for August 2024 without a record cap
mnk_user_obs(
  user_id = 4,
  year = 2024,
  month = 8,
  limit_download = FALSE
)
} # }
```
