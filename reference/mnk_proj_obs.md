# Download Project Observations by Year

Downloads observations for a specific Minka project, filtered by year
and optionally by month and day. This is a convenience wrapper around
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

  a single numeric project identifier.

- year:

  a single numeric year (e.g., 2024).

- month:

  optional numeric month (1-12). Defaults to NULL for all months.

- day:

  optional numeric day (1-31). Defaults to NULL for all days.

- quiet:

  logical. If TRUE, suppresses console messages. Defaults to FALSE.

- limit_download:

  logical. If TRUE (default), caps download at 10,000 records per query
  subdivision. If FALSE, attempts to download all records.

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
# Download all observations for project 419 for the year 2024
proj_data_2024 <- mnk_proj_obs(project_id = 419, year = 2024)

# Download observations for project 419 for August 2025, without limit
proj_data_aug_2025 <- mnk_proj_obs(
  project_id = 419,
  year = 2025,
  month = 8,
  limit_download = FALSE
)
} # }
```
