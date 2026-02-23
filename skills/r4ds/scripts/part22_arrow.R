# Chapter 22: Arrow

library(tidyverse)
library(arrow)

tmp_dir <- tempfile(); dir.create(tmp_dir)
tibble(year = c(2024, 2024, 2025), v = c(1, 2, 3)) |>
  write_dataset(tmp_dir, format = "parquet", partitioning = "year")

open_dataset(tmp_dir) |>
  filter(year == 2024) |>
  summarize(total = sum(v)) |>
  collect()
