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

  A logical value. If `TRUE`, all console messages will be suppressed.

- limit_download:

  A logical value. If `TRUE` (default), the download is capped at 10,000
  records per query subdivision. If `FALSE`, it attempts to download all
  records.

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
# Download all observations for place 'barcelona' for the year 2024
# (up to the download limit)
place_data_2024 <- mnk_place_obs(place_id = "barcelona", year = 2024)

# Download all observations for place 123 for August 2025,
# attempting to get all records without a limit.
place_data_aug_2025 <- mnk_place_obs(place_id = 123, year = 2025, month = 8,
limit_download = FALSE)
} # }
```
