# Extending ggplot2

## New Themes

### Modifying Existing Themes

```r
theme_minimal <- function(base_size = 11, base_family = "", ...) {
  theme_bw(...) %+replace%
  theme(
    axis.ticks = element_blank(),
    panel.background = element_blank(),
    # ... more elements
    complete = TRUE
  )
}
```

**Key points:**
- Use `%+replace%` to modify
- Always set `complete = TRUE`
- Provide parameters for customization

### Defining New Theme Elements

```r
register_theme_elements(
  mypackage.panel.annotation = element_text(color = "blue"),
  element_tree = list(
    mypackage.panel.annotation = el_def(
      class = "element_text", 
      inherit = "text"
    )
  )
)
```

Call from `.onLoad()` in package.

## New Stats

### Basic Stat Structure

```r
StatChull <- ggproto("StatChull", Stat,
  compute_group = function(data, scales) {
    data[chull(data$x, data$y), , drop = FALSE]
  },
  required_aes = c("x", "y")
)

stat_chull <- function(mapping = NULL, data = NULL, 
                       geom = "polygon", position = "identity",
                       na.rm = FALSE, show.legend = NA, 
                       inherit.aes = TRUE, ...) {
  layer(
    stat = StatChull,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
```

### Setup Methods

```r
StatExample <- ggproto("StatExample", Stat,
  setup_params = function(data, params) {
    # Modify parameters based on data
    if (is.null(params$bandwidth)) {
      params$bandwidth <- calculate_bandwidth(data)
    }
    params
  },
  
  setup_data = function(data, params) {
    # Modify data before computation
    # Preserve PANEL and group columns!
    data
  },
  
  compute_group = function(data, scales, param1 = 1) {
    # Main computation
    data.frame(x = ..., y = ...)
  }
)
```

### Compute Methods

**Three levels:**
- `compute_layer()` - whole layer
- `compute_panel()` - single panel
- `compute_group()` - single group

Usually only need to define `compute_group()`.

## New Geoms

### Modifying Defaults

```r
GeomPolygonHollow <- ggproto("GeomPolygonHollow", GeomPolygon,
  default_aes = aes(
    colour = "black",
    fill = NA,
    linewidth = 0.5,
    linetype = 1,
    alpha = NA
  )
)
```

### Modifying Data

```r
GeomSpike <- ggproto("GeomSpike", GeomSegment,
  required_aes = c("x", "y", "angle", "radius"),
  
  setup_data = function(data, params) {
    transform(data,
      xend = x + cos(angle) * radius,
      yend = y + sin(angle) * radius
    )
  }
)
```

### Combining Multiple Geoms

```r
GeomBarbell <- ggproto("GeomBarbell", Geom,
  required_aes = c("x", "y", "xend", "yend"),
  
  default_aes = aes(
    colour = "black",
    linewidth = 0.5,
    size = 2,
    linetype = 1,
    shape = 19,
    fill = NA,
    alpha = NA
  ),
  
  draw_panel = function(data, panel_params, coord, ...) {
    point1 <- transform(data)
    point2 <- transform(data, x = xend, y = yend)
    
    grid::gList(
      GeomSegment$draw_panel(data, panel_params, coord, ...),
      GeomPoint$draw_panel(point1, panel_params, coord, ...),
      GeomPoint$draw_panel(point2, panel_params, coord, ...)
    )
  }
)
```

## New Coords

**Rarely needed** - existing coords cover most cases.

**Key methods:**
- `transform()` - transform positions
- `setup_panel_params()` - set up panel
- `draw_panel()` / `draw_bg()` / `draw_axis()`

## New Scales

### Palette Wrapper

```r
scale_fill_random <- function(..., aesthetics = "fill") {
  discrete_scale(
    aesthetics = aesthetics,
    scale_name = "random",
    palette = function(n) sample(colours(distinct = TRUE), n)
  )
}
```

### New Aesthetic Default Scale

Name function `scale_<aesthetic>_<type>()`:
```r
scale_diameter_continuous <- function(..., range = c(0.25, 0.7)) {
  continuous_scale(
    aesthetics = "diameter",
    scale_name = "diameter_c",
    palette = scales::rescale_pal(range),
    ...
  )
}
```

## New Positions

```r
PositionJitterNormal <- ggproto('PositionJitterNormal', Position,
  required_aes = c('x', 'y'),
  
  setup_params = function(self, data) {
    list(sd_x = self$sd_x, sd_y = self$sd_y)
  },
  
  compute_layer = function(data, params, panel) {
    transform_position(
      df = data,
      trans_x = function(x) x + rnorm(length(x), sd = params$sd_x),
      trans_y = function(y) y + rnorm(length(y), sd = params$sd_y)
    )
  }
)

position_jitternormal <- function(sd_x = 0.15, sd_y = 0.15) {
  ggproto(NULL, PositionJitterNormal, sd_x = sd_x, sd_y = sd_y)
}
```

## New Facets

**Subclass existing facets:**

```r
FacetScatter <- ggproto("FacetScatter", FacetWrap,
  compute_layout = function(data, params) {
    # Create layout data frame with:
    # PANEL, ROW, COL, SCALE_X, SCALE_Y
    # Plus facetting variables
  }
)
```

**Key methods:**
- `compute_layout()` - define panel arrangement
- `map_data()` - assign data rows to panels

## Best Practices

1. **Always provide constructor functions**
2. **Match ggplot2 naming conventions**
3. **Include `...` for argument passing**
4. **Set sensible defaults**
5. **Document all parameters**
6. **Provide examples**
7. **Use `complete = TRUE` for themes**
8. **Preserve required columns (PANEL, group)**

## Testing Extensions

```r
# Test stat
ggplot(data, aes(x, y)) + stat_yourstat()

# Test geom
ggplot(data, aes(x, y)) + geom_yourgeom()

# Test combination
ggplot(data, aes(x, y, colour = group)) + 
  geom_yourgeom() + 
  facet_wrap(~group)
```
