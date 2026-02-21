# Maps

## Polygon Maps

Basic approach using `geom_polygon()` with data from the maps package:
```r
mi_counties <- map_data("county", "michigan")
ggplot(mi_counties, aes(lon, lat, group = group)) +
  geom_polygon(fill = "white", colour = "grey50") + 
  coord_quickmap()
```

Key variables:
- `lat`, `lon` - vertex coordinates
- `id` - region name
- `group` - unique identifier for contiguous areas

## Simple Features (sf) Maps

Modern approach using the sf package:
```r
library(sf)
ggplot(oz_states) + geom_sf() + coord_sf()
```

Features:
- Automatic geometry detection from sf objects
- `geom_sf()` handles geometry aesthetic automatically
- `coord_sf()` manages map projections

**Layered maps**: Add multiple `geom_sf()` layers
**Labelled maps**: Use `geom_sf_label()` or `geom_sf_text()`
**Adding points**: Combine with standard geoms using `geom_point()`

## Map Projections

Coordinate Reference System (CRS) includes:
- Geodetic datum (e.g., WGS84)
- Map projection type
- Projection parameters

Set CRS with `coord_sf()`:
```r
ggplot(oz_votes) + geom_sf() + coord_sf(crs = st_crs(3112))
```

Common considerations:
- Area-preserving vs shape-preserving projections
- Use `st_transform()` to convert between CRS

## Working with sf Data

**Geometry types**: MULTIPOLYGON, POLYGON, etc.
**Helper functions**:
- `st_geometry_type()` - extract geometry type
- `st_bbox()` - bounding box
- `st_crs()` - coordinate reference system
- `st_cast()` - convert between geometry types
- `st_area()` - calculate areas

## Raster Maps

For geospatial images (GeoTIFF):
```r
library(stars)
sat_vis <- read_stars("image.tif")
ggplot() + geom_stars(data = sat_vis) + coord_equal()
```

Overlay with vector data using `st_transform()` to match CRS.

## Data Sources

- ozmaps (Australia)
- USAboundaries (US historical)
- tigris (US Census)
- rnaturalearth (global)
- osmar (OpenStreetMap)
