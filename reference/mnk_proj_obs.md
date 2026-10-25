# Download Project Observations by Year

Downloads observations for a Minka project for a specified year and,
optionally, month and day. This is a convenience wrapper around
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).

## Usage

``` r
mnk_proj_obs(
  project_id,
  year,
  month = NULL,
  day = NULL,
  quiet = FALSE,
  limit_download = TRUE
)
```

## Arguments

- project_id:

  Numeric project identifier or character project slug.

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
# Download all observations for project 419 for the year 2024
proj_data_2024 <- mnk_proj_obs(project_id = 419, year = 2024)

# Download project observations for August 2025 without a record cap
proj_data_aug_2025 <- mnk_proj_obs(
  project_id = 419,
  year = 2025,
  month = 8,
  limit_download = FALSE
)
} # }
```
