
test_that("update_get_total_results success", {
  testthat::local_mocked_bindings(
    GET = function(...) structure(list(), class="response"),
    http_error = function(...) FALSE,
    content = function(...) list(total_results = 5),
    .package = "httr"
  )
  expect_equal(rminka:::update_get_total_results(list()), 5)
})


test_that("update_process_results covers all fields", {
  expect_equal(nrow(rminka:::update_process_results(list())), 0)
  fake <- list(list(
    id=1, observed_on="2024-01-01",
    observed_on_details=list(year=2024, month=1, day=1, week=1, hour=1),
    created_at="2024-01-01", updated_at="2024-01-02",
    geojson=list(coordinates=list(2.0, 41.5)), positional_accuracy=10,
    taxon_geoprivacy="open", obscured=FALSE, uri="x",
    taxon=list(id=1, name="a", rank="species", min_species_ancestry="a", endemic=FALSE, threatened=FALSE, introduced=FALSE, native=TRUE,
               default_photo=list(square_url="s", medium_url="m")),
    quality_grade="research", species_guess="a",
    user=list(id=1, login="u")
  ))
  out <- rminka:::update_process_results(fake)
  expect_equal(out$id, 1)
})

test_that("cubre 12,70,75 http_error y break", {
  # 12
  testthat::local_mocked_bindings(
    GET = function(...) structure(list(), class="response"),
    http_error = function(...) TRUE,
    .package = "httr"
  )
  expect_equal(rminka:::update_get_total_results(list()), 0)

  # 70 next y 75 break
  testthat::local_mocked_bindings(
    GET = function(...) structure(list(), class="response"),
    http_error = function(r) FALSE,
    content = function(...) list(results = NULL),
    .package = "httr"
  )
  # fuerza el break
  expect_equal(nrow(rminka:::update_download_chunk(list(), 200, TRUE, TRUE)), 0)
})

test_that("cubre 147-165 bounds bueno + 174-179 annotation bueno + 195-196", {
  skip_if_not_installed("sf")
  # 147-153 sf bueno
  poly_ok <- sf::st_as_sfc("POLYGON((0 38, 2 38, 2 42, 0 42, 0 38))", crs=4326)
  testthat::local_mocked_bindings(
    update_get_total_results = function(...) 1L,
    update_download_chunk = function(...) tibble::tibble(id=1),
    .package="rminka"
  )
  expect_s3_class(mnk_obs_update("2024-01-01", bounds=poly_ok, quiet=TRUE), "tbl_df")

  # 159-165 numerico bueno
  expect_s3_class(mnk_obs_update("2024-01-01", bounds=c(42.2,2.2,38.2,0.6), quiet=TRUE), "tbl_df")

  # 174-179 annotation bueno
  expect_s3_class(mnk_obs_update("2024-01-01", annotation=c(12,34), quiet=TRUE), "tbl_df")

  # 195-196 camino <=10000
  testthat::local_mocked_bindings(
    update_get_total_results = function(...) 500L,
    update_download_chunk = function(...) tibble::tibble(id=1),
    .package="rminka"
  )
  expect_equal(nrow(mnk_obs_update("2024-05-20", quiet=TRUE)), 1)
})

test_that("cubre 235-245 mes >10k y 252 mensaje dia", {
  testthat::local_mocked_bindings(today=function(...) as.Date("2024-03-31"), .package="lubridate")
  testthat::local_mocked_bindings(
    update_get_total_results = function(p) {
      if(!is.null(p$updated_at)) return(20000L) # fuerza subdiv
      if(!is.null(p$month) && is.null(p$day)) return(15000L) # mes >10k
      1L
    },
    update_download_chunk = function(...) tibble::tibble(id=1),
    .package="rminka"
  )
  # quiet=FALSE para cubrir los message de 236,241,252
  expect_message(mnk_obs_update("2024-03-01", quiet=FALSE), "Downloading day by day")
})

test_that("update_download_chunk with real results", {
  testthat::local_mocked_bindings(
    GET = function(...) structure(list(), class="response"),
    http_error = function(...) FALSE,
    content = function(...) list(results = list(
      list(id=1, observed_on="2024-01-01",
           observed_on_details=list(year=2024, month=1, day=1),
           created_at="a", updated_at="b", geojson=list(coordinates=list(0,0)),
           taxon=list(default_photo=list(square_url="s", medium_url="m")), user=list(id=1, login="a"))
    )),
    .package="httr"
  )
  out <- rminka:::update_download_chunk(list(), 1, TRUE, TRUE)
  expect_equal(nrow(out), 1) # aqui se ejecuta la linea 73
})


test_that("validations", {
  expect_error(mnk_obs_update("no-fecha"), "must be in")
  expect_error(mnk_obs_update("2024-01-01", bounds=1:3), "numeric vector of length 4")
  expect_error(mnk_obs_update("2024-01-01", annotation=1), "length 2")
  skip_if_not_installed("sf")
  poly_bad <- sf::st_as_sfc("POLYGON((0 38, 2 38, 2 42, 0 42, 0 38))", crs=3857)
  expect_error(mnk_obs_update("2024-01-01", bounds=poly_bad), "EPSG:4326")
})

test_that("covers 189 no records + 231 full month <=10k + 248 parcial", {
  # 189
  testthat::local_mocked_bindings(update_get_total_results=function(...) 0L, .package="rminka")
  expect_message(mnk_obs_update("2024-01-01", quiet=FALSE), "No records found")


  testthat::local_mocked_bindings(today=function(...) as.Date("2024-03-31"), .package="lubridate")
  testthat::local_mocked_bindings(
    update_get_total_results=function(p) if(!is.null(p$updated_at)) 20000L else 5000L,
    update_download_chunk=function(...) tibble::tibble(id=1),
    .package="rminka"
  )
  expect_message(mnk_obs_update("2024-03-01", quiet=FALSE), "Downloading month in one go")


  testthat::local_mocked_bindings(today=function(...) as.Date("2024-03-15"), .package="lubridate")
  testthat::local_mocked_bindings(
    update_get_total_results=function(p) if(!is.null(p$updated_at)) 20000L else 1L,
    update_download_chunk=function(...) tibble::tibble(id=1),
    .package="rminka"
  )
  obs <- mnk_obs_update("2024-03-10", quiet=TRUE)
  expect_true(nrow(obs) >= 1)
})
