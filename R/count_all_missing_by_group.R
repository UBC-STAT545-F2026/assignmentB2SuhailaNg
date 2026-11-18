#' Count missing values for all columns by group
#'
#' @description
#' Given a data frame and a grouping column, this function creates
#' a new data frame with one row per level of the grouping column.
#' It counts the number of missing values in every column except
#' the grouping column.
#'
#' @details
#' This function uses dplyr::group_by() and dplyr::summarize()
#' to calculate the number of missing values within each group.
#'
#' @param data A data frame or tibble containing the data to be summarized.
#' @param group_col An unquoted column in data to group the observations by.
#' @param .groups Optional. Controls the grouping structure of the output.
#'   Accepted values are "drop_last", "drop", "keep", "rowwise", or NULL.
#'   Defaults to "drop". See dplyr::summarize() for more information.
#'
#' @return A tibble with one row per group. The grouping column is retained,
#'   and the remaining columns contain the number of missing values in
#'   each column for the corresponding group.
#'
#' @examples
#' count_all_missing_by_group(datasets::airquality, Month)
#'
#' datasets::airquality |>
#'   count_all_missing_by_group(Month)
#'
#' count_all_missing_by_group(datasets::airquality, Month, .groups = "keep")
#'
#' @export
count_all_missing_by_group <- function(data, group_col, .groups = "drop") {

  if (!is.null(.groups)) {
    if (!(.groups %in% c("drop_last", "drop", "keep", "rowwise"))) {
      stop(".groups needs to be one of NULL, 'drop_last', 'drop', 'keep', and 'rowwise'.")
    }
  }

  data |>
    dplyr::group_by({{ group_col }}) |>
    dplyr::summarize(
      dplyr::across(dplyr::everything(), ~ sum(is.na(.x))),
      .groups = .groups
    )
}
