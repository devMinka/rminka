# Generate Short Name from Scientific Name

Creates an abbreviation from a scientific name by taking the first three
letters of each word, converting them to lowercase, and joining them
with periods. Each name must contain one to three words.

## Usage

``` r
shrt_name(scientific_name)
```

## Arguments

- scientific_name:

  A character vector of scientific names. Each element must contain one
  to three words. Missing and blank values are not allowed.

## Value

A character vector of the same length as \`scientific_name\`. Each
element contains the abbreviation formed by the first three lowercase
letters of each word, separated by periods. For example, "Diplodus
sargus" returns "dip.sar" and "Diplodus sargus sargus" returns
"dip.sar.sar". An error is signaled if the input is not a non-empty
character vector, contains missing or blank values, or has more than
three words per name.

## Examples

``` r
shrt_name("Diplodus sargus")
#> [1] "dip.sar"
shrt_name("Diplodus sargus sargus")
#> [1] "dip.sar.sar"
shrt_name(c("Diplodus cervinus", "Diplodus vulgaris", "Diplodus sargus"))
#> [1] "dip.cer" "dip.vul" "dip.sar"
```
