# Introduction

## Welcome to ggplot2

ggplot2 is an R package for producing statistical, or data, graphics. Unlike most other graphics packages, ggplot2 has an underlying grammar, based on the Grammar of Graphics (Wilkinson 2005), that allows you to compose graphs by combining independent components.

Key features of ggplot2:
- Provides beautiful, hassle-free plots that take care of details like legends
- Carefully chosen defaults enable publication-quality graphics in seconds
- Comprehensive theming system for special formatting requirements
- Works iteratively: start with raw data, then add annotations and statistical summaries
- Based on higher-level elements that easily combine with new datasets

## What is the Grammar of Graphics?

The grammar of graphics describes the fundamental features underlying all statistical graphics. A graphic maps data to aesthetic attributes (colour, shape, size) of geometric objects (points, lines, bars).

### Five Mapping Components

**1. Layer**
A collection of geometric elements (geoms) and statistical transformations (stats). Geoms represent what you see: points, lines, polygons. Stats summarise data: binning, counting, fitting models.

**2. Scales**
Map values in data space to aesthetic space (colour, shape, size). Draw legends and axes for reading original data values.

**3. Coordinate System (coord)**
Describes how data coordinates map to the graphic plane. Provides axes and gridlines. Options include Cartesian, polar, and map projections.

**4. Facet**
Specifies how to break up and display subsets of data as small multiples (conditioning/latticing/trellising).

**5. Theme**
Controls finer display points: font size, background colour, etc.

### What the Grammar Doesn't Do

- Doesn't suggest which graphics to use
- Doesn't describe interactive graphics, only static ones

## How ggplot2 Fits with Other R Graphics

**Base Graphics**
Pen-on-paper model; can only draw on top, cannot modify existing content. Fast but limited scope.

**Grid Graphics**
Rich system of graphical primitives. Grobs can be modified independently. Viewports make complex layouts easier. Provides primitives but no statistical graphics tools.

**Lattice**
Uses grid to implement trellis graphics. Easily produces conditioned plots. Lacks formal model, making extension difficult.

**ggplot2**
Combines good aspects of base and lattice with strong underlying model. Compact syntax describes wide range of graphics. Independent components make extension easy.

**htmlwidgets / plotly**
For interactive graphics and web visualizations.

## Book Overview

- Chapter 2: Getting started with ggplot2 basics
- Chapters 3-9: Basic toolbox for common visualization problems
- Chapters 10-12: Controlling scales, axes, and legends
- Chapters 13+: Layered grammar, coordinate systems, faceting, themes
- Advanced: Programming, internals, and extending ggplot2

## Required Packages

```r
install.packages(c(
  "ggplot2", "dplyr", "tidyr",
  "ggforce", "ggrepel", "ggthemes",
  "scales", "patchwork"
))
```
