# 17Themes
# Chapter 20

# Example 1
base <- ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
  geom_jitter() + 
  geom_abline(colour = "grey50", size = 2)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
base

# Example 2
labelled <- base +
  labs(
    x = "City mileage/gallon",
    y = "Highway mileage/gallon",
    colour = "Cylinders",
    title = "Highway and city mileage are highly correlated"
  ) +
  scale_colour_brewer(type = "seq", palette = "Spectral")
labelled

# Example 3
styled <- labelled +
  theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(
      fill = "white", 
      linewidth = 4, 
      colour = "white"
    ),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", linewidth = 0.2),
    panel.grid.major = element_line(colour = "grey70", linewidth = 0.2),
    panel.grid.minor = element_blank()
  )
styled

# Example 4
df <- data.frame(x = 1:3, y = 1:3)
base <- ggplot(df, aes(x, y)) + geom_point()
base + theme_grey() + ggtitle("theme_grey()")
base + theme_bw() + ggtitle("theme_bw()")
base + theme_linedraw() + ggtitle("theme_linedraw()")

# Example 5
base + theme_classic() + ggtitle("theme_classic()")
base + theme_void() + ggtitle("theme_void()")

# Example 6
library(ggthemes)
base + theme_tufte() + ggtitle("theme_tufte()")
base + theme_solarized() + ggtitle("theme_solarized()")
base + theme_excel() + ggtitle("theme_excel()") # ;)

# Example 7
base_t <- base + labs(title = "This is a ggplot") + xlab(NULL) + ylab(NULL)
  base_t + theme(plot.title = element_text(size = 16))
  base_t + theme(plot.title = element_text(face = "bold", colour = "red"))
  base_t + theme(plot.title = element_text(hjust = 1))

# Example 8
# The margins here look asymmetric because there are also plot margins
  base_t + theme(plot.title = element_text(margin = margin()))
  base_t + theme(plot.title = element_text(margin = margin(t = 10, b = 10)))
  base_t + theme(axis.title.y = element_text(margin = margin(r = 10)))

# Example 9
base + theme(panel.grid.major = element_line(colour = "black"))
  base + theme(panel.grid.major = element_line(linewidth = 2))
  base + theme(panel.grid.major = element_line(linetype = "dotted"))

# Example 10
base + theme(plot.background = element_rect(fill = "grey80", colour = NA))
  base + theme(plot.background = element_rect(colour = "red", linewidth = 2))
  base + theme(panel.background = element_rect(fill = "linen"))

# Example 11
base
  last_plot() + theme(panel.grid.minor = element_blank())
  last_plot() + theme(panel.grid.major = element_blank())

# Example 12
last_plot() + theme(panel.background = element_blank())
  last_plot() + theme(
    axis.title.x = element_blank(), 
    axis.title.y = element_blank()
  )
  last_plot() + theme(axis.line = element_line(colour = "grey50"))

# Example 13
old_theme <- theme_update(
  plot.background = element_rect(fill = "lightblue3", colour = NA),
  panel.background = element_rect(fill = "lightblue", colour = NA),
  axis.text = element_text(colour = "linen"),
  axis.title = element_text(colour = "linen")
)
base
theme_set(old_theme)
base

# Example 14
base + theme(plot.background = element_rect(colour = "grey50", linewidth = 2))
base + theme(
  plot.background = element_rect(colour = "grey50", linewidth = 2),
  plot.margin = margin(2, 2, 2, 2)
)
base + theme(plot.background = element_rect(fill = "lightblue"))

# Example 15
df <- data.frame(x = 1:3, y = 1:3)
base <- ggplot(df, aes(x, y)) + geom_point()

# Accentuate the axes
base + theme(axis.line = element_line(colour = "grey50", linewidth = 1))
# Style both x and y axis labels
base + theme(axis.text = element_text(color = "blue", size = 12))
# Useful for long labels
base + theme(axis.text.x = element_text(angle = -90, vjust = 0.5))

# Example 16
df <- data.frame(
  x = c("label", "a long label", "an even longer label"), 
  y = 1:3
)
base <- ggplot(df, aes(x, y)) + geom_point()
base
base + 
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0)) + 
  xlab(NULL) + 
  ylab(NULL)

# Example 17
df <- data.frame(x = 1:4, y = 1:4, z = rep(c("a", "b"), each = 2))
base <- ggplot(df, aes(x, y, colour = z)) + geom_point()

base + theme(
  legend.background = element_rect(
    fill = "lemonchiffon", 
    colour = "grey50", 
    linewidth = 1
  )
)
base + theme(
  legend.key = element_rect(color = "grey50"),
  legend.key.width = unit(0.9, "cm"),
  legend.key.height = unit(0.75, "cm")
)
base + theme(
  legend.text = element_text(size = 15),
  legend.title = element_text(size = 15, face = "bold")
)

# Example 18
base <- ggplot(df, aes(x, y)) + geom_point()
# Modify background
base + theme(panel.background = element_rect(fill = "lightblue"))

# Tweak major grid lines
base + theme(
  panel.grid.major = element_line(color = "gray60", linewidth = 0.8)
)
# Just in one direction  
base + theme(
  panel.grid.major.x = element_line(color = "gray60", linewidth = 0.8)
)

# Example 19
base2 <- base + theme(plot.background = element_rect(colour = "grey50"))
# Wide screen
base2 + theme(aspect.ratio = 9 / 16)
# Long and skinny
base2 + theme(aspect.ratio = 2 / 1)
# Square
base2 + theme(aspect.ratio = 1)

# Example 20
df <- data.frame(x = 1:4, y = 1:4, z = c("a", "a", "b", "b"))
base_f <- ggplot(df, aes(x, y)) + geom_point() + facet_wrap(~z)

base_f
base_f + theme(panel.spacing = unit(0.5, "in"))
base_f + theme(
  strip.text = element_text(colour = "white"),
  strip.background = element_rect(
    fill = "grey20", 
    color = "grey80", 
    linewidth = 1
  )
)

# Example 21
pdf("output.pdf", width = 6, height = 6)
ggplot(mpg, aes(displ, cty)) + geom_point()
dev.off()

# Example 22
ggplot(mpg, aes(displ, cty)) + geom_point()
ggsave("output.pdf")

