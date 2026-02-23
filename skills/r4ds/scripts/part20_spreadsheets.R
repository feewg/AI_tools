# Chapter 20: Spreadsheets

library(tidyverse)
library(readxl)
library(writexl)

demo <- tibble(id = 1:3, score = c(80, 90, 85))
tmp <- tempfile(fileext = ".xlsx")
write_xlsx(list(scores = demo), tmp)
read_excel(tmp, sheet = "scores")
