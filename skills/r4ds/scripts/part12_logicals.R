# Chapter 12: Logical vectors

library(tidyverse)

x <- tibble(v = c(1, 5, 9, NA))
x |>
  mutate(flag = v > 5, band = if_else(v > 5, "high", "low", missing = "missing"))
