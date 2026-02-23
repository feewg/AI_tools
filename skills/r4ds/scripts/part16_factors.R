# Chapter 16: Factors

library(tidyverse)

x <- tibble(cat = c("A", "B", "A", "C", "C", "C", "D"))
ggplot(x, aes(fct_infreq(factor(cat)))) + geom_bar()
