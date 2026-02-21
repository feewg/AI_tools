# 2First steps
# Chapter 2

# Example 1
library(ggplot2)
mpg
#> # A tibble: 234 × 11
#>   manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
#>   <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
#> 1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa…
#> 2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa…
#> 3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa…
#> 4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compa…
#> 5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compa…
#> 6 audi         a4      2.8  1999     6 manual(m5) f        18    26 p     compa…
#> # ℹ 228 more rows

# Example 2
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# Example 3
ggplot(mpg, aes(displ, hwy)) +
  geom_point()

# Example 4
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

# Example 5
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")

# Example 6
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)

# Example 7
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# Example 8
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(span = 0.2)
  #> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

  ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(span = 1)
  #> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# Example 9
library(mgcv)
  ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(method = "gam", formula = y ~ s(x))

# Example 10
ggplot(mpg, aes(displ, hwy)) + 
    geom_point() + 
    geom_smooth(method = "lm")
  #> `geom_smooth()` using formula = 'y ~ x'

# Example 11
ggplot(mpg, aes(drv, hwy)) + 
  geom_point()

# Example 12
ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()

# Example 13
ggplot(mpg, aes(hwy)) + geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
ggplot(mpg, aes(hwy)) + geom_freqpoly()
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.

# Example 14
ggplot(mpg, aes(hwy)) + 
  geom_freqpoly(binwidth = 2.5)
ggplot(mpg, aes(hwy)) + 
  geom_freqpoly(binwidth = 1)

# Example 15
ggplot(mpg, aes(displ, colour = drv)) + 
  geom_freqpoly(binwidth = 0.5)
ggplot(mpg, aes(displ, fill = drv)) + 
  geom_histogram(binwidth = 0.5) + 
  facet_wrap(~drv, ncol = 1)

# Example 16
ggplot(mpg, aes(manufacturer)) + 
  geom_bar()

# Example 17
drugs <- data.frame(
  drug = c("a", "b", "c"),
  effect = c(4.2, 9.7, 6.1)
)

# Example 18
ggplot(drugs, aes(drug, effect)) + geom_bar(stat = "identity")
ggplot(drugs, aes(drug, effect)) + geom_point()

# Example 19
ggplot(economics, aes(date, unemploy / pop)) +
  geom_line()
ggplot(economics, aes(date, uempmed)) +
  geom_line()

# Example 20
ggplot(economics, aes(unemploy / pop, uempmed)) + 
  geom_path() +
  geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy / pop, uempmed)) + 
  geom_path(colour = "grey50") +
  geom_point(aes(colour = year(date)))

# Example 21
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3)

ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3) + 
  xlab("city driving (mpg)") + 
  ylab("highway driving (mpg)")

# Remove the axis labels with NULL
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3) + 
  xlab(NULL) + 
  ylab(NULL)

# Example 22
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25)

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25) + 
  xlim("f", "r") + 
  ylim(20, 30)
#> Warning: Removed 138 rows containing missing values or values outside the scale range
#> (`geom_point()`).
  
# For continuous scales, use NA to set only one limit
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25, na.rm = TRUE) + 
  ylim(NA, 30)

# Example 23
p <- ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point()

# Example 24
summary(p)
  #> data: manufacturer, model, displ, year, cyl, trans, drv, cty, hwy, fl,
  #>   class [234x11]
  #> mapping:  x = ~displ, y = ~hwy, colour = ~factor(cyl)
  #> faceting:  <empty> 
  #> -----------------------------------
  #> geom_point: na.rm = FALSE
  #> stat_identity: na.rm = FALSE
  #> position_identity

