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
if (FALSE) { # \dontrun{
users <- mnk_proj_user(420)
dplyr::glimpse(users)
} # }
```
