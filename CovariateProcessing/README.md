# Directory Information

## GIS_COVS
### GPKG
These geopackages were created via **QGIS** or directly in **R** either as stand alone objects (e.g., study area polygon, Puget Sound polygon) or from files linked with details on their location. If the geopackage is modified, I used QGIS to crop the spatial object to within the study area and converted the projections to CRS 26910 for easier use in R and for reducing the file size. All Original sources for each geopackage are linked. More detail as to when and how they are used can be found within the code.

- `reduced_area.gpkg`
This is a trimmed version of the study area which has the lower region of Puget Sound removed as it was never surveyed.
It is used throughout the processing and analysis.

- `Dclass_cut.gpkg`
The geopackage for the [Dethier Class](https://www.eopugetsound.org/habitats/shore-types) which was adapted from the WA ShoreZone Inventory in 2014. The html provides further description. It is simply the clipped version within the study in gpkg format of the downloadable file from the link above. The clipping was originally done in **QGIS**.The gpkg is used as the shoreline for clipping purposes and to assign shoretype. It is later further cropped. _CRS: 26910 (meters)_

- `puget_poly.gpkg`
This is a single polygon feature that is the shape of the waters to the shoreline of Puget Sound. Made in **Covariate Processing** [**01-MakingGrids.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/01-MakingGrids.pdf) and slightly cropped in **QGIS**.
Used throughout the analysis.

- `CO-OPS_Regional_Zoning.gpkg`
**This is the original file** [CO-OPS Regional Zoning](https://www.arcgis.com/home/item.html?id=20fbff7c96fe4afebbf92e2c9a89b856) used to determine the tidal information for areas outside of the station locations.
Used in **06-TidalData.pdf**

- `SSM_mesh.gpkg`
I made with **QGIS** from the [Salish Sea Model was developed by Pacific Northwest National Laboratory (PNNL)](https://ecology.wa.gov/research-data/data-resources/models-spreadsheets/modeling-the-environment/salish-sea-modeling). The original file is a `geodatabase` file located on the [SSM's Downloadable Files Site](https://fortress.wa.gov/ecy/ezshare/EAP/SalishSea/SalishSeaModelBoundingScenarios.html) under the *Geographical Information System files* section. The original geodatabase is also included with the other original spatial files called `SSM_grid_web 2.gdb`.
Used in **Navy Covariate Processing, Chapter 07: Puget Current Data**

- `navy_edit_psu.gpkg`
polygons of navy PSUs I created in **QGIS** from the **Navy GPS Files** previously provided to me.
Used in **Navy Covariate Processing, Chapter 05: Tracklines**

- `pmep_biotic_habitat.gpkg`
**The Pacific Marine and Estuarine Fish Habitat Partnership**. Coastal and Marine Ecological Classification Standard (CMECS) out to -200 [Biotic Component](https://www.pacificfishhabitat.org/data/estuarine-biotic-habitat) (BC), Substrate Component (SC), and the nearshore zonal data and [current estuary extents](West Coast USA Current and Historical Estuary Extent).
*Did not end up using in analysis.*

- `pmep_substrate_habitat.gpkg`
**The Pacific Marine and Estuarine Fish Habitat Partnership**. Coastal and Marine Ecological Classification Standard (CMECS) out to -200 [Biotic Component](https://www.pacificfishhabitat.org/data/estuarine-biotic-habitat) (BC), Substrate Component (SC), and the nearshore zonal data and [current estuary extents](West Coast USA Current and Historical Estuary Extent).
Used in **Navy Covariate Processing, Chapter 03: Static Covariates**

- `pmep_estu_ext.gpkg`
**The Pacific Marine and Estuarine Fish Habitat Partnership**. Coastal and Marine Ecological Classification Standard (CMECS) out to -200 [Biotic Component](https://www.pacificfishhabitat.org/data/estuarine-biotic-habitat) (BC), Substrate Component (SC), and the nearshore zonal data and [current estuary extents](West Coast USA Current and Historical Estuary Extent).
Used in **Navy Covariate Processing, Chapter 03: Static Covariates**


## OUTPUTS

- `grid4km_hex.gpkg`
Grids used throughout the analysis and where density is assigned to. Made in **Navy Covariate Processing, Chapter 02: Making Grids**. After that, `reduced_area.gpkg` is used. *Throughout the code, there will be things labeled with 'hex', this is because originally I was using a hexagon shape and later changed to squares. I did not want to change the name throughout the code to left it as hex.*
    |-- `grid_currents.gpkg` # Average current per grid. Made in **Navy Covariate Processing, Chapter 07: Puget Current Data**.

