# Directory Information

[**08-FormattingData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/08-Formatting.pdf) This script is used to check candidiate covariates and prepare data for inputting into the the model.
  - It uses `dynamic_data_clean_grids.rds`, `dynamic_data_clean_tracks.rds`, `all_static_covs.csv`, `all_static_tacks.csv`, `grid_currents.csv`, `track_currents.csv` located in [**OUTPUTS**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/OUTPUTS) and `track_obs_info.Rdata` located in [**DataFiles**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/DataFiles). Further details on `track_obs_info.Rdata` is included in the code.
  - Final product is `formatted_data_2026.RData` and `Survey_Grid_info.RData` located in [**DataFiles**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/DataFiles) and used in the [**HDS_Model**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/HDS_Model.R) and [**PostProcessing**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing).


[**HDS_Model.R**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/HDS_Model.R) This is the model code. It is structured to run on a HCP system as an array whereby three chains are run on separate nodes.
- Uses `formatted_data_2026.RData` located in [**DataFiles**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/DataFiles)
- Final product are three separate chain outputs in the [**RESULTS**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/RESULTS) in the PostProcessing directory.

## DataFiles
Files required to format the data and run model.
