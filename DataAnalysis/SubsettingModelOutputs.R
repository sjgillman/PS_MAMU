# Predicting density and assessing factors driving marbled murrelet distribution in Puget Sound using hierarchical distance sampling

### Code by S.J. Gillman

# Code used to pull out parts of results and save in smaller chunks due to github size limitations


# Model outputs from hyak
load("RESULTS/CH1_nSQ_results_1.RData")
load("RESULTS/CH1_nSQ_results_2.RData")
load("RESULTS/CH1_nSQ_results_3.RData")


# Small enough to save together
initial_values <- list(init_1,init_2,init_3)
saveRDS(initial_values, "RESULTS/COMPRESSED/initial_values.rds")

# Save the Model Input Data
saveRDS(nimConstants, "RESULTS/COMPRESSED/nimConstants.rds")
saveRDS(nimData, "RESULTS/COMPRESSED/nimData.rds")

# Coefficient/main monitors each get their own chain saved
saveRDS(samples_1[[1]], "RESULTS/COMPRESSED/chain_1.rds")
saveRDS(samples_2[[1]], "RESULTS/COMPRESSED/chain_2.rds")
saveRDS(samples_3[[1]], "RESULTS/COMPRESSED/chain_3.rds")

## Goodness of Fit are the large files
gof_chains <- coda::mcmc.list(samples_1[[2]],samples_2[[2]],samples_3[[2]])

# Summarize GoF monitors
results_gof <- MCMCsummary(gof_chains, probs = c(0.025,0.25,0.5,0.75, 0.975))
round(max(results_gof$Rhat, na.rm =T),2)

## Save 
saveRDS(results_gof, "RESULTS/COMPRESSED/GOF/gof_SummaryStats.rds")

## Create Matrix
post_gof <- as.matrix(rbind(samples_1[[2]], samples_2[[2]], samples_3[[2]]))

# Subset for Latent Density
N_sub <- post_gof %>%
  as.data.frame() %>%
  dplyr::select(contains("N[")) %>%
  dplyr::select(-c(contains("rN"), contains("total_expected"))) %>%
  as.matrix()

# Subset for Dispersion Parameter
rN_sub <- post_gof %>%
  as.data.frame() %>%
  dplyr::select(contains("rN")) %>%
  as.matrix()

# Subset for Expected Density
lambda_sub <- post_gof %>%
  as.data.frame() %>%
  dplyr::select(contains("lambda")) %>%
  as.matrix()


saveRDS(N_sub, "RESULTS/COMPRESSED/GOF/N_posterior_gof.rds")
saveRDS(rN_sub, "RESULTS/COMPRESSED/GOF/rN_posterior_gof.rds")


lambda_sub1 <- lambda_sub[1:1000,1:2000]
lambda_sub2 <- lambda_sub[1:1000,2001:4000]
lambda_sub3 <- lambda_sub[1:1000,4001:6000]
lambda_sub4 <- lambda_sub[1:1000,6001:8095]

saveRDS(lambda_sub1, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof1.rds")
saveRDS(lambda_sub2, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof1b.rds")
saveRDS(lambda_sub3, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof1c.rds")
saveRDS(lambda_sub4, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof1d.rds")

lambda_sub5 <- lambda_sub[1001:2000,1:2000]
lambda_sub6 <- lambda_sub[1001:2000,2001:4000]
lambda_sub7 <- lambda_sub[1001:2000,4001:6000]
lambda_sub8 <- lambda_sub[1001:2000,6001:8095]


saveRDS(lambda_sub5, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof2.rds")
saveRDS(lambda_sub6, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof2b.rds")
saveRDS(lambda_sub7, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof2c.rds")
saveRDS(lambda_sub8, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof2d.rds")

lambda_sub9 <- lambda_sub[2001:3000,1:2000]
lambda_sub10 <- lambda_sub[2001:3000,2001:4000]
lambda_sub11 <- lambda_sub[2001:3000,4001:6000]
lambda_sub12 <- lambda_sub[2001:3000,6001:8095]

saveRDS(lambda_sub9, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof3.rds")
saveRDS(lambda_sub10, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof3b.rds")
saveRDS(lambda_sub11, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof3c.rds")
saveRDS(lambda_sub12, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof3d.rds")

lambda_sub13 <- lambda_sub[3001:4000,1:2000]
lambda_sub14 <- lambda_sub[3001:4000,2001:4000]
lambda_sub15 <- lambda_sub[3001:4000,4001:6000]
lambda_sub16 <- lambda_sub[3001:4000,6001:8095]

saveRDS(lambda_sub13, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof4.rds")
saveRDS(lambda_sub14, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof4b.rds")
saveRDS(lambda_sub15, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof4c.rds")
saveRDS(lambda_sub16, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof4d.rds")

lambda_sub17 <- lambda_sub[4001:5000,1:2000]
lambda_sub18 <- lambda_sub[4001:5000,2001:4000]
lambda_sub19 <- lambda_sub[4001:5000,4001:6000]
lambda_sub20 <- lambda_sub[4001:5000,6001:8095]

saveRDS(lambda_sub17, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof5.rds")
saveRDS(lambda_sub18, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof5b.rds")
saveRDS(lambda_sub19, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof5c.rds")
saveRDS(lambda_sub20, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof5d.rds")


lambda_sub21 <- lambda_sub[5001:6000,1:2000]
lambda_sub22 <- lambda_sub[5001:6000,2001:4000]
lambda_sub23 <- lambda_sub[5001:6000,4001:6000]
lambda_sub24 <- lambda_sub[5001:6000,6001:8095]

saveRDS(lambda_sub21, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof6.rds")
saveRDS(lambda_sub22, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof6b.rds")
saveRDS(lambda_sub23, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof6c.rds")
saveRDS(lambda_sub24, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof6d.rds")


# Subset for Expected Group Size
gs_sub <- post_gof %>%
  as.data.frame() %>%
  dplyr::select(contains("gs.lam")) %>%
  as.matrix()


saveRDS(gs_sub, "RESULTS/COMPRESSED/GOF/gs_posterior_gof.rds")

# Subset for detections
pcap_sub <- post_gof %>%
  as.data.frame() %>%
  dplyr::select(contains("pcap")) %>%
  as.matrix()


pcap_sub1 <- pcap_sub[1:1000,1:2000]
pcap_sub2 <- pcap_sub[1:1000,2001:4000]
pcap_sub3 <- pcap_sub[1:1000,4001:6000]
pcap_sub4 <- pcap_sub[1:1000,6001:8095]

saveRDS(pcap_sub1, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof1.rds")
saveRDS(pcap_sub2, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof1b.rds")
saveRDS(pcap_sub3, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof1c.rds")
saveRDS(pcap_sub4, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof1d.rds")

pcap_sub5 <- pcap_sub[1001:2000,1:2000]
pcap_sub6 <- pcap_sub[1001:2000,2001:4000]
pcap_sub7 <- pcap_sub[1001:2000,4001:6000]
pcap_sub8 <- pcap_sub[1001:2000,6001:8095]


saveRDS(pcap_sub5, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof2.rds")
saveRDS(pcap_sub6, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof2b.rds")
saveRDS(pcap_sub7, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof2c.rds")
saveRDS(pcap_sub8, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof2d.rds")

pcap_sub9 <- pcap_sub[2001:3000,1:2000]
pcap_sub10 <- pcap_sub[2001:3000,2001:4000]
pcap_sub11 <- pcap_sub[2001:3000,4001:6000]
pcap_sub12 <- pcap_sub[2001:3000,6001:8095]

saveRDS(pcap_sub9, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof3.rds")
saveRDS(pcap_sub10, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof3b.rds")
saveRDS(pcap_sub11, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof3c.rds")
saveRDS(pcap_sub12, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof3d.rds")

pcap_sub13 <- pcap_sub[3001:4000,1:2000]
pcap_sub14 <- pcap_sub[3001:4000,2001:4000]
pcap_sub15 <- pcap_sub[3001:4000,4001:6000]
pcap_sub16 <- pcap_sub[3001:4000,6001:8095]

saveRDS(pcap_sub13, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof4.rds")
saveRDS(pcap_sub14, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof4b.rds")
saveRDS(pcap_sub15, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof4c.rds")
saveRDS(pcap_sub16, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof4d.rds")

pcap_sub17 <- pcap_sub[4001:5000,1:2000]
pcap_sub18 <- pcap_sub[4001:5000,2001:4000]
pcap_sub19 <- pcap_sub[4001:5000,4001:6000]
pcap_sub20 <- pcap_sub[4001:5000,6001:8095]

saveRDS(pcap_sub17, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof5.rds")
saveRDS(pcap_sub18, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof5b.rds")
saveRDS(pcap_sub19, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof5c.rds")
saveRDS(pcap_sub20, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof5d.rds")


pcap_sub21 <- pcap_sub[5001:6000,1:2000]
pcap_sub22 <- pcap_sub[5001:6000,2001:4000]
pcap_sub23 <- pcap_sub[5001:6000,4001:6000]
pcap_sub24 <- pcap_sub[5001:6000,6001:8095]

saveRDS(pcap_sub21, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof6.rds")
saveRDS(pcap_sub22, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof6b.rds")
saveRDS(pcap_sub23, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof6c.rds")
saveRDS(pcap_sub24, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof6d.rds")
