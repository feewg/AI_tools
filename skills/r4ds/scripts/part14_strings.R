# Chapter 14: Strings

library(tidyverse)

names <- c("alice", "bob")
tibble(name = str_to_title(names), greet = str_glue("Hello, {name}!"), has_o = str_detect(name, "o"))
