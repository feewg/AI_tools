# Colour Scales and Legends

## Colour Theory

**HCL colour space:**
- Hue: 0-360 degrees (colour type)
- Chroma: 0 to max (colour purity)
- Luminance: 0 (black) to 1 (white)

**Colour blindness considerations:**
- Avoid red-green contrasts
- Use viridis palettes for accessibility
- Check with colorBlindness::displayAllColors()
- Provide redundant mappings (size, shape, line type)

## Continuous Colour Scales

**Pre-defined palettes:**
- `scale_fill_viridis_c()` - perceptually uniform, colour-blind safe
- `scale_fill_viridis_c(option = "magma")` - variant palettes
- `scale_fill_distiller()` - ColorBrewer continuous
- `scale_fill_distiller(palette = "RdPu")` - specific palette

**Gradient scales:**
- `scale_fill_gradient()` - two-colour gradient (low, high)
- `scale_fill_gradient2()` - three-colour with midpoint
- `scale_fill_gradientn()` - n-colour gradient with colours vector

**Examples:**
```r
scale_fill_gradient(low = "grey", high = "brown")
scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0)
scale_fill_gradientn(colours = terrain.colors(7))
```

**Missing values:**
- `na.value` parameter controls NA colour (default: grey)
- `na.value = NA` makes missing values invisible

**Colour bar guide:**
- `guide_colourbar()` for continuous colour legends
- `guide_colourbar(reverse = TRUE)` - flip direction
- `guide_colourbar(barheight = unit(2, "cm"))` - size control
- `guide_colourbar(direction = "horizontal")` - orientation

## Discrete Colour Scales

**ColorBrewer palettes:**
- `scale_colour_brewer()` - discrete ColorBrewer
- `scale_colour_brewer(palette = "Set1")` - qualitative
- `scale_colour_brewer(palette = "Set2")` - for areas
- Good for points: Set1, Dark2
- Good for areas: Set2, Pastel1, Pastel2, Accent

**Hue scales:**
- `scale_colour_hue()` - evenly spaced hues (default)
- `h`, `c`, `l` arguments for hue range, chroma, luminance

**Grey scales:**
- `scale_colour_grey()` - greyscale for discrete data
- `start`, `end` for grey range

**Manual scales:**
- `scale_colour_manual(values = c("red", "blue"))`
- Named vector for level mapping

**Legend customization:**
- `guide_legend(ncol = 2)` - columns
- `guide_legend(byrow = TRUE)` - fill order
- `guide_legend(reverse = TRUE)` - reverse order
- `guide_legend(override.aes = list(alpha = 1))` - fix display

## Binned Colour Scales

- `scale_fill_binned()` - continuous to discrete colour
- `scale_fill_steps()` - step function (default for binned)
- `scale_fill_steps(n.breaks = 8)` - number of steps
- `scale_fill_steps2()` - three-colour binned
- `scale_fill_stepsn()` - n-colour binned
- `scale_fill_fermenter()` - ColorBrewer binned

**Step guide:**
- `guide_coloursteps()` - step legend
- `guide_coloursteps(show.limits = TRUE)` - show endpoints

## Date/Time Colour Scales

- `scale_colour_date()` - for Date objects
- `scale_colour_datetime()` - for POSIXct
- `date_breaks`, `date_labels` arguments

## Alpha (Transparency) Scales

- `scale_alpha()` - continuous transparency
- `scale_alpha_discrete()` - discrete transparency
- Useful for down-weighting less important observations

## Legend Position

**Theme settings:**
- `theme(legend.position = "none")` - no legend
- `theme(legend.position = "right")` - default
- `theme(legend.position = "left", "top", "bottom")`
- `theme(legend.position = c(0.5, 0.5))` - inside plot (relative coords)
- `theme(legend.justification = c(0, 1))` - anchor point
- `theme(legend.direction = "horizontal")` - layout direction
- `theme(legend.box = "vertical")` - multiple legend arrangement

**Legend margin:**
- `theme(legend.margin = margin(0, 0, 0, 0))`

## External Palette Packages

- **viridis**: Perceptually uniform, colour-blind safe
- **scico**: Scientific colour maps
- **paletteer**: Unified interface to many palettes
- **munsell**: Munsell colour system
- **colorspace**: HCL-based palettes
- **dichromat**: Colour-blind simulation
- **colorBlindness**: Colour-blind testing
