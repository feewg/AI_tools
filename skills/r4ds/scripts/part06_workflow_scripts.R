# Chapter 6: Workflow: scripts and projects

library(tidyverse)

out <- tibble(metric = c("a", "b"), value = c(1, 2))
dir.create("output", showWarnings = FALSE)
write_csv(out, "output/summary.csv")
