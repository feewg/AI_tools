# Chapter 21: Databases

library(DBI)
library(dbplyr)
library(dplyr)

con <- dbConnect(duckdb::duckdb())
copy_to(con, tibble(id = 1:5, v = c(3, 5, 2, 8, 7)), "t_demo", temporary = TRUE)
tbl(con, "t_demo") |>
  filter(v >= 5) |>
  summarize(avg_v = mean(v)) |>
  show_query()
