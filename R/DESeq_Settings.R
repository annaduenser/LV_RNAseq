# RNASeq Analysis Settings
# May 2020 
# anna.duenser@gmail.com


## ----1. Libraries-------------------------------------------------------------
# if (!requireNamespace('BiocManager', quietly = TRUE))
#  install.packages("BiocManager")
# BiocManager::install(c("DESeq2",  "biomaRt", "apeglm", "topGO"))
# BiocManager::install(c("PCAtools", "DESeq2", "limma", "GEOquery",
#                        "goseq", "biomaRt", "apeglm", "topGO", "apeglm"))
# BiocManager::available()
library("DESeq2")
library("tidyverse")
#library("rtracklayer")
library("biomaRt")
library("topGO")
library("apeglm")
#library("limma")
#install.packages("pheatmap")
library("pheatmap")
#BiocManager::install("EnhancedVolcano")
library("EnhancedVolcano")
#install.packages("gplots") # heatmap.2
library("gplots")
#library("RColorBrewer")
#install.packages("sprof", repos="http://R-Forge.R-project.org")
#library("sprof")

# library("PCAtools")
# library("BiocParallel")
# library("topGO")
# library("ggrepel") # not needed anymore?
# library("Biobase")
# library("GEOquery")
# install.packages('VennDiagram')
library("VennDiagram")
# library("Glimma")

## ----3. DESeq2 preperation----------------------------------------------------

# gene/transcript count matrix
gcmatrix <- read.csv(paste0(FILE.DIR,"/",GENE.MATRIX), row.names = 1)
#gcmatrix <- read.csv(GENE.MATRIX, row.names = 1)

sampleTable <- read.table(paste0(FILE.DIR,"/",PHENOTYPE.TABLE), header = T)

# define library as factor
sampleTable$library <- as.factor(sampleTable$library)

# select the rows that you need, if too much info
rownames(sampleTable) <- sampleTable[,1]
# add 6 if using the full matrix with OJ and PJ
sampleTable <- sampleTable %>% 
  dplyr::select(-1)

# head of gcmatrix and rows of sampleTable have to have same order!
ifelse((colnames(gcmatrix) == rownames(sampleTable)), print("Looking good!"), print("Your files have a problem!"))

       