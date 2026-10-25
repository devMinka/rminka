# Package index

## Project Queries

A set of complementary functions to find projects and their associated
observations.

- [`mnk_proj_byname()`](https://devminka.github.io/rminka/reference/mnk_proj_byname.md)
  : Search Minka Projects by Name
- [`mnk_proj_info()`](https://devminka.github.io/rminka/reference/mnk_proj_info.md)
  : Get Metadata for a Minka Project
- [`mnk_proj_user()`](https://devminka.github.io/rminka/reference/mnk_proj_user.md)
  : Get Project Users With Metadata
- [`mnk_proj_obs()`](https://devminka.github.io/rminka/reference/mnk_proj_obs.md)
  : Download Project Observations by Year

## User Queries

Functions to find users and their contributed observations.

- [`mnk_user_byname()`](https://devminka.github.io/rminka/reference/mnk_user_byname.md)
  : Search Minka Users by Login Name
- [`mnk_user_info()`](https://devminka.github.io/rminka/reference/mnk_user_info.md)
  : Get Information About a Specific Minka User
- [`mnk_user_proj()`](https://devminka.github.io/rminka/reference/mnk_user_proj.md)
  : Projects Subscribed by a Minka User
- [`mnk_user_obs()`](https://devminka.github.io/rminka/reference/mnk_user_obs.md)
  : Download User Observations by Year

## Place Queries

Functions to find places and retrieve their spatial data and their
associated observations.

- [`mnk_place_byname()`](https://devminka.github.io/rminka/reference/mnk_place_byname.md)
  : Search Minka Place by Name
- [`mnk_place_sf()`](https://devminka.github.io/rminka/reference/mnk_place_sf.md)
  : Get Minka Place as sf Object
- [`mnk_place_obs()`](https://devminka.github.io/rminka/reference/mnk_place_obs.md)
  : Download Place Observations by Year

## Observation Queries

A variety of functions to fetch observation data based on different
parameters.

- [`mnk_obs_id()`](https://devminka.github.io/rminka/reference/mnk_obs_id.md)
  : Get Minka Observation Details
- [`mnk_obs()`](https://devminka.github.io/rminka/reference/mnk_obs.md)
  : Download Minka Observations
- [`mnk_obs_byday()`](https://devminka.github.io/rminka/reference/mnk_obs_byday.md)
  : Download Minka Observations by Date Range

## Auxiliary functions

A set of functions with different utilities that complement Minka’s
observational data and help in processing them when used in other R
packages (`vegan`, `dismo`, `labdsv` or others).

- [`export_mnk_qgis()`](https://devminka.github.io/rminka/reference/export_mnk_qgis.md)
  : Export sf Minka Objects to a GeoPackage for QGIS
- [`mnk_obs_sf()`](https://devminka.github.io/rminka/reference/mnk_obs_sf.md)
  : Convert Minka Observations to sf
- [`get_wrm_tax()`](https://devminka.github.io/rminka/reference/get_wrm_tax.md)
  : Get WoRMS Taxonomy
- [`shrt_name()`](https://devminka.github.io/rminka/reference/shrt_name.md)
  : Generate Short Name from Scientific Name
