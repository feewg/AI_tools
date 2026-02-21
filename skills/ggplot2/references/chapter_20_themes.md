# Themes

## Theme System Components

**Four main components:**
1. **Theme elements** - what can be controlled (plot.title, axis.ticks.x, etc.)
2. **Element functions** - describe visual properties (element_text(), element_line())
3. **theme() function** - override defaults
4. **Complete themes** - coordinated sets of theme settings

## Complete Themes

**Built-in themes:**

| Theme | Description |
|-------|-------------|
| `theme_grey()` | Default - light grey background, white gridlines |
| `theme_bw()` | White background, grey gridlines |
| `theme_linedraw()` | Black lines on white |
| `theme_light()` | Light grey lines, more data focus |
| `theme_dark()` | Dark background (coloured lines pop) |
| `theme_minimal()` | Minimal annotations |
| `theme_classic()` | Classic with axes, no grid |
| `theme_void()` | Completely empty |

**Base size:**
```r
theme_bw(base_size = 14)  # Controls all text sizes proportionally
```

**Set default theme:**
```r
theme_set(theme_bw())  # For all future plots
```

**External packages:**
- **ggthemes** - Tufte, Excel, Stata, Economist styles

## Element Functions

### element_text()

**Parameters:**
- `family` - font family
- `face` - "plain", "bold", "italic", "bold.italic"
- `colour` / `color` - text colour
- `size` - font size in points
- `hjust` - horizontal justification (0=left, 1=right)
- `vjust` - vertical justification (0=bottom, 1=top)
- `angle` - rotation in degrees
- `lineheight` - line spacing

```r
theme(plot.title = element_text(face = "bold", size = 16, hjust = 1))
```

**Margins:**
```r
theme(plot.title = element_text(margin = margin(t = 10, b = 10)))
```

### element_line()

**Parameters:**
- `colour` - line colour
- `linewidth` - line width
- `linetype` - line pattern

```r
theme(panel.grid.major = element_line(colour = "grey70", linewidth = 0.2))
```

### element_rect()

**Parameters:**
- `fill` - background fill
- `colour` - border colour
- `linewidth` - border width
- `linetype` - border pattern

```r
theme(plot.background = element_rect(fill = "lightblue", colour = "red"))
```

### element_blank()

- Draws nothing, allocates no space

```r
theme(panel.grid.minor = element_blank())
```

## Theme Element Hierarchy

**Inheritance structure:**
```
axis.text
├── axis.text.x
└── axis.text.y
    └── axis.text.y.right
```

Setting `axis.text` affects all, unless overridden by specific element.

## Theme Elements by Category

### Plot Elements

| Element | Setter | Description |
|---------|--------|-------------|
| `plot.background` | `element_rect()` | Plot background |
| `plot.title` | `element_text()` | Plot title |
| `plot.subtitle` | `element_text()` | Subtitle |
| `plot.caption` | `element_text()` | Caption |
| `plot.margin` | `margin()` | Margins around plot |
| `plot.tag` | `element_text()` | Tag (for labeling) |

### Axis Elements

| Element | Setter |
|---------|--------|
| `axis.line` | `element_line()` |
| `axis.text` | `element_text()` |
| `axis.text.x`, `axis.text.y` | `element_text()` |
| `axis.title` | `element_text()` |
| `axis.ticks` | `element_line()` |
| `axis.ticks.length` | `unit()` |

**Rotating x-axis labels:**
```r
theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0))
```

### Legend Elements

| Element | Setter |
|---------|--------|
| `legend.background` | `element_rect()` |
| `legend.key` | `element_rect()` |
| `legend.key.size`, `legend.key.height`, `legend.key.width` | `unit()` |
| `legend.margin` | `unit()` |
| `legend.text` | `element_text()` |
| `legend.title` | `element_text()` |

**Legend position (in theme):**
- `legend.position` - "right", "left", "top", "bottom", "none", or c(x, y)
- `legend.justification` - anchor point
- `legend.direction` - "horizontal" or "vertical"
- `legend.box` - arrangement of multiple legends

### Panel Elements

| Element | Setter |
|---------|--------|
| `panel.background` | `element_rect()` |
| `panel.border` | `element_rect()` (use fill = NA) |
| `panel.grid.major`, `panel.grid.minor` | `element_line()` |
| `panel.grid.major.x`, `panel.grid.major.y` | `element_line()` |
| `aspect.ratio` | numeric |

**Background vs border:**
- `panel.background` - drawn under data
- `panel.border` - drawn over data (always set fill = NA)

### Faceting Elements

| Element | Setter |
|---------|--------|
| `strip.background` | `element_rect()` |
| `strip.text` | `element_text()` |
| `strip.text.x`, `strip.text.y` | `element_text()` |
| `panel.spacing` | `unit()` |
| `panel.spacing.x`, `panel.spacing.y` | `unit()` |

```r
theme(
  strip.text = element_text(colour = "white"),
  strip.background = element_rect(fill = "grey20")
)
```

## Modifying Themes

**Single plot:**
```r
ggplot(...) + theme(...)
```

**Update theme (affects all future plots):**
```r
theme_update(plot.background = element_rect(fill = "lightblue"))
```

**Modify complete themes:**
```r
theme_bw() + theme(panel.grid.minor = element_blank())
```

## Saving Output

**ggsave():**

```r
ggsave("plot.pdf")  # Vector format
ggsave("plot.png", dpi = 300)  # Raster format
ggsave("plot.svg", width = 6, height = 4)
```

**Supported formats:**
- Vector: eps, pdf, svg, wmf
- Raster: png, jpg, bmp, tiff

**Key arguments:**
- `width`, `height` - in inches
- `dpi` - resolution for raster (default 300)
- `bg` - background colour

**When to use each format:**
- **Vector (pdf, svg):** Best quality, scalable, preferred
- **Raster (png):** Many objects (scatterplots), MS Office
