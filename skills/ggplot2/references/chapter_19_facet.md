# Faceting

## Types of Faceting

**Three facet types:**

| Function | Description |
|----------|-------------|
| `facet_null()` | Single plot (default) |
| `facet_wrap()` | 1D ribbon wrapped to 2D |
| `facet_grid()` | 2D grid of panels |

**Key difference:**
- `facet_wrap()` - fundamentally 1D, space-efficient
- `facet_grid()` - fundamentally 2D, row/column structure

## facet_wrap()

**One or more variables:**
```r
facet_wrap(~class)  # Single variable
facet_wrap(vars(class, cyl))  # Multiple variables
```

**Layout control:**
- `ncol` - number of columns
- `nrow` - number of rows
- `as.table = TRUE` - table-like layout (highest values bottom-right)
- `as.table = FALSE` - plot-like layout (highest top-right)
- `dir = "h"` - horizontal wrapping (default)
- `dir = "v"` - vertical wrapping

```r
facet_wrap(~class, ncol = 3)
facet_wrap(~class, ncol = 3, as.table = FALSE)
facet_wrap(~class, nrow = 3, dir = "v")
```

## facet_grid()

**Formula interface:**

```r
# Across columns (facilitates y comparison)
facet_grid(. ~ cyl)

# Down rows (facilitates x comparison)
facet_grid(drv ~ .)

# 2D grid
facet_grid(drv ~ cyl)
```

**Multiple variables:**
```r
# Nested on rows, crossed with columns
facet_grid(drv + fl ~ cyl)

# All combinations shown (including empty)
facet_grid(drv ~ cyl)  # Crossed
```

## Controlling Scales

**Common scales argument:**

| Value | Effect |
|-------|--------|
| `"fixed"` | All panels same scales (default) |
| `"free_x"` | x varies, y fixed |
| `"free_y"` | y varies, x fixed |
| `"free"` | Both vary |

```r
facet_wrap(~cyl, scales = "free")
facet_grid(drv ~ cyl, scales = "free_y")
```

**facet_grid constraint:**
- All panels in a column share x scale
- All panels in a row share y scale

**Space control (facet_grid only):**
```r
facet_grid(manufacturer ~ ., scales = "free", space = "free")
```
- Space proportional to scale range
- Useful for categorical data with varying levels

## Missing Faceting Variables

**Handling missing variables:**
```r
df1 <- data.frame(x = 1:3, y = 1:3, gender = c("f", "f", "m"))
df2 <- data.frame(x = 2, y = 2)  # No gender variable

ggplot(df1, aes(x, y)) + 
  geom_point(data = df2, colour = "red") +  # Appears in all facets
  geom_point() +
  facet_wrap(~gender)
```

- Data without faceting variables appears in ALL panels
- Useful for annotations shared across facets

## Grouping vs Faceting

**Comparison:**

| Aspect | Aesthetics (colour, shape) | Faceting |
|--------|---------------------------|----------|
| Position | Close together, may overlap | Far apart, no overlap |
| Small differences | Easy to see | Harder to see |
| Large differences | May be obscured | Clearly separated |

**When to use each:**
- Use aesthetics when groups overlap heavily
- Use faceting when comparing patterns across conditions

## Annotation Techniques

**Show group means in all panels:**
```r
df_sum <- df %>% 
  group_by(z) %>% 
  summarise(x = mean(x), y = mean(y)) %>%
  rename(z2 = z)

ggplot(df, aes(x, y)) + 
  geom_point() + 
  geom_point(data = df_sum, aes(colour = z2), size = 4) + 
  facet_wrap(~z)
```

**Show all data in background:**
```r
df2 <- dplyr::select(df, -z)  # Remove grouping variable

ggplot(df, aes(x, y)) + 
  geom_point(data = df2, colour = "grey70") +  # All data
  geom_point(aes(colour = z)) +  # Highlight current facet
  facet_wrap(~z)
```

## Continuous Variables

**Must discretize continuous variables:**

```r
# Equal width bins
mpg$disp_w <- cut_width(mpg$displ, 1)

# Equal length bins
mpg$disp_i <- cut_interval(mpg$displ, 6)

# Equal count bins
mpg$disp_n <- cut_number(mpg$displ, 6)

facet_wrap(~disp_w)
```

**Discretization functions:**
- `cut_interval(x, n)` - n bins of equal length
- `cut_width(x, width)` - bins of specified width
- `cut_number(x, n)` - n bins with equal observations

**Note:** Formula interface doesn't evaluate functions, create variable first.
