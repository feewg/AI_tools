# 7Networks
# Chapter 8

# Example 1
library(tidygraph)

graph <- play_erdos_renyi(n = 10, p = 0.2) %>% 
  activate(nodes) %>% 
  mutate(class = sample(letters[1:4], n(), replace = TRUE)) %>% 
  activate(edges) %>% 
  arrange(.N()$class[from])
#> Warning: `play_erdos_renyi()` was deprecated in tidygraph 1.3.0.
#> ℹ Please use `play_gnp()` instead.

graph
#> # A tbl_graph: 10 nodes and 18 edges
#> #
#> # A directed simple graph with 1 component
#> #
#> # Edge Data: 18 × 2 (active)
#>    from    to
#>   <int> <int>
#> 1     9     2
#> 2     5    10
#> 3     8     5
#> 4     8    10
#> 5     9     8
#> 6     9    10
#> # ℹ 12 more rows
#> #
#> # Node Data: 10 × 1
#>   class
#>   <chr>
#> 1 a    
#> 2 d    
#> 3 c    
#> # ℹ 7 more rows

# Example 2
hs_graph <- as_tbl_graph(highschool, directed = FALSE)
hs_graph
#> # A tbl_graph: 70 nodes and 506 edges
#> #
#> # An undirected multigraph with 1 component
#> #
#> # Node Data: 70 × 0 (active)
#> #
#> # Edge Data: 506 × 3
#>    from    to  year
#>   <int> <int> <dbl>
#> 1     1    13  1957
#> 2     1    14  1957
#> 3     1    20  1957
#> # ℹ 503 more rows

# Example 3
luv_clust <- hclust(dist(luv_colours[, 1:3]))
luv_graph <- as_tbl_graph(luv_clust)
luv_graph
#> # A tbl_graph: 1313 nodes and 1312 edges
#> #
#> # A rooted tree
#> #
#> # Node Data: 1,313 × 4 (active)
#>   height leaf  label members
#>    <dbl> <lgl> <chr>   <int>
#> 1     0  TRUE  "101"       1
#> 2     0  TRUE  "427"       1
#> 3   778. FALSE ""          2
#> 4     0  TRUE  "571"       1
#> 5     0  TRUE  "426"       1
#> 6     0  TRUE  "424"       1
#> # ℹ 1,307 more rows
#> #
#> # Edge Data: 1,312 × 2
#>    from    to
#>   <int> <int>
#> 1     3     1
#> 2     3     2
#> 3     8     6
#> # ℹ 1,309 more rows

# Example 4
graph %>% 
  activate(nodes) %>% 
  mutate(centrality = centrality_pagerank()) %>% 
  arrange(desc(centrality))
#> # A tbl_graph: 10 nodes and 18 edges
#> #
#> # A directed simple graph with 1 component
#> #
#> # Node Data: 10 × 2 (active)
#>   class centrality
#>   <chr>      <dbl>
#> 1 c         0.220 
#> 2 a         0.165 
#> 3 c         0.140 
#> 4 a         0.128 
#> 5 c         0.128 
#> 6 a         0.0703
#> # ℹ 4 more rows
#> #
#> # Edge Data: 18 × 2
#>    from    to
#>   <int> <int>
#> 1     6     7
#> 2     2     1
#> 3     8     2
#> # ℹ 15 more rows

# Example 5
library(ggraph)
ggraph(hs_graph) + 
  geom_edge_link() + 
  geom_node_point()
#> Using "stress" as default layout

# Example 6
ggraph(hs_graph, layout = "drl") + 
  geom_edge_link() + 
  geom_node_point()

# Example 7
hs_graph <- hs_graph %>% 
  activate(edges) %>% 
  mutate(edge_weights = runif(n()))
ggraph(hs_graph, layout = "stress", weights = edge_weights) + 
  geom_edge_link(aes(alpha = edge_weights)) + 
  geom_node_point() + 
  scale_edge_alpha_identity()

# Example 8
ggraph(luv_graph, layout = "dendrogram", circular = TRUE) + 
  geom_edge_link() + 
  coord_fixed()

# Example 9
ggraph(luv_graph, layout = "dendrogram") + 
  geom_edge_link() + 
  coord_polar() + 
  scale_y_reverse()

# Example 10
ggraph(hs_graph, layout = "stress") + 
  geom_edge_link() + 
  geom_node_point(
    aes(filter = centrality_degree() > 2, 
        colour = centrality_power()),
    size = 4
  )

# Example 11
ggraph(luv_graph, layout = "treemap") + 
  geom_node_tile(aes(fill = depth))
#> Warning: Existing variables `height` and `leaf` overwritten by layout variables

# Example 12
ggraph(graph, layout = "stress") + 
  geom_edge_link(aes(alpha = after_stat(index)))

# Example 13
ggraph(graph, layout = "stress") + 
  geom_edge_link2(
    aes(colour = node.class), 
    width = 3,
    lineend = "round")

# Example 14
ggraph(hs_graph, layout = "stress") + 
  geom_edge_fan()

# Example 15
ggraph(hs_graph, layout = "stress") + 
  geom_edge_parallel()

# Example 16
ggraph(luv_graph, layout = "dendrogram", height = height) + 
  geom_edge_elbow()

# Example 17
ggraph(graph, layout = "stress") + 
  geom_edge_link(arrow = arrow()) + 
  geom_node_point(aes(colour = class), size = 8)

# Example 18
ggraph(graph, layout = "stress") + 
  geom_edge_link(
    arrow = arrow(), 
    start_cap = circle(5, "mm"),
    end_cap = circle(5, "mm")
  ) + 
  geom_node_point(aes(colour = class), size = 8)

# Example 19
ggraph(hs_graph, layout = "matrix", sort.by = node_rank_traveller()) + 
  geom_edge_point()
#> Warning: Unknown parameter: method

# Example 20
ggraph(hs_graph, layout = "stress") + 
  geom_edge_link() + 
  geom_node_point() + 
  facet_edges(~year)

# Example 21
ggraph(hs_graph, layout = "stress") + 
  geom_edge_link() + 
  geom_node_point() + 
  facet_nodes(~ group_spinglass())

