# Chapter 4: Workflow: code style

library(tidyverse)
library(nycflights13)

delay_summary <- flights |>
  filter(!is.na(arr_delay)) |>
  group_by(origin) |>
  summarize(avg_delay = mean(arr_delay), .groups = "drop")

delay_summary
