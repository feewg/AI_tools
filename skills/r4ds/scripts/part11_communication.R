# Chapter 11: Communication

library(tidyverse)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Highway MPG vs displacement", x = "Engine displacement", y = "Highway MPG") +
  theme_minimal()
