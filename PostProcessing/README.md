# Directory Information

[**09-GoodnessofFit.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/09-GoodnessofFit.pdf) This script is used to get GoF values for latent abundance, counts, and group size sub-models. Due to the size of model outputs, data were subset into groups of 2000 posterior samples and can be found in the [**GOF**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/RESULTS/GOF) subfolder in the **RESULTS** folder. The code for subsetting the original model outputs is [**SubsettingModelOutputs.R**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/SubsettingModelOutputs.R).
  - It uses `Survey_Grid_Info.RData`, `chain_1.rds`, `chain_2.rds`, `chain_3.rds`, `nimConstants.rds`, `nimData.rds` located in the [**RESULTS**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/RESULTS) folder and `gof_SummaryStats.rds`, `N_posterior_gof.rds`, `rN_posterior_gof.rds`, `gs_posterior_gof.rds`, `pcap_posterior_gof1-6.rds`, `lambda_posterior_gof1-6.rds` from the **GOF** subfolder. pcap and lambda `.rds` files that end in the number are the iterations, 1 = 1 to 1000, 2 = 1001 to 2000, 3 = 2001 to 3000, etc. b,c,d are the PSU-Segments 2001 to 8095 broken up into 2k groups due to overall large size and needing to load to github.

[**10-PredictGridCells.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/10-PredictGridCells.pdf) Is the code used to make predicted density estimates from posterior samples. Includes functions to make month-year, average month, average season, etc predicted summaries across the grids.
- It uses `Survey_Grid_Info.RData`, `chain_1.rds`, `chain_2.rds`, `chain_3.rds`, `nimConstants.rds`, `nimData.rds` located in the [**RESULTS**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/RESULTS). Outputs from this code are in the [**PREDICTED**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/RESULTS/PREDICTED) subfolder in **RESULTS**.

[**11-MainPostProcessing.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/11-MainPostProcessing.pdf) All code required to make main tables and figures and summaries in the manuscript.

[**12-AppendixFigures.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing/12-AppendixFigures.pdf) All code required to make additional figures found in the Appendix.


## RESULTS
Main model outputs and subfolders containing data required to calculate GoF and grid cell predictions.
