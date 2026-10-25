# Get WoRMS Taxonomy

Downloads taxonomic information from the World Register of Marine
Species (WoRMS) for a scientific name and returns the first exact-name
match.

## Usage

``` r
get_wrm_tax(scientific_name)
```

## Arguments

- scientific_name:

  A single, non-empty character string containing a scientific name,
  such as `"Diplodus sargus"`.

## Value

A one-row tibble with taxonomic and habitat information. Returns `NULL`
invisibly if no taxon is found or the request or response cannot be
processed. The tibble contains these columns:

- valid_AphiaID:

  WoRMS AphiaID, integer.

- valid_name:

  Accepted scientific name, character.

- rank:

  Taxonomic rank, character.

- kingdom:

  Kingdom, character.

- phylum:

  Phylum, character.

- class:

  Class, character.

- order:

  Order, character.

- family:

  Family, character.

- genus:

  Genus, character.

- isMarine:

  Marine habitat flag, logical.

- isBrackish:

  Brackish-water habitat flag, logical.

- isFreshwater:

  Freshwater habitat flag, logical.

- isTerrestrial:

  Terrestrial habitat flag, logical.

- isExtinct:

  Extinct flag, logical.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get data for a species
get_wrm_tax("Diplodus sargus")

# Get data for a genus
get_wrm_tax("Diplodus")
} # }
```
