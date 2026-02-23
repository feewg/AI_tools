# Chapter 26: Iteration

library(tidyverse)

df <- tibble(a = 1:3, b = c(2, 4, 6), c = c(3, 6, 9))
df |>
  summarize(across(everything(), mean))
