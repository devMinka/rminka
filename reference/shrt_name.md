# Generate Short Name from Scientific Name

Creates a standardized abbreviation from a scientific name by taking the
first three letters of each word, converting to lowercase, and joining
with periods. Accepts names with one to three words.

## Usage

``` r
shrt_name(scientific_name)
```

## Arguments

- scientific_name:

  A character vector of scientific names. Each element must contain one
  to three words. Cannot contain `NA` or empty strings.

## Value

A character vector of the same length as `scientific_name`. Each element
contains the abbreviation formed by the first three lowercase letters of
each word, separated by periods. For example, "Diplodus sargus" returns
"dip.sar" and "Diplodus sargus sargus" returns "dip.sar.sar". Signals an
error if input is not character, is empty, contains `NA`, or has more
than three words.

## Examples

``` r
shrt_name("Diplodus sargus")
#> [1] "dip.sar"
shrt_name("Diplodus sargus sargus")
#> [1] "dip.sar.sar"
shrt_name(c("Diplodus cervinus", "Diplodus vulgaris", "Diplodus sargus"))
#> [1] "dip.cer" "dip.vul" "dip.sar"
```
