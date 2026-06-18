# Details For Files

- `track_obs_info.RData`
contains `ydat_tidal` and `DetectData` and used in [**08-FormattingData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/08-Formatting.pdf)
  - `ydat_tidal` has a row for each unique PSU-Segment survey event (8,095).
    - `sID` unique numerical value for each row
    - `trip_date` unique stratum-psu-segment-date ID
    - `date` date of survey
    - `OBSP` observer-pair combination for that trip_date
    - `obsNum` numerical value for `OBSP`
    - `month` three letter abbreviation for month of survey
    - `dist_shore` distance from shore during survey (in meters)
    - `season` **b** for "breeding" and **nb** for "non-breeding" seasons.
    - `seasNum` numerical value for `season` 1 for b or 2 for nb
    - `myNum` numerical value for the month-year of survey 1 to 100
    - `BF` Beaufort Sea State: 0, 1, or 2
    - `totobs` total number of MAMU observations
    - `effort` total survey area effort (length of trackline times 430 m) in $km^2$
    - `mNum` numerical version of `month` 1 to 11
    - `BF0` 1 if BF = 0 otherwise 0
    - `BF1` 1 if BF = 1 otherwise 0
    - `BF2` 1 if BF = 2 otherwise 0
    - `survey_tide` tidal height during survey period (meters)
    
  - `DetectData` has observation-level information.
    - `sID` unique numerical value for each row
    - `trip_date` unique stratum-psu-segment-date ID
    - `date` date of survey
    - `obs` 1 for every row
    - `grpsz` size of group observed
    - `perp_dist` perpendicular distance to observation in meters.
    - `OBSP` observer-pair combination for that trip_date
    - `obsNum` numerical value for `OBSP`
    - `month` three letter abbreviation for month of survey
    - `dist_shore` distance from shore during survey (in meters)
    - `season` **b** for "breeding" and **nb** for "non-breeding" seasons.
    - `seasNum` numerical value for `season` 1 for b or 2 for nb
    - `myNum` numerical value for the month-year of survey 1 to 100
    - `BF` Beaufort Sea State: 0, 1, or 2
    - `mNum` numerical version of `month` 1 to 11
    - `BF0` 1 if BF = 0 otherwise 0
    - `BF1` 1 if BF = 1 otherwise 0
    - `BF2` 1 if BF = 2 otherwise 0

- `formatted_data_2026.RData`
Created in in [**08-FormattingData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/08-Formatting.pdf) and used in [**HDS_Model.R**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/HDS_Model.R)

- `Survey_Grid_Info.RData`
Created in in [**08-FormattingData.pdf**](https://github.com/sjgillman/PS_MAMU/blob/main/CovariateProcessing/08-Formatting.pdf) and used in [**PostProcessing**](https://github.com/sjgillman/PS_MAMU/blob/main/PostProcessing) for predictions.

