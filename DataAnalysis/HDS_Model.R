################################################################################
#### Predicting density and assessing factors driving marbled murrelet distribution in Puget Sound using hierarchical distance sampling  #####
################################################################################
# ==============================================================================
# DATA INFO
# ==============================================================================
# "formatted_data_2026.RData" = ydat, detectDF, custom_breaks
# ydat: dataset with 8085 rows (One row for ever survey); 40 columns
# detectDF: individual detection bin info
# custom_breaks: bin widths for detection
# Data were created in `08-FormattingData.pdf`

## Load Packages
library(tidyverse)
library(nimble)

## Load Data
load("formatted_data_2026.RData")



## This code is formatted to run the model on UW's HCP, HYAK where by the model
## is run as an array on three separate cores and each chain is saved separately

## To get Array info
args <- commandArgs(trailingOnly = TRUE)

## Make a chain ID
chain_index <- as.numeric(args[1])

## Set Seed
set.seed(chain_index)


# ==============================================================================
# MODEL CODE
# ==============================================================================

ModelCode <- nimbleCode({
  # ----------------------------------------------------------------------------
  # PRIORS & HYPERPARAMETERS
  # ----------------------------------------------------------------------------
  ## Detection Parameters ##
  # Detection: BF0, BF1, BF2
  for (b in 1:3) {
    sigma0[b] ~ dnorm(log(100), sd = 1)
  }
  
  ## getting missing tidal data (survey level data)
  mu_tide ~ dnorm(0, sd = 2)      # Global mean tide
  sig_tide ~ dunif(0, 5)        # Variability in tide
  
  # Tidal Height
  beta ~ dnorm(0, sd =1)
  
  # Random effects: Observer Pairs
  sig_pair ~ dunif(0,1.5) # Hyperparameter for observer pairs
  for (t in 1:max(PAIRS)){
    eps_pair[t] ~ dnorm(0, sd = sig_pair)
  } 
  
  # Abundance: Seasonality and Overdispersion
  alpha0[1] ~ dnorm(0, sd = 1) # Breeding intercept
  alpha0[2] ~ dnorm(0, sd = 1) # Non-Breeding intercept
  
  ## getting missing Grand tide (monthly averages)
  mu_gt ~ dnorm(0, sd = 2)      # Global mean tide
  sig_gt ~ dunif(0, 5)        # Variability in tide
  
  # Year specific overdispersion
  shape_r ~ dexp(1) 
  rate_r  ~ dexp(1)
  
  for (y in 1:max(MONTHYEAR)){
    rN[y] ~ dgamma(shape_r, rate_r) 
  }
  
  
  # Random effects: Month
  sig_mon ~ dunif(0,1.5) # Hyperparameter for Month
  for (t in 1:max(MONTH)){
    eps_mon[t] ~ dnorm(alpha0[MONTHSEASON[t]], sd = sig_mon)
  }
  
  # Lambda Static Coefficients: Depth, BPI, RIE;
  # Categorical: Shoreline 7; seafloor 8
  for (a in 1:18){
    alpha_stat[a] ~ dnorm(0, sd = 1)
  }
  
  # Lambda Dynamic Coefficients: PAR, DO, HQH,GT, DShore, DShoreSQ
  for (aa in 1:2){ # 1 = breeding; 2 = non-breeding
    for (a in 1:6){
      alpha_sea[aa,a] ~ dnorm(0, sd = 1)
    }
  }
  
  ## Group Size Hyperparameters ##
  mu_delta ~ dnorm(0, sd = 0.5) # global mean
  sig_delta ~ dunif(0, 1)       # gs SD
  
  # ----------------------------------------------------------------------------
  # SUB-MODELS: Group Size & Detection Scale
  # ----------------------------------------------------------------------------
  
  for (m in 1:nMY) {
    delta0[m] ~ dnorm(mu_delta, sd = sig_delta) # Group Size Intercept
    gs.lam[m] <- exp(delta0[m])                 # Expected Group Size 
    gs.expected[m] <- gs.lam[m]+1               # Add back 1
  } 
  
  # ----------------------------------------------------------------------------
  # LIKELIHOODS
  # ----------------------------------------------------------------------------
  
  for(i in 1:nObs) {
    
    # truncated half-normal
    DIST[i] ~ T(dnorm(0, sd = sigma[sID[i]]),0,w)
  }
  
  for (r in 1:nS){
    # get missing tide data
    SIG_COV[r] ~ dnorm(mu_tide, sd = sig_tide)
    
    # Scale Parameter Calculation
    sigma[r] <- exp(sigma0[BF[r]] + SIG_COV[r]*beta + eps_pair[PAIRS[r]])
    
    # Effective strip width
    esw[r] <- ((pnorm(w / sigma[r], 0, 1) - 0.5))*sqrt(2*3.14159265359)*sigma[r]
    
    # Overall pcap over the full strip width
    pcap[r] <- esw[r] / w
    
    ## Group Size ##
    GS[r] ~ dpois(C[r] * gs.lam[MONTHYEAR[r]])
    
    # ----------------------------------------------------------------------------
    # SUB-MODELS: Counts & Latent Density
    # ----------------------------------------------------------------------------
    
    ### Observed population at each grid cell-visit ###
    C[r] ~ dbin(pcap[r], N[r])
    
    
    ## Latent Density ##
    N[r] ~ dnbinom((rN[MONTHYEAR[r]]/(rN[MONTHYEAR[r]] + lambda[r])),rN[MONTHYEAR[r]])
    
    ## Linear Predictor for Expected density ## Effort = log-transformed area surveyed
    # get missing tide data
    DYNAMIC[r, 4] ~ dnorm(mu_gt, sd = sig_gt)
    
    log(lambda[r]) <-  eps_mon[MONTH[r]]+ 
      EFFORT[r] +
      inprod(alpha_sea[SEASON[r], 1:6], DYNAMIC[r, 1:6]) +
      inprod(alpha_stat[1:18], STAT_COVS[r, 1:18])
  } # End of r loop
  
  # ----------------------------------------------------------------------------
  # DERIVED AVERAGES
  # ---------------------------------------------------------------------------- 
  sigma_mean <- sum(sigma[1:nS])/nS 
  
  for (y in 1:nMY) {
    ### Average detection ###
    pcap_mean[y] <- sum(pcap[START[y]:END[y]]) / nSMY[y]
  }
})


# ==============================================================================
# DATA PREP
# ==============================================================================

# determine number of surveys per month-year
month_counts <- ydat %>%
  arrange(myNum, sID) %>%
  group_by(myNum) %>%
  summarize(n = n()) %>%
  pull(n)

# Create the START and END index vectors
nMY <- length(month_counts)
END <- cumsum(month_counts)
START <- c(1, END[-nMY] + 1)

# get number of months within a season
MonSea <- ydat %>%
  distinct(mNum, seasNum) %>%
  arrange(mNum)


# Restructure BF to use as intercept
ydat <- ydat %>%
  mutate(BF = case_when(BF1 == 0 & BF2 == 0 ~ 1,
                        BF1 == 1 ~ 2,
                        BF2 == 1 ~ 3)) %>%
  arrange(myNum,sID)

# Combine Data together
nimConstants <- list(
  PAIRS = as.integer(ydat$obsNum), 
  SEASON = as.integer(ydat$seasNum), 
  MONTH = as.integer(ydat$mNum), 
  MONTHYEAR = as.integer(ydat$myNum),
  MONTHSEASON = as.integer(MonSea$seasNum),
  BF = as.integer(ydat$BF),
  
  ## INDEX ##
  nS = as.integer(nrow(ydat)), # 8095
  nMY = as.integer(nMY), # number of month-years (100)
  nSMY = as.integer(month_counts),
  START = as.integer(START), # number of segments surveyed in that month-year
  END = as.integer(END),
  nObs = as.integer(nrow(detectDF)),
  
  ## IDs ##
  sID = as.integer(detectDF$sID),
  
  # DETECTION #
  w = max(custom_breaks))


nimData <- list(
  ## DATA ##
  C = ydat$totobs,
  DIST = as.integer(detectDF$perp_dist),
  GS = ydat$sum_gsminus1,
  EFFORT = log(ydat$effort),
  SIG_COV = ydat$tidal_scale,
  STAT_COVS = as.matrix(ydat[c(21:38)]),
  DYNAMIC = as.matrix(ydat[,c(15:20)]))

# ==============================================================================
# INITIAL VALUES
# ==============================================================================

make_inits <- function(nimData, nimConstants){
  SIG_init <- nimData[["SIG_COV"]]
  tide_mean <- mean(SIG_init, na.rm = TRUE)
  SIG_init[is.na(SIG_init)] <- tide_mean
  
  DYNAM_init <- nimData[["DYNAMIC"]]
  gt_mean <- mean(DYNAM_init[, 4], na.rm = TRUE)
  DYNAM_init[is.na(DYNAM_init[, 4]), 4] <- gt_mean
  
  inits <- list(
    # detection
    sigma0 = rep(log(100),3),
    SIG_COV = SIG_init,
    beta = rnorm(1, 0, 0.1),
    sig_pair = runif(1,0,0.5),
    eps_pair = rep(0, max(nimConstants[["PAIRS"]])),
    mu_tide = tide_mean,            
    sig_tide = 1,                  
    
    # group size
    mu_delta = rnorm(1,0,1),
    sig_delta = runif(1,0.3,0.6),
    delta0 = rnorm(max(nimConstants[["MONTHYEAR"]]), 0, 0.1),
    
    # abundance
    N = nimData[["C"]]+5,
    DYNAMIC = DYNAM_init,
    mu_gt = gt_mean,                 
    sig_gt = 1,
    shape_r = 1,
    rate_r = 1,
    rN = rep(1, max(nimConstants[["MONTHYEAR"]])),
    alpha0 = rnorm(2,0,0.5),
    sig_mon = runif(1,0,0.5),
    eps_mon = rep(0, max(nimConstants[["MONTH"]])),
    alpha_stat = rnorm(18,0,0.5),
    alpha_sea = matrix(rnorm(12, 0,0.5), nrow = 2, ncol = 6))
  return(inits)
}

init <- make_inits(nimData, nimConstants)

# ==============================================================================
# IDENTIFY MONITORS
# ==============================================================================

params <- c(
  # Detection
  "sigma0","beta","sig_pair",
  "eps_pair",
  "sig_tide", "mu_tide",
  # Abundance
  "alpha0","eps_mon","sig_mon",
  "shape_r","rate_r","alpha_sea",
  "alpha_stat",
  "sig_gt","mu_gt",
  # Group Size
  "mu_delta","sig_delta","gs.expected",
  # Derived
  "sigma_mean", "pcap_mean")

# Additional Monitors
param_GoF <- c("lambda", "N", "rN","gs.lam","pcap")



# ==============================================================================
# RUN MODEL
# ==============================================================================
Rmodel <- nimbleModel(
  code = ModelCode,
  name = "ModelCode",
  constants = nimConstants,
  data = nimData,
  inits = init)

Cmodel <- compileNimble(Rmodel)


confMod <- configureMCMC(Rmodel, monitors = params, monitors2 = param_GoF)


Rmcmc <- buildMCMC(confMod)
Cmcmc <- compileNimble(Rmcmc, project = Rmodel)

nburn <- 125000
ni <- nburn + 50000
nt <- 10

(start <- Sys.time())   
samples <- runMCMC(
  Cmcmc,
  niter = ni,
  nburnin = nburn,
  thin = nt,
  thin2 = 25,
  nchains = 1,
  setSeed = TRUE,
  samplesAsCodaMCMC = T)
end <- Sys.time()
print(end - start)

sample_name  <- paste0("samples_", chain_index)
init_name    <- paste0("init_", chain_index)

assign(sample_name, samples)
assign(init_name, init)

objects_to_save <- c(sample_name, init_name,
                     "nimData", "nimConstants", "ydat",
                     "detectDF", "custom_breaks")

save(list = objects_to_save,
     file = paste0("CH1_nSQ_results_", chain_index, ".RData"))

