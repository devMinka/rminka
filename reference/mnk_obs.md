# Download Minka Observations

Downloads observation data from the Minka API. Handles pagination and
rate limits automatically by subdividing large queries by month or day.

## Usage

``` r
mnk_obs(
  query = NULL,
  taxon_name = NULL,
  taxon_id = NULL,
  user_id = NULL,
  project_id = NULL,
  place_id = NULL,
  endemic = NULL,
  introduced = NULL,
  threatened = NULL,
  quality = NULL,
  geo = NULL,
  annotation = NULL,
  year = NULL,
  month = NULL,
  day = NULL,
  bounds = NULL,
  quiet = FALSE,
  limit_download = TRUE
)
```

## Arguments

- query:

  a generic query string for the 'q' parameter.

- taxon_name:

  a character string with the taxon name (common or scientific).

- taxon_id:

  a numeric ID for the taxon.

- user_id:

  a numeric ID for a specific user.

- project_id:

  a numeric ID for a specific project.

- place_id:

  a numeric ID for a specific place.

- endemic:

  a logical value. Filters for endemic species.

- introduced:

  a logical value. Filters for introduced species.

- threatened:

  a logical value. Filters for threatened species.

- quality:

  a character string. Must be 'casual' or 'research'.

- geo:

  a logical value. If TRUE, filters for observations with coordinates.

- annotation:

  a numeric vector of length 2 (term_id, term_value_id).

- year:

  a numeric value for the year.

- month:

  a numeric value for the month (1-12).

- day:

  a numeric value for the day (1-31).

- bounds:

  a bounding box. Accepts an sf object with CRS EPSG:4326 (WGS84) or a
  numeric vector c(nelat, nelng, swlat, swlng).

- quiet:

  a logical value. If TRUE, suppresses console messages.

- limit_download:

  a logical value. If TRUE (default), caps download at 10,000 records.

## Value

a tibble with one row per observation and the following columns:

- id:

  observation identifier, integer.

- observed_on:

  observation date, character.

- year:

  year component, integer.

- month:

  month component, integer.

- week:

  week component, integer.

- day:

  day component, integer.

- hour:

  hour component, integer.

- created_at:

  creation timestamp, character.

- updated_at:

  last update timestamp, character.

- latitude:

  latitude in WGS84, numeric.

- longitude:

  longitude in WGS84, numeric.

- positional_accuracy:

  coordinate uncertainty in meters, integer.

- geoprivacy:

  geoprivacy setting, character.

- obscured:

  flag for obscured coordinates, logical.

- uri:

  API resource URI, character.

- url_picture:

  URL of first photo, character.

- quality_grade:

  quality grade, character.

- taxon_id:

  taxon identifier, integer.

- taxon_name:

  scientific name, character.

- taxon_rank:

  taxonomic rank, character.

- taxon_min_ancestry:

  lowest species ancestry, character.

- taxon_endemic:

  endemic flag, logical.

- taxon_threatened:

  threatened flag, logical.

- taxon_introduced:

  introduced flag, logical.

- taxon_native:

  native flag, logical.

- user_id:

  observer identifier, integer.

- user_login:

  observer login, character.

Returns an empty tibble if no data is found.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download firts 10.000 observations of taxon  from a project in 2025
obs <- mnk_obs(project_id = 417, year = 2025,
taxon_name = "Diplodus sargus" )

# Download all records in 2024 from a user using bounds
barcelona <- c(41.5, 2.3, 41.2, 2.0)
obs_bc <- mnk_obs( year=2024, user_login = "xasalvador",
bounds = barcelona, quiet = TRUE, limit_dowload = FALSE)
} # }
```
