# Download User Observations by Year

Downloads observations for a specific user, filtered by year and
optionally by month and day. This is a convenience wrapper for
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).

## Usage

``` r
mnk_user_obs(
  user_id,
  year,
  month = NULL,
  day = NULL,
  quiet = FALSE,
  limit_download = TRUE
)
```

## Arguments

- user_id:

  A user identifier, either numeric ID or character login.

- year:

  The year to query, as a single integer.

- month:

  Optional month to filter, integer from 1 to 12. Defaults to \`NULL\`.

- day:

  Optional day to filter, integer from 1 to 31. Defaults to \`NULL\`.

- quiet:

  Logical; if \`TRUE\`, suppresses console messages.

- limit_download:

  Logical; if \`TRUE\` (default), caps each query subdivision at 10,000
  records. If \`FALSE\`, attempts to retrieve all records.

## Value

A tibble with the observation columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md).
Returns an empty tibble if no observations match.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download the first 10,000 observations for user 4 in 2024
mnk_user_obs(user_id = 4, year = 2024)

# Download all observations for August 2024 without record cap
mnk_user_obs(user_id = 4, year = 2024, month = 8, limit_download = FALSE)
} # }
```
