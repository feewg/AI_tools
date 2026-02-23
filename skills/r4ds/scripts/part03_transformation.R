# Chapter 3: Data transformation

library(tidyverse)
library(nycflights13)

flights |>
  filter(!is.na(arr_delay)) |>
  group_by(carrier) |>
  summarize(avg_arr_delay = mean(arr_delay), .groups = "drop") |>
  arrange(desc(avg_arr_delay))
