# Chapter 9: Layers

library(tidyverse)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class), alpha = 0.7) +
  facet_wrap(~drv)
