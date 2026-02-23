# Chapter 10: Exploratory data analysis

library(tidyverse)

diamonds |>
  filter(carat < 3) |>
  ggplot(aes(carat)) +
  geom_histogram(binwidth = 0.05)
