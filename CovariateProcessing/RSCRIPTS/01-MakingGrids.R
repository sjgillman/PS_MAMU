## ----include=F----------------------------------------------------------------------------------------
library(ggplot2) # plotting
library(sf) # spatial
library(terra) # raster
library(tidyverse)
library(nngeo)

studyarea <- st_read("../GIS_COVS/GPKG/reduced_area.gpkg")
shoreline <- st_read("../GIS_COVS/GPKG/Dclass_cut.gpkg")
ss_bath <- terra::rast("../GIS_COVS/SS_Bathymetry/SS_Bathymetry.tif")
puget_polygon <- st_read("../GIS_COVS/GPKG/puget_poly.gpkg")


## ----packs, message=F, warning=F----------------------------------------------------------------------
library(ggplot2) # plotting
library(sf) # spatial
library(terra) # raster
library(tidyverse)
library(nngeo)


## ----eval=F-------------------------------------------------------------------------------------------
# 
# studyarea <- st_read("GIS_COVS/GPKG/reduced_area.gpkg")


## ----crop-shape, message = F--------------------------------------------------------------------------
ggplot()+
  geom_sf(data = studyarea, fill ="gray")


## ----eval=F-------------------------------------------------------------------------------------------
# shoreline <- st_read("GIS_COVS/GPKG/Dclass_cut.gpkg")


## ----dc_shore, message = F----------------------------------------------------------------------------
ggplot()+
  geom_sf(data = studyarea, fill ="gray")+
  geom_sf(data = shoreline, color = "black")


## ----eval=F-------------------------------------------------------------------------------------------
# ss_bath <- terra::rast("GIS_COVS/SS_Bathymetry/SS_Bathymetry.tif")


## ----ss-bath, message = F-----------------------------------------------------------------------------
ss_bath



## ----bath-poly, message = F---------------------------------------------------------------------------
shore <- shoreline %>% dplyr::select(OBJECTID_1)

# crop raster to remove land values with shoreline
cropped_raster <- crop(ss_bath, shore)

cropped_raster2 <- crop(cropped_raster, studyarea)
#mask
masked_raster <- terra::mask(cropped_raster2, studyarea)
plot(masked_raster)

bath_poly <- st_as_sf(as.polygons(masked_raster, dissolve = TRUE),as_points = FALSE)

# Drop attributes, keeping only geometry
bath_poly_geom <- st_geometry(bath_poly)

# Union all geometries into a single polygon
single_polygon <- st_union(bath_poly_geom)

# Convert to sf object
puget_poly <- st_sf(geometry = single_polygon)

polygon_buffered <- st_buffer(puget_poly, dist = 100) 

polygon_simple <- st_simplify(polygon_buffered, dTolerance = 250)

polygon_smoothed <- smoothr::smooth(polygon_simple, method = "chaikin")

## clip it back to the the study area

puget_polygon1 <- st_intersection(polygon_smoothed, studyarea)


ggplot()+
  geom_sf(data = studyarea, fill = "lightgray")+
  geom_sf(data = puget_polygon1, fill = "black", color = "red")





## ----save-pp, eval = F, echo=F------------------------------------------------------------------------
# st_write(puget_polygon1, "GIS_COVS/GPKG/puget_poly_clipped.gpkg", delete_layer = TRUE)


## ----reload_poly, message=F, eval=F-------------------------------------------------------------------
# puget_polygon <- st_read("GIS_COVS/GPKG/puget_poly.gpkg")
# 


## ----make-grid, message = F---------------------------------------------------------------------------


cell_area <- units::as_units(2, "km^2") # target grid size

hex_grid <- st_make_grid(puget_polygon,square = F, cellsize = cell_area)

# create sf
grid_sf <- st_sf(geometry = hex_grid)
# clip to study area
grid_clipped <- st_intersection(grid_sf, puget_polygon) %>%
  filter(st_geometry_type(.) != "POINT")
# validate
grid_valid <- st_make_valid(grid_clipped)

ggplot()+
  geom_sf(data = grid_valid)


## ----split_poly, message=F, warning=F-----------------------------------------------------------------
overlap_pairs <- st_overlaps(grid_valid, grid_valid, sparse = FALSE)
sum(overlap_pairs)

multipolygons <- grid_valid[st_geometry_type(grid_valid) == "MULTIPOLYGON", ]

overlap_pairs <- st_overlaps(multipolygons, multipolygons, sparse = FALSE)
sum(overlap_pairs)


parts <- st_as_sf(st_cast(multipolygons$geometry, "POLYGON"))

single <- grid_valid[st_geometry_type(grid_valid) == "POLYGON", ]


single <- single %>% st_geometry() %>%
  st_as_sf()

single_polys <- rbind(single,parts)

single_polys$id <- seq_len(nrow(single_polys))

single_polys <- single_polys %>%
  rename(geometry =x)

ggplot()+
  geom_sf(data = puget_polygon, fill="black") +
  geom_sf(data = single_polys, color="hotpink", fill=NA)




## ----merg_small, message=F,warning=F------------------------------------------------------------------
poly_simplified <- puget_polygon %>%
  st_buffer(dist = 150) %>%
  st_simplify(dTolerance = 200,preserveTopology = TRUE) %>%
  st_buffer(dist = -50)



ggplot()+
  geom_sf(data = puget_polygon, fill="gray", color =NA) +
  geom_sf(data = poly_simplified, color="hotpink", fill=NA)

## remove the small islands
area_thresh <- units::set_units(0.5, km^2)
p_dropped <- smoothr::fill_holes(poly_simplified, threshold = area_thresh)



threshold <- units::set_units(500000, m^2)
big_cells <- single_polys %>% filter(st_area(geometry) >= threshold)

merged_hexes <- st_union(big_cells$geometry)

gaps <- st_difference(p_dropped, merged_hexes)
gaps <- st_cast(gaps, "POLYGON")

ggplot()+
  geom_sf(data = single_polys, fill="black") +
  geom_sf(data = gaps, color="hotpink", fill=NA)



## ----proc_grids, message=F, warning=F-----------------------------------------------------------------
big_cells2 <- big_cells
for (i in seq_len(nrow(gaps))) {
  gap_geom <- gaps[i,]$geom  # Get individual gap polygon
  gap_sf <- st_as_sf(data.frame(geometry = gap_geom))
  # Find touching hexagons (neighbors that share an edge)
  touching_neighbors <- big_cells2[st_touches(big_cells2, gap_sf, sparse = FALSE), ]
  
  
  if (nrow(touching_neighbors) > 0) {
    # Calculate shared boundary length between the gap and each neighbor
    touching_neighbors <- touching_neighbors %>%
      rowwise() %>%
      mutate(shared_length = as.numeric(st_length(st_intersection(geometry,
                                                                  gap_sf)))) %>%
      ungroup()
    
    max_shared_length <- max(touching_neighbors$shared_length)
    
    # Find the neighbor with the longest shared boundary
    best_match_id <- touching_neighbors %>%
      filter(shared_length == max_shared_length) %>%
      mutate(min_area = min(st_area(geometry))) %>%
      filter(st_area(geometry) == min_area) %>%
      mutate(centroid_dist = st_distance(st_centroid(gap_sf$geometry),
                                         st_centroid(geometry))) %>%
      slice_min(centroid_dist, n = 1) %>%
      pull(id)
    
    # Merge the gap into the best-matching hexagon
    new_geom <- st_union(big_cells2$geometry[big_cells2$id == best_match_id],
                         gap_sf$geometry)
    
    big_cells2$geometry[big_cells2$id == best_match_id] <- st_make_valid(st_cast(new_geom, 
                                                                                 "POLYGON"))
  }
}


## check for multipolygons
nrow(big_cells[st_geometry_type(big_cells2) == "MULTIPOLYGON", ])

ggplot()+
  geom_sf(data = single_polys, fill="black") +
  geom_sf(data = gaps, fill="hotpink")+
  geom_sf(data = big_cells2, fill="black")



## ----merge_again, message=F, warning=F----------------------------------------------------------------
big_cells2 <- single_polys %>% filter(st_area(geometry) >= threshold)

merged_hexes <- st_union(big_cells2$geometry)

gaps <- st_difference(puget_polygon, merged_hexes)
gaps <- st_cast(gaps, "POLYGON")


ggplot()+
  geom_sf(data = single_polys, fill="black") +
  geom_sf(data = gaps, color="hotpink", fill=NA)



## ----gap_proc_2, message=F, warning=F-----------------------------------------------------------------
big_cells3 <- big_cells2
for (i in seq_len(nrow(gaps))) {
  gap_geom <- gaps[i,]$geom  # Get individual gap polygon
  gap_sf <- st_as_sf(data.frame(geometry = gap_geom))
  # Find touching hexagons (neighbors that share an edge)
  touching_neighbors <- big_cells2[st_touches(big_cells2, gap_sf,
                                              sparse = FALSE), ]
  
  
  if (nrow(touching_neighbors) > 0) {
    # Calculate shared boundary length between the gap and each neighbor
    touching_neighbors <- touching_neighbors %>%
      rowwise() %>%
      mutate(shared_length = as.numeric(st_length(st_intersection(geometry,
                                                                  gap_sf)))) %>%
      ungroup()
    
    max_shared_length <- max(touching_neighbors$shared_length)
    
    # Find the neighbor with the longest shared boundary
    best_match_id <- touching_neighbors %>%
      filter(shared_length == max_shared_length) %>%
      mutate(min_area = min(st_area(geometry))) %>%
      filter(st_area(geometry) == min_area) %>%
      mutate(centroid_dist = st_distance(st_centroid(gap_sf$geometry),
                                         st_centroid(geometry))) %>%
      slice_min(centroid_dist, n = 1) %>%
      pull(id)
    
    # Merge the gap into the best-matching hexagon
    new_geom <- st_union(big_cells3$geometry[big_cells3$id == best_match_id], 
                         gap_sf$geometry)
    
    big_cells3$geometry[big_cells3$id == best_match_id] <- st_make_valid(st_cast(new_geom,
                                                                                 "POLYGON"))
  }
}


## check for multipolygons
nrow(big_cells[st_geometry_type(big_cells3) == "MULTIPOLYGON", ])

ggplot()+
  geom_sf(data = single_polys, fill="black") +
  geom_sf(data = gaps, fill="hotpink")+
  geom_sf(data = big_cells3, fill="black")



## ----check_over, message=F, warning=F-----------------------------------------------------------------
overlap_pairs <- st_overlaps(big_cells3, big_cells3, sparse = FALSE)
sum(overlap_pairs)


## ----no_multi, message=F, warning=F-------------------------------------------------------------------
any(!st_is_valid(big_cells3))
nrow(big_cells3[st_geometry_type(big_cells3) == "MULTIPOLYGON", ])
any(st_overlaps(big_cells3, big_cells3, sparse = F))


## ----mak_val, message=F, warning=F--------------------------------------------------------------------
hex_final <- st_sf(geometry = big_cells3) %>%
  st_make_valid() %>%
  mutate(area = round(as.numeric(st_area(geometry))/1e6,2))


any(!st_is_valid(hex_final))
nrow(hex_final[st_geometry_type(hex_final) == "MULTIPOLYGON", ])
any(st_overlaps(hex_final, hex_final, sparse = F))


hex_final$ID <- paste0("G",seq_len(nrow(hex_final)))
hex_final$numid <- seq_len(nrow(hex_final))

hex_final$id <- NULL


## ----neighs, message=F, warning=F---------------------------------------------------------------------
neighbors <-spdep::poly2nb(hex_final, row.names=hex_final$numid,queen =F,
                           snap = 0.001)

all(names(neighbors) == hex_final$numid)

adjacency_info <- spdep::nb2WB(neighbors)




## ----save-grid, eval = F------------------------------------------------------------------------------
# st_write(hex_final,"GIS_COVS/OUTPUTS/grid2km_hex.gpkg", delete_layer = TRUE)

