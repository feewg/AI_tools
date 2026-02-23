# Chapter 5: Data tidying

library(tidyverse)

sales_wide <- tibble(id = c(1, 2), q1 = c(120, 150), q2 = c(130, 165))
sales_long <- sales_wide |>
  pivot_longer(q1:q2, names_to = "quarter", values_to = "revenue")

sales_long |>
  pivot_wider(names_from = quarter, values_from = revenue)
