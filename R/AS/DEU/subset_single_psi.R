# filter psi event files for SUPPA
# Oktobrt 2020

getwd()

library("dplyr")
library("tidyverse")

STAGE <- "L" #change this

FILE.DIR    <- "/cl_tmp/singh_duenser/all_LV/suppa"
PATH.OUT <- "/cl_tmp/singh_duenser/all_LV/DEU/output/"
DATE <- format(Sys.time(), "%m%d%Y")

#filtered.gffcmp.LV.A.annotated_isoform.psi
psi_A3_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.A3.psi", sep = ""), header = TRUE)
psi_A5_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.A5.psi", sep = ""), header = TRUE)
psi_AF_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.AF.psi", sep = ""), header = TRUE)
psi_AL_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.AL.psi", sep = ""), header = TRUE)
psi_MX_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.MX.psi", sep = ""), header = TRUE)
psi_RI_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.RI.psi", sep = ""), header = TRUE)
psi_SE_matrix <- read.table(paste(FILE.DIR, "/filtered.gffcmp.LV.", STAGE, ".annotated.SE.psi", sep = ""), header = TRUE)


my_log <- file(paste("log_subsetPSIevent", STAGE,"_R_", DATE, ".txt", sep = ""))
sink(my_log, append = TRUE, type = "output", split = TRUE)

OJ_sub <- psi_A3_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_A3.tsv"), sep="\t", quote=F)
OJ_sub <- psi_A5_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_A5.tsv"), sep="\t", quote=F)
OJ_sub <- psi_AF_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_AF.tsv"), sep="\t", quote=F)
OJ_sub <- psi_AL_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_AL.tsv"), sep="\t", quote=F)
OJ_sub <- psi_MX_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_MX.tsv"), sep="\t", quote=F)
OJ_sub <- psi_RI_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_RI.tsv"), sep="\t", quote=F)
OJ_sub <- psi_SE_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT, "OJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_SE.tsv"), sep="\t", quote=F)

PJ_sub <- psi_A3_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_A3.tsv"), sep="\t", quote=F)
PJ_sub <- psi_A5_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_A5.tsv"), sep="\t", quote=F)
PJ_sub <- psi_AF_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_AF.tsv"), sep="\t", quote=F)
PJ_sub <- psi_AL_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_AL.tsv"), sep="\t", quote=F)
PJ_sub <- psi_MX_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_MX.tsv"), sep="\t", quote=F)
PJ_sub <- psi_RI_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_RI.tsv"), sep="\t", quote=F)
PJ_sub <- psi_SE_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_psi.LV.filtered.gffcmp.annotated_isoform_SE.tsv"), sep="\t", quote=F)

rm(PJ_sub, OJ_sub)


exp <- c("OJ", "PJ")
species <- c("Gh", "Ht", "Ml", "No", "Ps")
MERCH <- tibble(
  exp = rep(exp, 5),
  s1 = rep(species,2)
)
rm(exp, species)
for(i in 1:nrow(MERCH)){
  temp_string = paste(STAGE)
  print(temp_string)
  
  exp = as.character(MERCH$exp[i])
  s1  = MERCH$s1[i]
  print(exp)
  temp_coef = paste(s1,exp, sep = "_" )
  print(temp_coef)
  temp_matrix_A3 <- psi_A3_matrix %>% dplyr::select(contains(exp))
  temp_res_A3 <- temp_matrix_A3 %>% dplyr::select(matches(s1))
  #temp_res_PJ <- PJ %>% dplyr::select(matches(paste0( i[2], "|", i[3])))
  write.table(as.data.frame(temp_res_A3), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_A3.tsv"), sep="\t", quote=F)
  
  temp_matrix_A5 <- psi_A5_matrix %>% dplyr::select(contains(exp))
  temp_res_A5 <- temp_matrix_A5 %>% dplyr::select(matches(s1))
  #temp_res_PJ <- PJ %>% dplyr::select(matches(paste0( i[2], "|", i[3])))
  write.table(as.data.frame(temp_res_A5), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_A5.tsv"), sep="\t", quote=F)

  temp_matrix_AF <- psi_AF_matrix %>% dplyr::select(contains(exp))
  temp_res_AF <- temp_matrix_AF %>% dplyr::select(matches(s1))
  write.table(as.data.frame(temp_res_AF), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_AF.tsv"), sep="\t", quote=F)

  temp_matrix_AL <- psi_AL_matrix %>% dplyr::select(contains(exp))
  temp_res_AL <- temp_matrix_AL %>% dplyr::select(matches(s1))
  write.table(as.data.frame(temp_res_AL), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_AL.tsv"), sep="\t", quote=F)
  
  temp_matrix_MX <- psi_MX_matrix %>% dplyr::select(contains(exp))
  temp_res_MX <- temp_matrix_MX %>% dplyr::select(matches(s1))
  write.table(as.data.frame(temp_res_MX), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_MX.tsv"), sep="\t", quote=F)
  
  temp_matrix_RI <- psi_RI_matrix %>% dplyr::select(contains(exp))
  temp_res_RI <- temp_matrix_RI %>% dplyr::select(matches(s1))
  write.table(as.data.frame(temp_res_RI), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_RI.tsv"), sep="\t", quote=F)
  
  temp_matrix_SE <- psi_SE_matrix %>% dplyr::select(contains(exp))
  temp_res_SE <- temp_matrix_SE %>% dplyr::select(matches(s1))
  write.table(as.data.frame(temp_res_SE), file = paste0(PATH.OUT,temp_coef,"_", STAGE, "_psi.LV.filtered.gffcmp.annotated_event_SE.tsv"), sep="\t", quote=F)

}

sink()




quit(save="no")

