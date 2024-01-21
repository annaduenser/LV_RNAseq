# filter psi files for SUPPA
# Oktobrt 2020

getwd()

library("dplyr")
library("tidyverse")

STAGE <- "L"

FILE.DIR     <- "/cl_tmp/singh_duenser/all_LV/DTU"
PATH.OUT <- "/cl_tmp/singh_duenser/all_LV/DTU/"
DATE <- format(Sys.time(), "%m%d%Y")

#filtered.gffcmp.LV.A.annotated_isoform.psi
psi_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated_isoform.psi", sep = ""), header = TRUE)

my_log <- file(paste("log_subsetPSIisoform", STAGE,"_R_", DATE, ".txt", sep = ""))
sink(my_log, append = TRUE, type = "output", split = TRUE)

OJ_sub <- psi_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT,"filtered.gffcmp.LV.", STAGE, ".OJ.annotated_isoform.psi_",".tsv"), sep="\t", quote=F)

PJ_sub <- psi_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"filtered.gffcmp.LV.", STAGE, ".PJ.annotated_isoform.psi_",".tsv"), sep="\t", quote=F)
print("save OJ subset")
print("save PJ subset")
rm(PJ_sub, OJ_sub)


exp <- c("OJ", "PJ")
species <- c("Gh", "Ht", "Ml", "No", "Ps")
MERCH <- tibble(
  s1 = c(
    rep(species[1], 4),
    rep(species[2], 3),
    rep(species[3], 2),
    rep(species[4], 1)
  ),
  s2 = c(
    species[2:5], species[3:5], species[4:5], species[5]
  ),
)
MERCH <- rbind(cbind(exp = exp[1], MERCH), cbind(exp = exp[2], MERCH))
rm(exp, species)
#names(SUPPA.LIST)
SUPPA.RES <- list()
for(i in 1:nrow(MERCH)){
  temp_string = paste(STAGE)
  print(temp_string)
  
  exp = as.character(MERCH$exp[i])
  s1  = MERCH$s1[i]
  s2  = MERCH$s2[i]
  print(exp)
  temp_coef = paste(paste(s1, s2, sep = ""),exp, sep = "_" )
  print(temp_coef)
  temp_matrix <- psi_matrix %>% dplyr::select(contains(exp))
  temp_res <- temp_matrix %>% dplyr::select(matches(paste0( s1, "|", s2)))
  #temp_res_PJ <- PJ %>% dplyr::select(matches(paste0( i[2], "|", i[3])))
  
  write.table(as.data.frame(temp_res), file = paste0(PATH.OUT,"filtered.gffcmp.LV.", STAGE, ".annotated_isoform.psi_", temp_coef,".tsv"), sep="\t", quote=F)
  
}

sink()




quit(save="no")

