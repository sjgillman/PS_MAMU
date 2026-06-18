# Details For Files

- `all_tracklines_2026_final.gpkg`
PSU-segment level tracklines for every survey recorded. A total of 8,095 PSU-segments which provide the unique ID "trip_date", date, total survey effort length and the multilinestring geometry. Used throughout the analysis starting in [**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf). Compressed for downloadability.

- `lat_long_times.rds`
PSU-segment level lat-long information with times for each GPS point. Used in [**04-TidalData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/04-TidalData.pdf) and [**05-AverageCurrent.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/05-AverageCurrent.pdf).

- `reduced_area.gpkg`
This is a trimmed version of the study area which has the lower region of Puget Sound removed as it was never surveyed. It is used throughout the processing and analysis.

- `Dclass_cut.gpkg`
The geopackage for the [Dethier Class](https://www.eopugetsound.org/habitats/shore-types) which was adapted from the WA ShoreZone Inventory in 2014. The html provides further description. It is simply the clipped version within the study in gpkg format of the downloadable file from the link above. The clipping was originally done in QGIS. Used in [**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf) for clipping purposes and [**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf) to assign major shoreline types.

- `puget_poly.gpkg`
This is a single polygon feature that is the shape of the waters to the shoreline of Puget Sound. Made in **Covariate Processing** [**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf) and slightly cropped in **QGIS**.
Used throughout the analysis.

- `pmep_substrate_habitat.gpkg`
**The Pacific Marine and Estuarine Fish Habitat Partnership**. Coastal and Marine Ecological Classification Standard (CMECS) out to -200 Substrate Component (SC). Used to assign major seafloor substrate type. Compressed for downloadability.
Used in [**02-StaticCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/02-StaticCovariates.pdf).

- `ubcSSnBathymetry.csv`
Is the grid [SalishSeaCast](https://salishsea.eos.ubc.ca/nemo/) geo-location and bathymetry for the model they create and used here to link specific monthly observations to the study grids they are located in. I do not use their bathymetry data and only use the information for geo-locations. Used in [**03-DynamicCovariates.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/03-DynamicCovariates.pdf)

- `CO-OPS_Regional_Zoning.gpkg`
**This is the original file** [CO-OPS Regional Zoning](https://www.arcgis.com/home/item.html?id=20fbff7c96fe4afebbf92e2c9a89b856) used to determine the tidal information for areas outside of the station locations.
Used in [**04-TidalData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/04-TidalData.pdf) and [**05-AverageCurrent.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/05-AverageCurrent.pdf).

- `puget_current_stations.csv`
Is a subset of information from the `coops-historiccurrentstations.csv` file downloaded from NOAA's Tides & Currents' [current stations information](https://tidesandcurrents.noaa.gov/cdata/StationList?type=Current+Data&filter=historic&pid=39), "Historic Stations" in excel format. Used in [**05-AverageCurrent.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/05-AverageCurrent.pdf).

- `CURRENTS.zip`
Has all csv files that were downloaded individually for all stations from 2015 -2017 for a total of 134 stations. Recorded information were available at varying depths for each station and length and time of recordings also varied per station. It also includes `SSM_mesh.gpkg` which was made with **QGIS** from the [Salish Sea Model was developed by Pacific Northwest National Laboratory (PNNL)](https://ecology.wa.gov/research-data/data-resources/models-spreadsheets/modeling-the-environment/salish-sea-modeling). The original file is a `geodatabase` file located on the [SSM's Downloadable Files Site](https://fortress.wa.gov/ecy/ezshare/EAP/SalishSea/SalishSeaModelBoundingScenarios.html) under the *Geographical Information System files* section. *NOTE* average current speed was eventually dropped from the model due to correlation, but code it kept for records. Used in [**05-AverageCurrent.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/05-AverageCurrent.pdf).
