# Chapter 15: Regular expressions

library(tidyverse)

txt <- c("id: A-102", "id: B-204", "none")
tibble(txt, has_id = str_detect(txt, "[A-Z]-\\d{3}"), id = str_extract(txt, "[A-Z]-\\d{3}"))
