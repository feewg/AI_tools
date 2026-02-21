# Collective Geoms

## Individual vs Collective Geoms

- **Individual geoms**: One graphical object per observation (e.g., `geom_point()`)
- **Collective geoms**: Multiple observations per geometric object (e.g., boxplots, polygons, lines)

## The Group Aesthetic

Controls assignment of observations to graphical elements. By default, mapped to interaction of all discrete variables.

**Common cases needing explicit grouping:**

**1. Multiple groups, one aesthetic (spaghetti plots)**
```r
ggplot(Oxboys, aes(age, height, group = Subject)) + 
  geom_line()
```

**2. Different groups on different layers**
Set grouping in specific geom, not global:
```r
ggplot(Oxboys, aes(age, height)) + 
  geom_line(aes(group = Subject)) + 
  geom_smooth(method = "lm")
```

**3. Overriding default grouping**
Connect across groups with explicit `group`:
```r
ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot() +
  geom_line(aes(group = Subject), colour = "blue")
```

## Matching Aesthetics to Graphic Objects

**Lines and paths**: Use "first value" principle - aesthetic from first observation used for each segment.

**Polygons and other collective geoms**: Aesthetics used only if all components are the same; otherwise uses default values.

**Discrete vs continuous variables**: For discrete, ggplot2 treats variable as part of group aesthetic, splitting collective geom. For continuous, may need to override grouping.
