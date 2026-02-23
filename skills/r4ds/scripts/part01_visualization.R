# Chapter 1: Data visualization

library(tidyverse)
library(palmerpenguins)

ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color = species), na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) +
  labs(x = "Flipper length (mm)", y = "Body mass (g)", color = "Species")
