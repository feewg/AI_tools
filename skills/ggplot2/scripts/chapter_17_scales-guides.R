# 14Scales and guides
# Chapter 17

# Example 1
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class))

# Example 2
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) +
  scale_x_continuous() + 
  scale_y_continuous() + 
  scale_colour_discrete()

# Example 3
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) + 
  scale_x_continuous(name = "A really awesome x axis label") +
  scale_y_continuous(name = "An amazingly great y axis label")

# Example 4
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_x_continuous(name = "Label 1") +
  scale_x_continuous(name = "Label 2")
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_x_continuous(name = "Label 2")

# Example 5
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) +
  scale_x_sqrt() + 
  scale_colour_brewer()

# Example 6
df <- data.frame(x = 1:6, y = 8:13)
base <- ggplot(df, aes(x, y)) + 
  geom_col(aes(fill = x)) +                    # bar chart
  geom_vline(xintercept = 3.5, colour = "red") # for visual clarity only

base
base + scale_fill_gradient(limits = c(1, 3))
base + scale_fill_gradient(limits = c(1, 3), oob = scales::squish)

# Example 7
base <- ggplot(faithfuld, aes(waiting, eruptions)) + 
  geom_raster(aes(fill = density)) + 
  scale_x_continuous(NULL, NULL, expand = c(0, 0)) +
  scale_y_continuous(NULL, NULL, expand = c(0, 0))
  
base
base + scale_fill_continuous(trans = "sqrt")

# Example 8
df <- data.frame(x = runif(20), y = runif(20), z = sample(20))
base <- ggplot(df, aes(x, y, size = z)) + geom_point()

base 
base + scale_size(trans = "reverse")

# Example 9
ggplot(toy, aes(up, up)) + 
  geom_point(size = 4, colour = "grey20") +
  geom_point(aes(colour = txt), size = 2) 

ggplot(toy, aes(up, up)) + 
  geom_point(size = 4, colour = "grey20", show.legend = TRUE) +
  geom_point(aes(colour = txt), size = 2)

# Example 10
base <- ggplot(toy, aes(const, up)) +
  scale_x_continuous(NULL, breaks = NULL)
base + geom_point(aes(colour = txt))
base + geom_point(aes(shape = txt))
base + geom_point(aes(shape = txt, colour = txt))

# Example 11
base <- ggplot(toy, aes(const, up)) + 
  geom_point(aes(shape = txt, colour = txt)) + 
  scale_x_continuous(NULL, breaks = NULL)

base
base + labs(shape = "Split legend")
base + labs(shape = "Merged legend", colour = "Merged legend")

# Example 12
base <- ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = factor(year)), size = 5) + 
  scale_colour_brewer("year", type = "qual", palette = 5) 

base
base + 
  ggnewscale::new_scale_colour() + 
  geom_point(aes(colour = cyl == 4), size = 1, fill = NA) + 
  scale_colour_manual("4 cylinder", values = c("grey60", "black"))

# Example 13
base <- ggplot(economics, aes(date, psavert, color = "savings"))

base + geom_line()
base + geom_line(key_glyph = "timeseries")

