library(testthat)
library(mockery)

test_that("mnk_place_obs calls mnk_obs with the correct basic parameters", {
  m <- mockery::mock()
  mockery::stub(where = mnk_place_obs, what = "mnk_obs", how = m)

  mnk_place_obs(place_id = "barcelona", year = 2024)

  mockery::expect_called(m, 1)

  mockery::expect_args(m, 1,
                       place_id = "barcelona",
                       year = 2024,
                       month = NULL,
                       day = NULL,
                       quiet = FALSE,
                       limit_download = TRUE
  )
})

test_that("mnk_place_obs passes all optional parameters correctly", {
  m <- mockery::mock()
  mockery::stub(where = mnk_place_obs, what = "mnk_obs", how = m)

  mnk_place_obs(
    place_id = 999,
    year = 2025,
    month = 8,
    day = 15,
    quiet = TRUE,
    limit_download = FALSE
  )

  mockery::expect_called(m, 1)

  mockery::expect_args(m, 1,
                       place_id = 999,
                       year = 2025,
                       month = 8,
                       day = 15,
                       quiet = TRUE,
                       limit_download = FALSE
  )
})

test_that("mnk_place_obs exposes URL_image while preserving photo columns", {
  expected <- tibble::tibble(
    url_picture_icon = "https://example.org/square.jpg",
    url_picture_med = "https://example.org/medium.jpg",
    url_picture_orig = "https://example.org/original.jpg"
  )
  mockery::stub(
    where = mnk_place_obs,
    what = "mnk_obs",
    how = mockery::mock(expected)
  )

  result <- mnk_place_obs(place_id = 123, year = 2025)

  expect_equal(result$URL_image, expected$url_picture_med)
  expect_equal(result$url_picture_icon, expected$url_picture_icon)
  expect_equal(result$url_picture_med, expected$url_picture_med)
  expect_equal(result$url_picture_orig, expected$url_picture_orig)
})

test_that("mnk_place_obs requires place_id and year", {
  expect_error(
    mnk_place_obs(year = 2024),
    "argument \"place_id\" is missing, with no default"
  )

  expect_error(
    mnk_place_obs(place_id = 123),
    "argument \"year\" is missing, with no default"
  )
})
