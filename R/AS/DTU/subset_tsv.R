# filter tsv files for SUPPA
# Oktobrt 2020

getwd()

library("dplyr")
library("tidyverse")

STAGE <- "L" # change this!

FILE.DIR     <- "/cl_tmp/singh_duenser/all_LV/DTU"
PATH.OUT <- "/cl_tmp/singh_duenser/all_LV/DTU/"
DATE <- format(Sys.time(), "%m%d%Y")

tsv_matrix <- read.table(paste(FILE.DIR, "/transcript_tpm_all_", STAGE, ".tsv", sep = ""), header = TRUE)

my_log <- file(paste("log_subsetTSV_R_", DATE,"_", STAGE, ".txt", sep = ""))
sink(my_log, append = TRUE, type = "output", split = TRUE)

OJ_sub <- tsv_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT,"transcript_tpm_", STAGE, "_OJ.tsv"), sep="\t", quote=F)

PJ_sub <- tsv_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"transcript_tpm_", STAGE, "_PJ.tsv"), sep="\t", quote=F)
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
  temp_coef = paste(paste0(s1, s2),exp, sep = "_" )
  print(temp_coef)
  temp_matrix <- tsv_matrix %>% dplyr::select(contains(exp))
  temp_res <- temp_matrix %>% dplyr::select(matches(paste0( s1, "|", s2)))
  
  write.table(as.data.frame(temp_res), file = paste0(PATH.OUT,"transcript_tpm_",temp_coef,"_", STAGE, ".tsv"), sep="\t", quote=F)
  
}

sink()

quit(save="no")

