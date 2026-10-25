# Get Minka Observation Details

Retrieves full details for a single Minka observation by its identifier.
The Minka API response is flattened into a tibble.

## Usage

``` r
mnk_obs_id(id, meta = FALSE)
```

## Arguments

- id:

  A single non-empty character or numeric value identifying the Minka
  observation.

- meta:

  Logical value reserved for future use. It is currently ignored.

## Value

A one-row tibble containing the flattened Minka API response, with
fields for the taxon, observer, photos, identifications, and quality
metrics. Key fields include:

- id:

  Observation identifier, integer.

- uuid:

  Unique identifier, character.

- observed_on:

  Observation date, character.

- created_at:

  Creation date, character.

- updated_at:

  Last update, character.

- quality_grade:

  Quality grade, character.

- latitude:

  Latitude in WGS84, numeric.

- longitude:

  Longitude in WGS84, numeric.

- taxon.id:

  Taxon identifier, integer.

- taxon.name:

  Scientific name, character.

- taxon.rank:

  Taxonomic rank, character.

- user.id:

  Observer identifier, integer.

- user.login:

  Observer login, character.

- photos:

  List-column containing photo metadata.

- identifications:

  List-column containing identifications.

`NULL` is returned invisibly if the observation is not found, the
response is empty or has an unexpected structure, or the API returns an
HTTP error. Invalid JSON raises an error.

## Examples

``` r
if (FALSE) { # \dontrun{
obs <- mnk_obs_id(id = 3546)
obs$id
obs$species_guess
obs$quality_grade
} # }
```
