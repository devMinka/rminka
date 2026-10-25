# Get a Minka Place as an sf Object

Retrieves a Minka place as an `sf` object using its `place_id`. The
source GeoJSON is in EPSG:4326 (WGS 84). By default, the output retains
this CRS, but an alternative CRS may be requested.

## Usage

``` r
mnk_place_sf(place_id, crs = 4326)
```

## Arguments

- place_id:

  A single finite integer identifier for a Minka place.

- crs:

  Coordinate reference system for the output geometry, supplied as an
  EPSG code or any value accepted by
  [`sf::st_crs()`](https://r-spatial.github.io/sf/reference/st_crs.html).
  Defaults to `4326`; `NULL` is treated as `4326`.

## Value

An `sf` object with one row per place and the following columns. Returns
`NULL` invisibly if the API returns an HTTP error, an empty body, or no
matching place:

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

  Centroid as a latitude,longitude string.

- geometry:

  POINT, POLYGON, or MULTIPOLYGON geometry in CRS 4326 unless
  transformed. Missing or unreadable geometry is an empty POINT.

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve place 253 in WGS 84
place <- mnk_place_sf(place_id = 253)

# Retrieve the same place reprojected to ETRS89 / UTM zone 31N
place_25831 <- mnk_place_sf(place_id = 253, crs = 25831)
} # }
```
