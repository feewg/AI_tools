# 9Arranging plots
# Chapter 10

# Example 1
p1 <- ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy))

p2 <- ggplot(mpg) + 
  geom_bar(aes(x = as.character(year), fill = drv), position = "dodge") + 
  labs(x = "year")

p3 <- ggplot(mpg) + 
  geom_density(aes(x = hwy, fill = drv), colour = NA) + 
  facet_grid(rows = vars(drv))

p4 <- ggplot(mpg) + 
  stat_summary(aes(x = drv, y = hwy, fill = drv), geom = "col", fun.data = mean_se) +
  stat_summary(aes(x = drv, y = hwy), geom = "errorbar", fun.data = mean_se, width = 0.5)

# Example 2
library(patchwork)

p1 + p2

# Example 3
layout <- "
AAB
C#B
CDD
"

p1 + p2 + p3 + p4 + plot_layout(design = layout)

# Example 4
p12 <- p1 + p2
p12[[2]] <- p12[[2]] + theme_light()
p12

# Example 5
p1 + p4 & scale_y_continuous(limits = c(0, 45))

# Example 6
p34 <- p3 + p4 + plot_annotation(
  title = "A closer look at the effect of drive train in cars",
  caption = "Source: mpg dataset in ggplot2"
)
p34

# Example 7
p123 <- p1 | (p2 / p3)
p123 + plot_annotation(tag_levels = "I") # Uppercase roman numerics

# Example 8
p123[[2]] <- p123[[2]] + plot_layout(tag_level = "new")
p123 + plot_annotation(tag_levels = c("I", "a"))

# Example 9
p24 <- p2 / p4 + plot_layout(guides = "collect")
p1 + inset_element(p24, left = 0.5, bottom = 0.05, right = 0.95, top = 0.9)

# Example 10
p12 <- p1 + inset_element(p2, left = 0.5, bottom = 0.5, right = 0.9, top = 0.95)
p12 & theme_bw()

