# Individual Geoms

## Basic Plot Types

Fundamental building blocks of ggplot2. Each requires `x` and `y` aesthetics. All understand `colour` and `size`; filled geoms also understand `fill`.

**Geoms:**

- `geom_area()` - area plot (filled line to y-axis)
- `geom_bar(stat = "identity")` - bar chart
- `geom_line()` - line plot (left to right)
- `geom_path()` - path plot (data order)
- `geom_point()` - scatterplot
- `geom_polygon()` - filled polygons
- `geom_rect()` - rectangles (by corners)
- `geom_tile()` / `geom_raster()` - rectangles (by center and size)
- `geom_text()` - text labels

## Aesthetics

- `colour` / `color` - outline colour
- `fill` - interior colour
- `size` - point size or line width
- `shape` - point shape
- `linetype` - line style (solid, dashed, etc.)
- `label` - text for `geom_text()`

Note: Bar, area, and tile geoms extend axes beyond data range.
