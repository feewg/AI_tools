# Chapter 19: Joins

library(tidyverse)

orders <- tibble(id = c(1, 2, 3), amount = c(99, 129, 88))
users  <- tibble(id = c(1, 3), tier = c("gold", "silver"))
orders |>
  left_join(users, by = join_by(id))
