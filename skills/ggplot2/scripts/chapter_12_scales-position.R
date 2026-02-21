# 10Position scales and axes
# Chapter 12

# Example 1
ggplot(mpg, aes(x = displ)) + geom_histogram()

# Example 2
ggplot(mpg, aes(x = displ, y = after_stat(count))) + geom_histogram()

# Example 3
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  facet_wrap(vars(year))

# Example 4
mpg_99 <- mpg %>% filter(year == 1999)
mpg_08 <- mpg %>% filter(year == 2008)

base_99 <- ggplot(mpg_99, aes(displ, hwy)) + geom_point() 
base_08 <- ggplot(mpg_08, aes(displ, hwy)) + geom_point() 

base_99
base_08

# Example 5
base_99 + 
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))

base_08 + 
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))

# Example 6
base_99 + lims(x = c(1, 7), y = c(10, 45))
base_08 + lims(x = c(1, 7), y = c(10, 45))

# Example 7
base <- ggplot(mpg, aes(drv, hwy)) + 
  geom_hline(yintercept = 28, colour = "red") + 
  geom_boxplot() 

base
base + coord_cartesian(ylim = c(10, 35)) # works as expected
base + ylim(10, 35) # distorts the boxplot 
#> Warning: Removed 6 rows containing non-finite outside the scale range
#> (`stat_boxplot()`).

# Example 8
base <- ggplot(faithfuld, aes(waiting, eruptions)) + 
  geom_raster(aes(fill = density)) + 
  theme(legend.position = "none") + 
  labs(x = NULL, y = NULL)

base 
base + 
  scale_x_continuous(expand = expansion(0)) + 
  scale_y_continuous(expand = expansion(0))

# Example 9
# Additive expansion of three units on both axes
base + 
  scale_x_continuous(expand = expansion(add = 3)) + 
  scale_y_continuous(expand = expansion(add = 3))

# Multiplicative expansion of 20% on both axes
base + 
  scale_x_continuous(expand = expansion(mult = .2)) + 
  scale_y_continuous(expand = expansion(mult = .2)) 

# Multiplicative expansion of 5% at the lower end of each axes,
# and 20% at the upper end; for the y-axis the expansion is 
# set directly instead of using expansion()
base + 
  scale_x_continuous(expand = expansion(mult = c(.05, .2))) + 
  scale_y_continuous(expand = c(.05, 0, .2, 0))

# Example 10
toy <- data.frame(
  const = 1, 
  up = 1:4,
  txt = letters[1:4], 
  big = (1:4)*1000,
  log = c(2, 5, 10, 2000)
)
toy
#>   const up txt  big  log
#> 1     1  1   a 1000    2
#> 2     1  2   b 2000    5
#> 3     1  3   c 3000   10
#> 4     1  4   d 4000 2000

# Example 11
base <- ggplot(toy, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

base

# Example 12
base + scale_x_continuous(breaks = c(1000, 2000, 4000))
base + scale_x_continuous(breaks = c(1000, 1500, 2000, 4000))

# Example 13
base 
base + scale_x_continuous(breaks = scales::breaks_extended())
base + scale_x_continuous(breaks = scales::breaks_extended(n = 2))

# Example 14
base + 
  scale_x_continuous(breaks = scales::breaks_width(800))
base + 
  scale_x_continuous(breaks = scales::breaks_width(800, offset = 200))
base + 
  scale_x_continuous(breaks = scales::breaks_width(800, offset = -200))

# Example 15
mb <- unique(as.numeric(1:10 %o% 10 ^ (0:3)))
mb
#>  [1]     1     2     3     4     5     6     7     8     9    10    20    30
#> [13]    40    50    60    70    80    90   100   200   300   400   500   600
#> [25]   700   800   900  1000  2000  3000  4000  5000  6000  7000  8000  9000
#> [37] 10000

# Example 16
base <- ggplot(toy, aes(log, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

base + scale_x_log10()
base + scale_x_log10(minor_breaks = mb)

# Example 17
base <- ggplot(toy, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_y_continuous(breaks = NULL) 

base
base + 
  scale_x_continuous(
    breaks = c(2000, 4000), 
    labels = c("2k", "4k")
  )

# Example 18
base <- ggplot(toy, aes(big, const)) + 
  geom_point() + 
  labs(x = NULL, y = NULL) +
  scale_x_continuous(breaks = NULL)

base
base + scale_y_continuous(labels = scales::label_percent())
base + scale_y_continuous(
  labels = scales::label_dollar(prefix = "", suffix = "€")
)

# Example 19
base + scale_y_continuous(breaks = NULL)
base + scale_y_continuous(labels = NULL)

# Example 20
base <- ggplot(mpg, aes(displ, hwy)) + geom_point()

base
base + scale_x_reverse()
base + scale_y_reverse()

# Example 21
# convert from fuel economy to fuel consumption
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = "reciprocal")

# log transform x and y axes
ggplot(diamonds, aes(price, carat)) + 
  geom_bin2d() + 
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

# Example 22
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = "reciprocal")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(trans = scales::reciprocal_trans())

# Example 23
ggplot(diamonds, aes(price, carat)) + 
  geom_bin2d() + 
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

ggplot(diamonds, aes(price, carat)) + 
  geom_bin2d() + 
  scale_x_log10() +
  scale_y_log10()
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

# Example 24
# manual transformation
ggplot(mpg, aes(log10(displ), hwy)) + 
  geom_point()

# transform using scales
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_x_log10()

# Example 25
date_base <- ggplot(economics, aes(date, psavert)) + 
  geom_line(na.rm = TRUE) +
  labs(x = NULL, y = NULL)

date_base 
date_base + scale_x_date(date_breaks = "15 years")

# Example 26
the_year <- as.Date(c("2021-01-01", "2021-12-31"))
set_breaks <- scales::breaks_width("1 month")
set_breaks(the_year)
#>  [1] "2021-01-01" "2021-02-01" "2021-03-01" "2021-04-01" "2021-05-01"
#>  [6] "2021-06-01" "2021-07-01" "2021-08-01" "2021-09-01" "2021-10-01"
#> [11] "2021-11-01" "2021-12-01" "2022-01-01"

# Example 27
set_breaks <- scales::breaks_width("1 month", offset = 8)
set_breaks(the_year)
#>  [1] "2021-01-09" "2021-02-09" "2021-03-09" "2021-04-09" "2021-05-09"
#>  [6] "2021-06-09" "2021-07-09" "2021-08-09" "2021-09-09" "2021-10-09"
#> [11] "2021-11-09" "2021-12-09" "2022-01-09"

# Example 28
df <- data.frame(y = as.Date(c("2022-01-01", "2022-04-01")))
base <- ggplot(df, aes(y = y)) + 
  labs(y = NULL) + 
  theme_minimal() + 
  theme(
    panel.grid.major = element_line(colour = "black"),
    panel.grid.minor = element_line(colour = "grey50")
  )

base + scale_y_date(date_breaks = "1 month")
base + 
  scale_y_date(date_breaks = "1 month", date_minor_breaks = "1 week")

# Example 29
base <- ggplot(economics, aes(date, psavert)) + 
  geom_line(na.rm = TRUE) +
  labs(x = NULL, y = NULL)

base + scale_x_date(date_breaks = "5 years")
base + scale_x_date(date_breaks = "5 years", date_labels = "%y")

# Example 30
lim <- as.Date(c("2004-01-01", "2005-01-01"))

base + scale_x_date(limits = lim, date_labels = "%b %y")
base + scale_x_date(limits = lim, date_labels = "%B\n%Y")

# Example 31
base + 
  scale_x_date(
    limits = lim, 
    labels = scales::label_date_short()
  )

# Example 32
ggplot(mpg, aes(x = hwy, y = class)) + 
  geom_point()

ggplot(mpg, aes(x = hwy, y = class)) + 
  geom_point() + 
  scale_x_continuous() +
  scale_y_discrete()

# Example 33
ggplot(mpg, aes(x = hwy, y = class)) + 
  geom_point() +
  annotate("text", x = 5, y = 1:7, label = 1:7)

# Example 34
ggplot(mpg, aes(x = hwy, y = class)) + 
  geom_jitter(width = 0, height = .25) +
  annotate("text", x = 5, y = 1:7, label = 1:7)

# Example 35
ggplot(mpg, aes(x = drv, y = hwy)) + geom_boxplot()
ggplot(mpg, aes(x = drv, y = hwy)) + geom_boxplot(width = .4)

# Example 36
base <- ggplot(toy, aes(const, txt)) + 
  geom_label(aes(label = txt)) +
  scale_x_continuous(breaks = NULL) +
  labs(x = NULL, y = NULL)

base 
base + scale_y_discrete(limits = c("a", "b", "c", "d", "e"))
base + scale_y_discrete(limits = c("d", "c", "a", "b"))

# Example 37
base + scale_y_discrete(breaks = c("b", "c"))
base + scale_y_discrete(labels = c(c = "carrot", b = "banana"))

# Example 38
base <- ggplot(mpg, aes(manufacturer, hwy)) + geom_boxplot() 
base

# Example 39
base + scale_x_discrete(guide = guide_axis(n.dodge = 3))
base + scale_x_discrete(guide = guide_axis(angle = 90))

# Example 40
ggplot(mpg, aes(hwy)) + geom_histogram(bins = 8)
ggplot(mpg, aes(hwy)) + 
  geom_bar() +
  scale_x_binned()

# Example 41
base <- ggplot(mpg, aes(displ, hwy)) + 
  geom_count()

base

# Example 42
base + 
  scale_x_binned(n.breaks = 15) +
  scale_y_binned(n.breaks = 15)

