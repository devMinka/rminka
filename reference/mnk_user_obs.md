# Download User Observations by Year

Downloads observations for a user for a specified year and, optionally,
month and day. This is a convenience wrapper around
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

  Numeric user identifier or character login name.

- year:

  Numeric year to query.

- month:

  Optional month to query, from 1 to 12. Defaults to `NULL` (all
  months).

- day:

  Optional day to query, from 1 to 31. Defaults to `NULL` (all days).

- quiet:

  Logical value. If `TRUE`, suppresses console messages.

- limit_download:

  Logical value. If `TRUE` (default), limits each query subdivision to
  10,000 records. If `FALSE`, attempts to download all matching records.

## Value

A tibble with the observation columns documented in
[`mnk_obs`](https://devminka.github.io/rminka/reference/mnk_obs.md). An
empty tibble is returned if no observations match.

## Examples

``` r
# \donttest{
# Download up to 10,000 observations for user 4 in 2024
mnk_user_obs(user_id = 4, year = 2024)
#> --- STARTING ANNUAL DOWNLOAD FOR THE YEAR 2024 ---
#> 
#> --- Evaluating month: January 2024 ---
#> The month of January has 1818 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: February 2024 ---
#> The month of February has 911 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: March 2024 ---
#> The month of March has 2139 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: April 2024 ---
#> The month of April has 1042 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: May 2024 ---
#> The month of May has 536 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: June 2024 ---
#> The month of June has 1045 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: July 2024 ---
#> The month of July has 1802 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- Evaluating month: August 2024 ---
#> The month of August has 1360 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> NOTE: Fetching only the first 707 of 1,360 available records due to limit.
#> Download limit reached. Stopping.
#> 
#> --- FINISHING... ---
#> Download complete! A total of 10,000 records were obtained.
#> # A tibble: 10,000 × 29
#>        id observed_on  year month  week   day  hour created_at        updated_at
#>     <int> <chr>       <int> <int> <int> <int> <int> <chr>             <chr>     
#>  1 222196 2024-01-12   2024     1     2    12     1 2024-02-06T08:07… 2024-12-1…
#>  2 220874 2024-01-24   2024     1     4    24    23 2024-01-31T19:11… 2024-01-3…
#>  3 220873 2024-01-24   2024     1     4    24    23 2024-01-31T19:11… 2024-01-3…
#>  4 220872 2024-01-24   2024     1     4    24    23 2024-01-31T19:11… 2024-02-0…
#>  5 220871 2024-01-24   2024     1     4    24    23 2024-01-31T19:11… 2024-01-3…
#>  6 220870 2024-01-24   2024     1     4    24    23 2024-01-31T19:11… 2024-01-3…
#>  7 220869 2024-01-24   2024     1     4    24    23 2024-01-31T19:10… 2024-01-3…
#>  8 220868 2024-01-24   2024     1     4    24    23 2024-01-31T19:10… 2024-01-3…
#>  9 220867 2024-01-24   2024     1     4    24    23 2024-01-31T19:10… 2024-01-3…
#> 10 220866 2024-01-24   2024     1     4    24    23 2024-01-31T19:10… 2024-01-3…
#> # ℹ 9,990 more rows
#> # ℹ 20 more variables: latitude <dbl>, longitude <dbl>,
#> #   positional_accuracy <int>, geoprivacy <chr>, obscured <lgl>, uri <chr>,
#> #   url_picture_icon <chr>, url_picture_med <chr>, url_picture_orig <chr>,
#> #   quality_grade <chr>, taxon_id <int>, taxon_name <chr>, taxon_rank <chr>,
#> #   taxon_min_ancestry <chr>, taxon_endemic <lgl>, taxon_threatened <lgl>,
#> #   taxon_introduced <lgl>, taxon_native <lgl>, user_id <int>, …

# Download observations for August 2024 without a record cap
mnk_user_obs(
  user_id = 4,
  year = 2024,
  month = 8,
  limit_download = FALSE
)
#> --- STARTING DOWNLOAD FOR MONTH: August 2024 ---
#> 
#> --- Evaluating month: August 2024 ---
#> The month of August has 1360 records.
#>  -> Total <= 10,000. Downloading month in one go...
#> 
#> --- FINISHING... ---
#> Download complete! A total of 1,360 records were obtained.
#> # A tibble: 1,360 × 29
#>        id observed_on  year month  week   day  hour created_at        updated_at
#>     <int> <chr>       <int> <int> <int> <int> <int> <chr>             <chr>     
#>  1 348388 2024-08-31   2024     8    35    31    13 2024-09-02T13:02… 2024-09-0…
#>  2 348387 2024-08-31   2024     8    35    31    13 2024-09-02T13:02… 2024-09-0…
#>  3 348386 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  4 348385 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  5 348384 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  6 348383 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  7 348382 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  8 348381 2024-08-31   2024     8    35    31    13 2024-09-02T13:01… 2024-09-0…
#>  9 348380 2024-08-31   2024     8    35    31    12 2024-09-02T13:01… 2024-09-0…
#> 10 348379 2024-08-31   2024     8    35    31    12 2024-09-02T13:01… 2024-09-0…
#> # ℹ 1,350 more rows
#> # ℹ 20 more variables: latitude <dbl>, longitude <dbl>,
#> #   positional_accuracy <int>, geoprivacy <chr>, obscured <lgl>, uri <chr>,
#> #   url_picture_icon <chr>, url_picture_med <chr>, url_picture_orig <chr>,
#> #   quality_grade <chr>, taxon_id <int>, taxon_name <chr>, taxon_rank <chr>,
#> #   taxon_min_ancestry <chr>, taxon_endemic <lgl>, taxon_threatened <lgl>,
#> #   taxon_introduced <lgl>, taxon_native <lgl>, user_id <int>, …
# }
```
