# Directory Information

[**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf) This script is used to construct a clean, continuous hexagonal analytical grid over the study area in the Puget Sound region. It uses `reduced_area.gpkg`, `Dclass_cut.gpk`, and `puget_poly.gpkg` located in [**GIS_COVS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/GIS_COVS). Final product is `grid2km_hex.gpkg` located in [**OUTPUTS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/OUTPUTS) and used to link static and dynamic covariates to specific locations. Grids used throughout the analysis and where density is assigned to.

## GIS_COVS

These geopackages were created via QGIS or directly in R either as stand alone objects (e.g., study area polygon, Puget Sound polygon) or from files linked with details on their location. If the geopackage is modified, I used QGIS to crop the spatial object to within the study area and converted the projections to CRS 26910 for easier use in R and for reducing the file size. All Original sources for each geopackage are linked. More detail as to when and how they are used can be found within the code.

## OUTPUTS

End products of scripts from [**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf), [**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf),



