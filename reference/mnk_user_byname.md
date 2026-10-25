# Search Minka Users by Login Name

Retrieves users whose login name contains a given string from the Minka
API.

## Usage

``` r
mnk_user_byname(query)
```

## Arguments

- query:

  A single non-empty character string contained in a user login name.

## Value

A tibble with one row per matching user. If no users match, the response
has an unexpected format, or an HTTP error occurs, the function returns
an empty tibble with the columns listed below.

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
