# Get Project Users With Metadata

Queries the Minka API for a given project identifier, extracts the
associated user identifiers, and returns a tibble with full metadata for
each participant by calling
[`mnk_user_info()`](https://devminka.github.io/rminka/reference/mnk_user_info.md).
The function is type-stable: it always returns a tibble with the same
sixteen columns, even when the project does not exist or the API request
fails. Individual user lookup failures produce a row of `NA` values and
do not interrupt the overall query.

## Usage

``` r
mnk_proj_user(project_id = NULL)
```

## Arguments

- project_id:

  A single atomic character or numeric value giving the project
  identifier. Vectors of length greater than one are not accepted.

## Value

A tibble with one row per participant and sixteen columns:

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

The function performs a GET request to
`https://api.minka-sdg.org/v1/projects?id={project_id}`, extracts
`results[[1]]$user_ids`, and applies
[`purrr::map_dfr()`](https://purrr.tidyverse.org/reference/map_dfr.html)
over
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
