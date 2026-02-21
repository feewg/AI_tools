# Internals of ggplot2

## The plot() Method

**Plotting happens at print time:**
```r
p <- ggplot(mpg, aes(displ, hwy)) + geom_point()
# p is just a specification - no drawing yet
p  # Print triggers plotting
```

**Simplified plot process:**
```r
ggprint <- function(x) {
  data <- ggplot_build(x)
  gtable <- ggplot_gtable(data)
  grid::grid.newpage()
  grid::grid.draw(gtable)
  return(invisible(x))
}
```

**Four steps:**
1. `ggplot_build()` - prepare data
2. `ggplot_gtable()` - create graphic elements
3. `grid::grid.draw()` - render to device
4. Return ggplot object invisibly

## The Build Step

### Data Preparation

**Layer data sources:**
1. Layer's own data argument
2. Inherit from ggplot() global data
3. Function applied to global data

**Added columns:**
- `PANEL` - links rows to facet panels
- `group` - for grouping within panels

### Data Transformation Pipeline

**Step 1: Scale transformations**
- Apply `trans` argument
- Happens before statistics

**Step 2: Position scale mapping**
- Continuous: apply `oob` function, remove NA
- Discrete: map to integer positions
- Binned: cut into bins at midpoints

**Step 3: Statistical transformation**
- Split by `PANEL` and `group`
- Calculate statistics
- Reassemble data

**Step 4: Delayed aesthetic mapping**
- `stat()` or `..var..` expressions evaluated
- Computed variables added to data

**Step 5: Position adjustment**
- Apply dodge, jitter, stack, etc.

**Step 6: Scale retraining**
- Position scales reset and reapplied
- Accounts for changes from stats/position

**Step 7: Non-position aesthetics**
- Train and map colour, size, etc.
- Add geom defaults

### Build Output

Returns `ggplot_built` class object containing:
- Computed data for all layers
- `Layout` object (coordinate system, facets)
- Copy of original plot with trained scales

## The GTable Step

### Rendering Panels

**Process:**
1. Convert layers to grobs
   - Split by `PANEL` and `group`
   - Coordinate system transforms positions
2. Facet assembles panels
   - Collect grobs from layers
   - Add strips, backgrounds, gridlines, axes
   - Arrange into gtable

### Adding Guides

**Legend creation:**
1. Train guide for each scale
2. Merge guides where possible
3. Collect key grobs from layers
4. Assemble into legend gtable
5. Add to main gtable

### Final Output

**gtable object:**
```r
p_built <- ggplot_build(p)
p_gtable <- ggplot_gtable(p_built)
class(p_gtable)  # "gtable", "gTree", "grob"
```

**Structure:**
- Table with rows and columns
- Named grobs (panel-1, axis-b-1, strip-t-1, etc.)
- Z-order for layering

## ggproto System

**ggplot2's OOP system:**
- Reference semantics
- Inheritance support
- Used by all ggplot2 components

### Creating Classes

```r
Person <- ggproto("Person", NULL,
  # Fields
  given_name = NA,
  family_name = NA,
  
  # Methods
  full_name = function(self) {
    paste(self$given_name, self$family_name)
  }
)
```

### Creating Instances

```r
Thomas <- ggproto(NULL, Person,
  given_name = "Thomas",
  family_name = "Pedersen"
)

Thomas$full_name()  # "Thomas Pedersen"
```

### Inheritance

```r
Royalty <- ggproto("Royalty", Person,
  rank = NA,
  territory = NA,
  
  full_name = function(self) {
    paste(self$rank, self$given_name, "of", self$territory)
  }
)

Victoria <- ggproto(NULL, Royalty,
  given_name = "Victoria",
  rank = "Queen",
  territory = "the United Kingdom"
)

Victoria$full_name()  # "Queen Victoria of the United Kingdom"
```

### Parent Access

```r
description <- function(self) {
  paste(
    self$rank,
    ggproto_parent(Person, self)$description()
  )
}
```

## ggproto Style Guide

**Key principles:**

1. **Stateless objects** - Never modify after creation
2. **Selective use** - Only extend existing classes
3. **Simple inheritance** - Direct method calls often preferred

**Common pattern:**
```r
GeomErrorbar <- ggproto(
  "GeomErrorbar", Geom,
  setup_params = function(data, params) {
    GeomLinerange$setup_params(data, params)  # Reuse parent's method
  }
)
```

## Key ggproto Classes

| Class | Purpose |
|-------|---------|
| `Stat` | Statistical transformations |
| `Geom` | Geometric objects |
| `Scale` | Data to aesthetic mapping |
| `Coord` | Coordinate systems |
| `Facet` | Faceting specifications |
| `Position` | Position adjustments |
| `Theme` | Visual defaults |

## Debugging Tips

**Inspect built data:**
```r
p_build <- ggplot_build(p)
p_build$data[[1]]  # First layer's data
```

**Inspect gtable:**
```r
p_gtable <- ggplot_gtable(ggplot_build(p))
p_gtable$layout  # See structure
```

**Print ggproto methods:**
```r
GeomPoint$draw_panel
StatSmooth$compute_group
```
