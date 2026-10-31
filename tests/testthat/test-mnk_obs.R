test_that("mnk_obs stops if there are no parameters", {
  expect_error(mnk_obs(), "You must specify at least one search parameter")
})

test_that("mnk_obs validates logical parameters", {
  expect_error(mnk_obs(taxon_name = "test", quiet = "no"), "'quiet' must be TRUE or FALSE")
  expect_error(mnk_obs(taxon_name = "test", limit_download = "yes"), "'limit_download' must be TRUE or FALSE")
})

test_that("mnk_obs validates the 'quality' parameter", {
  expect_error(mnk_obs(quality = "malo"), "must be 'casual' or 'research'")
})

test_that("process_minka_results handles an empty list", {
  result <- rminka:::process_minka_results(list())
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

test_that("download_paginated_data handles an API response with 0 results", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    result <- rminka:::download_paginated_data(params = list(q = "cero_resultados_test"))
    expect_equal(result$count, 0)
    expect_s3_class(result$data, "tbl_df")
  })
})

test_that("download_paginated_data downloads one page of results", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    result <- rminka:::download_paginated_data(params = list(q = "una_pagina_test"))
    expect_equal(result$count, 1)
    expect_s3_class(result$data, "tbl_df")
    expect_equal(nrow(result$data), 1)
    expect_equal(result$data$id[1], 12345)
  })
})

test_that("download_paginated_data handles multiple pages of results", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    result <- rminka:::download_paginated_data(params = list(q = "multi_pagina_test"))
    expect_equal(result$count, 201)
    expect_s3_class(result$data, "tbl_df")
    expect_equal(nrow(result$data), 201)
    expect_equal(result$data$id[201], 99999)
  })
})

test_that("mnk_obs validates the format of the 'annotation' parameter", {
  expect_error(mnk_obs(annotation = c("a", "b")), "The 'annotation' parameter must be a numeric vector of length 2")
  expect_error(mnk_obs(annotation = c(1, 2, 3)), "The 'annotation' parameter must be a numeric vector of length 2")
})

test_that("mnk_obs validates the format of the 'bounds' parameter", {
  expect_error(mnk_obs(bounds = c(1, 2, 3)), "'bounds' must be a numeric vector of length 4")
  expect_error(mnk_obs(bounds = c("a", "b", "c", "d")), "'bounds' must be a numeric vector of length 4")
})

test_that("mnk_obs downloads data for a specific day", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    day_data <- mnk_obs(taxon_name = "test_taxon_dia", year = 2025, month = 8, day = 15)
    expect_s3_class(day_data, "tbl_df")
    expect_equal(nrow(day_data), 1)
    expect_equal(day_data$id[1], 815)
  })
})

test_that("mnk_obs downloads a full month (less than 10k results)", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    month_data <- mnk_obs(taxon_name = "test_taxon_mes", year = 2025, month = 9)
    expect_s3_class(month_data, "tbl_df")
    expect_equal(nrow(month_data), 2)
    expect_equal(month_data$id[2], 902)
  })
})

test_that("mnk_obs downloads a full year, iterating through months", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    annual_data <- mnk_obs(taxon_name = "test_taxon_anual", year = 2024, quiet = TRUE)
    expect_s3_class(annual_data, "tbl_df")
    expect_equal(nrow(annual_data), 3)
    expect_true(202 %in% annual_data$id)
  })
})

test_that("mnk_obs preserves partial date filters", {
  captured_params <- list()
  testthat::local_mocked_bindings(
    download_paginated_data = function(params, ..., numeric_limit) {
      captured_params[[length(captured_params) + 1]] <<- params
      list(data = tibble::tibble(id = 1), count = 1)
    },
    .package = "rminka"
  )

  mnk_obs(month = 9, quiet = TRUE)
  mnk_obs(day = 15, quiet = TRUE)
  mnk_obs(month = 9, day = 15, quiet = TRUE)
  mnk_obs(year = 2024, day = 15, quiet = TRUE)

  expect_equal(captured_params[[1]]$month, 9)
  expect_equal(captured_params[[2]]$day, 15)
  expect_equal(captured_params[[3]]$month, 9)
  expect_equal(captured_params[[3]]$day, 15)
  expect_equal(captured_params[[4]]$year, 2024)
  expect_equal(captured_params[[4]]$day, 15)
})

test_that("mnk_obs downloads data without a date filter", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    data_without_date_filter <- mnk_obs(project_id = 999, quiet = TRUE)
    expect_s3_class(data_without_date_filter, "tbl_df")
    expect_equal(nrow(data_without_date_filter), 1)
    expect_equal(data_without_date_filter$id[1], 99901)
  })
})

test_that("mnk_obs subdivides download by days if a month has >10k results", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    subdivided_data <- mnk_obs(taxon_name = "test_taxon_subdivision", year = 2024, month = 4, quiet = TRUE)
    expect_s3_class(subdivided_data, "tbl_df")
    expect_equal(nrow(subdivided_data), 1)
    expect_equal(subdivided_data$id[1], 40101)
  })
})

test_that("mnk_obs correctly validates all parameter types", {
  expect_error(mnk_obs(endemic = "no"), "The 'endemic' parameter must be TRUE or FALSE.")
  expect_error(mnk_obs(introduced = "yes"), "The 'introduced' parameter must be TRUE or FALSE.")
  expect_error(mnk_obs(threatened = 1), "The 'threatened' parameter must be TRUE or FALSE.")
  expect_error(mnk_obs(annotation = c(1, 2, 3)), "The 'annotation' parameter must be a numeric vector of length 2")
  expect_error(mnk_obs(annotation = c("a", "b")), "The 'annotation' parameter must be a numeric vector of length 2")
  expect_error(mnk_obs(bounds = c(1, 2, 3)), "'bounds' must be a numeric vector of length 4")
  expect_error(mnk_obs(bounds = c("a", "b", "c", "d")), "'bounds' must be a numeric vector of length 4")
})

test_that("download_paginated_data returns an empty tibble if the API fails", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    result <- rminka:::download_paginated_data(params = list(q = "test_api_error_500"), quiet = TRUE)
    expect_s3_class(result$data, "tbl_df")
    expect_equal(nrow(result$data), 0)
    expect_equal(result$count, 0)
  })
})

test_that("download_paginated_data shows message when exceeding the download limit", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    expect_message(rminka:::download_paginated_data(params = list(q = "test_limit_message"), numeric_limit = 50, quiet = FALSE),
                   "NOTE: Fetching only the first 50 of 101 available records")
  })
})

test_that("mnk_obs correctly handles a response with no results", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    no_results <- mnk_obs(query = "no_existe_nada_con_este_nombre", quiet = TRUE)
    expect_s3_class(no_results, "data.frame")
    expect_equal(nrow(no_results), 0)
  })
  expect_message(httptest::with_mock_api({ mnk_obs(query = "no_existe_nada_con_este_nombre", quiet = FALSE) }), "No data could be downloaded")
})

test_that("mnk_obs correctly processes multiple parameters at once", {
  captured_params <- NULL
  testthat::local_mocked_bindings(
    download_paginated_data = function(params, ..., numeric_limit) {
      captured_params <<- params
      list(data = tibble::tibble(id = 1), count = 1)
    },
    .package = "rminka"
  )

  result <- mnk_obs(
    query = "test query",
    taxon_id = 5,
    user_id = 10,
    project_id = 20,
    place_id = 15,
    geo = TRUE,
    endemic = TRUE,
    threatened = TRUE,
    introduced = FALSE,
    quality = "research",
    quiet = TRUE
  )

  expect_s3_class(result, "tbl_df")
  expect_equal(captured_params$q, "test query")
  expect_equal(captured_params$taxon_id, 5)
  expect_equal(captured_params$user_id, 10)
  expect_equal(captured_params$project_id, 20)
  expect_equal(captured_params$place_id, 15)
  expect_equal(captured_params$`has[]`, "geo")
  expect_equal(captured_params$endemic, "true")
  expect_equal(captured_params$threatened, "true")
  expect_equal(captured_params$introduced, "false")
  expect_equal(captured_params$quality_grade, "research")
})

test_that("mnk_obs passes numeric month and download limit to the API helper", {
  captured_params <- list()
  captured_limits <- list()
  testthat::local_mocked_bindings(
    download_paginated_data = function(params, ..., numeric_limit) {
      captured_params[[length(captured_params) + 1]] <<- params
      captured_limits[[length(captured_limits) + 1]] <<- numeric_limit
      list(data = tibble::tibble(id = 1), count = 1)
    },
    .package = "rminka"
  )

  mnk_obs(month = 9, quiet = TRUE)
  mnk_obs(month = 9, limit_download = FALSE, quiet = TRUE)

  expect_equal(captured_params[[1]]$month, 9)
  expect_equal(captured_params[[2]]$month, 9)
  expect_equal(captured_limits, list(10000, Inf))
})

test_that("mnk_obs processes bounds and annotation correctly", {
  captured_params <- NULL
  testthat::local_mocked_bindings(
    download_paginated_data = function(params, ..., numeric_limit) {
      captured_params <<- params
      list(data = tibble::tibble(id = 1), count = 1)
    },
    .package = "rminka"
  )

  barcelona_bounds <- c(41.4, 2.2, 41.3, 2.1)
  life_stage_annotation <- c(1, 2)
  result <- mnk_obs(month = 9, bounds = barcelona_bounds,
                    annotation = life_stage_annotation, quiet = TRUE)

  expect_s3_class(result, "tbl_df")
  expect_equal(captured_params$month, 9)
  expect_equal(captured_params$nelat, 41.4)
  expect_equal(captured_params$nelng, 2.2)
  expect_equal(captured_params$swlat, 41.3)
  expect_equal(captured_params$swlng, 2.1)
  expect_equal(captured_params$term_id, 1)
  expect_equal(captured_params$term_value_id, 2)
})

test_that("mnk_obs handles a 'ping' call failure", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    expect_message(mnk_obs(project_id = "non-existent-project", quiet = FALSE), "No data could be downloaded for the specified criteria.")
    results <- mnk_obs(project_id = "non-existent-project", quiet = TRUE)
    expect_s3_class(results, "data.frame")
    expect_equal(nrow(results), 0)
  })
})

test_that("mnk_obs works with sf objects in 'bounds'", {
  skip_if_not_installed("sf")
  skip_if_not_installed("httptest")
  point <- sf::st_point(c(2.15, 41.35))
  sf_obj <- sf::st_as_sf(data.frame(geom = sf::st_sfc(point, crs = 4326)))
  httptest::with_mock_api({
    obs_data <- mnk_obs(bounds = sf_obj, quiet = TRUE)
    expect_equal(nrow(obs_data), 1)
  })
})

test_that("mnk_obs handles a failure in an intermediate download page", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    results <- mnk_obs(project_id = "test-fail", quiet = TRUE)
    expect_equal(nrow(results), 200)
  })
})

test_that("mnk_obs returns an empty tibble when the initial PING query fails", {
  skip_if_not_installed("httptest")
  httptest::with_mock_api({
    results <- mnk_obs(project_id = "test-ping-fail", quiet = FALSE)
    expect_s3_class(results, "tbl_df")
    expect_equal(nrow(results), 0)
  })
})

test_that("mnk_obs handles a monthly PING failure", {
  testthat::local_mocked_bindings(
    GET = function(...) structure(list(), class = "response"),
    http_error = function(...) TRUE,
    status_code = function(...) 500L,
    .package = "httr"
  )

  results <- mnk_obs(project_id = "monthly-ping-failure", year = 2025,
                     month = 10, quiet = TRUE)
  expect_s3_class(results, "tbl_df")
  expect_equal(nrow(results), 0)
})
