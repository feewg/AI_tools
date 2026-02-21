# 5Statistical summaries
# Chapter 6

# Example 1
y <- c(18, 11, 16)
df <- data.frame(x = 1:3, y = y, se = c(1.2, 0.5, 1.0))

base <- ggplot(df, aes(x, y, ymin = y - se, ymax = y + se))
base + geom_crossbar()
base + geom_pointrange()
base + geom_smooth(stat = "identity")

# Example 2
base + geom_errorbar()
base + geom_linerange()
base + geom_ribbon()

# Example 3
# Unweighted
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point()

# Weight by population
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1e6)) + 
  scale_size_area("Population\n(millions)", breaks = c(0.5, 1, 2, 4))

# Example 4
# Unweighted
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point() + 
  geom_smooth(method = lm, linewidth = 1)
#> `geom_smooth()` using formula = 'y ~ x'

# Weighted by population
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1e6)) + 
  geom_smooth(aes(weight = poptotal), method = lm, linewidth = 1) +
  scale_size_area(guide = "none")
#> `geom_smooth()` using formula = 'y ~ x'

# Example 5
ggplot(midwest, aes(percbelowpoverty)) +
  geom_histogram(binwidth = 1) + 
  ylab("Counties")

ggplot(midwest, aes(percbelowpoverty)) +
  geom_histogram(aes(weight = poptotal), binwidth = 1) +
  ylab("Population (1000s)")

# Example 6
ggplot(diamonds, aes(depth)) + 
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.

ggplot(diamonds, aes(depth)) + 
  geom_histogram(binwidth = 0.1) + 
  xlim(55, 70)
#> Warning: Removed 45 rows containing non-finite outside the scale range
#> (`stat_bin()`).
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_bar()`).

# Example 7
ggplot(diamonds, aes(depth)) + 
  geom_freqpoly(aes(colour = cut), binwidth = 0.1, na.rm = TRUE) +
  xlim(58, 68) + 
  theme(legend.position = "none")

ggplot(diamonds, aes(depth)) + 
  geom_histogram(aes(fill = cut), binwidth = 0.1, position = "fill",
    na.rm = TRUE) +
  xlim(58, 68) + 
  theme(legend.position = "none")

# Example 8
ggplot(diamonds, aes(depth)) +
  geom_density(na.rm = TRUE) + 
  xlim(58, 68) + 
  theme(legend.position = "none")

ggplot(diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE) + 
  xlim(58, 68) + 
  theme(legend.position = "none")

# Example 9
ggplot(diamonds, aes(clarity, depth)) + 
    geom_boxplot()

  ggplot(diamonds, aes(carat, depth)) + 
    geom_boxplot(aes(group = cut_width(carat, 0.1))) + 
    xlim(NA, 2.05)
  #> Warning: Orientation is not uniquely specified when both the x and y aesthetics are
  #> continuous. Picking default orientation 'x'.
  #> Warning: Removed 997 rows containing missing values or values outside the scale range
  #> (`stat_boxplot()`).

# Example 10
ggplot(diamonds, aes(clarity, depth)) + 
    geom_violin()

  ggplot(diamonds, aes(carat, depth)) + 
    geom_violin(aes(group = cut_width(carat, 0.1))) + 
    xlim(NA, 2.05)
  #> Warning: Removed 997 rows containing non-finite outside the scale range
  #> (`stat_ydensity()`).

# Example 11
df <- data.frame(x = rnorm(2000), y = rnorm(2000))
  norm <- ggplot(df, aes(x, y)) + xlab(NULL) + ylab(NULL)
  norm + geom_point()
  norm + geom_point(shape = 1) # Hollow circles
  norm + geom_point(shape = ".") # Pixel sized

# Example 12
norm + geom_point(alpha = 1 / 3)
  norm + geom_point(alpha = 1 / 5)
  norm + geom_point(alpha = 1 / 10)

# Example 13
norm + geom_bin2d()
  #> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.
  norm + geom_bin2d(bins = 10)

# Example 14
norm + geom_hex()
  norm + geom_hex(bins = 10)

# Example 15
ggplot(diamonds, aes(color)) + 
  geom_bar()

ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat = "summary_bin", fun = mean)

# Example 16
ggplot(diamonds, aes(table, depth)) + 
  geom_bin2d(binwidth = 1, na.rm = TRUE) + 
  xlim(50, 70) + 
  ylim(50, 70)

ggplot(diamonds, aes(table, depth, z = price)) + 
  geom_raster(binwidth = 1, stat = "summary_2d", fun = mean, 
    na.rm = TRUE) + 
  xlim(50, 70) + 
  ylim(50, 70)

# Example 17
ggplot(faithfuld, aes(eruptions, waiting)) + 
  geom_contour(aes(z = density, colour = ..level..))
#> Warning: The dot-dot notation (`..level..`) was deprecated in ggplot2 3.4.0.
#> ℹ Please use `after_stat(level)` instead.

# Example 18
ggplot(faithfuld, aes(eruptions, waiting)) + 
  geom_raster(aes(fill = density))

# Example 19
# Bubble plots work better with fewer observations
small <- faithfuld[seq(1, nrow(faithfuld), by = 10), ]
ggplot(small, aes(eruptions, waiting)) + 
  geom_point(aes(size = density), alpha = 1/3) + 
  scale_size_area()

