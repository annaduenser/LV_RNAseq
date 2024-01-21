
# filter tsv files for SUPPA
# Oktobrt 2020

getwd()

library("dplyr")
library("tidyverse")

STAGE <- "L" #change this!!

FILE.DIR     <- "/cl_tmp/singh_duenser/all_LV/DTU"
PATH.OUT <- "/cl_tmp/singh_duenser/all_LV/DTU/output/"
DATE <- format(Sys.time(), "%m%d%Y")

tsv_matrix <- read.table(paste(FILE.DIR, "/transcript_tpm_all_", STAGE, ".tsv", sep = ""), header = TRUE)

my_log <- file(paste("log_subsetTSV_", STAGE,"_R_", DATE, ".txt", sep = ""))
sink(my_log, append = TRUE, type = "output", split = TRUE)

OJ_sub <- tsv_matrix %>% select(matches("OJ"))
write.table(as.data.frame(OJ_sub), file = paste0(PATH.OUT,"OJ_", STAGE, "_transcript_tpm.tsv"), sep="\t", quote=F)

PJ_sub <- tsv_matrix %>% select(matches("PJ"))
write.table(as.data.frame(PJ_sub), file = paste0(PATH.OUT,"PJ_", STAGE, "_transcript_tpm.tsv"), sep="\t", quote=F)
print("save OJ subset")
print("save PJ subset")
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
  temp_coef = paste(s1, exp, sep = "_" )
  print(temp_coef)
  temp_matrix <- tsv_matrix %>% dplyr::select(contains(exp))
  temp_res <- temp_matrix %>% dplyr::select(matches(s1))

  write.table(as.data.frame(temp_res), file = paste0(PATH.OUT, temp_coef, "_", STAGE, "_transcript_tpm.tsv"), sep="\t", quote=F)
  
}

sink()

quit(save="no")
