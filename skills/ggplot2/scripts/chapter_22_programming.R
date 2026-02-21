# 18Programming with ggplot2
# Chapter 22

# Example 1
bestfit <- geom_smooth(
  method = "lm", 
  se = FALSE, 
  colour = alpha("steelblue", 0.5),
  linewidth = 2
)
ggplot(mpg, aes(cty, hwy)) + 
  geom_point() + 
  bestfit
#> `geom_smooth()` using formula = 'y ~ x'
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  bestfit
#> `geom_smooth()` using formula = 'y ~ x'

# Example 2
geom_lm <- function(formula = y ~ x, colour = alpha("steelblue", 0.5), 
                    linewidth = 2, ...)  {
  geom_smooth(formula = formula, se = FALSE, method = "lm", colour = colour,
    linewidth = linewidth, ...)
}
ggplot(mpg, aes(displ, 1 / hwy)) + 
  geom_point() + 
  geom_lm()
ggplot(mpg, aes(displ, 1 / hwy)) + 
  geom_point() + 
  geom_lm(y ~ poly(x, 2), linewidth = 1, colour = "red")

# Example 3
geom_mean <- function() {
  list(
    stat_summary(fun = "mean", geom = "bar", fill = "grey70"),
    stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", width = 0.4)
  )
}
ggplot(mpg, aes(class, cty)) + geom_mean()
ggplot(mpg, aes(drv, cty)) + geom_mean()

# Example 4
geom_mean <- function(se = TRUE) {
  list(
    stat_summary(fun = "mean", geom = "bar", fill = "grey70"),
    if (se) 
      stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", width = 0.4)
  )
}

ggplot(mpg, aes(drv, cty)) + geom_mean()
ggplot(mpg, aes(drv, cty)) + geom_mean(se = FALSE)

# Example 5
borders <- function(database = "world", regions = ".", fill = NA, 
                    colour = "grey50", ...) {
  df <- map_data(database, regions)
  geom_polygon(
    aes_(~long, ~lat, group = ~group), 
    data = df, fill = fill, colour = colour, ..., 
    inherit.aes = FALSE, show.legend = FALSE
  )
}

# Example 6
geom_mean <- function(..., bar.params = list(), errorbar.params = list()) {
  params <- list(...)
  bar.params <- modifyList(params, bar.params)
  errorbar.params  <- modifyList(params, errorbar.params)
  
  bar <- do.call("stat_summary", modifyList(
    list(fun = "mean", geom = "bar", fill = "grey70"),
    bar.params)
  )
  errorbar <- do.call("stat_summary", modifyList(
    list(fun.data = "mean_cl_normal", geom = "errorbar", width = 0.4),
    errorbar.params)
  )

  list(bar, errorbar)
}

ggplot(mpg, aes(class, cty)) + 
  geom_mean(
    colour = "steelblue",
    errorbar.params = list(width = 0.5, linewidth = 1)
  )
ggplot(mpg, aes(class, cty)) + 
  geom_mean(
    bar.params = list(fill = "steelblue"),
    errorbar.params = list(colour = "blue")
  )

# Example 7
piechart <- function(data, mapping) {
  ggplot(data, mapping) +
    geom_bar(width = 1) + 
    coord_polar(theta = "y") + 
    xlab(NULL) + 
    ylab(NULL)
}
piechart(mpg, aes(factor(1), fill = class))

# Example 8
pcp_data <- function(df) {
  is_numeric <- vapply(df, is.numeric, logical(1))

  # Rescale numeric columns
  rescale01 <- function(x) {
    rng <- range(x, na.rm = TRUE)
    (x - rng[1]) / (rng[2] - rng[1])
  }
  df[is_numeric] <- lapply(df[is_numeric], rescale01)
  
  # Add row identifier
  df$.row <- rownames(df)
  
  # Treat numerics as value (aka measure) variables
  # gather_ is the standard-evaluation version of gather, and
  # is usually easier to program with.
  tidyr::gather_(df, "variable", "value", names(df)[is_numeric])
}
pcp <- function(df, ...) {
  df <- pcp_data(df)
  ggplot(df, aes(variable, value, group = .row)) + geom_line(...)
}
pcp(mpg)
#> Warning: `gather_()` was deprecated in tidyr 1.2.0.
#> ℹ Please use `gather()` instead.
pcp(mpg, aes(colour = drv))
#> Warning: `gather_()` was deprecated in tidyr 1.2.0.
#> ℹ Please use `gather()` instead.

# Example 9
my_function <- function(x_var) {
  aes(x = x_var)
}
my_function(abc)
#> Aesthetic mapping: 
#> * `x` -> `x_var`

# Example 10
my_function <- function(x_var) {
  aes(x = {{ x_var }})
}
my_function(abc)
#> Aesthetic mapping: 
#> * `x` -> `abc`

# Example 11
piechart <- function(data, var) {
  ggplot(data, aes(factor(1), fill = {{ var }})) +
    geom_bar(width = 1) + 
    coord_polar(theta = "y") + 
    xlab(NULL) + 
    ylab(NULL)
}
mpg |> piechart(class)

# Example 12
geoms <- list(
  geom_point(),
  geom_boxplot(aes(group = cut_width(displ, 1))),
  list(geom_point(), geom_smooth())
)

p <- ggplot(mpg, aes(displ, hwy))
lapply(geoms, function(g) p + g)
#> [[1]]
#> 
#> [[2]]
#> Warning: Orientation is not uniquely specified when both the x and y aesthetics are
#> continuous. Picking default orientation 'x'.
#> 
#> [[3]]
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# Example 13
plots <- list(
     ggplot(mpg, aes(displ, hwy)),
     ggplot(diamonds, aes(carat, price)),
     ggplot(faithfuld, aes(waiting, eruptions, size = density))
   )

# Example 14
mystery <- function(...) {
     Reduce(`+`, list(...), accumulate = TRUE)
   }

   mystery(
     ggplot(mpg, aes(displ, hwy)) + geom_point(), 
     geom_smooth(), 
     xlab(NULL), 
     ylab(NULL)
   )

