# Arranging Plots

## patchwork Package

Combine plots with `+` operator:
```r
library(patchwork)
p1 + p2
p1 + p2 + p3 + p4
```

Automatic layout based on number of plots (same algorithm as `facet_wrap()`).

## Controlling Layout

**`plot_layout()`**:
```r
p1 + p2 + p3 + plot_layout(ncol = 2)
```

**Row/column operators**:
```r
p1 / p2    # single column
p3 | p4    # single row
p3 | (p2 / (p1 | p4))  # nested layouts
```

**Custom design** (textual representation):
```r
layout <- "
AAB
C#B
CDD
"
p1 + p2 + p3 + p4 + plot_layout(design = layout)
```

## Guides

Collect and deduplicate legends:
```r
p1 + p2 + p3 + plot_layout(guides = "collect")
p1 + p2 + p3 + guide_area() + plot_layout(ncol = 2, guides = "collect")
```

## Modifying Subplots

**Individual modification** with indexing:
```r
p12 <- p1 + p2
p12[[2]] <- p12[[2]] + theme_light()
```

**All subplots** with `&`:
```r
p1 + p4 & theme_minimal()
p1 + p4 & scale_y_continuous(limits = c(0, 45))
```

## Annotation

**Global titles**:
```r
p3 + p4 + plot_annotation(
  title = "Title",
  caption = "Source: dataset"
)
```

**Auto-tagging**:
```r
p1 + p2 + plot_annotation(tag_levels = "A")  # A, B, C...
p1 + p2 + plot_annotation(tag_levels = "1")  # 1, 2, 3...
p1 + p2 + plot_annotation(tag_levels = "I")  # I, II, III...
```

Nested tagging levels:
```r
p123 + plot_annotation(tag_levels = c("I", "a"))  # I, Ia, Ib...
```

## Insets

Place plots on top of each other:
```r
p1 + inset_element(p2, left = 0.5, bottom = 0.4, right = 0.9, top = 0.95)
```

Position with `npc` units (0-1) or `grid::unit()`:
```r
p1 + inset_element(p2, left = 0.4, bottom = 0.4, 
  right = unit(1, "npc") - unit(15, "mm"),
  top = unit(1, "npc") - unit(15, "mm"),
  align_to = "full")
```
