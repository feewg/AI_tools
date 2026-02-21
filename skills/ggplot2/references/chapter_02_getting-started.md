# First Steps

## Overview

This chapter teaches the basics of ggplot2 for producing useful graphics quickly. You'll learn the fundamentals of `ggplot()` and recipes for common plots.

## Key Components of Every Plot

1. **Data** - The dataset to visualize
2. **Aesthetic mappings** - Map variables to visual properties (x, y, colour, etc.)
3. **Geoms** - Geometric objects that render the data (points, lines, bars)

Basic structure:
```r
ggplot(data, aes(x, y)) + geom_type()
```

## Aesthetics

Map additional variables to visual properties:
- `aes(x, y, colour = class)` - colour by category
- `aes(x, y, shape = drv)` - shape by category  
- `aes(x, y, size = cyl)` - size by continuous value

Setting vs mapping:
- Inside `aes()` = mapping (creates scale and legend)
- Outside `aes()` = setting fixed value

## Faceting

Split data into subsets with `facet_wrap()`:
```r
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)
```

## Common Geoms

**Smooth trends:**
- `geom_smooth()` - add smoothed line with confidence interval
- Methods: "loess" (default, small n), "gam" (large n), "lm" (linear)

**Distributions:**
- `geom_histogram()` - histogram
- `geom_freqpoly()` - frequency polygon
- `geom_density()` - density plot
- `geom_boxplot()` - box plot
- `geom_violin()` - violin plot
- `geom_jitter()` - jittered points

**Categorical:**
- `geom_bar()` - bar chart (counts)
- `geom_bar(stat = "identity")` - bar chart (values)

**Time series:**
- `geom_line()` - lines (left to right)
- `geom_path()` - paths (data order)

## Axis Modification

- `xlab()`, `ylab()` - axis labels
- `xlim()`, `ylim()` - axis limits
- Use `NULL` to remove labels

## Working with Plot Objects

```r
p <- ggplot(mpg, aes(displ, hwy)) + geom_point()
print(p)      # display
summary(p)    # structure
ggsave("plot.png", p)  # save
```
