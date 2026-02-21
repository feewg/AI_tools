# Statistical Summaries

## Revealing Uncertainty

Four families of geoms for displaying uncertainty:

**Discrete x:**
- `geom_errorbar()`, `geom_linerange()` - range only
- `geom_crossbar()`, `geom_pointrange()` - range & center

**Continuous x:**
- `geom_ribbon()` - range only
- `geom_smooth(stat = "identity")` - range & center

Use `ymin` and `ymax` aesthetics to specify y ranges.

## Weighted Data

For aggregated data where each row represents multiple observations:

- Simple geoms: use `size` aesthetic
- Statistical geoms: use `weight` aesthetic

Example:
```r
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal)) + 
  geom_smooth(aes(weight = poptotal), method = lm)
```

## Displaying Distributions

**1D continuous:**
- `geom_histogram()` - bin and count
- `geom_freqpoly()` - frequency polygon
- `geom_density()` - density estimate

**Comparing groups:**
- `facet_wrap(~ var)` - small multiples
- `geom_freqpoly(aes(colour = var))` - coloured lines
- `geom_histogram(position = "fill")` - conditional density

**Alternatives for many distributions:**
- `geom_boxplot()` - five-number summary
- `geom_violin()` - density in boxplot format
- `geom_dotplot()` - individual points (small data)

## Dealing with Overplotting

Techniques for large datasets:

**Aesthetic tweaks:**
- Smaller points
- Hollow glyphs: `shape = 1`
- Alpha blending: `alpha = 1/5`
- Jittering: `geom_jitter()`

**Density estimation:**
- `geom_bin2d()` - square bins
- `geom_hex()` - hexagonal bins
- `stat_density2d()` - 2D density contours

## Statistical Summaries

Custom summaries with `stat_summary_bin()` and `stat_summary_2d()`:

```r
ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat = "summary_bin", fun = mean)

ggplot(diamonds, aes(table, depth, z = price)) + 
  geom_raster(stat = "summary_2d", fun = mean)
```

## 3D Surfaces in 2D

- `geom_contour()` - contour lines
- `geom_raster()` - coloured tiles
- `geom_point(aes(size = z))` - bubble plots
