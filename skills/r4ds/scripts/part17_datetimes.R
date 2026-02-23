# Chapter 17: Dates and times

library(tidyverse)
library(lubridate)

ts <- ymd_hms(c("2025-01-01 08:10:00", "2025-01-01 21:30:00"), tz = "UTC")
tibble(ts, hour = hour(ts), wday = wday(ts, label = TRUE))
