# Chapter 25: Functions

library(tidyverse)

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

tibble(x = c(1, 3, 5, 10)) |>
  mutate(x01 = rescale01(x))
