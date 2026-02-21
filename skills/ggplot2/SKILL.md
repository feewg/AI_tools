---
name: ggplot2
description: Comprehensive guide for creating data visualizations with ggplot2 in R, based on the official ggplot2 book (ggplot2-book.org).
version: 1.0.0
author: Kilo Code
source: https://ggplot2-book.org/
---

# ggplot2 Skill

Guide users in creating statistical graphics and data visualizations using ggplot2 in R.

## Purpose

Provide comprehensive guidance for creating publication-quality data visualizations using ggplot2. This skill covers everything from basic plots to advanced customization, helping users understand the grammar of graphics and apply it effectively to their data.

## When to Use

Use this skill when:
- Creating statistical graphics and data visualizations in R
- Exploratory data analysis with visual plots
- Producing publication-quality figures
- Learning ggplot2 concepts and best practices
- Troubleshooting visualization problems
- Extending ggplot2 with custom components

## Key Concepts

### The Grammar of Graphics
ggplot2 is based on the Grammar of Graphics, which describes the fundamental features that underlie all statistical graphics. A graphic maps data to aesthetic attributes (colour, shape, size) of geometric objects (points, lines, bars).

### Core Components

1. **Data**: The information you want to visualize
2. **Aesthetic mappings**: Description of how variables are mapped to visual properties
3. **Geoms**: Geometric objects representing what you see (points, lines, bars)
4. **Stats**: Statistical transformations summarizing the data
5. **Scales**: Map values in data space to aesthetic space
6. **Coordinate systems**: Describe how data coordinates map to the plot plane
7. **Facets**: Display subsets of data as small multiples
8. **Themes**: Control display details like fonts and background colors

### Layer Structure
Every ggplot2 plot is built by adding layers:
```r
ggplot(data, aes(x, y)) +     # Base layer with data and aesthetics
  geom_point() +              # Geometric layer
  theme_minimal()             # Theme layer
```

## Workflow

### 1. Start with Data
Load your data and understand its structure:
```r
library(ggplot2)
data(mpg)  # Example dataset
```

### 2. Create Basic Plot
Start with a simple plot and build up:
```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point()
```

### 3. Add Aesthetics
Map additional variables to visual properties:
```r
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point()
```

### 4. Refine and Customize
Adjust scales, themes, and annotations:
```r
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  theme_minimal() +
  labs(title = "Fuel Economy vs Engine Size",
       x = "Engine Displacement (L)",
       y = "Highway MPG")
```

## Available Resources

### Reference Documentation
Located in `references/` directory:
- `chapter_01_introduction.md` - Introduction to ggplot2
- `chapter_02_getting-started.md` - First steps with ggplot2
- `chapter_03_toolbox.md` - The toolbox overview
- `chapter_04_individual-geoms.md` - Individual geoms
- `chapter_05_collective-geoms.md` - Collective geoms
- `chapter_06_statistical-summaries.md` - Statistical summaries
- `chapter_07_maps.md` - Spatial data and maps
- `chapter_08_networks.md` - Network visualizations
- `chapter_09_annotations.md` - Annotations
- `chapter_10_arranging-plots.md` - Arranging multiple plots
- `chapter_11_scales.md` - Scales overview
- `chapter_12_scales-position.md` - Position scales and axes
- `chapter_13_scales-colour.md` - Colour scales and legends
- `chapter_14_scales-other.md` - Other aesthetic scales
- `chapter_15_mastery.md` - The grammar of graphics
- `chapter_16_layers.md` - Building plots layer by layer
- `chapter_17_scales-guides.md` - Scales and guides
- `chapter_18_coord.md` - Coordinate systems
- `chapter_19_facet.md` - Faceting
- `chapter_20_themes.md` - Themes
- `chapter_21_extending.md` - Advanced topics
- `chapter_22_programming.md` - Programming with ggplot2
- `chapter_23_internals.md` - Internals of ggplot2
- `chapter_24_extensions.md` - Extending ggplot2
- `chapter_25_ext-springs.md` - Case study: extension example

### Code Examples
Located in `scripts/` directory:
- `chapter_01_introduction.R` - Introduction examples
- `chapter_02_getting-started.R` - First steps examples
- `chapter_04_individual-geoms.R` - Individual geoms examples
- `chapter_05_collective-geoms.R` - Collective geoms examples
- `chapter_06_statistical-summaries.R` - Statistical summaries examples
- `chapter_07_maps.R` - Maps examples
- `chapter_08_networks.R` - Networks examples
- `chapter_09_annotations.R` - Annotations examples
- `chapter_10_arranging-plots.R` - Arranging plots examples
- `chapter_12_scales-position.R` - Position scales examples
- `chapter_13_scales-colour.R` - Colour scales examples
- `chapter_14_scales-other.R` - Other scales examples
- `chapter_15_mastery.R` - Grammar examples
- `chapter_16_layers.R` - Layers examples
- `chapter_17_scales-guides.R` - Scales and guides examples
- `chapter_18_coord.R` - Coordinate systems examples
- `chapter_19_facet.R` - Faceting examples
- `chapter_20_themes.R` - Themes examples
- `chapter_22_programming.R` - Programming examples
- `chapter_23_internals.R` - Internals examples
- `chapter_24_extensions.R` - Extensions examples
- `chapter_25_ext-springs.R` - Case study examples

## Common Geoms

### One Variable
- `geom_histogram()` - Histogram
- `geom_density()` - Density plot
- `geom_bar()` - Bar chart
- `geom_freqpoly()` - Frequency polygon

### Two Variables (Continuous x, Continuous y)
- `geom_point()` - Scatterplot
- `geom_smooth()` - Smoothed conditional means
- `geom_line()` - Line plot
- `geom_path()` - Path plot
- `geom_quantile()` - Quantile regression
- `geom_rug()` - Marginal rug plot

### Two Variables (Discrete x, Continuous y)
- `geom_boxplot()` - Box and whiskers plot
- `geom_violin()` - Violin plot
- `geom_dotplot()` - Dot plot
- `geom_jitter()` - Jittered points

### Two Variables (Discrete x, Discrete y)
- `geom_count()` - Count overlapping points

### Three Variables
- `geom_contour()` - Contour lines
- `geom_tile()` / `geom_raster()` - Tile plot / Raster plot

## Common Scales

### Position Scales
- `scale_x_continuous()` / `scale_y_continuous()` - Continuous scales
- `scale_x_discrete()` / `scale_y_discrete()` - Discrete scales
- `scale_x_log10()` / `scale_y_log10()` - Log10 scales
- `scale_x_reverse()` / `scale_y_reverse()` - Reversed scales
- `scale_x_date()` / `scale_y_date()` - Date scales

### Colour Scales
- `scale_colour_manual()` / `scale_fill_manual()` - Manual colors
- `scale_colour_brewer()` / `scale_fill_brewer()` - ColorBrewer palettes
- `scale_colour_viridis_c()` / `scale_colour_viridis_d()` - Viridis palettes
- `scale_colour_gradient()` / `scale_fill_gradient()` - Continuous gradients

### Other Aesthetic Scales
- `scale_size_continuous()` / `scale_size_discrete()` - Size scales
- `scale_shape_manual()` / `scale_shape_discrete()` - Shape scales
- `scale_linetype_manual()` / `scale_linetype_discrete()` - Line type scales

## Faceting

### Wrap Facets
```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class)
```

### Grid Facets
```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)
```

## Themes

### Built-in Themes
- `theme_gray()` - Gray background (default)
- `theme_bw()` - Black and white
- `theme_minimal()` - Minimal theme
- `theme_classic()` - Classic theme
- `theme_void()` - Empty theme

### Theme Customization
```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 14),
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "gray90")
  )
```

## Best Practices

1. **Start Simple**: Begin with a basic plot and add complexity gradually
2. **Choose Appropriate Geoms**: Select geoms that best represent your data type
3. **Use Consistent Scales**: Ensure scales are consistent across related plots
4. **Mindful Aesthetics**: Don't overload with too many aesthetic mappings
5. **Clear Labels**: Always include informative titles and axis labels
6. **Consider Color Blindness**: Use colorblind-friendly palettes
7. **Save High Resolution**: Use `ggsave()` with appropriate DPI for publication

## Extending ggplot2

### Creating Custom Themes
```r
theme_custom <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 16),
      axis.title = element_text(size = 12)
    )
}
```

### Creating Custom Geoms
See `chapter_24_extensions.R` and `chapter_25_ext-springs.R` for detailed examples.

## Additional Resources

- Official ggplot2 documentation: https://ggplot2.tidyverse.org/
- ggplot2 book source: https://github.com/hadley/ggplot2-book
- R for Data Science (visualization chapter): https://r4ds.had.co.nz/data-visualisation.html
- ggplot2 cheatsheet: https://posit.co/resources/cheatsheets/

## Common Issues and Solutions

### Overplotting
- Use `alpha` transparency
- Use `geom_jitter()` for small datasets
- Use `geom_hex()` or `geom_density_2d()` for large datasets
- Use `geom_count()` to show overlapping points

### Legends
- Use `guides()` to customize legend appearance
- Use `theme(legend.position = ...)` to control position
- Use `scale_*_manual()` for custom labels

### Scales
- Use appropriate transformations for skewed data
- Consider log scales for data spanning multiple orders of magnitude
- Use consistent scales when comparing multiple plots

## Programming with ggplot2

### Building Plots Programmatically
```r
plot_by_var <- function(data, x_var, y_var) {
  ggplot(data, aes(.data[[x_var]], .data[[y_var]])) +
    geom_point()
}
```

### Functional Programming
```r
library(purrr)

data_split <- split(mpg, mpg$class)
plots <- map(data_split, ~ggplot(.x, aes(displ, hwy)) + geom_point())
```

## Saving Plots

```r
# Save to file
ggsave("plot.png", width = 10, height = 6, dpi = 300)

# Save last plot
ggsave("plot.pdf", device = "pdf")

# Multiple formats
ggsave("plot.svg", device = "svg")
```

## Notes

- This skill is based on the third edition of the ggplot2 book
- All code examples are extracted from https://ggplot2-book.org/
- Code examples assume ggplot2 and related packages are installed
- Some examples require additional packages (sf, ggraph, etc.)
