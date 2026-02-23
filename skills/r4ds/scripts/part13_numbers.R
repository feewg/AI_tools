# Chapter 13: Numbers

library(tidyverse)

x <- c("$1,234", "59%", "USD 88")
vals <- parse_number(x)
tibble(raw = x, num = vals, bucket = cut(vals, breaks = c(0, 60, 200, 2000)))
