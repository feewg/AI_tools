# 20Extending ggplot2
# Chapter 24

# Example 1
theme_minimal <- function(base_size = 11, 
                          base_family = "", 
                          base_line_size = base_size/22, 
                          base_rect_size = base_size/22) {
    theme_bw(
      base_size = base_size, 
      base_family = base_family, 
      base_line_size = base_line_size, 
      base_rect_size = base_rect_size
    ) %+replace% 
    theme(
      axis.ticks = element_blank(), 
      legend.background = element_blank(), 
      legend.key = element_blank(), 
      panel.background = element_blank(), 
      panel.border = element_blank(), 
      strip.background = element_blank(), 
      plot.background = element_blank(), 
      complete = TRUE
    )
}

# Example 2
theme_background <- function(background = "white", ...) {
  theme_minimal(...) %+replace%
    theme(
      plot.background = element_rect(
        fill = background,
        colour = background
      ),
      complete = TRUE
    )
}

base <- ggplot(mpg, aes(displ, hwy)) + geom_point()
base + theme_minimal(base_size = 14)
base + theme_background(base_size = 14)
base + theme_background(base_size = 14, background = "grey70")

# Example 3
# good 
theme_predictable <- function(...) {
  theme_classic(...) %+replace% 
    theme(
      axis.line.x = element_line(color = "blue"),
      axis.line.y = element_line(color = "orange"),
      complete = TRUE
    )
}

# bad
theme_surprising <- function(...) {
  theme_classic(...) %+replace% 
    theme(
      axis.line.x = element_line(color = "blue"),
      axis.line.y = element_line(color = "orange")
    )
}

# Example 4
base + theme_classic()
base + theme_predictable()
base + theme_surprising()

# Example 5
base + theme_classic() + theme(axis.line = element_blank())
base + theme_predictable() + theme(axis.line = element_blank())
base + theme_surprising() + theme(axis.line = element_blank())

# Example 6
base + 
  theme_classic() +
  theme(
      axis.line.x = element_line(color = "blue"),
      axis.line.y = element_line(color = "orange"),
      axis.line = element_blank()
  )

# Example 7
coord_annotate <- function(label = "panel annotation") {
  ggproto(NULL, CoordCartesian,
          limits = list(x = NULL, y = NULL),
          expand = TRUE,
          default = FALSE,
          clip = "on",
          render_fg = function(panel_params, theme) {
            element_render(
              theme = theme, 
              element = "ggxyz.panel.annotation", 
              label = label
            )
          }
  )
}

# Example 8
StatChull <- ggproto("StatChull", Stat,
  compute_group = function(data, scales) {
    data[chull(data$x, data$y), , drop = FALSE]
  },
  required_aes = c("x", "y")
)

# Example 9
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

# Example 10
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  stat_chull(fill = NA, colour = "black")

ggplot(mpg, aes(displ, hwy, colour = drv)) + 
  geom_point() + 
  stat_chull(fill = NA)

# Example 11
common_bandwidth <- function(data) {
  split_data <- split(data$x, data$group)
  bandwidth <- mean(vapply(split_data, bw.nrd0, numeric(1)))
  return(bandwidth)
}

# Example 12
StatDensityCommon <- ggproto("StatDensityCommon", Stat,
  required_aes = "x",
  
  setup_params = function(data, params) {
    if(is.null(params$bandwith)) {
      params$bandwidth <- common_bandwidth(data)
      message("Picking bandwidth of ", signif(params$bandwidth, 3))
    }
    return(params)
  },
    
  compute_group = function(data, scales, bandwidth = 1) {
    d <- density(data$x, bw = bandwidth)
    return(data.frame(x = d$x, y = d$y))
  }  
)

# Example 13
stat_density_common <- function(mapping = NULL, data = NULL, 
                                geom = "line", position = "identity", 
                                na.rm = FALSE, show.legend = NA, 
                                inherit.aes = TRUE, bandwidth = NULL, ...) {
  layer(
    stat = StatDensityCommon, 
    data = data, 
    mapping = mapping, 
    geom = geom, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(
      bandwidth = bandwidth, 
      na.rm = na.rm,
      ...
    )
  )
}

# Example 14
ggplot(mpg, aes(displ, colour = drv)) + 
  stat_density_common()
#> Picking bandwidth of 0.345

# Example 15
GeomPolygonHollow <- ggproto("GeomPolygonHollow", GeomPolygon,
  default_aes = aes(
    colour = "black", 
    fill = NA, 
    linewidth = 0.5,
    linetype = 1,
    alpha = NA
  )
)

# Example 16
geom_chull <- function(mapping = NULL, data = NULL, stat = "chull",
                       position = "identity", na.rm = FALSE, 
                       show.legend = NA, inherit.aes = TRUE, ...) {
  layer(
    geom = GeomPolygonHollow, 
    data = data, 
    mapping = mapping, 
    stat = stat, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

# Example 17
ggplot(mpg, aes(displ, hwy)) + 
  geom_chull() +
  geom_point()

# Example 18
GeomSpike <- ggproto("GeomSpike", GeomSegment,
  
  # Specify the required aesthetics                   
  required_aes = c("x", "y", "angle", "radius"),
  
  # Transform the data before any drawing takes place
  setup_data = function(data, params) {
    transform(data,
      xend = x + cos(angle) * radius,
      yend = y + sin(angle) * radius
    )
  }
)

# Example 19
geom_spike <- function(mapping = NULL, data = NULL, 
                       stat = "identity", position = "identity", 
                       ..., na.rm = FALSE, show.legend = NA, 
                       inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    geom = GeomSpike, 
    stat = stat, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# Example 20
df <- data.frame(
  x = 1:10,
  y = 0,
  angle = seq(from = 0, to = 2 * pi, length.out = 10),
  radius = seq(from = 0, to = 2, length.out = 10)
)
ggplot(df, aes(x, y)) +
  geom_spike(aes(angle = angle, radius = radius)) + 
  coord_equal()

# Example 21
GeomBarbell <- ggproto("GeomBarbell", Geom,
  
  required_aes = c("x", "y", "xend", "yend"),
  
  default_aes = aes(
    colour = "black",
    linewidth = .5,
    size = 2,
    linetype = 1,
    shape = 19,
    fill = NA,
    alpha = NA,
    stroke = 1
  ),
  
  draw_panel = function(data, panel_params, coord, ...) {
    
    # Transformed data for the points
    point1 <- transform(data) 
    point2 <- transform(data, x = xend, y = yend)    
    
    # Return all three components
    grid::gList(
      GeomSegment$draw_panel(data, panel_params, coord, ...),
      GeomPoint$draw_panel(point1, panel_params, coord, ...),
      GeomPoint$draw_panel(point2, panel_params, coord, ...)
    )
  }
)

# Example 22
geom_barbell <- function(mapping = NULL, data = NULL, 
                         stat = "identity", position = "identity", 
                         ..., na.rm = FALSE, show.legend = NA, 
                         inherit.aes = TRUE) {
  layer(
    data = data, 
    mapping = mapping, 
    stat = stat, 
    geom = GeomBarbell, 
    position = position, 
    show.legend = show.legend, 
    inherit.aes = inherit.aes, 
    params = list(na.rm = na.rm, ...)
  )
}

# Example 23
df <- data.frame(x = 1:10, xend = 0:9, y = 0, yend = 1:10)
base <- ggplot(df, aes(x, y, xend = xend, yend = yend))

base + geom_barbell()
base + geom_barbell(shape = 4, linetype = "dashed")

# Example 24
random_colours <- function(n) {
  sample(colours(distinct = TRUE), n, replace = TRUE)
}

# Example 25
scale_fill_random <- function(..., aesthetics = "fill") {
  discrete_scale(
    aesthetics = aesthetics, 
    scale_name = "random", 
    palette = random_colours
  )
}

ggplot(mpg, aes(hwy, class, fill = class)) + 
  geom_violin(show.legend = FALSE) +
  scale_fill_random()
#> Warning: The `scale_name` argument of `discrete_scale()` is deprecated as of ggplot2
#> 3.5.0.

# Example 26
normal_transformer <- function(x, sd) {
  function(x) {x + rnorm(length(x), sd = sd)}
}

# Example 27
PositionJitterNormal <- ggproto('PositionJitterNormal', Position,
           
  # We need an x and y position aesthetic                              
  required_aes = c('x', 'y'),
  
  # By using the "self" argument we can access parameters that the 
  # user has passed to the position, and add them as layer parameters
  setup_params = function(self, data) {
    list(
      sd_x = self$sd_x, 
      sd_y = self$sd_y
    )
  },

  # When computing the layer, we can read the standard deviation 
  # parameters off the param list, and use them to transform the
  # position aesthetics
  compute_layer = function(data, params, panel) {
    
    # construct transformers for the x and y position scales 
    x_transformer <- normal_transformer(x, params$sd_x)
    y_transformer <- normal_transformer(y, params$sd_y)
    
    # return the transformed data
    transform_position(
      df = data,
      trans_x = x_transformer,  
      trans_y = y_transformer
    )
  }
)

# Example 28
position_jitternormal <- function(sd_x = .15, sd_y = .15) {
  ggproto(NULL, PositionJitterNormal, sd_x = sd_x, sd_y = sd_y)
}

# Example 29
df <- data.frame(
  x = sample(1:3, 1500, TRUE),
  y = sample(1:3, 1500, TRUE)
)

ggplot(df, aes(x, y)) + geom_point(position = position_jitter())
ggplot(df, aes(x, y)) + geom_point(position = position_jitternormal())

# Example 30
FacetScatter <- ggproto("FacetScatter", FacetWrap,
  
  # This isn't important to the example: all we're doing is
  # forcing all panels to use fixed scale so that the rest
  # of the example can be kept simple
  setup_params = function(data, params) {
    params <- FacetWrap$setup_params(data, params)
    params$free <- list(x = FALSE, y = FALSE)
    return(params)
  },                      
  
  # The compute_layout() method does the work
  compute_layout = function(data, params) {
                  
    # create a data frame with one column per facetting 
    # variable, and one row for each possible combination
    # of values (i.e., one row per panel)
    panels <- combine_vars(
      data = data,
      env = params$plot_env, 
      vars = params$facets, 
      drop = FALSE
    )
    
    # Create a data frame with columns for ROW and COL, 
    # with one row for each possible cell in the panel grid
    locations <- expand.grid(ROW = 1:params$nrow, COL = 1:params$ncol)
    
    # Randomly sample a subset of the locations
    shuffle <- sample(nrow(locations), nrow(panels))
    
    # Assign each panel a location                      
    layout <- data.frame(
      PANEL = 1:nrow(panels),       # panel identifier
      ROW = locations$ROW[shuffle], # row number for the panels
      COL = locations$COL[shuffle], # column number for the panels
      SCALE_X = 1L,                 # all x-axis scales are fixed
      SCALE_Y = 1L                  # all y-axis scales are fixed
    )
    
    # Bind the layout information with the panel identification
    # and return the resulting specification
    return(cbind(layout, panels))
  }                      
)

# Example 31
facet_scatter <- function(facets, nrow, ncol, 
                          strip.position = "top", 
                          labeller = "label_value") {
  
  ggproto(NULL, FacetScatter, 
    params = list(
      facets = rlang::quos_auto_name(facets),
      strip.position = strip.position,
      labeller = labeller, 
      ncol = ncol, 
      nrow = nrow
    )
  )
}

# Example 32
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_scatter(vars(manufacturer), nrow = 5, ncol = 6)

