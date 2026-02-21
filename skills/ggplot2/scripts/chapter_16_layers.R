# 13Build a plot layer by layer
# Chapter 16

# Example 1
p <- ggplot(mpg, aes(displ, hwy))
p

# Example 2
p + geom_point()

# Example 3
mod <- loess(hwy ~ displ, data = mpg)
grid <- tibble(displ = seq(min(mpg$displ), max(mpg$displ), length = 50))
grid$hwy <- predict(mod, newdata = grid)

grid
#> # A tibble: 50 × 2
#>   displ   hwy
#>   <dbl> <dbl>
#> 1  1.6   33.1
#> 2  1.71  32.2
#> 3  1.82  31.3
#> 4  1.93  30.4
#> 5  2.04  29.6
#> 6  2.15  28.8
#> # ℹ 44 more rows

# Example 4
std_resid <- resid(mod) / mod$s
outlier <- filter(mpg, abs(std_resid) > 2)
outlier
#> # A tibble: 6 × 11
#>   manufacturer model      displ  year   cyl trans  drv     cty   hwy fl    class
#>   <chr>        <chr>      <dbl> <int> <int> <chr>  <chr> <int> <int> <chr> <chr>
#> 1 chevrolet    corvette     5.7  1999     8 manua… r        16    26 p     2sea…
#> 2 pontiac      grand prix   3.8  2008     6 auto(… f        18    28 r     mids…
#> 3 pontiac      grand prix   5.3  2008     8 auto(… f        16    25 p     mids…
#> 4 volkswagen   jetta        1.9  1999     4 manua… f        33    44 d     comp…
#> 5 volkswagen   new beetle   1.9  1999     4 manua… f        35    44 d     subc…
#> 6 volkswagen   new beetle   1.9  1999     4 auto(… f        29    41 d     subc…

# Example 5
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_line(data = grid, colour = "blue", linewidth = 1.5) +
  geom_text(data = outlier, aes(label = model))

# Example 6
ggplot(mapping = aes(displ, hwy)) + 
  geom_point(data = mpg) + 
  geom_line(data = grid) + 
  geom_text(data = outlier, aes(label = model))

# Example 7
library(dplyr)
   class <- mpg %>% 
     group_by(class) %>% 
     summarise(n = n(), hwy = mean(hwy))

# Example 8
aes(x = displ, y = hwy, colour = class)

# Example 9
aes(displ, hwy, colour = class)

# Example 10
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class))
ggplot(mpg, aes(displ)) + 
  geom_point(aes(y = hwy, colour = class))
ggplot(mpg) + 
  geom_point(aes(displ, hwy, colour = class))

# Example 11
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")
#> `geom_smooth()` using formula = 'y ~ x'

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) + 
  geom_smooth(method = "lm", se = FALSE) + 
  theme(legend.position = "none")
#> `geom_smooth()` using formula = 'y ~ x'

# Example 12
ggplot(mpg, aes(cty, hwy)) + 
  geom_point(colour = "darkblue") 

ggplot(mpg, aes(cty, hwy)) + 
  geom_point(aes(colour = "darkblue"))

# Example 13
ggplot(mpg, aes(cty, hwy)) + 
  geom_point(aes(colour = "darkblue")) + 
  scale_colour_identity()

# Example 14
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth(aes(colour = "loess"), method = "loess", se = FALSE) + 
  geom_smooth(aes(colour = "lm"), method = "lm", se = FALSE) +
  labs(colour = "Method")
#> `geom_smooth()` using formula = 'y ~ x'
#> `geom_smooth()` using formula = 'y ~ x'

# Example 15
ggplot(mpg) + 
     geom_point(aes(mpg$displ, mpg$hwy))

   ggplot() + 
    geom_point(mapping = aes(y = hwy, x = cty), data = mpg) +
    geom_smooth(data = mpg, mapping = aes(cty, hwy))

   ggplot(diamonds, aes(carat, price)) + 
     geom_point(aes(log(brainwt), log(bodywt)), data = msleep)

# Example 16
ggplot(mpg) +
     geom_point(aes(class, cty)) + 
     geom_boxplot(aes(trans, hwy))

# Example 17
ggplot(mpg, aes(trans, cty)) + 
  geom_point() + 
  stat_summary(geom = "point", fun = "mean", colour = "red", size = 4)

ggplot(mpg, aes(trans, cty)) + 
  geom_point() + 
  geom_point(stat = "summary", fun = "mean", colour = "red", size = 4)

# Example 18
ggplot(diamonds, aes(price)) + 
  geom_histogram(binwidth = 500)

ggplot(diamonds, aes(price)) + 
  geom_histogram(aes(y = after_stat(density)), binwidth = 500)

# Example 19
ggplot(diamonds, aes(price, colour = cut)) + 
  geom_freqpoly(binwidth = 500) +
  theme(legend.position = "none")

ggplot(diamonds, aes(price, colour = cut)) + 
  geom_freqpoly(aes(y = after_stat(density)), binwidth = 500) + 
  theme(legend.position = "none")

# Example 20
mod <- loess(hwy ~ displ, data = mpg)
   smoothed <- data.frame(displ = seq(1.6, 7, length = 50))
   pred <- predict(mod, newdata = smoothed, se = TRUE) 
   smoothed$hwy <- pred$fit
   smoothed$hwy_lwr <- pred$fit - (1.96 * pred$se.fit)
   smoothed$hwy_upr <- pred$fit + (1.96 * pred$se.fit)

# Example 21
dplot <- ggplot(diamonds, aes(color, fill = cut)) + 
  xlab(NULL) + ylab(NULL) + theme(legend.position = "none")
# position stack is the default for bars, so `geom_bar()` 
# is equivalent to `geom_bar(position = "stack")`.
dplot + geom_bar()
dplot + geom_bar(position = "fill")
dplot + geom_bar(position = "dodge")

# Example 22
dplot + geom_bar(position = "identity", alpha = 1 / 2, colour = "grey50")

ggplot(diamonds, aes(color, colour = cut)) + 
  geom_line(aes(group = cut), stat = "count") + 
  xlab(NULL) + ylab(NULL) + 
  theme(legend.position = "none")

# Example 23
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(position = "jitter")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(position = position_jitter(width = 0.05, height = 0.5))

# Example 24
ggplot(mpg, aes(displ, hwy)) + 
  geom_jitter(width = 0.05, height = 0.5)

