# Chapter 18: Missing values

library(tidyverse)

df <- tibble(a = c(1, NA, 3), b = c(NA, 2, 3))
df |>
  mutate(miss_a = is.na(a), a_filled = coalesce(a, b))
