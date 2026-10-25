# Get Information About a Specific Minka User

Retrieves public profile information for a user from the Minka API.

## Usage

``` r
mnk_user_info(id_user)
```

## Arguments

- id_user:

  A single non-empty character string or finite numeric value
  representing the user identifier.

## Value

A one-row tibble with user metadata. If the user is not found or a
network or HTTP request fails, the function returns a one-row tibble
with the same columns filled with `NA`. Columns are:

- id:

  User identifier, integer.

- login:

  Username, character.

- name:

  Full name, character.

- created_at:

  Account creation timestamp, POSIXct.

- observations_count:

  Number of observations, integer.

- identifications_count:

  Number of identifications, integer.

- species_count:

  Number of observed species, integer.

- activity_count:

  Activity score, integer.

- journal_posts_count:

  Number of journal posts, integer.

- orcid:

  ORCID identifier, character or \`NA\`.

- icon_url:

  URL of profile image, character.

- site_id:

  Site identifier, integer.

- roles:

  List-column containing the user's roles.

- spam:

  Spam flag, logical.

- suspended:

  Suspended flag, logical.

- universal_search_rank:

  Search rank, integer.

## Details

Queries the `/v1/users/{id}` endpoint. The `id_user` corresponds to the
identifier in profile URLs such as
<https://observe.minka-sdg.org/users/6>.

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve information for user ID 4
mnk_user_info(4)
} # }
```
