# Download Minka Observations

Downloads observation data from the Minka API. Handles pagination and
API result limits by subdividing large queries by month or day.

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

  A general search string passed to the API's `q` parameter.

- taxon_name:

  A common or scientific taxon name.

- taxon_id:

  A numeric identifier for a taxon.

- user_id:

  A numeric identifier or login name for a user.

- project_id:

  A numeric identifier or slug for a project.

- place_id:

  A numeric identifier or slug for a place.

- endemic:

  Logical value indicating whether to filter for endemic species.

- introduced:

  Logical value indicating whether to filter for introduced species.

- threatened:

  Logical value indicating whether to filter for threatened species.

- quality:

  Quality grade to include: `"casual"` or `"research"`.

- geo:

  Logical value. If `TRUE`, filters for observations with coordinates.

- annotation:

  Numeric vector of length two containing a term ID and a term value ID.

- year:

  Numeric year to include.

- month:

  Numeric month to include, from 1 to 12.

- day:

  Numeric day to include, from 1 to 31.

- bounds:

  Bounding box, supplied as an `sf` object in EPSG:4326 (WGS 84) or as a
  numeric vector in the order `c(nelat, nelng, swlat, swlng)`.

- quiet:

  Logical value. If `TRUE`, suppresses console messages.

- limit_download:

  Logical value. If `TRUE` (default), limits the total download to
  10,000 records. If `FALSE`, attempts to download all matching records.

## Value

A tibble with one row per observation and the following columns:

- id:

  Observation identifier, integer.

- observed_on:

  Observation date, character.

- year:

  Year component, integer.

- month:

  Month component, integer.

- week:

  Week component, integer.

- day:

  Day component, integer.

- hour:

  Hour component, integer.

- created_at:

  Creation timestamp, character.

- updated_at:

  Last update timestamp, character.

- latitude:

  Latitude in WGS 84, numeric.

- longitude:

  Longitude in WGS 84, numeric.

- positional_accuracy:

  Coordinate uncertainty in meters, integer.

- geoprivacy:

  Geoprivacy setting, character.

- obscured:

  Flag indicating obscured coordinates, logical.

- uri:

  API resource URI, character.

- url_picture_icon:

  URL of the first photo at icon resolution, character.

- url_picture_med:

  URL of the first photo at medium resolution, character.

- url_picture_orig:

  URL of the first photo at original resolution, character.

- quality_grade:

  Quality grade, character.

- taxon_id:

  Taxon identifier, integer.

- taxon_name:

  Scientific name, character.

- taxon_rank:

  Taxonomic rank, character.

- taxon_min_ancestry:

  Lowest species ancestry, character.

- taxon_endemic:

  Endemic status, logical.

- taxon_threatened:

  Threatened status, logical.

- taxon_introduced:

  Introduced status, logical.

- taxon_native:

  Native status, logical.

- user_id:

  Observer identifier, integer.

- user_login:

  Observer login, character.

An empty tibble is returned if no observations are found.

## Examples

``` r
# \donttest{
# Download the first 10,000 observations of a taxon from a project in 2025
obs <- mnk_obs(project_id = 417, year = 2025,
taxon_name = "Diplodus sargus" )
#> --- STARTING ANNUAL DOWNLOAD FOR THE YEAR 2025 ---
#> 
#> --- Evaluating month: January 2025 ---
#> No records were found for January 2025
#> 
#> --- Evaluating month: February 2025 ---
#> No records were found for February 2025
#> 
#> --- Evaluating month: March 2025 ---
#> No records were found for March 2025
#> 
#> --- Evaluating month: April 2025 ---
#> No records were found for April 2025
#> 
#> --- Evaluating month: May 2025 ---
#> The month of May has 115 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: June 2025 ---
#> The month of June has 210 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: July 2025 ---
#> The month of July has 234 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: August 2025 ---
#> The month of August has 391 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: September 2025 ---
#> The month of September has 300 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: October 2025 ---
#> The month of October has 89 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: November 2025 ---
#> No records were found for November 2025
#> 
#> --- Evaluating month: December 2025 ---
#> No records were found for December 2025
#> 
#> --- FINISHING... ---
#> Download complete! A total of 1,339 records were obtained.
# Download all 2024 observations for a user within a bounding box
barcelona <- c(41.5, 2.3, 41.2, 2.0)
obs_bc <- mnk_obs(
  year = 2024,
  user_id = 4,
  bounds = barcelona,
  quiet = TRUE,
  limit_download = FALSE
)
# }
```
