# Scales and Guides (Theory)

## Theory of Scales and Guides

**Scale definition:** Function from data space (domain) to aesthetic space (range)

**Guide definition:** Inverse function - converts visual properties back to data

**Common components:**
| Argument | Axis | Legend |
|----------|------|--------|
| `name` | Label | Title |
| `breaks` | Ticks & grid | Key |
| `labels` | Tick labels | Key labels |

## Scale Specification

**One scale per aesthetic:**
```r
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) +
  # These are added automatically:
  scale_x_continuous() + 
  scale_y_continuous() + 
  scale_colour_discrete()
```

**Overriding scales:**
- Last scale for each aesthetic takes precedence
- Warning message when adding duplicate scale

## Naming Scheme

**Structure:** `scale_<aesthetic>_<type>`

Examples:
- `scale_x_continuous()`
- `scale_colour_discrete()`
- `scale_fill_brewer()`

## Fundamental Scale Types

**Three internal types:**
1. **Continuous scales** - continuous_scale()
2. **Discrete scales** - discrete_scale()
3. **Binned scales** - binned_scale()

## Scale Names

Use `labs()` for convenience:
```r
labs(x = "X Label", y = "Y Label", colour = "Legend Title")
```

## Scale Breaks

**Unified concept across scale types:**
- Specific data values where guide displays something

## Scale Limits

**Region of data space for mapping:**
- Continuous/binned: two endpoints
- Discrete: enumeration of categories

**Out of bounds handling:**
- Default: convert to NA (`scales::oob_censor()`)
- Alternative: squish to range (`scales::oob_squish()`)

```r
scale_fill_gradient(limits = c(1, 3), oob = scales::squish)
```

## Scale Guides

**Guide objects:** Created by guide functions

**Default guide types:**
| Scale Type | Default Guide |
|------------|---------------|
| Continuous colour/fill | colourbar |
| Binned colour/fill | coloursteps |
| Position scales | axis |
| Discrete (non-position) | legend |
| Binned (non-position/colour) | bins |

**Guide functions:**
- `guide_colourbar()` - continuous colour
- `guide_coloursteps()` - binned colour
- `guide_axis()` - position axes
- `guide_legend()` - discrete legends
- `guide_bins()` - binned legends

## Scale Transformation

**Can apply to non-position scales:**
```r
scale_fill_continuous(trans = "sqrt")
scale_size(trans = "reverse")
```

## Legend Merging and Splitting

**Merging:** Same variable mapped to multiple aesthetics = single legend

```r
geom_point(aes(shape = txt, colour = txt))  # One legend
```

**Require same name to merge:**
```r
labs(shape = "Merged legend", colour = "Merged legend")
```

**Splitting:** One aesthetic to multiple variables

Use ggnewscale package:
```r
ggnewscale::new_scale_colour() + 
  geom_point(aes(colour = different_variable))
```

## Legend Key Glyphs

**Override default legend symbols:**
```r
geom_line(key_glyph = "timeseries")
geom_line(key_glyph = draw_key_timeseries)
```

**Available draw_key functions:**
- `draw_key_point()`, `draw_key_path()`, `draw_key_boxplot()`
- `draw_key_rect()`, `draw_key_polygon()`, etc.
