# Get Minka Place as sf Object

Retrieve a Minka place as a simple features (`sf`) object given its
`place_id`. The function queries the Minka API and returns the place
boundary geometry together with descriptive metadata. The source GeoJSON
is always in EPSG:4326 (WGS 84). By default the output retains this CRS,
but an alternative CRS may be requested.

## Usage

``` r
mnk_place_sf(place_id, crs = 4326)
```

## Arguments

- place_id:

  a single integer identifier for a Minka place. Each place has a unique
  identifier.

- crs:

  coordinate reference system for the output geometry, supplied as an
  EPSG code or any value accepted by
  [`sf::st_crs()`](https://r-spatial.github.io/sf/reference/st_crs.html).
  Defaults to `4326`.

## Value

An `sf` object with one row per place and the following columns. Returns
`NULL` invisibly if the request fails or the response is empty:

- place_id:

  Place identifier, integer.

- name:

  Place name, character.

- display_name:

  Full display name, character.

- slug:

  URL slug, character.

- uuid:

  Universally unique identifier, character.

- place_type:

  Type of place, character or `NA`.

- admin_level:

  Administrative level, integer or `NA`.

- bbox_area:

  Bounding box area, numeric.

- location:

  Centroid as "lat,lon" string, character.

- geometry:

  Simple feature geometry (POINT, POLYGON or MULTIPOLYGON), CRS 4326
  unless transformed.

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve place 253 in WGS 84
place <- mnk_place_sf(place_id = 253)

# Retrieve the same place reprojected to ETRS89 / UTM zone 31N
place_25831 <- mnk_place_sf(place_id = 253, crs = 25831)
} # }
```
