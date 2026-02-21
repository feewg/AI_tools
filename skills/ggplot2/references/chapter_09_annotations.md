# Annotations

## Plot and Axis Titles

Use `labs()` for titles:
```r
ggplot(mpg, aes(displ, hwy)) + 
  labs(
    x = "Engine displacement (litres)", 
    y = "Highway miles per gallon",
    title = "Mileage by engine size",
    subtitle = "Source: fueleconomy.gov"
  )
```

- Use `\n` for line breaks
- Use `quote()` for mathematical expressions
- Use `ggtext::element_markdown()` for markdown in titles
- `labs(x = NULL)` removes label and space
- `labs(x = "")` removes label but keeps space

## Text Labels

**`geom_text()`** - add text at specified positions:
- `family` - font ("sans", "serif", "mono" are guaranteed)
- `fontface` - "plain", "bold", "italic"
- `hjust`, `vjust` - alignment ("left", "center", "right", "inward", "outward")
- `size` - font size in mm
- `angle` - rotation in degrees
- `nudge_x`, `nudge_y` - offset from points
- `check_overlap = TRUE` - remove overlapping labels

**`geom_label()`** - text with rounded rectangle background

**Packages for better labeling:**
- **ggrepel**: `geom_text_repel()` - automatic label positioning
- **ggfittext**: tools for fitting text in spaces

## Custom Annotations

**Geoms for annotation:**
- `geom_rect()` - rectangular regions (xmin, xmax, ymin, ymax)
- `geom_line()`, `geom_segment()` - lines with `arrow` parameter
- `geom_vline()`, `geom_hline()`, `geom_abline()` - reference lines spanning plot
- `geom_curve()` - curved lines connecting points

**`annotate()` helper** - single annotation without data frame:
```r
ggplot(economics, aes(date, unemploy)) + 
  geom_line() + 
  annotate("text", x = date, y = value, label = "text")
```

Use `-Inf` and `Inf` for plot edges.

## Direct Labelling

Place labels directly on plot instead of legend:

**directlabels package**:
```r
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point(show.legend = FALSE) +
  directlabels::geom_dl(aes(label = class), method = "smart.grid")
```

**ggforce package**:
```r
ggforce::geom_mark_ellipse(aes(label = cyl, group = cyl))
```

**gghighlight package**:
```r
gghighlight::gghighlight(Subject %in% 1:3)
```

## Annotation Across Facets

Add reference lines/elements that appear in all facets:
```r
mod_coef <- coef(lm(log10(price) ~ log10(carat), data = diamonds))
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() + 
  geom_abline(intercept = mod_coef[1], slope = mod_coef[2]) + 
  facet_wrap(vars(cut))
```

Use `gghighlight()` with facets to show full data in background.
