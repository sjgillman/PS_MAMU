# Predicting density and assessing factors driving marbled murrelet distribution in Puget Sound using hierarchical distance sampling

### Code by S.J. Gillman

# Code used to pull out parts of results and save in smaller chunks due to github size limitations
library(tidyverse)
library(MCMCvis)
library(coda)

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


lambda_sub25 <- lambda_sub[6001:7000,1:2000]
lambda_sub26 <- lambda_sub[6001:7000,2001:4000]
lambda_sub27 <- lambda_sub[6001:7000,4001:6000]
lambda_sub28 <- lambda_sub[6001:7000,6001:8095]

saveRDS(lambda_sub25, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof7.rds")
saveRDS(lambda_sub26, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof7b.rds")
saveRDS(lambda_sub27, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof7c.rds")
saveRDS(lambda_sub28, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof7d.rds")



lambda_sub29 <- lambda_sub[7001:8000,1:2000]
lambda_sub30 <- lambda_sub[7001:8000,2001:4000]
lambda_sub31 <- lambda_sub[7001:8000,4001:6000]
lambda_sub32 <- lambda_sub[7001:8000,6001:8095]

saveRDS(lambda_sub29, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof8.rds")
saveRDS(lambda_sub30, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof8b.rds")
saveRDS(lambda_sub31, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof8c.rds")
saveRDS(lambda_sub32, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof8d.rds")


lambda_sub33 <- lambda_sub[8001:9000,1:2000]
lambda_sub34 <- lambda_sub[8001:9000,2001:4000]
lambda_sub35 <- lambda_sub[8001:9000,4001:6000]
lambda_sub36 <- lambda_sub[8001:9000,6001:8095]

saveRDS(lambda_sub33, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof9.rds")
saveRDS(lambda_sub34, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof9b.rds")
saveRDS(lambda_sub35, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof9c.rds")
saveRDS(lambda_sub36, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof9d.rds")

lambda_sub37 <- lambda_sub[9001:10000,1:2000]
lambda_sub38 <- lambda_sub[9001:10000,2001:4000]
lambda_sub39 <- lambda_sub[9001:10000,4001:6000]
lambda_sub40 <- lambda_sub[9001:10000,6001:8095]

saveRDS(lambda_sub37, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof10.rds")
saveRDS(lambda_sub38, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof10b.rds")
saveRDS(lambda_sub39, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof10c.rds")
saveRDS(lambda_sub40, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof10d.rds")


lambda_sub41 <- lambda_sub[10001:10200,1:2000]
lambda_sub42 <- lambda_sub[10001:10200,2001:4000]
lambda_sub43 <- lambda_sub[10001:10200,4001:6000]
lambda_sub44 <- lambda_sub[10001:10200,6001:8095]

saveRDS(lambda_sub41, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof11.rds")
saveRDS(lambda_sub42, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof11b.rds")
saveRDS(lambda_sub43, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof11c.rds")
saveRDS(lambda_sub44, "RESULTS/COMPRESSED/GOF/lambda_posterior_gof11d.rds")

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

pcap_sub25 <- pcap_sub[6001:7000,1:2000]
pcap_sub26 <- pcap_sub[6001:7000,2001:4000]
pcap_sub27 <- pcap_sub[6001:7000,4001:6000]
pcap_sub28 <- pcap_sub[6001:7000,6001:8095]

saveRDS(pcap_sub25, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof7.rds")
saveRDS(pcap_sub26, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof7b.rds")
saveRDS(pcap_sub27, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof7c.rds")
saveRDS(pcap_sub28, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof7d.rds")



pcap_sub29 <- pcap_sub[7001:8000,1:2000]
pcap_sub30 <- pcap_sub[7001:8000,2001:4000]
pcap_sub31 <- pcap_sub[7001:8000,4001:6000]
pcap_sub32 <- pcap_sub[7001:8000,6001:8095]

saveRDS(pcap_sub29, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof8.rds")
saveRDS(pcap_sub30, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof8b.rds")
saveRDS(pcap_sub31, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof8c.rds")
saveRDS(pcap_sub32, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof8d.rds")


pcap_sub33 <- pcap_sub[8001:9000,1:2000]
pcap_sub34 <- pcap_sub[8001:9000,2001:4000]
pcap_sub35 <- pcap_sub[8001:9000,4001:6000]
pcap_sub36 <- pcap_sub[8001:9000,6001:8095]

saveRDS(pcap_sub33, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof9.rds")
saveRDS(pcap_sub34, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof9b.rds")
saveRDS(pcap_sub35, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof9c.rds")
saveRDS(pcap_sub36, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof9d.rds")

pcap_sub37 <- pcap_sub[9001:10000,1:2000]
pcap_sub38 <- pcap_sub[9001:10000,2001:4000]
pcap_sub39 <- pcap_sub[9001:10000,4001:6000]
pcap_sub40 <- pcap_sub[9001:10000,6001:8095]

saveRDS(pcap_sub37, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof10.rds")
saveRDS(pcap_sub38, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof10b.rds")
saveRDS(pcap_sub39, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof10c.rds")
saveRDS(pcap_sub40, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof10d.rds")


pcap_sub41 <- pcap_sub[10001:10200,1:2000]
pcap_sub42 <- pcap_sub[10001:10200,2001:4000]
pcap_sub43 <- pcap_sub[10001:10200,4001:6000]
pcap_sub44 <- pcap_sub[10001:10200,6001:8095]

saveRDS(pcap_sub41, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof11.rds")
saveRDS(pcap_sub42, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof11b.rds")
saveRDS(pcap_sub43, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof11c.rds")
saveRDS(pcap_sub44, "RESULTS/COMPRESSED/GOF/pcap_posterior_gof11d.rds")

