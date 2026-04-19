# Get WoRMS Taxonomy

Downloads taxonomic information from the World Register of Marine
Species (WoRMS) for a given scientific name. Returns the first exact
match found.

## Usage

``` r
get_wrm_tax(scientific_name)
```

## Arguments

- scientific_name:

  a character string with the scientific name to search for, for example
  "Diplodus sargus" or "Diplodus".

## Value

a one-row tibble with taxonomic and habitat flags. Returns `NULL`
invisibly if the taxon is not found or the request fails. The tibble
contains the following columns:

- valid_AphiaID:

  WoRMS AphiaID, integer.

- valid_name:

  accepted scientific name, character.

- rank:

  taxonomic rank, character.

- kingdom:

  kingdom, character.

- phylum:

  phylum, character.

- class:

  class, character.

- order:

  order, character.

- family:

  family, character.

- genus:

  genus, character.

- isMarine:

  marine flag, logical.

- isBrackish:

  brackish flag, logical.

- isFreshwater:

  freshwater flag, logical.

- isTerrestrial:

  terrestrial flag, logical.

- isExtinct:

  extinct flag, logical.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get data for a species
get_wrm_tax("Diplodus sargus")

# Get data for a genus
get_wrm_tax("Diplodus")
} # }
```
