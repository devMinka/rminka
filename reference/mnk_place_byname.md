# Search Minka Places by Name

Retrieves places whose name contains a given string from the Minka API.

## Usage

``` r
mnk_place_byname(query)
```

## Arguments

- query:

  A single non-empty character string contained in a place name.

## Value

A tibble with one row per matching place. Returns an empty tibble with
the columns listed below if no matches are found. Returns `NULL`
invisibly if the API returns an empty body or an HTTP error. Columns
are:

- place_id:

  Place identifier, integer.

- slug:

  URL slug, character.

- name:

  Place name, character.

- area:

  Bounding box area, numeric.

- display_name:

  Full display name, character.

- location_latitud:

  Latitude in decimal degrees, numeric.

- location_longitud:

  Longitude in decimal degrees, numeric.

## Details

Queries the `/v1/places/autocomplete` endpoint.

## Examples

``` r
if (FALSE) { # \dontrun{
places <- mnk_place_byname(query = "Sant Feliu")
} # }
```
