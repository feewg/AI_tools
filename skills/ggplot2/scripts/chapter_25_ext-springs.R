# 21A case study
# Chapter 25

# Example 1
circle <- tibble(
  radians = seq(0, 2 * pi, length.out = 100),
  x = cos(radians),
  y = sin(radians),
  index = 1:100,
  type = "circle"
)

ggplot(circle, aes(x = x, y = y, alpha = -index)) + 
  geom_path(show.legend = FALSE) + 
  coord_equal()

# Example 2
spring <- circle %>% 
  mutate(
    motion = seq(0, 1, length.out = 100),
    x = x + motion,
    type = "spring"
  )

ggplot(spring, aes(x = x, y = y, alpha = -index)) + 
  geom_path(show.legend = FALSE) + 
  coord_equal()

# Example 3
create_spring <- function(x, 
                          y, 
                          xend, 
                          yend, 
                          diameter = 1, 
                          tension = 0.75, 
                          n = 50) {
  
  # Validate the input arguments
  if (tension <= 0) {
    rlang::abort("`tension` must be larger than zero.")
  }
  if (diameter == 0) {
    rlang::abort("`diameter` can not be zero.")
  }
  if (n == 0) {
    rlang::abort("`n` must be greater than zero.")
  }
  
  # Calculate the direct length of the spring path
  length <- sqrt((x - xend)^2 + (y - yend)^2)
  
  # Calculate the number of revolutions and points we need
  n_revolutions <- length / (diameter * tension)
  n_points <- n * n_revolutions
  
  # Calculate the sequence of radians and the x and y offset values
  radians <- seq(0, n_revolutions * 2 * pi, length.out = n_points)
  x <- seq(x, xend, length.out = n_points)
  y <- seq(y, yend, length.out = n_points)
  
  # Create and return the transformed data frame
  data.frame(
    x = cos(radians) * diameter/2 + x,
    y = sin(radians) * diameter/2 + y
  )
}

# Example 4
spring <- create_spring(
  x = 4, y = 2, xend = 10, yend = 6,
  diameter = 2, tension = 0.6, n = 50
)

ggplot(spring) + 
  geom_path(aes(x = x, y = y)) + 
  coord_equal()

# Example 5
StatSpring <- ggproto("StatSpring", Stat)

# Example 6
StatSpring <- ggproto("StatSpring", Stat, 
  
  # Edit the input data to ensure the group identifiers are unique
  setup_data = function(data, params) {
    if (anyDuplicated(data$group)) {
      data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
    }
    data
  },
  
  # Construct data for this panel by calling create_spring()
  compute_panel = function(data, 
                           scales, 
                           diameter = 1, 
                           tension = 0.75, 
                           n = 50) {
    cols_to_keep <- setdiff(names(data), c("x", "y", "xend", "yend"))
    springs <- lapply(
      seq_len(nrow(data)), 
      function(i) {
        spring_path <- create_spring(
          data$x[i], 
          data$y[i], 
          data$xend[i], 
          data$yend[i], 
          diameter = diameter, 
          tension = tension, 
          n = n
        )
        cbind(spring_path, unclass(data[i, cols_to_keep]))
      }
    )
    do.call(rbind, springs)
  },
  
  # Specify which aesthetics are required input
  required_aes = c("x", "y", "xend", "yend")
)

# Example 7
function(data, scales, diameter = 1, tension = 0.75, n = 50) {
  cols_to_keep <- setdiff(names(data), c("x", "y", "xend", "yend"))
  springs <- lapply(
    seq_len(nrow(data)), 
    function(i) {
      spring_path <- create_spring(
        data$x[i], 
        data$y[i], 
        data$xend[i], 
        data$yend[i], 
        diameter = diameter, 
        tension = tension, 
        n = n
      )
      cbind(spring_path, unclass(data[i, cols_to_keep]))
    }
  )
  do.call(rbind, springs)
}

# Example 8
function(data, params) {
  if (anyDuplicated(data$group)) {
    data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
  }
  data
}

# Example 9
geom_spring <- function(mapping = NULL,
                        data = NULL, 
                        stat = "spring",
                        position = "identity", 
                        ..., 
                        diameter = 1, 
                        tension = 0.75,
                        n = 50, 
                        arrow = NULL, 
                        lineend = "butt", 
                        linejoin = "round",
                        na.rm = FALSE, 
                        show.legend = NA, 
                        inherit.aes = TRUE
                        ) {
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

# Example 10
stat_spring <- function(mapping = NULL, 
                        data = NULL, 
                        geom = "path", 
                        position = "identity", 
                        ..., 
                        diameter = 1, 
                        tension = 0.75, 
                        n = 50, 
                        na.rm = FALSE, 
                        show.legend = NA, 
                        inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    stat = StatSpring, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(
      diameter = diameter, 
      tension = tension, 
      n = n, 
      na.rm = na.rm, 
      ...
    )
  )
}

# Example 11
df <- tibble(
  x = runif(5, max = 10),
  y = runif(5, max = 10),
  xend = runif(5, max = 10),
  yend = runif(5, max = 10),
  class = sample(letters[1:2], 5, replace = TRUE)
)

ggplot(df) + 
  geom_spring(aes(x = x, y = y, xend = xend, yend = yend)) +
  coord_equal()

# Example 12
ggplot(df) + 
  geom_spring(
    aes(x, y, xend = xend, yend = yend, colour = class),
    linewidth = 1
  ) +
  coord_equal() + 
  facet_wrap(~ class)

# Example 13
ggplot(df) + 
  stat_spring(
    aes(x, y, xend = xend, yend = yend, colour = class),
    geom = "point", 
    n = 15
  ) +
  coord_equal() + 
  facet_wrap(~ class)

# Example 14
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
        data$x[i], 
        data$y[i], 
        data$xend[i], 
        data$yend[i], 
        data$diameter[i],
        data$tension[i], 
        n
      )
      cbind(spring_path, unclass(data[i, cols_to_keep]))
    })
    do.call(rbind, springs)
  },
  
  required_aes = c("x", "y", "xend", "yend"),
  optional_aes = c("diameter", "tension")
)

# Example 15
geom_spring <- function(mapping = NULL, 
                        data = NULL, 
                        stat = "spring", 
                        position = "identity", 
                        ..., 
                        n = 50, 
                        arrow = NULL, 
                        lineend = "butt", 
                        linejoin = "round", 
                        na.rm = FALSE,
                        show.legend = NA, 
                        inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    stat = stat, 
    geom = GeomPath, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(
      n = n, 
      arrow = arrow, 
      lineend = lineend, 
      linejoin = linejoin, 
      na.rm = na.rm, 
      ...
    )
  )
}

# Example 16
df <- tibble(
  x = runif(5, max = 10),
  y = runif(5, max = 10),
  xend = runif(5, max = 10),
  yend = runif(5, max = 10),
  class = sample(letters[1:2], 5, replace = TRUE),
  tension = runif(5),
  diameter = runif(5, 0.5, 1.5)
)

ggplot(df, aes(x, y, xend = xend, yend = yend)) + 
  geom_spring(aes(tension = tension, diameter = diameter))

# Example 17
ggplot(df, aes(x, y, xend = xend, yend = yend)) + 
  geom_spring(diameter = 0.5)
#> Warning in geom_spring(diameter = 0.5): Ignoring unknown parameters: `diameter`
#> Warning: Computation failed in `stat_spring()`.
#> Caused by error in `if (tension <= 0) ...`:
#> ! argument is of length zero

# Example 18
GeomSpring <- ggproto("GeomSpring", Geom,
  
  # Ensure that each row has a unique group id
  setup_data = function(data, params) {
    if (is.null(data$group)) {
      data$group <- seq_len(nrow(data))
    }
    if (anyDuplicated(data$group)) {
      data$group <- paste(data$group, seq_len(nrow(data)), sep = "-")
    }
    data
  },
  
  # Transform the data inside the draw_panel() method
  draw_panel = function(data, 
                        panel_params, 
                        coord, 
                        n = 50, 
                        arrow = NULL,
                        lineend = "butt", 
                        linejoin = "round", 
                        linemitre = 10,
                        na.rm = FALSE) {
    
    # Transform the input data to specify the spring paths
    cols_to_keep <- setdiff(names(data), c("x", "y", "xend", "yend"))
    springs <- lapply(seq_len(nrow(data)), function(i) {
      spring_path <- create_spring(
        data$x[i], 
        data$y[i], 
        data$xend[i], 
        data$yend[i], 
        data$diameter[i],
        data$tension[i], 
        n
      )
      cbind(spring_path, unclass(data[i, cols_to_keep]))
    })
    springs <- do.call(rbind, springs)
    
    # Use the draw_panel() method from GeomPath to do the drawing
    GeomPath$draw_panel(
      data = springs, 
      panel_params = panel_params, 
      coord = coord, 
      arrow = arrow, 
      lineend = lineend, 
      linejoin = linejoin, 
      linemitre = linemitre, 
      na.rm = na.rm
    )
  },
  
  # Specify the default and required aesthetics
  required_aes = c("x", "y", "xend", "yend"),
  default_aes = aes(
    colour = "black", 
    linewidth = 0.5, 
    linetype = 1L, 
    alpha = NA, 
    diameter = 1, 
    tension = 0.75
  )
)

# Example 19
geom_spring <- function(mapping = NULL, 
                        data = NULL, 
                        stat = "identity", 
                        position = "identity", 
                        ..., 
                        n = 50, 
                        arrow = NULL, 
                        lineend = "butt", 
                        linejoin = "round", 
                        na.rm = FALSE,
                        show.legend = NA, 
                        inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    stat = stat, 
    geom = GeomSpring, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(
      n = n, 
      arrow = arrow, 
      lineend = lineend, 
      linejoin = linejoin, 
      na.rm = na.rm, 
      ...
    )
  )
}

# Example 20
ggplot(df, aes(x, y, xend = xend, yend = yend)) + 
  geom_spring(aes(tension = tension, diameter = diameter))
ggplot(df, aes(x, y, xend = xend, yend = yend)) + 
  geom_spring(diameter = 0.5)

# Example 21
ggplot() + 
  geom_spring(aes(x = 0, y = 0, xend = 3, yend = 20))

# Example 22
ggplot() + 
  geom_spring(aes(x = 0, y = 0, xend = 100, yend = 80))

# Example 23
library(grid)
circles <- circleGrob(
  x = c(0.1, 0.4, 0.7), 
  y = c(0.5, 0.3, 0.6),
  r = c(0.1, 0.2, 0.3)
)
circles
#> circle[GRID.circle.586]

# Example 24
labels <- textGrob(
  label = c("small", "medium", "large"),
  x = c(0.1, 0.4, 0.7), 
  y = c(0.5, 0.3, 0.6),
)

composite <- grobTree(circles, labels)
grid.newpage()
grid.draw(composite)

# Example 25
vp_default <- viewport()
vp_rotated <- viewport(angle = 15)

# Example 26
composite_default <- grobTree(circles, labels, vp = vp_default)
composite_rotated <- grobTree(circles, labels, vp = vp_rotated)

# Example 27
gp_blue <- gpar(col = "blue", fill = NA)
gp_orange <- gpar(col = "orange", fill = NA)

# Example 28
grob1 <- grobTree(circles, labels, vp = vp_default, gp = gp_blue)
grob2 <- grobTree(circles, labels, vp = vp_rotated, gp = gp_orange)

# Example 29
surpriseGrob <- function(x, 
                         y, 
                         size, 
                         default.units = "npc", 
                         name = NULL, 
                         gp = gpar(), 
                         vp = NULL) {
  
  # Ensure that input arguments are units
  if (!is.unit(x)) x <- unit(x, default.units)
  if (!is.unit(y)) y <- unit(y, default.units)
  if (!is.unit(size)) size <- unit(size, default.units)
  
  # Construct the surprise grob subclass as a gTree
  gTree(
    x = x, 
    y = y, 
    size = size, 
    name = name, 
    gp = gp, 
    vp = vp, 
    cl = "surprise"
  )
}

# Example 30
makeContent.surprise <- function(x) {
  x_pos <- x$x
  y_pos <- x$y
  size <- convertWidth(x$size, unitTo = "cm", valueOnly = TRUE)
  
  # Figure out if the given sizes are bigger or smaller than 3 cm
  circles <- size < 3
  
  # Create a circle grob for the small ones
  if (any(circles)) {
    circle_grob <- circleGrob(
      x = x_pos[circles], 
      y = y_pos[circles], 
      r = unit(size[circles] / 2, "cm")
    )
  } else {
    circle_grob <- NULL
  }
  
  # Create a rect grob for the large ones
  if (any(!circles)) {
    square_grob <- rectGrob(
      x = x_pos[!circles], 
      y = y_pos[!circles], 
      width = unit(size[!circles], "cm"),
      height = unit(size[!circles], "cm")
    )
  } else {
    square_grob <- NULL
  }
  
  # Add the circle and rect grob as children of our input grob
  setChildren(x, gList(circle_grob, square_grob))
}

# Example 31
surprises <- surpriseGrob(
  x = c(0.25, 0.45, 0.75), 
  y = c(0.5, 0.5, 0.5), 
  size = c(0.05, 0.15, 0.25)
)

# Example 32
p <- ggplot(mpg, aes(displ, hwy)) + geom_point()
grob_table <- ggplotGrob(p)
grob_table
#> TableGrob (16 x 13) "layout": 22 grobs
#>     z         cells             name
#> 1   0 ( 1-16, 1-13)       background
#> 2   5 ( 8- 8, 6- 6)           spacer
#> 3   7 ( 9- 9, 6- 6)           axis-l
#> 4   3 (10-10, 6- 6)           spacer
#> 5   6 ( 8- 8, 7- 7)           axis-t
#> 6   1 ( 9- 9, 7- 7)            panel
#> 7   9 (10-10, 7- 7)           axis-b
#> 8   4 ( 8- 8, 8- 8)           spacer
#> 9   8 ( 9- 9, 8- 8)           axis-r
#> 10  2 (10-10, 8- 8)           spacer
#> 11 10 ( 7- 7, 7- 7)           xlab-t
#> 12 11 (11-11, 7- 7)           xlab-b
#> 13 12 ( 9- 9, 5- 5)           ylab-l
#> 14 13 ( 9- 9, 9- 9)           ylab-r
#> 15 14 ( 9- 9,11-11)  guide-box-right
#> 16 15 ( 9- 9, 3- 3)   guide-box-left
#> 17 16 (13-13, 7- 7) guide-box-bottom
#> 18 17 ( 5- 5, 7- 7)    guide-box-top
#> 19 18 ( 9- 9, 7- 7) guide-box-inside
#> 20 19 ( 4- 4, 7- 7)         subtitle
#> 21 20 ( 3- 3, 7- 7)            title
#> 22 21 (14-14, 7- 7)          caption
#>                                             grob
#> 1                rect[plot.background..rect.633]
#> 2                                 zeroGrob[NULL]
#> 3            absoluteGrob[GRID.absoluteGrob.622]
#> 4                                 zeroGrob[NULL]
#> 5                                 zeroGrob[NULL]
#> 6                       gTree[panel-1.gTree.614]
#> 7            absoluteGrob[GRID.absoluteGrob.618]
#> 8                                 zeroGrob[NULL]
#> 9                                 zeroGrob[NULL]
#> 10                                zeroGrob[NULL]
#> 11                                zeroGrob[NULL]
#> 12 titleGrob[axis.title.x.bottom..titleGrob.625]
#> 13   titleGrob[axis.title.y.left..titleGrob.628]
#> 14                                zeroGrob[NULL]
#> 15                                zeroGrob[NULL]
#> 16                                zeroGrob[NULL]
#> 17                                zeroGrob[NULL]
#> 18                                zeroGrob[NULL]
#> 19                                zeroGrob[NULL]
#> 20         zeroGrob[plot.subtitle..zeroGrob.630]
#> 21            zeroGrob[plot.title..zeroGrob.629]
#> 22          zeroGrob[plot.caption..zeroGrob.631]

# Example 33
xtick <- 0:8
ytick <- seq(0, 50, 10)

points <- pointsGrob(
  x = mpg$displ / xtick[length(xtick)],
  y = mpg$hwy / ytick[length(ytick)],
  default.units = 'npc',
  size = unit(6, 'pt')
)

xaxis <- xaxisGrob(
  at = seq(0, 1, length.out = length(xtick)), 
  label = xtick
)

yaxis <- yaxisGrob(
  at = seq(0, 1, length.out = length(ytick)), 
  label = ytick
)

# Example 34
library(gtable)

plot_layout <- gtable(
  widths = unit(c(1.5, 0, 1, 0.5), c('cm', 'cm', 'null', 'cm')),
  heights = unit(c(0.5, 1, 0, 1.5), c('cm', 'null', 'cm', 'cm'))
)

# Example 35
plot_layout <- gtable_add_grob(
  plot_layout,
  grobs = list(points, xaxis, yaxis),
  t = c(2, 3, 2), # the row defining the top extent of each grob
  l = c(3, 3, 2), # the column defining the left extent of each grob
  clip = 'off'
)

# Example 36
springGrob <- function(x0 = unit(0, "npc"), 
                       y0 = unit(0, "npc"), 
                       x1 = unit(1, "npc"), 
                       y1 = unit(1, "npc"), 
                       diameter = unit(0.1, "npc"), 
                       tension = 0.75,
                       n = 50, 
                       default.units = "npc", 
                       name = NULL, 
                       gp = gpar(), 
                       vp = NULL) {
  
  # Use the default unit if the user does not specify one
  if (!is.unit(x0)) x0 <- unit(x0, default.units)
  if (!is.unit(x1)) x1 <- unit(x1, default.units)
  if (!is.unit(y0)) y0 <- unit(y0, default.units)
  if (!is.unit(y1)) y1 <- unit(y1, default.units)
  if (!is.unit(diameter)) diameter <- unit(diameter, default.units)
  
  # Return a gTree of class "spring"
  gTree(
    x0 = x0, 
    y0 = y0, 
    x1 = x1, 
    y1 = y1, 
    diameter = diameter, 
    tension = tension, 
    n = n, 
    name = name, 
    gp = gp, 
    vp = vp, 
    cl = "spring"
  )
}

# Example 37
makeContent.spring <- function(x) {
  
  # Convert position and diameter values absolute units
  x0 <- convertX(x$x0, "mm", valueOnly = TRUE)
  x1 <- convertX(x$x1, "mm", valueOnly = TRUE)
  y0 <- convertY(x$y0, "mm", valueOnly = TRUE)
  y1 <- convertY(x$y1, "mm", valueOnly = TRUE)
  diameter <- convertWidth(x$diameter, "mm", valueOnly = TRUE)
  
  # Leave tension and n untouched
  tension <- x$tension
  n <- x$n
  
  # Transform the input data to a data frame containing spring paths
  springs <- lapply(seq_along(x0), function(i) {
    cbind(
      create_spring(
        x = x0[i], 
        y = y0[i], 
        xend = x1[i], 
        yend = y1[i], 
        diameter = diameter[i], 
        tension = tension[i], 
        n = n
      ),
      id = i
    )
  })
  springs <- do.call(rbind, springs)
  
  # Construct the grob
  spring_paths <- polylineGrob(
    x = springs$x, 
    y = springs$y, 
    id = springs$id, 
    default.units = "mm", 
    gp = x$gp
  )
  setChildren(x, gList(spring_paths))
}

# Example 38
springs <- springGrob(
  x0 = c(0, 0),
  y0 = c(0, 0.5),
  x1 = c(1, 1),
  y1 = c(1, 0.5),
  diameter = unit(c(1, 3), "cm"),
  tension = c(0.2, 0.7)
)
grid.newpage()
grid.draw(springs)

# Example 39
GeomSpring <- ggproto("GeomSpring", Geom,
  
  # Check that the user has specified sensible parameters                    
  setup_params = function(data, params) {
    if (is.null(params$n)) {
      params$n <- 50
    } else if (params$n <= 0) {
      rlang::abort("Springs must be defined with `n` greater than 0")
    }
    params
  },
  
  # Check input data and return grobs
  draw_panel = function(data, 
                        panel_params, 
                        coord, 
                        n = 50, 
                        lineend = "butt", 
                        na.rm = FALSE) {
    
    # Remove missing data, returning early if all are missing
    data <- remove_missing(
      df = data, 
      na.rm = na.rm,
      vars = c("x", "y", "xend", "yend", "linetype", "linewidth"),
      name = "geom_spring"
    )
    if (is.null(data) || nrow(data) == 0) return(zeroGrob())
    
    # Supply the coordinate system for the plot
    if (!coord$is_linear()) {
      rlang::warn(
        "spring geom only works correctly on linear coordinate systems"
      )
    }
    coord <- coord$transform(data, panel_params)
    
    # Construct the grob
    springGrob(
      coord$x, 
      coord$y, 
      coord$xend, 
      coord$yend,
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
  
  # Specify the default and required aesthetics
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

# Example 40
geom_spring <- function(mapping = NULL, 
                        data = NULL, 
                        stat = "identity", 
                        position = "identity", 
                        ..., 
                        n = 50, 
                        lineend = "butt", 
                        na.rm = FALSE, 
                        show.legend = NA, 
                        inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    stat = stat, 
    geom = GeomSpring, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(
      n = n, 
      lineend = lineend, 
      na.rm = na.rm, 
      ...
    )
  )
}

# Example 41
ggplot(df) + 
  geom_spring(aes(
    x = x * 100, 
    y = y, 
    xend = xend, 
    yend = yend, 
    diameter = diameter, 
    tension = tension
  ))

# Example 42
scale_tension_continuous <- function(..., range = c(0.1, 1)) {
  continuous_scale(
    aesthetics = "tension", 
    scale_name = "tension_c", 
    palette = scales::rescale_pal(range), 
    ...
  )
}

# Example 43
scale_tension <- scale_tension_continuous

# Example 44
scale_tension_discrete <- function(...) {
  rlang::abort("Tension cannot be used with discrete data")
}

# Example 45
scale_diameter_continuous <- function(..., 
                                      range = c(0.25, 0.7), 
                                      unit = "cm") {
  range <- grid::convertWidth(
    unit(range, unit), 
    "cm", 
    valueOnly = TRUE
  )
  continuous_scale(
    aesthetics = "diameter", 
    scale_name = "diameter_c", 
    palette = scales::rescale_pal(range), 
    ...
  )
}
scale_diameter <- scale_diameter_continuous
scale_tension_discrete <- function(...) {
  rlang::abort("Diameter cannot be used with discrete data")
}

# Example 46
ggplot(df) + 
  geom_spring(aes(
    x = x, 
    y = y, 
    xend = xend, 
    yend = yend, 
    tension = tension, 
    diameter = diameter
  )) + 
  scale_tension(range = c(0.1, 5)) 
#> Warning: The `scale_name` argument of `continuous_scale()` is deprecated as of ggplot2
#> 3.5.0.

# Example 47
draw_key_point
#> function (data, params, size) 
#> {
#>     data$shape <- translate_shape_string(data$shape %||% 19)
#>     pointsGrob(0.5, 0.5, pch = data$shape, gp = gg_par(col = alpha(data$colour %||% 
#>         "black", data$alpha), fill = fill_alpha(data$fill %||% 
#>         "black", data$alpha), pointsize = data$size %||% 1.5, 
#>         stroke = data$stroke %||% 0.5))
#> }
#> <bytecode: 0x560fc56e4ec8>
#> <environment: namespace:ggplot2>

# Example 48
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

# Example 49
draw_key_spring <- function(data, params, size) {
  springGrob(
    x0 = 0, 
    y0 = 0, 
    x1 = 1, 
    y1 = 1,
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

# Example 50
GeomSpring$draw_key <- draw_key_spring

# Example 51
ggplot(df) + 
  geom_spring(aes(
    x = x, 
    y = y, 
    xend = xend, 
    yend = yend, 
    tension = tension, 
    diameter = diameter
  )) + 
  scale_tension(range = c(0.1, 5))

# Example 52
ggplot(df) + 
  geom_spring(aes(
    x = x, 
    y = y, 
    xend = xend, 
    yend = yend, 
    tension = tension, 
    diameter = diameter
  )) + 
  scale_tension(range = c(0.1, 5)) +
  theme(legend.key.size = unit(1, "cm"))

# Example 53
ggplot(df) + 
  geom_spring(aes(
    x = x, 
    y = y, 
    xend = xend, 
    yend = yend, 
    colour = class
  )) + 
  theme(legend.key.size = unit(1, "cm"))

