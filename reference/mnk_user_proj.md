# Projects Subscribed by a Minka User

Retrieves projects to which a user is explicitly subscribed from Minka
and returns project metadata as a tibble.

## Usage

``` r
mnk_user_proj(id_user)
```

## Arguments

- id_user:

  A single finite numeric value identifying the user.

## Value

A tibble with one row per subscribed project. If no subscriptions are
found or a network or HTTP request fails, the function returns an empty
tibble with the columns listed below.

- id:

  Project identifier, integer.

- title:

  Project title, character.

- description:

  Project description, character.

- slug:

  URL slug, character.

- icon:

  Icon URL, character.

- place_id:

  Associated place identifier, integer or \`NA\`.

- created_at:

  Creation date, character in ISO 8601 format.

## Examples

``` r
# \donttest{
mnk_user_proj(4)
#> # A tibble: 10 × 7
#>       id title                       description slug  icon  place_id created_at
#>    <int> <chr>                       <chr>       <chr> <chr>    <int> <chr>     
#>  1   522 (Principal) Biodiverciutat… "Aquest pr… prin… http…       NA 2025-10-2…
#>  2   144 ANERIS - Biodiversitat D.C… "El projec… aner… http…      337 2023-06-0…
#>  3   312 ANERIS - Biodiversitat Llo… "El projec… aner… http…      416 2024-06-1…
#>  4   146 ANERIS - Biodiversitat UNI… "El projec… aner… http…      338 2023-06-0…
#>  5   177 ANERIS - Biodiversitat al … "El projec… aner… http…      361 2023-08-2…
#>  6   183 ANERIS - SASBA (Seguiment … "Descobrim… aner… http…      251 2023-10-0…
#>  7    44 Anthozoos del Barcelonés    "Estudi de… anth… http…       NA 2022-09-2…
#>  8   444 Arees verdes marines - Emp… "Aquest pr… aree… http…      712 2025-05-2…
#>  9   448 BIODIVERSIDAD MARINA BADIA… "Biodivers… biod… http…      714 2025-05-2…
#> 10   181 BM-PortSalvi                "El projec… bm-p… http…      367 2023-09-1…
# }
```
