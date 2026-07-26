
## ===================================================================
# HELPER FUNCTIONS (NOT EXPORTED)
# Defined in dependency order, from least to most dependent.
# ===================================================================

# Helper 1
#' @noRd
update_get_total_results <- function(p) {
  resp <- httr::GET("https://api.minka-sdg.org/v1/observations",
                    query = c(p, list(per_page = 1)))
  if (httr::http_error(resp)) return(0)
  total <- httr::content(resp, as = "parsed")$total_results
  rlang::`%||%`(total, 0)
}

# Helper 2
#' @noRd
update_process_results <- function(all_results) {
  if (length(all_results) == 0) return(tibble::tibble())

  processed <- purrr::map(all_results, ~tibble::tibble(
    id = rlang::`%||%`(.x$id, NA_integer_),
    observed_on = rlang::`%||%`(.x$observed_on, NA),
    year = rlang::`%||%`(.x$observed_on_details$year, NA_integer_),
    month = rlang::`%||%`(.x$observed_on_details$month, NA_integer_),
    week = rlang::`%||%`(.x$observed_on_details$week, NA_integer_),
    day = rlang::`%||%`(.x$observed_on_details$day, NA_integer_),
    hour = rlang::`%||%`(.x$observed_on_details$hour, NA_integer_),
    created_at = rlang::`%||%`(.x$created_at, NA),
    updated_at = rlang::`%||%`(.x$updated_at, NA),
    latitude = rlang::`%||%`(.x$geojson$coordinates[[2]], NA_real_),
    longitude = rlang::`%||%`(.x$geojson$coordinates[[1]], NA_real_),
    positional_accuracy = rlang::`%||%`(.x$positional_accuracy, NA_integer_),
    geoprivacy = rlang::`%||%`(.x$taxon_geoprivacy, NA),
    obscured = rlang::`%||%`(.x$obscured, NA),
    uri = rlang::`%||%`(.x$uri, NA),
    photo_url_square = rlang::`%||%`(.x$taxon$default_photo$square_url, NA_character_),
    photo_url_medium = rlang::`%||%`(.x$taxon$default_photo$medium_url, NA_character_),
    quality_grade = rlang::`%||%`(.x$quality_grade, NA),
    species_guess = rlang::`%||%`(.x$species_guess, NA),
    taxon_id = rlang::`%||%`(.x$taxon$id, NA_integer_),
    taxon_name = rlang::`%||%`(.x$taxon$name, NA),
    taxon_rank = rlang::`%||%`(.x$taxon$rank, NA),
    taxon_min_ancestry = rlang::`%||%`(.x$taxon$min_species_ancestry, NA),
    taxon_endemic = rlang::`%||%`(.x$taxon$endemic, NA),
    taxon_threatened = rlang::`%||%`(.x$taxon$threatened, NA),
    taxon_introduced = rlang::`%||%`(.x$taxon$introduced, NA),
    taxon_native = rlang::`%||%`(.x$taxon$native, NA),
    user_id = rlang::`%||%`(.x$user$id, NA_integer_),
    user_login = rlang::`%||%`(.x$user$login, NA)
  ))
  dplyr::bind_rows(processed)
}

# Helper 3
#' @noRd
update_download_chunk <- function(params, total_res, quiet, limit_download) {
  API_MAX_PER_PAGE <- 200
  download_limit <- if (limit_download) 10000 else Inf
  max_to_fetch <- min(total_res, download_limit)

  all_results <- list()
  if (max_to_fetch > 0) {
    pages <- 1:ceiling(max_to_fetch / API_MAX_PER_PAGE)
    for (i in pages) {
      page_params <- c(params, list(per_page = API_MAX_PER_PAGE, page = i))
      data_response <- httr::GET("https://api.minka-sdg.org/v1/observations",
                                 query = page_params)
      if (httr::http_error(data_response)) next
      data_content <- httr::content(data_response, as = "parsed")$results
      if (!is.null(data_content) && length(data_content) > 0) {
        all_results <- c(all_results, data_content)
      } else {
        break
      }
    }
  }
  update_process_results(all_results)
}

## ===================================================================

# MAIN FUNCTION

## ===================================================================
##' Download Minka Observations by Last Update Date
#'
#' @description Downloads observation data from the Minka API filtering by
#'   last update date. It automatically subdivides requests by month and day
#'   to avoid the 10,000 record limit per request imposed by the Minka API.
#'
#' @details This is a wrapper around \code{\link{mnk_obs}} that uses the
#'   \code{updated_at} filter. If the total number of records since
#'   \code{day_update} exceeds 10,000, the function splits the query by
#'   year/month, and if necessary, by day.
#'
#' @param day_update Date from which to retrieve updated observations.
#'   Character string in \code{"yyyy-mm-dd"} format or a \code{Date} object.
#'   Observations with \code{updated_at >= day_update} will be returned.
#' @param ... Additional arguments passed to \code{\link{mnk_obs}}. See
#'   details for available filters like \code{taxon_name}, \code{bounds},
#'   \code{project_id}, etc.
#' @param quiet Logical. If \code{TRUE}, suppresses console progress messages.
#'   Default \code{FALSE}.
#' @param limit_download Logical. If \code{TRUE} (default), each subdivided
#'   request is capped at 10,000 records as per API limitation.
#'
#' @inheritDotParams mnk_obs -year -month -day -quiet -limit_download
#'
#' @return A \code{tibble} with one row per observation and the same columns
#'   documented in \code{\link{mnk_obs}}. Returns an empty tibble if no data
#'   is found.
#' @seealso \code{\link{mnk_obs}}, \code{\link{mnk_obs_byday}}
#' @family minka download functions
#' @export
#'
#' @examples
#' \dontrun{
#' # Download all observations updated since a date
#' obs <- mnk_obs_update("2026-03-31", taxon_name = "Diplodus vulgaris")
#'
#' # Use with bounds (must be EPSG:4326)
#' barcelona <- c(41.5, 2.3, 41.2, 2.0)
#' obs_bc <- mnk_obs_update("2024-01-01",
#'   bounds = barcelona, quiet = TRUE)
#' }
mnk_obs_update <- function(day_update,..., quiet = FALSE, limit_download = TRUE) {
  date <- as.Date(day_update, format = "%Y-%m-%d")

  if (is.na(date) ) {
    stop("Date  must be in 'yyyy-mm-dd' format.")
  }

  all_params <- list(...)
  base_params <- purrr::compact(all_params)

  if (!is.null(base_params$bounds)) {
    bounds <- base_params$bounds
    if (inherits(bounds, c("sf", "sfc"))) {

      crs <- sf::st_crs(bounds)
      if (is.na(crs) || crs$epsg!= 4326) {
        stop("bounds must have CRS EPSG:4326 (WGS84). ",
             "Use sf::st_transform(bounds, 4326) first.", call. = FALSE)
      }
      bbox <- sf::st_bbox(bounds)
      processed_bounds <- list(
        swlng = as.numeric(bbox[["xmin"]]),
        swlat = as.numeric(bbox[["ymin"]]),
        nelng = as.numeric(bbox[["xmax"]]),
        nelat = as.numeric(bbox[["ymax"]])
      )
    } else {
      if (!is.numeric(bounds) || length(bounds)!= 4) {
        stop("'bounds' must be a numeric vector of length 4: ",
             "c(nelat, nelng, swlat, swlng)")
      }
      processed_bounds <- list(
        nelat = bounds[1], nelng = bounds[2],
        swlat = bounds[3], swlng = bounds[4]
      )
    }
    base_params$bounds <- NULL
    base_params <- c(base_params, processed_bounds)
  }

  if (!is.null(base_params$annotation)) {
    annotation <- base_params$annotation
    if (!is.numeric(annotation) || length(annotation)!= 2) {
      stop("The 'annotation' parameter must be a numeric vector of length 2: ",
           "c(term_id, term_value_id)")
    }
    processed_annotation <- list(
      term_id = annotation[1],
      term_value_id = annotation[2]
    )
    base_params$annotation <- NULL
    base_params <- c(base_params, processed_annotation)
  }

  total_results <- update_get_total_results(c(base_params, list(updated_at = date)))

  if (!quiet) {
    if (total_results > 0) {
      message("Found a total of ", format(total_results, big.mark = ","),
              " records since ", date, ".")
    } else {
      message("No records found for the specified criteria.")
    }
  }
  if (total_results == 0) return(tibble::tibble())

  if (total_results <= 10000) {
    params <- c(base_params, list( updated_at = date))
    return(update_download_chunk(params, total_results, quiet, limit_download))
  }

  if (!quiet) message(" -> Total > 10,000. Subdividing request...")
  all_results_list <- list()

  years_in_range <- unique(format(seq.Date( date, lubridate::today(), by = "day"), "%Y"))

  for (year_val in years_in_range) {
    year_start_date <- max(date, as.Date(paste0(year_val, "-01-01")))
    year_end_date <- min(lubridate::today(), as.Date(paste0(year_val, "-12-31")))
    months_in_range <- unique(format(seq.Date(year_start_date,
                                              year_end_date, by = "day"), "%Y-%m"))

    for (month_str in months_in_range) {
      m_date <- as.Date(paste0(month_str, "-01"))
      m <- as.numeric(format(m_date, "%m"))
      if (!quiet) message("\n--- Processing month: ", month.name[m],
                          " ", year_val, " ---")

      start_day <- as.numeric(format(max(year_start_date, m_date), "%d"))
      end_day <- as.numeric(format(min(year_end_date,
                                       as.Date(paste0(month_str, "-", lubridate::days_in_month(m_date)))), "%d"))
      is_full_month <- start_day == 1 && end_day == lubridate::days_in_month(m_date)

      if (is_full_month) {
        monthly_total <- update_get_total_results(
          c(base_params, list(year = year_val, month = m))
        )
        if (!quiet && monthly_total > 0) {
          message(" -> Month has ", format(monthly_total, big.mark = ","),
                  " records.")
        }

        if (monthly_total > 0 && monthly_total <= 10000) {
          if (!quiet) message(" -> Downloading month in one go...")
          params <- c(base_params, list(year = year_val, month = m))
          all_results_list[[length(all_results_list) + 1]] <-
            update_download_chunk(params, monthly_total, TRUE, limit_download)
        } else if (monthly_total > 10000) {
          if (!quiet) message(" -> Month > 10,000. Downloading day by day...")
          for (d in start_day:end_day) {
            params <- c(base_params, list(year = year_val, month = m, day = d))
            day_total <- update_get_total_results(params)
            if (day_total > 0) {
              if (!quiet) message(" - Day: ", d, " has ", day_total, " records.")
              all_results_list[[length(all_results_list) + 1]] <-
                update_download_chunk(params, day_total, TRUE, limit_download)
            }
          }
        }
      } else {
        for (d in start_day:end_day) {
          params <- c(base_params, list(year = year_val, month = m, day = d))
          day_total <- update_get_total_results(params)
          if (day_total > 0) {
            if (!quiet) message(" - Day: ", d, " has ", day_total, " records.")
            all_results_list[[length(all_results_list) + 1]] <-
              update_download_chunk(params, day_total, TRUE, limit_download)
          }
        }
      }
    }
  }

  final_data <- dplyr::bind_rows(all_results_list)
  if (nrow(final_data) > 0) {
    final_data <- final_data[!duplicated(final_data$id), ]
  }

  if (!quiet) {
    message("\nOverall process complete! A total of ",
            format(nrow(final_data), big.mark = ","),
            " unique records were obtained.")
  }
  return(final_data)
}
