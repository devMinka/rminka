# Download User Observations by Year

Downloads observations for a specific user, filtered by year and
optionally by month and day. This is a convenience wrapper for
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

  A user identifier, either numeric ID or character login.

- year:

  The year to query, as a single integer.

- month:

  Optional month to filter, integer from 1 to 12. Defaults to `NULL`.

- day:

  Optional day to filter, integer from 1 to 31. Defaults to `NULL`.

- quiet:

  Logical; if `TRUE`, suppresses console messages.

- limit_download:

  Logical; if `TRUE` (default), caps each query subdivision at 10,000
  records. If `FALSE`, attempts to retrieve all records.

## Value

A tibble with one row per observation. Returns an empty tibble with zero
rows if no observations match the query. Columns are:

- id:

  Observation identifier, integer.

- observed_on:

  Observation date, character in YYYY-MM-DD format.

- year:

  Year of observation, integer.

- month:

  Month of observation, integer.

- week:

  ISO week number, integer.

- day:

  Day of month, integer.

- hour:

  Hour of observation, integer.

- created_at:

  Record creation timestamp, character in ISO 8601 format.

- updated_at:

  Record update timestamp, character in ISO 8601 format.

- latitude:

  Decimal latitude, numeric.

- longitude:

  Decimal longitude, numeric.

- positional_accuracy:

  Coordinate uncertainty in meters, integer.

- geoprivacy:

  Geoprivacy flag, logical.

- obscured:

  Obscured coordinates flag, logical.

- uri:

  Observation url in Minka, character.

- url_picture:

  URL of observation image in Minka, character.

- quality_grade:

  Data quality grade, character.

- taxon_id:

  Taxon identifier, integer.

- taxon_name:

  Scientific name, character.

- taxon_rank:

  Taxonomic rank, character.

- taxon_min_ancestry:

  Minimal ancestry string, character.

- taxon_endemic:

  Endemic flag, logical.

- taxon_threatened:

  Threatened flag, logical.

- taxon_introduced:

  Introduced flag, logical.

- taxon_native:

  Native flag, logical.

- user_id:

  Observer identifier, integer.

- user_login:

  Observer login, character.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download the first 10,000 observations for user 6 (xasalva) in 2024
mnk_user_obs(user_id = 6, year = 2024)

# Download all observations for August 2024 without record cap
mnk_user_obs(user_id = 6, year = 2024, month = 8, limit_download = FALSE)
} # }
```
