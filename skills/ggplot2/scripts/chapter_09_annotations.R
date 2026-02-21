# 8Annotations
# Chapter 9

# Example 1
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = factor(cyl))) + 
  labs(
    x = "Engine displacement (litres)", 
    y = "Highway miles per gallon", 
    colour = "Number of cylinders",
    title = "Mileage by engine size and cylinders",
    subtitle = "Source: https://fueleconomy.gov"
  )

# Example 2
values <- seq(from = -2, to = 2, by = .01)
df <- data.frame(x = values, y = values ^ 3)
ggplot(df, aes(x, y)) + 
  geom_path() + 
  labs(y = quote(f(x) == x^3))

# Example 3
df <- data.frame(x = 1:3, y = 1:3)
base <- ggplot(df, aes(x, y)) + 
  geom_point() + 
  labs(x = "Axis title with *italics* and **boldface**")

base 
base + theme(axis.title.x = ggtext::element_markdown())

# Example 4
df <- data.frame(x = 1, y = 3:1, family = c("sans", "serif", "mono"))
  ggplot(df, aes(x, y)) + 
    geom_text(aes(label = family, family = family))

# Example 5
df <- data.frame(x = 1, y = 3:1, face = c("plain", "bold", "italic"))
  ggplot(df, aes(x, y)) + 
    geom_text(aes(label = face, fontface = face))

# Example 6
df <- data.frame(
    x = c(1, 1, 2, 2, 1.5),
    y = c(1, 2, 1, 2, 1.5),
    text = c(
      "bottom-left", "top-left",  
      "bottom-right", "top-right", "center"
    )
  )
  ggplot(df, aes(x, y)) +
    geom_text(aes(label = text))
  ggplot(df, aes(x, y)) +
    geom_text(aes(label = text), vjust = "inward", hjust = "inward")

# Example 7
df <- data.frame(
    treatment = c("a", "b", "c"), 
    response = c(1.2, 3.4, 2.5)
  )

  ggplot(df, aes(treatment, response)) + 
    geom_point() + 
    geom_text(
      mapping = aes(label = paste0("(", response, ")")), 
      nudge_x = -0.3
    ) + 
    ylim(1.1, 3.6)

# Example 8
ggplot(mpg, aes(displ, hwy)) + 
    geom_text(aes(label = model)) + 
    xlim(1, 8)

  ggplot(mpg, aes(displ, hwy)) + 
    geom_text(aes(label = model), check_overlap = TRUE) + 
    xlim(1, 8)

# Example 9
label <- data.frame(
  waiting = c(55, 80), 
  eruptions = c(2, 4.3), 
  label = c("peak one", "peak two")
)

ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_tile(aes(fill = density)) + 
  geom_label(data = label, aes(label = label))

# Example 10
mini_mpg <- mpg[sample(nrow(mpg), 20), ]
  ggplot(mpg, aes(displ, hwy)) + 
    geom_point(colour = "red") + 
    ggrepel::geom_text_repel(data = mini_mpg, aes(label = class))

# Example 11
ggplot(economics, aes(date, unemploy)) + 
  geom_line()

# Example 12
presidential <- subset(presidential, start > economics$date[1])

ggplot(economics) + 
  geom_rect(
    aes(xmin = start, xmax = end, fill = party), 
    ymin = -Inf, ymax = Inf, alpha = 0.2, 
    data = presidential
  ) + 
  geom_vline(
    aes(xintercept = as.numeric(start)), 
    data = presidential,
    colour = "grey50", alpha = 0.5
  ) + 
  geom_text(
    aes(x = start, y = 2500, label = name), 
    data = presidential, 
    size = 3, vjust = 0, hjust = 0, nudge_x = 50
  ) + 
  geom_line(aes(date, unemploy)) + 
  scale_fill_manual(values = c("blue", "red")) +
  xlab("date") + 
  ylab("unemployment")
#> Warning in scale_x_date(): A <numeric> value was passed to a Date scale.
#> ℹ The value was converted to a <Date> object.

# Example 13
yrng <- range(economics$unemploy)
xrng <- range(economics$date)
caption <- paste(strwrap("Unemployment rates in the US have 
  varied a lot over the years", 40), collapse = "\n")

ggplot(economics, aes(date, unemploy)) + 
  geom_line() + 
  geom_text(
    aes(x, y, label = caption), 
    data = data.frame(x = xrng[1], y = yrng[2], caption = caption), 
    hjust = 0, vjust = 1, size = 4
  )

# Example 14
ggplot(economics, aes(date, unemploy)) + 
  geom_line() + 
  annotate(
    geom = "text", x = xrng[1], y = yrng[2], 
    label = caption, hjust = 0, vjust = 1, size = 4
  )

# Example 15
p <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(
    data = filter(mpg, manufacturer == "subaru"), 
    colour = "orange",
    size = 3
  ) +
  geom_point()

# Example 16
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point(show.legend = FALSE) +
  directlabels::geom_dl(aes(label = class), method = "smart.grid")

# Example 17
ggplot(mpg, aes(displ, hwy)) +
  geom_point() + 
  ggforce::geom_mark_ellipse(aes(label = cyl, group = cyl))

# Example 18
data(Oxboys, package = "nlme")
ggplot(Oxboys, aes(age, height, group = Subject)) + 
  geom_line() + 
  geom_point() + 
  gghighlight::gghighlight(Subject %in% 1:3)
#> Warning: Tried to calculate with group_by(), but the calculation failed.
#> Falling back to ungrouped filter operation...
#> Tried to calculate with group_by(), but the calculation failed.
#> Falling back to ungrouped filter operation...
#> label_key: Subject

# Example 19
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() + 
  facet_wrap(vars(cut), nrow = 1)
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

# Example 20
mod_coef <- coef(lm(log10(price) ~ log10(carat), data = diamonds))
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() + 
  geom_abline(intercept = mod_coef[1], slope = mod_coef[2], 
    colour = "white", linewidth = 1) + 
  facet_wrap(vars(cut), nrow = 1)
#> `stat_bin2d()` using `bins = 30`. Pick better value `binwidth`.

# Example 21
ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point() + 
  gghighlight::gghighlight() + 
  facet_wrap(vars(cyl))

