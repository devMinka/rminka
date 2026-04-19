# Search Minka Projects by Name

Retrieves projects whose title contains a given string from the Minka
API.

## Usage

``` r
mnk_proj_byname(query)
```

## Arguments

- query:

  a single character string contained in the project name.

## Value

A tibble with one row per matching project. Returns an empty tibble with
zero rows if no matches are found. Columns are:

- id:

  Project identifier, integer.

- title:

  Project title, character.

- place_id:

  Associated place identifier, integer or `NA`.

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
mainly used to obtain the project identifier for other functions.

## Examples

``` r
if (FALSE) { # \dontrun{
# Search for projects containing "Biomarato 2025"
mnk_proj_byname(query = "Biomarato 2025")
} # }
```
