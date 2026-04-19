# Projects Subscribed by a Minka User

Retrieves projects to which a user is explicitly subscribed from Minka
and returns project metadata as a tibble.

## Usage

``` r
mnk_user_proj(id_user)
```

## Arguments

- id_user:

  A single integer or numeric value identifying the user.

## Value

A tibble with one row per subscribed project. If no subscriptions are
found or an error occurs, it returns an empty tibble with the same
column structure. Columns are:

- id:

  Project identifier, integer.

- title:

  Project title, character.

- description:

  Project description, character.

- slug:

  URL slug, character.

- icon:

  Icon URL, character.

- place_id:

  Associated place identifier, integer or `NA`.

- created_at:

  Creation date, character in ISO 8601 format.

## Examples

``` r
if (FALSE) { # \dontrun{
mnk_user_proj(6)
} # }
```
