
<!-- README.md is generated from README.Rmd. Please edit this file. -->

# assignmentB2SuhailaNg

## Overview

The goal of assignmentB2SuhailaNg is to provide a function for counting
missing values (NAs) across all columns of a data frame, grouped by a
specified column.

The `count_all_missing_by_group()` function returns a tibble containing
one row per group and the number of missing values in each remaining
column. It also allows users to control whether the resulting data frame
retains its grouping structure.

## Installation

You can install the package from GitHub using:

``` r
# install.packages("devtools")
devtools::install_github(
  "UBC-STAT545-F2026/assignmentB2SuhailaNg",
  ref = "0.1.1"
)
```

## Usage

The following example demonstrates how to use
`count_all_missing_by_group()` with the built-in `airquality` dataset.

First, load the package:

``` r
library(assignmentB2SuhailaNg)
```

Count the number of missing values in each column, grouped by Month:

``` r
count_all_missing_by_group(datasets::airquality, Month)
#> # A tibble: 5 × 6
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```

The function can also be used with the native R pipe operator:

``` r
datasets::airquality |>
  count_all_missing_by_group(Month)
#> # A tibble: 5 × 6
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```

By default, the output is ungrouped. To retain grouping by the specified
column, use the optional `.groups` argument:

``` r
count_all_missing_by_group(
  datasets::airquality,
  Month,
  .groups = "keep"
)
#> # A tibble: 5 × 6
#> # Groups:   Month [5]
#>   Month Ozone Solar.R  Wind  Temp   Day
#>   <int> <int>   <int> <int> <int> <int>
#> 1     5     5       4     0     0     0
#> 2     6    21       0     0     0     0
#> 3     7     5       0     0     0     0
#> 4     8     5       3     0     0     0
#> 5     9     1       0     0     0     0
```

The `.groups` argument also accepts `"drop_last"`, `"drop"`,
`"rowwise"`, and `NULL`.
