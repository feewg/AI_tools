# 12Other aesthetics
# Chapter 14

# Example 1
base <- ggplot(mpg, aes(displ, hwy, size = cyl)) +
  geom_point()

base
base + scale_size(range = c(1, 2))

# Example 2
base <- ggplot(planets, aes(1, name, size = radius)) +
  geom_point() +
  scale_x_continuous(breaks = NULL) +
  labs(x = NULL, y = NULL, size = NULL)

base + ggtitle("not to scale")
base +
  scale_radius(limits = c(0, NA), range = c(0, 10)) +
  ggtitle("to scale")

# Example 3
base <- ggplot(mpg, aes(displ, manufacturer, size = hwy)) +
  geom_point(alpha = .2) +
  scale_size_binned()

base

# Example 4
base <- ggplot(mpg, aes(displ, hwy, shape = factor(cyl))) +
  geom_point()

base
base + scale_shape(solid = FALSE)

# Example 5
base +
  scale_shape_manual(
    values = c("4" = 16, "5" = 17, "6" = 1, "8" = 2)
  )

# Example 6
base <- ggplot(airquality, aes(x = factor(Month), y = Temp))

base + geom_pointrange(stat = "summary", fun.data = "median_hilow")
base +
  geom_pointrange(
    stat = "summary",
    fun.data = "median_hilow",
    size = 2
  )
base +
  geom_pointrange(
    stat = "summary",
    fun.data = "median_hilow",
    linewidth = 2
  )

# Example 7
ggplot(airquality, aes(Day, Temp, group = Month)) +
  geom_line(aes(linewidth = Month)) +
  scale_linewidth(range = c(0.5, 3))

# Example 8
ggplot(economics_long, aes(date, value01, linetype = variable)) +
  geom_line()

# Example 9
df <- data.frame(value = letters[1:13])
base <- ggplot(df, aes(linetype = value)) +
  geom_segment(
    mapping = aes(x = 0, xend = 1, y = value, yend = value),
    show.legend = FALSE
  ) +
  theme(panel.grid = element_blank()) +
  scale_x_continuous(NULL, NULL)

base

# Example 10
linetypes <- function(n) {
  types <- c(
    "55",
    "75",
    "95",
    "1115",
    "111115",
    "11111115",
    "5158",
    "9198",
    "c1c8"
  )
  return(types[seq_len(n)])
}

base + discrete_scale("linetype", palette = linetypes)

# Example 11
huron <- data.frame(year = 1875:1972, level = as.numeric(LakeHuron))
ggplot(huron, aes(year)) +
  geom_line(aes(y = level + 5), colour = "red") +
  geom_line(aes(y = level - 5), colour = "blue")

# Example 12
ggplot(huron, aes(year)) +
  geom_line(aes(y = level + 5, colour = "above")) +
  geom_line(aes(y = level - 5, colour = "below"))

# Example 13
ggplot(huron, aes(year)) +
  geom_line(aes(y = level + 5, colour = "above")) +
  geom_line(aes(y = level - 5, colour = "below")) +
  scale_colour_manual(
    "Direction",
    values = c("above" = "red", "below" = "blue")
  )

# Example 14
head(luv_colours)
#>      L         u    v           col
#> 1 9342 -3.37e-12    0         white
#> 2 9101 -4.75e+02 -635     aliceblue
#> 3 8810  1.01e+03 1668  antiquewhite
#> 4 8935  1.07e+03 1675 antiquewhite1
#> 5 8452  1.01e+03 1610 antiquewhite2
#> 6 7498  9.03e+02 1402 antiquewhite3

ggplot(luv_colours, aes(u, v)) +
  geom_point(aes(colour = col), size = 3) +
  scale_color_identity() +
  coord_equal()

