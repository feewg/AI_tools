# Building a Plot Layer by Layer

## The Layer Function

**Behind the scenes:**
```r
layer(
  mapping = NULL,
  data = NULL,
  geom = "point",
  stat = "identity",
  position = "identity"
)
```

**Five components:**
1. **mapping** - aesthetic mappings (or NULL for default)
2. **data** - dataset (NULL to inherit from ggplot())
3. **geom** - geometric object name
4. **stat** - statistical transformation name
5. **position** - position adjustment name

## Data Requirements

**Tidy data format:**
- Variables in columns
- Observations in rows

**Multiple datasets in one plot:**
```r
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_line(data = grid, colour = "blue") +
  geom_text(data = outlier, aes(label = model))
```

## Aesthetic Mappings

**Defining mappings:**
```r
aes(x = displ, y = hwy, colour = class)
# or abbreviated:
aes(displ, hwy, colour = class)
```

**Layer-level vs plot-level:**
- Mappings can be in `ggplot()` or individual layers
- Layer mappings override plot mappings
- Can add, override, or remove mappings per layer

**Operations on layer aesthetics:**
| Operation | Layer aesthetics | Result |
|-----------|------------------|--------|
| Add | `aes(colour = cyl)` | Original + colour |
| Override | `aes(y = cty)` | New y aesthetic |
| Remove | `aes(y = NULL)` | Remove y mapping |

## Setting vs Mapping

**Setting (constant):**
```r
geom_point(colour = "red")  # outside aes()
```

**Mapping (variable):**
```r
geom_point(aes(colour = "red"))  # inside aes()
# Creates new variable with value "red"
```

**Identity scale for literal colours:**
```r
geom_point(aes(colour = my_colour_column)) +
  scale_colour_identity()
```

## Available Geoms

**Graphical primitives:**
- `geom_blank()` - nothing (for adjusting limits)
- `geom_point()` - points
- `geom_path()` - paths
- `geom_ribbon()` - ribbons
- `geom_segment()` - line segments
- `geom_rect()` - rectangles
- `geom_polygon()` - polygons
- `geom_text()` - text

**One variable:**
- `geom_bar()` - discrete distribution
- `geom_histogram()` - continuous distribution
- `geom_density()` - smoothed density
- `geom_dotplot()` - dot plot
- `geom_freqpoly()` - frequency polygon

**Two variables (both continuous):**
- `geom_point()` - scatterplot
- `geom_quantile()` - quantile regression
- `geom_rug()` - marginal rugs
- `geom_smooth()` - smoothed line
- `geom_text()` - text labels

**Two variables (show distribution):**
- `geom_bin2d()` - 2D bins
- `geom_density2d()` - 2D density
- `geom_hex()` - hexagonal bins

**Two variables (one discrete):**
- `geom_boxplot()` - boxplots
- `geom_violin()` - violin plots
- `geom_jitter()` - jittered points

**Time series:**
- `geom_line()` - line plot
- `geom_area()` - area plot
- `geom_step()` - step plot

**Uncertainty:**
- `geom_crossbar()` - bar with center
- `geom_errorbar()` - error bars
- `geom_linerange()` - vertical line
- `geom_pointrange()` - point with range

## Statistical Transformations

**Stats compute new data:**
- `stat_bin()` - binning (histograms)
- `stat_smooth()` - smoothing
- `stat_boxplot()` - boxplot statistics
- `stat_contour()` - contour lines
- `stat_quantile()` - quantile regression

**Default stat-geom pairs:**
- `geom_bar()` uses `stat_count()`
- `geom_histogram()` uses `stat_bin()`
- `geom_smooth()` uses `stat_smooth()`

**Using stats directly:**
```r
stat_summary(fun = "mean", geom = "point")
geom_point(stat = "summary", fun = "mean")
```

## Generated Variables

**Access with `after_stat()`:**
```r
geom_histogram(aes(y = after_stat(density)))
```

**Common generated variables:**
- `count` - number of observations in bin
- `density` - density (proportion / width)
- `x` - bin center

## Position Adjustments

**For bars:**
- `position_stack()` - stack bars
- `position_fill()` - stack to 100%
- `position_dodge()` - side by side
- `position_identity()` - no adjustment (overlapping)

**For points:**
- `position_nudge()` - fixed offset
- `position_jitter()` - random noise
- `position_jitterdodge()` - dodge then jitter

**Specifying parameters:**
```r
geom_point(position = position_jitter(width = 0.05, height = 0.5))
# shortcut:
geom_jitter(width = 0.05, height = 0.5)
```
