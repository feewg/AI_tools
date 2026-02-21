# The Grammar of Graphics

## Core Concepts

**Grammar components:**
- Data and aesthetic mappings
- Geometric objects (geoms)
- Statistical transformations (stats)
- Scales
- Coordinate systems
- Faceting

**Key principle:** Every plot is a combination of these components, not a specific chart type.

## Building a Plot

**Simple scatterplot example:**
```r
ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) + geom_point()
```

**Aesthetic mappings:**
- Map variables to visual properties (position, colour, size, shape)
- `aes()` creates the mapping
- Mappings produce a transformed data frame with columns x, y, colour, etc.

**Geoms:**
- Geometric objects determine plot type
- Same data, different geoms = different plots
- `geom_point()`, `geom_line()`, `geom_bar()`

## Scaling Process

**Three steps:**
1. **Transformation:** Apply scale transformations (before stats)
2. **Training:** Combine ranges across all layers and facets
3. **Mapping:** Convert data values to aesthetic values

**Example scales:**
- Position: linear map to [0, 1] range
- Colour: map to hues on colour wheel (discrete) or gradient (continuous)

## Adding Complexity

**Facets:** Create small multiples for different data subsets

**Multiple layers:** Different geoms on same plot

**Stats:** Statistical transformations of data

## Layer Structure

**A layer consists of:**
1. Data
2. Aesthetic mappings
3. Statistical transformation (stat)
4. Geometric object (geom)
5. Position adjustment

## Scale Characteristics

**Every aesthetic has a scale:**
- Controls mapping from data to visual property
- Provides guide (axis or legend) for reading values

**Scale = function + inverse:**
- Function: data space to aesthetic space
- Inverse (guide): aesthetic back to data

## Coordinate Systems

**Role:** Map position aesthetics to 2D plot plane

**Types:**
- Cartesian (default)
- Polar
- Map projections

**Coordinate systems:**
- Transform all position variables together
- Change appearance of geometric objects
- Scaling happens before stats, coordinate transforms after
