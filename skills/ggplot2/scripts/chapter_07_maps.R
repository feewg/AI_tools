# 6Maps
# Chapter 7

# Example 1
mi_counties <- map_data("county", "michigan") %>% 
  select(lon = long, lat, group, id = subregion)
head(mi_counties)
#>     lon  lat group     id
#> 1 -83.9 44.9     1 alcona
#> 2 -83.4 44.9     1 alcona
#> 3 -83.4 44.9     1 alcona
#> 4 -83.3 44.8     1 alcona
#> 5 -83.3 44.8     1 alcona
#> 6 -83.3 44.8     1 alcona

# Example 2
ggplot(mi_counties, aes(lon, lat)) + 
  geom_point(size = .25, show.legend = FALSE) +
  coord_quickmap()

ggplot(mi_counties, aes(lon, lat, group = group)) +
  geom_polygon(fill = "white", colour = "grey50") + 
  coord_quickmap()

# Example 3
library(ozmaps)
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

oz_states <- ozmaps::ozmap_states
oz_states
#> Simple feature collection with 9 features and 1 field
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 106 ymin: -43.6 xmax: 168 ymax: -9.23
#> Geodetic CRS:  GDA94
#> # A tibble: 9 × 2
#>   NAME                                                                  geometry
#> * <chr>                                                       <MULTIPOLYGON [°]>
#> 1 New South Wales   (((151 -35.1, 151 -35.1, 151 -35.1, 151 -35.1, 151 -35.2, 1…
#> 2 Victoria          (((147 -38.7, 147 -38.7, 147 -38.7, 147 -38.7, 147 -38.7)),…
#> 3 Queensland        (((149 -20.3, 149 -20.4, 149 -20.4, 149 -20.3)), ((149 -20.…
#> 4 South Australia   (((137 -34.5, 137 -34.5, 137 -34.5, 137 -34.5, 137 -34.5, 1…
#> 5 Western Australia (((126 -14, 126 -14, 126 -14, 126 -14, 126 -14)), ((124 -16…
#> 6 Tasmania          (((148 -40.3, 148 -40.3, 148 -40.3, 148 -40.3)), ((147 -39.…
#> # ℹ 3 more rows

# Example 4
ggplot(oz_states) + 
  geom_sf() + 
  coord_sf()

# Example 5
oz_states <- ozmaps::ozmap_states %>% filter(NAME != "Other Territories")
oz_votes <- rmapshaper::ms_simplify(ozmaps::abs_ced)

# Example 6
ggplot() + 
  geom_sf(data = oz_states, mapping = aes(fill = NAME), show.legend = FALSE) +
  geom_sf(data = oz_votes, fill = NA) + 
  coord_sf()

# Example 7
# Filter electorates in the Sydney metropolitan region
sydney_map <- ozmaps::abs_ced %>% filter(NAME %in% c(
  "Sydney", "Wentworth", "Warringah", "Kingsford Smith", "Grayndler", "Lowe", 
  "North Sydney", "Barton", "Bradfield", "Banks", "Blaxland", "Reid", 
  "Watson", "Fowler", "Werriwa", "Prospect", "Parramatta", "Bennelong", 
  "Mackellar", "Greenway", "Mitchell", "Chifley", "McMahon"
))

# Draw the electoral map of Sydney
ggplot(sydney_map) + 
  geom_sf(aes(fill = NAME), show.legend = FALSE) + 
  coord_sf(xlim = c(150.97, 151.3), ylim = c(-33.98, -33.79)) + 
  geom_sf_label(aes(label = NAME), label.padding = unit(1, "mm"))
#> Warning in st_point_on_surface.sfc(sf::st_zm(x)): st_point_on_surface may not
#> give correct results for longitude/latitude data

# Example 8
oz_capitals <- tibble::tribble( 
  ~city,           ~lat,     ~lon,
  "Sydney",    -33.8688, 151.2093,  
  "Melbourne", -37.8136, 144.9631, 
  "Brisbane",  -27.4698, 153.0251, 
  "Adelaide",  -34.9285, 138.6007, 
  "Perth",     -31.9505, 115.8605, 
  "Hobart",    -42.8821, 147.3272, 
  "Canberra",  -35.2809, 149.1300, 
  "Darwin",    -12.4634, 130.8456, 
)

ggplot() + 
  geom_sf(data = oz_votes) + 
  geom_sf(data = oz_states, colour = "black", fill = NA) + 
  geom_point(data = oz_capitals, mapping = aes(x = lon, y = lat), colour = "red") + 
  coord_sf()

# Example 9
ggplot(oz_votes) + geom_sf()
ggplot(oz_votes) + geom_sf() + coord_sf(crs = st_crs(3112))

# Example 10
edenmonaro <- ozmaps::abs_ced %>% filter(NAME == "Eden-Monaro")

p <- ggplot(edenmonaro) + geom_sf()
p + coord_sf(xlim = c(147.75, 150.25), ylim = c(-37.5, -34.5)) 
p + coord_sf(xlim = c(150, 150.25), ylim = c(-36.3, -36))

# Example 11
edenmonaro <- edenmonaro %>% pull(geometry)

# Example 12
dawson <- ozmaps::abs_ced %>% 
  filter(NAME == "Dawson") %>% 
  pull(geometry)
dawson
#> Geometry set for 1 feature 
#> Geometry type: MULTIPOLYGON
#> MULTIPOLYGON (((148 -19.9, 148 -19.8, 148 -19.8...

ggplot(dawson) + 
  geom_sf() +
  coord_sf()

# Example 13
dawson <- st_cast(dawson, "POLYGON")
which.max(st_area(dawson))
#> [1] 69

# Example 14
ggplot(dawson[-69]) + 
  geom_sf() + 
  coord_sf()

# Example 15
library(stars)
#> Loading required package: abind
sat_vis <- read_stars(
  "IDE00422.202001072100.tif", 
  RasterIO = list(nBufXSize = 600, nBufYSize = 600)
)

# Example 16
ggplot() + 
  geom_stars(data = sat_vis) + 
  coord_equal()

# Example 17
ggplot() + 
  geom_stars(data = sat_vis, show.legend = FALSE) +
  facet_wrap(vars(band)) + 
  coord_equal() + 
  scale_fill_gradient(low = "black", high = "white")

# Example 18
oz_states <- st_transform(oz_states, crs = st_crs(sat_vis))

# Example 19
ggplot() + 
  geom_stars(data = sat_vis, show.legend = FALSE) +
  geom_sf(data = oz_states, fill = NA, color = "white") + 
  coord_sf() + 
  theme_void() + 
  scale_fill_gradient(low = "black", high = "white")

# Example 20
cities <- oz_capitals %>% 
  st_as_sf(coords = c("lon", "lat"), crs = 4326, remove = FALSE)

# Example 21
cities <- st_transform(cities, st_crs(sat_vis))

# Example 22
ggplot() + 
  geom_stars(data = sat_vis, show.legend = FALSE) +
  geom_sf(data = oz_states, fill = NA, color = "white") + 
  geom_sf(data = cities, color = "red") + 
  coord_sf() + 
  theme_void() + 
  scale_fill_gradient(low = "black", high = "white")

# Example 23
geom_sf_text(data = cities, mapping = aes(label = city))

