# Position Scales and Axes

Position scales control the location of visual entities in a plot and map them to data values.

## Continuous Position Scales

**Basic scales:**
- `scale_x_continuous()`, `scale_y_continuous()` - default linear scales
- `scale_x_log10()`, `scale_y_log10()` - log10 transformation
- `scale_x_reverse()`, `scale_y_reverse()` - reverse axis
- `scale_x_sqrt()`, `scale_y_sqrt()` - square root transformation

**Scale limits:**
- `limits` argument: numeric vector of length two
- `lims(x = c(min, max), y = c(min, max))` - convenience function
- `xlim()`, `ylim()` - helper functions for single axes
- Setting limits removes data outside range (converts to NA)

**Zooming:**
- `coord_cartesian(xlim = c(4, 6))` - visual zoom without removing data
- `ylim(10, 35)` on scale removes data, distorting stats

**Visual expansion:**
- `expand = expansion(0)` - remove padding around data
- `expansion(add = 3)` - additive expansion in data units
- `expansion(mult = 0.2)` - multiplicative expansion (20%)
- `expansion(mult = c(0.05, 0.2))` - different expansion each side

**Breaks and labels:**
- `breaks` - vector of values or function
- `labels` - vector of labels or labelling function
- `minor_breaks` - vector or function for minor ticks
- `scales::breaks_extended()`, `scales::breaks_pretty()`, `scales::breaks_width()`
- `scales::label_percent()`, `scales::label_dollar()`, `scales::label_comma()`

**Transformations:**
- `trans` argument: "log", "log10", "log2", "reverse", "sqrt", "reciprocal", "identity"
- Transformations apply before statistics

## Date/Time Position Scales

**Default scales:**
- `scale_x_date()` - for Date objects
- `scale_x_datetime()` - for POSIXct objects

**Date-specific arguments:**
- `date_breaks = "15 years"` - break spacing
- `date_minor_breaks = "1 week"` - minor break spacing
- `date_labels = "%b %Y"` - date format strings

**Format strings:**
- `%Y` - 4-digit year, `%y` - 2-digit year
- `%m` - numeric month, `%b` - abbreviated month, `%B` - full month
- `%d` - day of month (01-31), `%e` - day (1-31)
- `%H` - hour 24h, `%I` - hour 12h, `%p` - am/pm
- `%M` - minute, `%S` - second

## Discrete Position Scales

**Default scales:**
- `scale_x_discrete()`, `scale_y_discrete()`

**Key features:**
- Categories mapped to integers internally
- `limits` - character vector of all possible values
- `breaks` - values to display
- `labels` - can use named vector for selective relabeling

**Axis label customization:**
- `guides(x = guide_axis(n.dodge = 3))` - stagger labels
- `guides(x = guide_axis(angle = 90))` - rotate labels

## Binned Position Scales

- `scale_x_binned()`, `scale_y_binned()` - continuous to discrete bins
- `n.breaks` - number of bins
- Useful for histogram-like displays with `geom_bar()`
