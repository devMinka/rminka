# Search Minka Projects by Name

Retrieves projects whose title contains a given string from the Minka
API.

## Usage

``` r
mnk_proj_byname(query)
```

## Arguments

- query:

  A single non-empty character string contained in a project title.

## Value

A tibble with one row per matching project. If the API response contains
no projects or has an unexpected format, the function returns an empty
tibble with the columns listed below. If the API returns no content or
an HTTP error, it returns `NULL` invisibly. Columns are:

- id:

  Project identifier, integer.

- title:

  Project title, character.

- place_id:

  Associated place identifier, integer or \`NA\`.

- slug:

  URL slug, character.

- created_at:

  Creation timestamp, character.

- updated_at:

  Last update timestamp, character.

- project_type:

  Project type, character.

- description:

  Project description, character.

## Details

Queries the `/v1/projects/autocomplete` endpoint. This function is
mainly used to obtain project identifiers for other functions.

## Examples

``` r
# \donttest{
# Search for projects containing "Biomarato 2025"
mnk_proj_byname(query = "Biomarato 2025")
#> # A tibble: 5 × 8
#>      id title      place_id slug  created_at updated_at project_type description
#>   <int> <chr>         <int> <chr> <chr>      <chr>      <chr>        <chr>      
#> 1   417 BioMARató…      244 biom… 2025-03-2… 2026-06-2… collection   "La BioMAR…
#> 2   418 BioMARató…      245 biom… 2025-03-2… 2026-05-0… collection   "La BioMAR…
#> 3   419 BioMARató…      249 biom… 2025-03-2… 2026-05-0… collection   "La BioMAR…
#> 4   420 BioMARató…      248 biom… 2025-03-2… 2026-05-0… collection   "La BioMAR…
#> 5   424 BioMARato…      701 biom… 2025-04-0… 2026-09-0… collection   "Descobre …
# }
```
