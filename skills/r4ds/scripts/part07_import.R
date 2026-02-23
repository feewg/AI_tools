# Chapter 7: Data import

library(tidyverse)

csv_text <- I("id,name,score\n1,A,88\n2,B,92")
df <- read_csv(csv_text, show_col_types = FALSE)
spec(df)
write_csv(df, tempfile(fileext = ".csv"))
