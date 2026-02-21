# Programming with ggplot2

## Single Components

**Save and reuse components:**
```r
bestfit <- geom_smooth(
  method = "lm", 
  se = FALSE, 
  colour = alpha("steelblue", 0.5),
  linewidth = 2
)

ggplot(mpg, aes(cty, hwy)) + geom_point() + bestfit
ggplot(mpg, aes(displ, hwy)) + geom_point() + bestfit
```

**Function wrappers:**
```r
geom_lm <- function(formula = y ~ x, colour = alpha("steelblue", 0.5), 
                    linewidth = 2, ...) {
  geom_smooth(formula = formula, se = FALSE, method = "lm", 
              colour = colour, linewidth = linewidth, ...)
}
```

**Key principle:** Always include `...` to pass additional arguments.

## Multiple Components

**Return list of components:**
```r
geom_mean <- function() {
  list(
    stat_summary(fun = "mean", geom = "bar", fill = "grey70"),
    stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", width = 0.4)
  )
}

ggplot(mpg, aes(class, cty)) + geom_mean()
```

**Conditional components:**
```r
geom_mean <- function(se = TRUE) {
  list(
    stat_summary(fun = "mean", geom = "bar", fill = "grey70"),
    if (se) stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", width = 0.4)
  )
}
```

## Component Types in Lists

Valid list contents:
- Data frames (override layer data)
- `aes()` objects (combine with default)
- Scales
- Coordinate systems
- Faceting specifications
- Theme components

## Annotations

**Self-contained layers:**
```r
borders <- function(database = "world", regions = ".", fill = NA, 
                    colour = "grey50", ...) {
  df <- map_data(database, regions)
  geom_polygon(
    aes_(~long, ~lat, group = ~group), 
    data = df, fill = fill, colour = colour, ..., 
    inherit.aes = FALSE, show.legend = FALSE
  )
}
```

**Critical arguments:**
- `inherit.aes = FALSE` - Don't inherit aesthetics
- `show.legend = FALSE` - Don't show in legend

## Plot Functions

**Complete plot functions:**
```r
piechart <- function(data, mapping) {
  ggplot(data, mapping) +
    geom_bar(width = 1) + 
    coord_polar(theta = "y") + 
    xlab(NULL) + 
    ylab(NULL)
}

piechart(mpg, aes(factor(1), fill = class))
```

**Return plot object** (not print) to allow further modification.

## Tidy Evaluation

**The problem:**
```r
my_function <- function(x_var) {
  aes(x = x_var)  # Maps to "x_var", not the variable value
}
```

**The solution (embracing):**
```r
my_function <- function(x_var) {
  aes(x = {{ x_var }})  # Uses the variable value
}

my_function(displ)  # Maps to "displ"
```

**Applied to piechart:**
```r
piechart <- function(data, var) {
  ggplot(data, aes(factor(1), fill = {{ var }})) +
    geom_bar(width = 1) + 
    coord_polar(theta = "y") + 
    xlab(NULL) + 
    ylab(NULL)
}

mpg |> piechart(class)
```

## Functional Programming

**Plots in lists:**
```r
geoms <- list(
  geom_point(),
  geom_boxplot(aes(group = cut_width(displ, 1))),
  list(geom_point(), geom_smooth())
)

p <- ggplot(mpg, aes(displ, hwy))
lapply(geoms, function(g) p + g)
```

**Modify list of plots:**
```r
plots <- list(
  ggplot(mpg, aes(displ, hwy)),
  ggplot(diamonds, aes(carat, price)),
  ggplot(faithfuld, aes(waiting, eruptions, size = density))
)

# Add geom_point to each
lapply(plots, function(p) p + geom_point())
```

## Best Practices

**Function naming:**
- Match ggplot2 conventions
- Use `geom_*()`, `stat_*()` prefixes for layers
- Include `...` for flexibility

**Argument order:**
- `mapping` first
- `data` second
- Parameters with defaults
- `...` last

**Documentation:**
- Document all parameters
- Provide examples
- Export user-facing functions
