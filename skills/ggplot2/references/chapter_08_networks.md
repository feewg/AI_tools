# Networks

## Network Data Structure

Networks consist of:
- **Nodes** (vertices) - entities
- **Edges** (links) - relationships between entities

Both can have additional data attached. Edges can be directed or undirected.

## tidygraph

Data manipulation package for network data:
```r
library(tidygraph)
graph <- play_erdos_renyi(n = 10, p = 0.2) %>% 
  activate(nodes) %>% 
  mutate(class = sample(letters[1:4], n(), replace = TRUE))
```

Key functions:
- `activate(nodes)` / `activate(edges)` - switch between data frames
- `.N()` / `.E()` / `.G()` - access node/edge/graph data
- `as_tbl_graph()` - convert from other formats

**Algorithms**: Centrality, ranking, grouping, etc.:
```r
graph %>% 
  activate(nodes) %>% 
  mutate(centrality = centrality_pagerank())
```

## ggraph Visualization

Initialize with `ggraph()` instead of `ggplot()`:
```r
library(ggraph)
ggraph(hs_graph) + 
  geom_edge_link() + 
  geom_node_point()
```

### Layouts

Layouts calculate x and y from network topology:
```r
ggraph(hs_graph, layout = "stress")  # default
ggraph(hs_graph, layout = "drl")     # different layout
ggraph(graph, layout = "dendrogram", circular = TRUE)
```

### Drawing Nodes

- `geom_node_point()` - points
- `geom_node_tile()` - tiles (for treemaps)
- `filter` aesthetic for selective display
- Can use tidygraph algorithms inside `aes()`

### Drawing Edges

- `geom_edge_link()` - straight lines
- `geom_edge_link0()` - fast version (no gradients)
- `geom_edge_link2()` - interpolate between endpoints
- `geom_edge_fan()` - fan out parallel edges
- `geom_edge_parallel()` - parallel lines for parallel edges
- `geom_edge_elbow()` - elbow edges for trees
- `geom_edge_bend()`, `geom_edge_diagonal()` - smoother variants

**Edge variants**:
- Standard: access terminal nodes with `node1.`, `node2.` prefixes
- `2` suffix: access with `node.` prefix

**Clipping**: Use `start_cap` and `end_cap` to prevent overlap:
```r
geom_edge_link(arrow = arrow(), start_cap = circle(5, "mm"))
```

### Faceting

Specialized faceting for networks:
- `facet_edges(~year)` - facet by edge variable
- `facet_nodes(~group)` - facet by node variable
- `facet_graph()` - grid faceting with rows/cols for nodes or edges
