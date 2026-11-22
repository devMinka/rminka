# Get Project Users with Metadata

Retrieves the user identifiers associated with a Minka project and
returns each user's profile metadata in a tibble using
[`mnk_user_info()`](https://devminka.github.io/rminka/reference/mnk_user_info.md).
The result has sixteen columns. A project lookup that fails because of a
network or HTTP error returns a zero-row tibble. Network or HTTP errors
for individual user lookups produce rows containing `NA` values.

## Usage

``` r
mnk_proj_user(project_id = NULL)
```

## Arguments

- project_id:

  A single non-empty character string or finite numeric value giving the
  project identifier. Missing values and blank strings are not accepted.

## Value

A tibble with one row per project participant and the following sixteen
columns:

- id:

  Integer. User identifier.

- login:

  Character. Username.

- name:

  Character. Full name.

- created_at:

  POSIXct. Account creation time.

- observations_count:

  Integer. Number of observations.

- identifications_count:

  Integer. Number of identifications.

- species_count:

  Integer. Number of observed species.

- activity_count:

  Integer. Total activity count.

- journal_posts_count:

  Integer. Number of journal posts.

- orcid:

  Character. ORCID identifier.

- icon_url:

  Character. URL of profile icon.

- site_id:

  Integer. Site identifier.

- roles:

  List. User roles.

- spam:

  Logical. Spam flag.

- suspended:

  Logical. Suspension flag.

- universal_search_rank:

  Integer. Search rank.

## Details

The function queries the project endpoint, extracts its user
identifiers, and retrieves each user's metadata with
[`mnk_user_info()`](https://devminka.github.io/rminka/reference/mnk_user_info.md).

## See also

[`mnk_user_info`](https://devminka.github.io/rminka/reference/mnk_user_info.md),
[`mnk_proj_info`](https://devminka.github.io/rminka/reference/mnk_proj_info.md)

## Examples

``` r
# \donttest{
users <- mnk_proj_user(420)
dplyr::glimpse(users)
#> Rows: 15
#> Columns: 16
#> $ id                    <int> 4, 6, 11, 12, 13, 42, 51, 219, 817, 1659, 2890, …
#> $ login                 <chr> "xasalva", "ramonservitje", "jaume-piera", "soni…
#> $ name                  <chr> "xavi salvador costa", "", "Jaume Piera", NA, "K…
#> $ created_at            <dttm> 2021-04-16 10:44:11, 2022-04-16 15:47:14, 2022-…
#> $ observations_count    <int> 85319, 1277, 12711, 410, 600, 251, 18388, 32470,…
#> $ identifications_count <int> 477480, 75, 58470, 12, 2, 0, 56540, 5211, 2, 4, …
#> $ species_count         <int> 3770, 339, 1299, 123, 201, 113, 1412, 1554, 153,…
#> $ activity_count        <int> 562799, 1352, 71181, 422, 602, 251, 74928, 37681…
#> $ journal_posts_count   <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ orcid                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ icon_url              <chr> "/attachments/users/icons/4-medium.png?165010597…
#> $ site_id               <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
#> $ roles                 <list> ["admin", "curator"], [], ["curator"], [], [], […
#> $ spam                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
#> $ suspended             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE…
#> $ universal_search_rank <int> 85319, 1277, 12711, 410, 600, 251, 18388, 32470,…
# }
```
