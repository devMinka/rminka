# Get Minka Observation Details

Retrieves full details for a single Minka observation by its identifier.
Queries the Minka API and returns the complete record flattened into a
tibble.

## Usage

``` r
mnk_obs_id(id, meta = FALSE)
```

## Arguments

- id:

  a single integer. The Minka observation identifier.

- meta:

  a logical value. Reserved for future use. Currently ignored.

## Value

a one-row tibble with the observation data. The result is the flattened
JSON response from the Minka API and contains more than 160 columns
covering taxon, user, photos, identifications, and quality metrics. Key
fields include:

- id:

  observation identifier, integer.

- uuid:

  unique identifier, character.

- observed_on:

  observation date, character.

- created_at:

  creation date, character.

- updated_at:

  last update, character.

- quality_grade:

  quality grade, character.

- latitude:

  latitude in WGS84, numeric.

- longitude:

  longitude in WGS84, numeric.

- taxon.id:

  taxon identifier, integer.

- taxon.name:

  scientific name, character.

- taxon.rank:

  taxonomic rank, character.

- user.id:

  observer identifier, integer.

- user.login:

  observer login, character.

- photos:

  list column with photo metadata.

- identifications:

  list column with identifications.

Returns `NULL` invisibly if the observation is not found or the request
fails.

## Examples

``` r
if (FALSE) { # \dontrun{
obs <- mnk_obs_id(6475)
obs$id
obs$taxon.name
obs$quality_grade
} # }
```
