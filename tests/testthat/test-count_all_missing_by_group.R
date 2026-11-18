
testthat::test_that("counts missing values correctly by group", {

  data <- data.frame(
    group = c("A", "A", "B", "B", "B"),
    x = c(1, NA, NA, 4, 5),
    y = c(NA, 2, NA, NA, 5)
  )

  result <- count_all_missing_by_group(data, group)

  expected <- data.frame(
    group = c("A", "B"),
    x = c(1, 1),
    y = c(1, 2)
  )

  testthat::expect_equal(as.data.frame(result), expected)
})


testthat::test_that("drops grouping by default", {

  data <- data.frame(
    group = c("A", "A", "B", "B"),
    x = c(1, NA, 2, NA)
  )

  result <- count_all_missing_by_group(data, group)

  testthat::expect_identical(
    dplyr::group_vars(result),
    character()
  )
})


testthat::test_that("retains grouping when .groups is keep", {

  data <- data.frame(
    group = c("A", "A", "B", "B"),
    x = c(1, NA, 2, NA)
  )

  result <- count_all_missing_by_group(
    data,
    group,
    .groups = "keep"
  )

  testthat::expect_identical(
    dplyr::group_vars(result),
    "group"
  )
})


testthat::test_that("returns zero when there are no missing values", {

  data <- data.frame(
    group = c("A", "A", "B", "B"),
    x = c(1, 2, 3, 4),
    y = c(5, 6, 7, 8)
  )

  result <- count_all_missing_by_group(data, group)

  expected <- data.frame(
    group = c("A", "B"),
    x = c(0, 0),
    y = c(0, 0)
  )

  testthat::expect_equal(as.data.frame(result), expected)
})


testthat::test_that("returns an error for an invalid .groups value", {

  data <- data.frame(
    group = c("A", "B"),
    x = c(1, NA)
  )

  testthat::expect_error(
    count_all_missing_by_group(data, group, .groups = "invalid"),
    "needs to be one of"
  )
})
