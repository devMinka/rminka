# Get Metadata for a Minka Project

Retrieves detailed information for a specific Minka project using either
its unique `project_id` or its group identifier (`grpid`).

## Usage

``` r
mnk_proj_info(project_id = NULL, grpid = NULL)
```

## Arguments

- project_id:

  A single character string or number representing the unique Minka
  project identifier.

- grpid:

  A single character string or number representing the group identifier
  (slug) for the project.

## Value

A single-row `tibble` with project metadata. If the project is not
found, returns an empty tibble with the same column structure. Columns
are:

- id:

  Project identifier, integer.

- title:

  Project title, character.

- created_at:

  Creation timestamp, character in ISO 8601 format.

- subscrib_users:

  Total number of subscribed users, integer.

- place_id:

  Associated place identifier, integer or `NA`.

- slug:

  URL slug, character.

- description:

  Project description, character.

## Details

You must provide either `project_id` or `grpid`. If you do not know the
identifier, use
[`mnk_proj_byname`](https://devminka.github.io/rminka/reference/mnk_proj_byname.md)
to find it. A Minka `grpid` or slug is typically the project name
formatted with hyphens (e.g., 'biomarato-barcelona-2025'). You can find
it in the URL of the project's page.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get metadata for project ID 420
mnk_proj_info(project_id = 420)

# Get metadata using the project slug
mnk_proj_info(grpid = "biomarato-barcelona-2025")
} # }
```
