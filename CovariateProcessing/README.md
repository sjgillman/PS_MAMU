# Directory Information

## GIS_COVS
### GPKG
These geopackages were created via QGIS or directly in R either as stand alone objects (e.g., study area polygon, Puget Sound polygon) or from files linked with details on their location. If the geopackage is modified, I used QGIS to crop the spatial object to within the study area and converted the projections to CRS 26910 for easier use in R and for reducing the file size. All Original sources for each geopackage are linked. More detail as to when and how they are used can be found within the code.

## OUTPUTS

- `grid2km_hex.gpkg`
Grids used throughout the analysis and where density is assigned to. Made in **Navy Covariate Processing, Chapter 02: Making Grids**. After that, `reduced_area.gpkg` is used. *Throughout the code, there will be things labeled with 'hex', this is because originally I was using a hexagon shape and later changed to squares. I did not want to change the name throughout the code to left it as hex.*
    |-- `grid_currents.gpkg` # Average current per grid. Made in **Navy Covariate Processing, Chapter 07: Puget Current Data**.

