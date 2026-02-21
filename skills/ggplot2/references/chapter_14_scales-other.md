# Other Aesthetic Scales

## Size Scales

**Default scales:**
- `scale_size()` - scales area (not radius), default range 1-6
- `scale_size_area()` - ensures 0 maps to area 0
- `scale_radius()` - scales radius directly
- `scale_size_binned()` - binned size scale

**Range control:**
- `scale_size(range = c(1, 2))` - control output range

**Binned size guide:**
- `guide_bins()` - default for binned size
- `guide_bins(direction = "horizontal")` - orientation
- `guide_bins(show.limits = TRUE)` - show range endpoints

## Shape Scales

**Default scale:**
- `scale_shape()` - up to 6 shapes (warning if more)
- `solid = TRUE` - default (solid shapes)
- `solid = FALSE` - hollow shapes only

**Shape values:**
- Integers 0-25 available
- 21-25: fillable shapes

**Manual shape:**
- `scale_shape_manual(values = c(16, 17, 1, 2))`
- Named vector for specific level mapping

## Line Width Scales

**Default:**
- `scale_linewidth()` - linear width scaling
- `scale_linewidth_binned()` - binned linewidth

**Difference from size:**
- `size` scales area, `linewidth` scales linearly
- Introduced in ggplot2 3.4.0 to separate point size from line width

## Line Type Scales

**Default:**
- `scale_linetype()` - for discrete variables
- `scale_linetype_binned()` - for continuous to discrete
- `scale_linetype_continuous()` - produces error (not meaningful)

**Line type specification:**
- String names: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"
- Hex string: up to 8 values (line length, space length pattern)
- Example: "55" = 5 on, 5 off

**Manual linetype:**
- `scale_linetype_manual()`
- Custom palette function with `discrete_scale()`

## Manual Scales

**Purpose:** Map values to aesthetics directly

**Available functions:**
- `scale_colour_manual()`
- `scale_fill_manual()`
- `scale_size_manual()`
- `scale_shape_manual()`
- `scale_linetype_manual()`
- `scale_alpha_manual()`

**Usage pattern:**
```r
scale_colour_manual(values = c("group1" = "red", "group2" = "blue"))
```

**Multiple line legend trick:**
```r
ggplot(huron, aes(year)) +
  geom_line(aes(y = level + 5, colour = "above")) +
  geom_line(aes(y = level - 5, colour = "below")) +
  scale_colour_manual("Direction", values = c("above" = "red", "below" = "blue"))
```

## Identity Scales

**Purpose:** When data values are already aesthetic values

**Available:**
- `scale_colour_identity()`
- `scale_fill_identity()`
- `scale_shape_identity()`
- `scale_size_identity()`
- `scale_alpha_identity()`
- `scale_linetype_identity()`

**Use case:** When data column contains colour names/hex codes directly
