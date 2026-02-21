# The Grammar
# Chapter 15

# Example 1
ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point()

# Example 2
ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_line() + 
  theme(legend.position = "none")

ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_bar(stat = "identity", position = "identity", fill = NA) + 
  theme(legend.position = "none")

# Example 3
ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) + 
  geom_point() + 
  geom_smooth(method = "lm")
#> `geom_smooth()` using formula = 'y ~ x'

# Example 4
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth() + 
  facet_wrap(~year)

