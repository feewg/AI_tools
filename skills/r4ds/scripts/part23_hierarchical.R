# Chapter 23: Hierarchical data

library(tidyverse)

x <- tibble(id = 1:2, meta = list(list(city = "SH", level = 1), list(city = "BJ", level = 2)))
x |>
  unnest_wider(meta)
