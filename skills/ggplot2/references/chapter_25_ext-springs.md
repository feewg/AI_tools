# Case Study: Creating a Spring Geom

This chapter demonstrates the complete development of a custom ggplot2 extension - a spring geom that draws springs between two points.

## Part 1: Creating a Stat

### Step 1: Helper Function

```r
create_spring <- function(x, y, xend, yend, 
                          diameter = 1, tension = 0.75, n = 50) {
  # Input validation
  if (tension <= 0) rlang::abort("`tension` must be > 0")
  if (diameter == 0) rlang::abort("`diameter` cannot be 0")
  if (n <= 0) rlang::abort("`n` must be > 0")
  
  # Calculate spring path
  length <- sqrt((x - xend)^2 + (y - yend)^2)
  n_revolutions <- length / (diameter * tension)
  n_points <- n * n_revolutions
  
  radians <- seq(0, n_revolutions * 2 * pi, length.out = n_points)
  x_seq <- seq(x, xend, length.out = n_points)
  y_seq <- seq(y, yend, length.out = n_points)
  
  data.frame(
    x = cos(radians) * diameter/2 + x_seq,
    y = sin(radians) * diameter/2 + y_seq
  )
}
```

### Step 2: Stat ggproto

```r
StatSpring <- ggproto("StatSpring", Stat,
  setup_data = function(data, params) {
    if (anyDuplicated(data$group)) {
      data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
    }
    data
  },
  
  compute_panel = function(data, scales, diameter = 1, tension = 0.75, n = 50) {
    cols_to_keep <- setdiff(names(data), c("x", "y", "xend", "yend"))
    springs <- lapply(seq_len(nrow(data)), function(i) {
      spring_path <- create_spring(
        data$x[i], data$y[i], data$xend[i], data$yend[i],
        diameter = diameter, tension = tension, n = n
      )
      cbind(spring_path, unclass(data[i, cols_to_keep]))
    })
    do.call(rbind, springs)
  },
  
  required_aes = c("x", "y", "xend", "yend")
)
```

### Step 3: Constructor Function

```r
geom_spring <- function(mapping = NULL, data = NULL, 
                        stat = "spring", position = "identity",
                        ..., diameter = 1, tension = 0.75, n = 50,
                        arrow = NULL, lineend = "butt", 
                        linejoin = "round", na.rm = FALSE,
                        show.legend = NA, inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPath,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      diameter = diameter,
      tension = tension,
      n = n,
      arrow = arrow,
      lineend = lineend,
      linejoin = linejoin,
      na.rm = na.rm,
      ...
    )
  )
}
```

## Part 2: Making diameter and tension Aesthetics

**Problem:** Parameters are constant per layer

**Solution:** Move to data columns (aesthetics)

```r
StatSpring <- ggproto("StatSpring", Stat,
  setup_data = function(data, params) {
    if (anyDuplicated(data$group)) {
      data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
    }
    data
  },
  
  compute_panel = function(data, scales, n = 50) {
    cols_to_keep <- setdiff(names(data), c("x", "y", "xend", "yend"))
    springs <- lapply(seq_len(nrow(data)), function(i) {
      spring_path <- create_spring(
        data$x[i], data$y[i], data$xend[i], data$yend[i],
        data$diameter[i], data$tension[i], n
      )
      cbind(spring_path, unclass(data[i, cols_to_keep]))
    })
    do.call(rbind, springs)
  },
  
  required_aes = c("x", "y", "xend", "yend"),
  optional_aes = c("diameter", "tension")
)
```

## Part 3: Creating a Proper Geom

**Problem:** Coordinates affect spring shape

**Solution:** Create custom Geom that draws with grid

```r
GeomSpring <- ggproto("GeomSpring", Geom,
  setup_data = function(data, params) {
    if (is.null(data$group)) data$group <- seq_len(nrow(data))
    if (anyDuplicated(data$group)) {
      data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
    }
    data
  },
  
  draw_panel = function(data, panel_params, coord, n = 50,
                        lineend = "butt", na.rm = FALSE) {
    data <- remove_missing(data, na.rm, 
                          c("x", "y", "xend", "yend", "linetype"),
                          name = "geom_spring")
    if (is.null(data) || nrow(data) == 0) return(zeroGrob())
    
    if (!coord$is_linear()) {
      rlang::warn("spring geom only works correctly on linear coords")
    }
    coord <- coord$transform(data, panel_params)
    
    springGrob(
      coord$x, coord$y, coord$xend, coord$yend,
      default.units = "native",
      diameter = unit(coord$diameter, "cm"),
      tension = coord$tension,
      n = n,
      gp = gpar(
        col = alpha(coord$colour, coord$alpha),
        lwd = coord$linewidth * .pt,
        lty = coord$linetype,
        lineend = lineend
      )
    )
  },
  
  required_aes = c("x", "y", "xend", "yend"),
  default_aes = aes(
    colour = "black",
    linewidth = 0.5,
    linetype = 1L,
    alpha = NA,
    diameter = 0.35,
    tension = 0.75
  )
)
```

## Part 4: Grid Grob

### Spring Grob Constructor

```r
springGrob <- function(x0 = unit(0, "npc"), y0 = unit(0, "npc"),
                       x1 = unit(1, "npc"), y1 = unit(1, "npc"),
                       diameter = unit(0.1, "npc"), tension = 0.75,
                       n = 50, default.units = "npc",
                       name = NULL, gp = gpar(), vp = NULL) {
  if (!is.unit(x0)) x0 <- unit(x0, default.units)
  if (!is.unit(x1)) x1 <- unit(x1, default.units)
  if (!is.unit(y0)) y0 <- unit(y0, default.units)
  if (!is.unit(y1)) y1 <- unit(y1, default.units)
  if (!is.unit(diameter)) diameter <- unit(diameter, default.units)
  
  gTree(
    x0 = x0, y0 = y0, x1 = x1, y1 = y1,
    diameter = diameter, tension = tension, n = n,
    name = name, gp = gp, vp = vp, cl = "spring"
  )
}
```

### Make Content Method

```r
makeContent.spring <- function(x) {
  # Convert to absolute units (mm)
  x0 <- convertX(x$x0, "mm", valueOnly = TRUE)
  x1 <- convertX(x$x1, "mm", valueOnly = TRUE)
  y0 <- convertY(x$y0, "mm", valueOnly = TRUE)
  y1 <- convertY(x$y1, "mm", valueOnly = TRUE)
  diameter <- convertWidth(x$diameter, "mm", valueOnly = TRUE)
  
  # Create spring paths
  springs <- lapply(seq_along(x0), function(i) {
    cbind(
      create_spring(x0[i], y0[i], x1[i], y1[i], 
                    diameter[i], x$tension[i], x$n),
      id = i
    )
  })
  springs <- do.call(rbind, springs)
  
  # Create polyline grob
  spring_paths <- polylineGrob(
    x = springs$x,
    y = springs$y,
    id = springs$id,
    default.units = "mm",
    gp = x$gp
  )
  
  setChildren(x, gList(spring_paths))
}
```

## Part 5: Scales

### Tension Scale

```r
scale_tension_continuous <- function(..., range = c(0.1, 1)) {
  continuous_scale(
    aesthetics = "tension",
    scale_name = "tension_c",
    palette = scales::rescale_pal(range),
    ...
  )
}

scale_tension <- scale_tension_continuous

scale_tension_discrete <- function(...) {
  rlang::abort("Tension cannot be used with discrete data")
}
```

### Diameter Scale

```r
scale_diameter_continuous <- function(..., range = c(0.25, 0.7), 
                                      unit = "cm") {
  range <- grid::convertWidth(unit(range, unit), "cm", valueOnly = TRUE)
  continuous_scale(
    aesthetics = "diameter",
    scale_name = "diameter_c",
    palette = scales::rescale_pal(range),
    ...
  )
}

scale_diameter <- scale_diameter_continuous
```

### Custom Legend Key

```r
draw_key_spring <- function(data, params, size) {
  springGrob(
    x0 = 0, y0 = 0, x1 = 1, y1 = 1,
    diameter = unit(data$diameter, "cm"),
    tension = data$tension,
    gp = gpar(
      col = alpha(data$colour %||% "black", data$alpha),
      lwd = (data$size %||% 0.5) * .pt,
      lty = data$linetype %||% 1
    ),
    vp = viewport(clip = "on")
  )
}

# Attach to geom
GeomSpring$draw_key <- draw_key_spring
```

## Key Lessons

1. **Start simple** - Begin with a stat, upgrade to geom later
2. **Use grid** - For absolute sizing independent of coordinates
3. **Handle units** - Convert between data and absolute units
4. **Preserve aesthetics** - Pass non-position aesthetics through
5. **Test thoroughly** - Check with faceting, scaling, resizing
6. **Provide scales** - Custom aesthetics need custom scales
7. **Create legend keys** - Match key style to geom appearance
