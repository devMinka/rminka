# Search Minka Users by Login Name

Retrieves users whose login name contains a given string from the Minka
API.

## Usage

``` r
mnk_user_byname(query)
```

## Arguments

- query:

  A single character string contained in the user login name.

## Value

A tibble with one row per matching user. If no matches are found, it
returns an empty tibble with the same column structure. Columns are:

- id:

  User identifier, integer.

- login:

  Username, character.

- name:

  Full name, character.

- observations_count:

  Number of observations, integer.

- created_at:

  Account creation timestamp, POSIXct.

## Details

Queries the `/v1/users/autocomplete` endpoint. This function is mainly
used to obtain the user identifier for other functions.

## Examples

``` r
if (FALSE) { # \dontrun{
# Search for users whose login contains "xavier"
mnk_user_byname(query = "xavier")
} # }
```
