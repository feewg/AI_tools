# 4Collective geoms
# Chapter 5

# Example 1
ggplot(Oxboys, aes(age, height, group = Subject)) + 
  geom_point() + 
  geom_line()

# Example 2
ggplot(Oxboys, aes(age, height)) + 
  geom_point() + 
  geom_line()

# Example 3
ggplot(Oxboys, aes(age, height, group = Subject)) + 
  geom_line() + 
  geom_smooth(method = "lm", se = FALSE)
#> `geom_smooth()` using formula = 'y ~ x'

# Example 4
ggplot(Oxboys, aes(age, height)) + 
  geom_line(aes(group = Subject)) + 
  geom_smooth(method = "lm", linewidth = 2, se = FALSE)
#> `geom_smooth()` using formula = 'y ~ x'

# Example 5
ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot()

# Example 6
ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot() +
  geom_line(colour = "#3366FF", alpha = 0.5)

# Example 7
ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot() +
  geom_line(aes(group = Subject), colour = "#3366FF", alpha = 0.5)

# Example 8
df <- data.frame(x = 1:3, y = 1:3, colour = c(1, 3, 5))

ggplot(df, aes(x, y, colour = factor(colour))) + 
  geom_line(aes(group = 1), linewidth = 2) +
  geom_point(size = 5)

ggplot(df, aes(x, y, colour = colour)) + 
  geom_line(aes(group = 1), linewidth = 2) +
  geom_point(size = 5)

# Example 9
xgrid <- with(df, seq(min(x), max(x), length = 50))
interp <- data.frame(
  x = xgrid,
  y = approx(df$x, df$y, xout = xgrid)$y,
  colour = approx(df$x, df$colour, xout = xgrid)$y  
)
ggplot(interp, aes(x, y, colour = colour)) + 
  geom_line(linewidth = 2) +
  geom_point(data = df, size = 5)

# Example 10
ggplot(mpg, aes(class)) + 
  geom_bar()
ggplot(mpg, aes(class, fill = drv)) + 
  geom_bar()

# Example 11
ggplot(mpg, aes(class, fill = hwy)) + 
  geom_bar()
#> Warning: The following aesthetics were dropped during statistical transformation: fill.
#> ℹ This can happen when ggplot fails to infer the correct grouping structure in
#>   the data.
#> ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
#>   variable into a factor?
ggplot(mpg, aes(class, fill = hwy, group = hwy)) + 
  geom_bar()

# Example 12
ggplot(mpg, aes(displ, cty)) + 
     geom_boxplot()

# Example 13
ggplot(mpg, aes(drv)) + 
     geom_bar()

   ggplot(mpg, aes(drv, fill = hwy, group = hwy)) + 
     geom_bar()

   library(dplyr)  
   mpg2 <- mpg %>% arrange(hwy) %>% mutate(id = seq_along(hwy)) 
   ggplot(mpg2, aes(drv, fill = hwy, group = id)) + 
     geom_bar()

# Example 14
library(babynames)
   hadley <- dplyr::filter(babynames, name == "Hadley")
   ggplot(hadley, aes(year, n)) + 
     geom_line()

