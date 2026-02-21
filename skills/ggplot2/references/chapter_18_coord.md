# Coordinate Systems

## Linear Coordinate Systems

**Preserve shape of geoms:**

### coord_cartesian()

- Default Cartesian coordinates
- `xlim` and `ylim` for zooming (without removing data)

```r
coord_cartesian(xlim = c(4, 6))  # Visual zoom
scale_x_continuous(limits = c(4, 6))  # Removes data outside range
```

### coord_flip()

- Flips x and y axes
- Useful for horizontal boxplots, bar charts

```r
ggplot(mpg, aes(displ, cty)) + geom_point() + coord_flip()
```

### coord_fixed()

- Fixed aspect ratio (1:1 by default)
- `ratio` argument for custom aspect ratio

```r
coord_fixed(ratio = 1)  # Equal scales
coord_fixed(ratio = 2)  # x unit = 2 * y unit
```

## Non-linear Coordinate Systems

**Change shapes:** straight lines may curve

### coord_polar()

- Polar coordinates (angle and radius)
- Creates pie charts, rose charts, radar charts
- `theta` argument: which variable maps to angle ("x" or "y")

```r
# Pie chart
geom_bar(width = 1) + coord_polar(theta = "y")

# Bullseye chart
geom_bar(width = 1) + coord_polar()
```

### coord_map() / coord_quickmap()

- Map projections for longitude/latitude data
- `coord_quickmap()` - fast approximation (good for small regions)
- `coord_map()` - uses mapproj package, many projections

```r
coord_quickmap()  # Aspect ratio correction only
coord_map("ortho")  # Orthographic projection
coord_map("stereographic")
coord_map("mercator")
```

### coord_sf()

- For sf (simple features) spatial data
- Supports various CRS (Coordinate Reference Systems)
- See Chapter 7 (Maps) for details

### coord_trans()

**Warning:** Deprecated in ggplot2 4.0.0, use `coord_transform()`

- Transform x and y after statistical computation
- Different from scale transformations (which happen before stats)

```r
coord_trans(x = "log10", y = "log10")
```

**Use case:** Model on transformed scale, display on original scale

## How Coordinate Systems Work

**Two-step process:**

1. **Parameterization:** Convert geoms to location-based representation
   - Bar (x, height, width) → Polygon (4 corners)
   
2. **Transformation:** Transform each location to new coordinate system
   - Lines/polygons broken into small segments ("munching")
   - Each segment transformed individually

## Scale vs Coordinate Transformation

| Aspect | Scale Transform | Coordinate Transform |
|--------|-----------------|----------------------|
| When applied | Before stats | After stats |
| Affects stats | Yes | No |
| Changes shapes | No | Yes |

**Example - different fits:**
```r
# Scale transformation affects geom_smooth fit
ggplot(diamonds, aes(log10(carat), log10(price))) + geom_smooth()

# Coordinate transformation doesn't affect fit
ggplot(diamonds, aes(carat, price)) + geom_smooth() + coord_trans(x = "log10", y = "log10")
```

## Back-transformation Pattern

```r
# Model on log scale
ggplot(diamonds, aes(carat, price)) + 
  geom_smooth(method = "lm") +
  scale_x_log10() + 
  scale_y_log10() + 
  coord_trans(x = scales::exp_trans(10), y = scales::exp_trans(10))
```
