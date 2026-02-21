# 15Coordinate systems
# Chapter 18

# Example 1
base <- ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth()

# Full dataset
base
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
# Scaling to 4--6 throws away data outside that range
base + scale_x_continuous(limits = c(4, 6))
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
#> Warning: Removed 153 rows containing non-finite outside the scale range
#> (`stat_smooth()`).
#> Warning: Removed 153 rows containing missing values or values outside the scale range
#> (`geom_point()`).
# Zooming to 4--6 keeps all the data but only shows some of it
base + coord_cartesian(xlim = c(4, 6))
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# Example 2
ggplot(mpg, aes(displ, cty)) + 
  geom_point() + 
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
# Exchanging cty and displ rotates the plot 90 degrees, but the smooth 
# is fit to the rotated data.
ggplot(mpg, aes(cty, displ)) + 
  geom_point() + 
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
# coord_flip() fits the smooth to the original data, and then rotates 
# the output
ggplot(mpg, aes(displ, cty)) + 
  geom_point() + 
  geom_smooth() + 
  coord_flip()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# Example 3
rect <- data.frame(x = 50, y = 50)
line <- data.frame(x = c(1, 200), y = c(100, 1))
base <- ggplot(mapping = aes(x, y)) + 
  geom_tile(data = rect, aes(width = 50, height = 50)) + 
  geom_line(data = line) + 
  xlab(NULL) + ylab(NULL)
base
base + coord_polar("x")
base + coord_polar("y")

# Example 4
df <- data.frame(r = c(0, 1), theta = c(0, 3 / 2 * pi))
   ggplot(df, aes(r, theta)) + 
     geom_line() + 
     geom_point(size = 2, colour = "red")

# Example 5
interp <- function(rng, n) {
     seq(rng[1], rng[2], length = n)
   }
   munched <- data.frame(
     r = interp(df$r, 15),
     theta = interp(df$theta, 15)
   )

   ggplot(munched, aes(r, theta)) + 
     geom_line() + 
     geom_point(size = 2, colour = "red")

# Example 6
transformed <- transform(munched,
     x = r * sin(theta),
     y = r * cos(theta)
   )

   ggplot(transformed, aes(x, y)) + 
     geom_path() + 
     geom_point(size = 2, colour = "red") + 
     coord_fixed()

# Example 7
# Linear model on original scale is poor fit
base <- ggplot(diamonds, aes(carat, price)) + 
  stat_bin2d() + 
  geom_smooth(method = "lm") + 
  xlab(NULL) + 
  ylab(NULL) + 
  theme(legend.position = "none")
base

# Better fit on log scale, but harder to interpret
base +
  scale_x_log10() + 
  scale_y_log10()

# Fit on log scale, then backtransform to original.
# Highlights lack of expensive diamonds with large carats
pow10 <- scales::exp_trans(10)
base +
  scale_x_log10() + 
  scale_y_log10() + 
  coord_trans(x = pow10, y = pow10)

# Example 8
base <- ggplot(mtcars, aes(factor(1), fill = factor(cyl))) +
  geom_bar(width = 1) + 
  theme(legend.position = "none") + 
  scale_x_discrete(NULL, expand = c(0, 0)) +
  scale_y_continuous(NULL, expand = c(0, 0))

# Stacked barchart
base

# Pie chart
base + coord_polar(theta = "y")

# The bullseye chart
base + coord_polar()

# Example 9
# Prepare a map of NZ
  nzmap <- ggplot(map_data("nz"), aes(long, lat, group = group)) +
    geom_polygon(fill = "white", colour = "black") +
    xlab(NULL) + ylab(NULL)

  # Plot it in cartesian coordinates
  nzmap
  # With the aspect ratio approximation
  nzmap + coord_quickmap()

# Example 10
world <- map_data("world")
  worldmap <- ggplot(world, aes(long, lat, group = group)) +
    geom_path() +
    scale_y_continuous(NULL, breaks = (-2:3) * 30, labels = NULL) +
    scale_x_continuous(NULL, breaks = (-4:4) * 45, labels = NULL)

  worldmap + coord_map()
  # Some crazier projections
  worldmap + coord_map("ortho")
  worldmap + coord_map("stereographic")

