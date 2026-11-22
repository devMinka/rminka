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
# \donttest{
# Search for users whose login contains "xavier"
mnk_user_byname(query = "xavier")
#> # A tibble: 6 × 5
#>      id login      name                   observations_count created_at         
#>   <int> <chr>      <chr>                               <int> <dttm>             
#> 1   155 xavier     NA                                     88 2022-07-15 11:51:35
#> 2  1178 xparellada Xavier Parellada                     1674 2023-10-31 09:07:52
#> 3   798 xavidp     Xavier de Pedro Puente                306 2023-07-06 16:43:21
#> 4  2408 xaviermas  NA                                     44 2024-05-04 17:49:55
#> 5 16275 xavierlln  Xavier Llurba                         184 2025-03-23 07:07:25
#> 6  1214 monsblaus  Xavier Llopis                         178 2023-11-14 13:53:24
# }
```
