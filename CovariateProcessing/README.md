# Directory Information

[**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf) This script is used to construct a clean, continuous hexagonal analytical grid over the study area in the Puget Sound region. It uses `reduced_area.gpkg`, `Dclass_cut.gpk`, and `puget_poly.gpkg` located in [**GIS_COVS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/GIS_COVS). Final product is `grid2km_hex.gpkg` located in [**OUTPUTS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/OUTPUTS) and used to link static and dynamic covariates to specific locations. Grids used throughout the analysis and where density is assigned to. `SS_Bathymetry.tiff` is the [Bathymetric Base Map for the Salish Sea Bioregion](https://www.arcgis.com/home/item.html?id=f23310e286614728a823ae84ab865cc1) by Aquila Flower, 2021. I used it to make a closed polygon shape for other analyses. 3-arc second (approximately 90 meter) spatial resolution. Vertical datum: approximately Mean Sea Level, but is not included due to size and must be downloaded directly from source if wanting to follow code line by line.

[**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf) Script to calculate and assign static environmental covariates across the study area for both grid cells and surveyed tracklines. It uses `reduced_area.gpkg`, `Dclass_cut.gpk`, `puget_poly.gpkg`, and `all_tracks_2026_updated.gpkg` located in [**GIS_COVS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/GIS_COVS) and `grid2km_hex.gpkg` located in [**OUTPUTS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/OUTPUTS). Final products are `all_static_hex.gpkg` and `all_static_track.gpkg` located in [**OUTPUTS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/OUTPUTS).

## GIS_COVS

These geopackages were created via QGIS or directly in R either as stand alone objects (e.g., study area polygon, Puget Sound polygon) or from files linked with details on their location. If the geopackage is modified, I used QGIS to crop the spatial object to within the study area and converted the projections to CRS 26910 for easier use in R and for reducing the file size. All Original sources for each geopackage are linked. More detail as to when and how they are used can be found within the code.

## OUTPUTS

End products of scripts from [**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf), [**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf),



