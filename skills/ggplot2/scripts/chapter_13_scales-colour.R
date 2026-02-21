# 11Colour scales and legends
# Chapter 13

# Example 1
erupt <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_x_continuous(NULL, expand = c(0, 0)) + 
  scale_y_continuous(NULL, expand = c(0, 0)) + 
  theme(legend.position = "none")

# Example 2
erupt
erupt + scale_fill_viridis_c()
erupt + scale_fill_viridis_c(option = "magma")

# Example 3
erupt + scale_fill_distiller()
erupt + scale_fill_distiller(palette = "RdPu")
erupt + scale_fill_distiller(palette = "YlOrBr")

# Example 4
erupt + scico::scale_fill_scico(palette = "bilbao") # the default
erupt + scico::scale_fill_scico(palette = "vik")
erupt + scico::scale_fill_scico(palette = "lajolla")

# Example 5
erupt + paletteer::scale_fill_paletteer_c("viridis::plasma")
erupt + paletteer::scale_fill_paletteer_c("scico::tokyo")

# Example 6
erupt
erupt + scale_fill_continuous()
erupt + scale_fill_gradient()

# Example 7
erupt + scale_fill_gradient(low = "grey", high = "brown")
erupt + 
  scale_fill_gradient2(
    low = "grey", 
    mid = "white", 
    high = "brown", 
    midpoint = .02
  )
erupt + scale_fill_gradientn(colours = terrain.colors(7))

# Example 8
munsell::hue_slice("5P") +  # Generate a ggplot with hue_slice()
  annotate(                 # Add arrows for annotation 
    geom = "segment", 
    x = c(7, 7), 
    y = c(1, 10), 
    xend = c(7, 7), 
    yend = c(2, 9), 
    arrow = arrow(length = unit(2, "mm"))
  ) 
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the munsell package.
#>   Please report the issue at <https://github.com/cwickham/munsell/issues>.
#> Warning: Removed 31 rows containing missing values or values outside the scale range
#> (`geom_text()`).

# Construct scale
erupt + scale_fill_gradient(
  low = munsell::mnsl("5P 2/12"), 
  high = munsell::mnsl("5P 7/12")
)

# Example 9
# munsell example
erupt + scale_fill_gradient2(
  low = munsell::mnsl("5B 7/8"),
  high = munsell::mnsl("5Y 7/8"),
  mid = munsell::mnsl("N 7/0"),
  midpoint = .02
) 

# colorspace examples
erupt + scale_fill_gradientn(colours = colorspace::heat_hcl(7))
erupt + scale_fill_gradientn(colours = colorspace::diverge_hcl(7))

# Example 10
df <- data.frame(x = 1, y = 1:5, z = c(1, 3, 2, NA, 5))
base <- ggplot(df, aes(x, y)) + 
  geom_tile(aes(fill = z), linewidth = 5) + 
  labs(x = NULL, y = NULL) +
  scale_x_continuous(labels = NULL)

base
base + scale_fill_gradient(na.value = NA)
base + scale_fill_gradient(na.value = "yellow")

# Example 11
base <- ggplot(toy, aes(up, up, fill = big)) + 
  geom_tile() + 
  labs(x = NULL, y = NULL) 

base 
base + scale_fill_continuous(limits = c(0, 10000))

# Example 12
base + scale_fill_continuous(breaks = c(1000, 2000, 4000))
base + scale_fill_continuous(labels = scales::label_dollar())

# Example 13
base <- ggplot(mpg, aes(cyl, displ, colour = hwy)) +
  geom_point(size = 2)

base

# Example 14
base + guides(colour = guide_colourbar(reverse = TRUE))
base + scale_colour_continuous(guide = guide_colourbar(reverse = TRUE))

# Example 15
df <- data.frame(x = c("a", "b", "c", "d"), y = c(3, 4, 1, 2))
bars <- ggplot(df, aes(x, y, fill = x)) + 
  geom_bar(stat = "identity") + 
  labs(x = NULL, y = NULL) +
  theme(legend.position = "none")

# Example 16
bars
bars + scale_fill_discrete()
bars + scale_fill_hue()

# Example 17
bars + scale_fill_brewer(palette = "Set1")
bars + scale_fill_brewer(palette = "Set2")
bars + scale_fill_brewer(palette = "Accent")

# Example 18
# scatter plot
df <- data.frame(
  x = 1:3 + runif(30), 
  y = runif(30), 
  z = c("a", "b", "c")
)
point <- ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z))  + 
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL)

# three palettes
point + scale_colour_brewer(palette = "Set1")
point + scale_colour_brewer(palette = "Set2")  
point + scale_colour_brewer(palette = "Pastel1")

# Example 19
# bar plot
df <- data.frame(x = 1:3, y = 3:1, z = c("a", "b", "c"))
area <- ggplot(df, aes(x, y)) + 
  geom_bar(aes(fill = z), stat = "identity") + 
  theme(legend.position = "none") +
  labs(x = NULL, y = NULL)

# three palettes
area + scale_fill_brewer(palette = "Set1")
area + scale_fill_brewer(palette = "Set2")
area + scale_fill_brewer(palette = "Pastel1")

# Example 20
bars
bars + scale_fill_hue(c = 40)
bars + scale_fill_hue(h = c(180, 300))

# Example 21
bars + scale_fill_grey()
bars + scale_fill_grey(start = 0.5, end = 1)
bars + scale_fill_grey(start = 0, end = 0.5)

# Example 22
bars + paletteer::scale_fill_paletteer_d("rtist::vangogh")
bars + paletteer::scale_fill_paletteer_d("colorBlindness::paletteMartin")
bars + paletteer::scale_fill_paletteer_d("wesanderson::FantasticFox1")

# Example 23
bars + 
  scale_fill_manual(
    values = c("sienna1", "sienna4", "hotpink1", "hotpink4")
  )

bars + 
  scale_fill_manual(
    values = c("tomato1", "tomato2", "tomato3", "tomato4")
  )

bars + 
  scale_fill_manual(
    values = c("grey", "black", "grey", "grey")
  )

# Example 24
bars + 
  scale_fill_manual(
    values = c(
      "d" = "grey",
      "c" = "grey",
      "b" = "black",
      "a" = "grey"
    )
  )

# Example 25
mpg_99 <- mpg %>% filter(year == 1999)
mpg_08 <- mpg %>% filter(year == 2008)

base_99 <- ggplot(mpg_99, aes(displ, hwy, colour = fl)) + geom_point() 
base_08 <- ggplot(mpg_08, aes(displ, hwy, colour = fl)) + geom_point() 

base_99
base_08

# Example 26
base_99 + lims(colour = c("c", "d", "e", "p", "r"))
base_08 + lims(colour = c("c", "d", "e", "p", "r"))

# Example 27
base_99 + 
  lims(
    x = c(1, 7), 
    y = c(10, 45), 
    colour = c("c", "d", "e", "p", "r")
  )

base_08 + 
  lims(
    x = c(1, 7), 
    y = c(10, 45), 
    colour = c("c", "d", "e", "p", "r")
  )

# Example 28
base_99 + 
  scale_color_discrete(
    limits = c("c", "d", "e", "p", "r"), 
    breaks = c("d", "p", "r"),
    labels = c("diesel", "premium", "regular")
  )

# Example 29
base_99 + 
  lims(x = c(1, 7), y = c(10, 45)) +
  scale_color_discrete(
    limits = c("c", "d", "e", "p", "r"), 
    breaks = c("d", "p", "r"),
    labels = c("diesel", "premium", "regular")
  )

base_08 + 
  lims(x = c(1, 7), y = c(10, 45)) +
  scale_color_discrete(
    limits = c("c", "d", "e", "p", "r"), 
    labels = c("compressed", "diesel", "ethanol", "premium", "regular")
  )

# Example 30
base <- ggplot(mpg, aes(drv, fill = factor(cyl))) + geom_bar() 

  base
  base + guides(fill = guide_legend(ncol = 2))
  base + guides(fill = guide_legend(ncol = 2, byrow = TRUE))

# Example 31
base <- ggplot(mpg, aes(displ, hwy, colour = drv)) +
    geom_point(size = 4, alpha = .2, stroke = 0)

  base + guides(colour = guide_legend())
  base + guides(colour = guide_legend(override.aes = list(alpha = 1)))

# Example 32
erupt + scale_fill_binned()
erupt + scale_fill_steps()
erupt + scale_fill_steps(n.breaks = 8)

# Example 33
erupt + scale_fill_steps(low = "grey", high = "brown")
erupt + 
  scale_fill_steps2(
    low = "grey", 
    mid = "white", 
    high = "brown", 
    midpoint = .02
  )
erupt + scale_fill_stepsn(n.breaks = 12, colours = terrain.colors(12))

# Example 34
erupt + scale_fill_stepsn(n.breaks = 9, colours = viridis::viridis(9))
erupt + scale_fill_stepsn(n.breaks = 9, colours = viridis::magma(9))
erupt + scale_fill_stepsn(n.breaks = 9, colours = viridis::inferno(9))

# Example 35
erupt + scale_fill_fermenter(n.breaks = 9)
erupt + scale_fill_fermenter(n.breaks = 9, palette = "Oranges")
erupt + scale_fill_fermenter(n.breaks = 9, palette = "PuOr")

# Example 36
base <- ggplot(mpg, aes(cyl, displ, colour = hwy)) +
    geom_point(size = 2) +
    scale_color_binned()

  base 
  base + guides(colour = guide_coloursteps(show.limits = TRUE))

# Example 37
base <- ggplot(economics, aes(psavert, uempmed, colour = date)) + 
  geom_point() 

base
base + 
  scale_colour_date(
    date_breaks = "142 months", 
    date_labels = "%b %Y"
  )

# Example 38
ggplot(faithfuld, aes(waiting, eruptions, alpha = density)) +
  geom_raster(fill = "maroon") +
  scale_x_continuous(expand = c(0, 0)) + 
  scale_y_continuous(expand = c(0, 0))

# Example 39
base <- ggplot(toy, aes(up, up)) + 
  geom_point(aes(colour = txt), size = 3) + 
  xlab(NULL) + 
  ylab(NULL)

base + theme(legend.position = "left")
base + theme(legend.position = "right") # the default 
base + theme(legend.position = "bottom")
base + theme(legend.position = "none")

# Example 40
base <- ggplot(toy, aes(up, up)) + 
  geom_point(aes(colour = txt), size = 3)

base + 
  theme(
    legend.position = c(0, 1), 
    legend.justification = c(0, 1)
  )

base + 
  theme(
    legend.position = c(0.5, 0.5), 
    legend.justification = c(0.5, 0.5)
  )

base + 
  theme(
    legend.position = c(1, 0), 
    legend.justification = c(1, 0)
  )

