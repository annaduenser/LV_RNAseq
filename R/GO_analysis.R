## ----1. Variables load or remove unneeded-----------------------------------------------
library("GSEABase")
library("Category")
library("topGO")
library("biomaRt")
library("goseq")

citation("topGo")
citation("biomaRt")
citation("topGO")


supportedOrganisms()


#[topGO](https://bioconductor.org/packages/release/bioc/vignettes/topGO/inst/doc/topGO.pdf)


# load variables, if they are not in your environment
STAGE <- "L"
JAW <- "PJ"

FILE.DIR        <- "~/Google_Drive/KFU_RNAseq/R_files/DESeq/Data"
GENE.MATRIX     <- paste0("normalized_gcmatrix_", STAGE, "_01112021.csv", sep = "")
PHENOTYPE.TABLE <- paste0("phenotype_",STAGE, ".txt", sep = "")
DATE            <- format(Sys.time(), "%m%d%Y")

FILE.DIR.BASE        <- "~/Google_Drive/KFU_RNAseq/R_files/"
PATH.OUT        <- paste0(FILE.DIR.BASE, "GO/same_direction/")
FILE.DIR.GOFRAME        <- paste0(FILE.DIR.BASE, "GO/")

# set directory 
setwd(FILE.DIR)
getwd()

# source(file = "~/Google_Drive/KFU_RNAseq/R_files/RNASeq_Settings.R")
# source(file = "~/Google_Drive/KFU_RNAseq/R_files/DESeq2_Analysis_2020.R")



#########################################################################
###  2. bioMart to get gene names and GO term
#########################################################################

# You only need to do this once 

# 16        oniloticus_gene_ensembl      Oreochromis niloticus  ENSONIG
# listMarts()
# ensembl <- useMart("ensembl")                   
# datasets <- listDatasets(ensembl)
# head(datasets)                   
# grep("G*", datasets)
# searchDatasets(mart = ensembl, pattern = "aculeatus")
# oniloticus_gene_ensembl
# listAttributes(ensembl)
# searchAttributes(mart=ensembl, pattern = "evidence")
# search for filter patterns 
# searchFilters(mart = ensembl, pattern = "gene")

myMart = useMart("ensembl", dataset="oniloticus_gene_ensembl", host = "www.ensembl.org")

## retrieve GO annotation from ENSEMBL
# annot<-getBM(attributes = c("go_id","go_linkage_type","ensembl_gene_id"),
#              filters = 'biotype',values = "protein_coding",    # only focus on protein coding genes
#              mart = myMart)

## retrieve GO annotations from ENSEMBL
annot<-getBM(attributes = c("go_id","go_linkage_type","ensembl_gene_id"),    # I am not sure if I should filter for something
             mart = myMart)

goframeData <- annot
goframeData <- goframeData[which(goframeData[,2]!=""),]  # remove missing values for go_linkage_type
goframeData <- goframeData[which(goframeData[,3]!="NA"),]  # remove NA in geneID
head(goframeData)

# select GOID and ensemblID
GOdata <- goframeData %>% 
  dplyr::select(go_id, ensembl_gene_id)

# save this
write_tsv(GOdata, "~/Google_Drive/KFU_RNAseq/R_files/GO/goframeData.txt", na = "NA", col_names = FALSE)

###########################################################################
### GO  Enrichment analysis 
###########################################################################

# build your GO2geneID or geneID2GO dataframe
GO2geneID <- readMappings(file = paste0(FILE.DIR.GOFRAME, "goframeData.txt"), sep = "")
geneID2GO <- inverseList(GO2geneID)
geneNames <- names(geneID2GO)
str(head(geneID2GO))
length(geneNames)


#[topGO](https://bioconductor.org/packages/release/bioc/vignettes/topGO/inst/doc/topGO.pdf) Section 4.4

# If the user has some a priori knowledge about a set of interesting genes, he can test the enrichment of GO
# terms with regard to this list of interesting genes. In this scenario, when only a list of interesting genes is
# provided, the user can use only tests statistics that are based on gene counts, like Fisher’s exact test, Z score
# and alike.


# The geneList object is a named factor that indicates which genes are interesting and which not
# import your genes of interest

# shared_genes <-read.table(paste0(FILE.DIR,"/Output/shared_genes/", STAGE,"/", STAGE, "_", JAW, "_shared_DGE_ensemblID_HvsC_10182021.txt"),header=F)
# dim(shared_genes)

# shared_genes <-read.table(paste0(FILE.DIR,"/Output/st26_adult/L_A_", JAW, "_shared_DGE_ensemblID_HvsC_05172021.txt"),header=F)
# dim(shared_genes)

shared_genes <-read.table(paste0(FILE.DIR,"/Output/shared_genes/", STAGE,"/", STAGE, "_", JAW, "_shared_DGE_SAMEDIRECTION_ensemblID_HvsC_11152021.txt"),header=F)
dim(shared_genes)


# get ensemble IDs from expression matrix:

# gene.universe <- rownames(gcmatrix) %>% 
#   as_tibble() %>% 
#   separate(value,
#            c("gene_id", "ensembl"),
#            sep = "[|]", remove = TRUE) %>% 
#   dplyr::select(-1) %>% 
#   drop_na(ensembl)
# write.table(gene.universe, file = paste0(PATH.OUT, "gene_universe.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t")

universe <-read.table(paste0(FILE.DIR.GOFRAME,"gene_universe.txt"),header=F)

gene.universe <- universe %>% 
  unique()

sub <- as.character(gene.universe$V1) %in% geneNames
geneNames.universe <- geneNames[sub]


# all annotated genes:
# geneList1 <- factor(as.integer(geneNames %in% as.character(shared_genes$V1)))
# names(geneList1) <- geneNames

# only my universe from the RNAseq experiment
geneList <- factor(as.integer(geneNames.universe %in% as.character(shared_genes$V1)))
names(geneList) <- geneNames.universe
str(geneList)

# Biological process

# ontology: character string specifying the ontology of interest (BP, MF or CC)
# description: optional short description
# allGenes: named vector of type numeric or factor. The names attribute contains the genes identifiers. The genes listed in this object define the gene universe
# str(geneList)
# the genesList object is a named factor that indicates which genes are interesting and which not. It should be straightforward to compute such a named vector in a real case situation, where the user has his own predefined list of interesting genes

# geneSelectionFun: function to specify which genes are interesting based on the gene scores. It should be present if the allGenes object is of type numeric
# nodeSize: an integer larger or equal to1. This parameter is used to prune the GO hirarchy from the terms which have less than nodeSize annotated genes (after the true path rule is applied)
# annotationFun: function which maps genes identifiers to GO terms. There are a couple of annotation function included in the package trying to address the user's needs. The annotation function takes three arguments. One of those arguments is specifying where the mappings can be found, and needs to be provided by the user. 
# annFun.gene2GO: this function is used when the annotations are provided as a gene-to-GOs mapping.

GOdata_BP <- new(
  "topGOdata", 
  ontology = "BP", 
  allGenes = geneList , 
  annot = annFUN.gene2GO, 
  gene2GO = geneID2GO
  ) 

# have a look at your topGOdata object: available genes (all genes in your geneList), feasable genes (genes that can be used for further analysis)
GOdata_BP
numGenes(GOdata_BP)
sg <- sigGenes(GOdata_BP)
str(sg)

GOdata <- read.table("/Users/anna/Google_Drive/KFU_RNAseq/R_files/DESeq/Data/Output/shared_genes/biomaRt_GO_id_10182021.txt", na = c("", "NA"), sep = " ", header = T)

external_name <- GOdata %>% 
  dplyr::select(1,2) %>%
  unique() 

sg_names <- external_name %>% 
  filter(ensembl_gene_id %in% sg)

#STAGE <- "L_A"

write.table(sg_names, file = paste0(PATH.OUT, STAGE, "_", JAW, "sig_genes_GO.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t")
numSigGenes(GOdata_BP)


# graph(GOdata_BP) ## returns the GO graph
# ug <- usedGO(GOdata_BP)
# head(ug)

# num.ann.genes <- countGenesInTerm(GOdata_BP) # the number of annotated genes
# ann.genes <- genesInTerm(GOdata_BP) # get the annotations

# test 1 fisher classic
test.stat <- new(
  "classicCount", 
  testStatistic = GOFisherTest, 
  name = "Fisher test"
  )

resultFis <- runTest(
  GOdata_BP, 
  algorithm = "classic", 
  statistic = "fisher"
  )

head(score(resultFis))

# test two, weight
test.stat <- new(
  "weightCount", 
  testStatistic = GOFisherTest, 
  name = "Fisher test", 
  sigRatio = "ratio"
  )

resultWeight <- getSigGroups(
  GOdata_BP, 
  test.stat
  )
head(score(resultWeight))

allRes <- GenTable(
  GOdata_BP, 
  classic = resultFis, 
  weight = resultWeight,
  orderBy = "weight", 
  ranksOf = "classic", 
  topNodes = 50
  )
write.table(allRes, file = paste0(PATH.OUT, STAGE, "_", JAW, "_fisher_weight_tests_BP.txt"), quote = FALSE, row.names = FALSE, sep = "\t")

allRes_BP <- GenTable(
  GOdata_BP, 
  weight = resultWeight, 
  orderBy = "weight", 
  topNodes = 20
  )
write.table(allRes_BP, file = paste0(PATH.OUT, STAGE, "_", JAW,"_weight_BP.txt"), quote = FALSE, row.names = FALSE, sep = "\t")


# retrieve genes2GO list from the "expanded" annotation in GOdata
allGO = genesInTerm(GOdata_BP)
subset <- allRes$GO.ID

#allGO[["GO:0048856"]]
#$`GO:0000109`
#[1] "ENSG00000012061" "ENSG00000104472" "ENSG00000175595"

retr_sig_gene <- lapply(allGO,function(x) x[x %in% shared_genes$V1] )

# Your significant genes for GO:0016055 wnt
#retr_sig_gene[["GO:0016055"]]

#repalce NAs with "NA"!

L.RES <- list()
for (i in subset){
  L.RES[[i]] = retr_sig_gene[[i]]
}

GOtable <- L.RES %>% 
  map(., as_tibble) %>% 
  unlist(.) %>% 
  as_tibble(., rownames = "id") %>% 
  mutate(
    GOid = str_replace(id, ".value.*", "")
  ) %>% 
  left_join(external_name, by = c("value" = "ensembl_gene_id")) %>% 
  mutate(
    external_gene_name = str_replace_na(external_gene_name, "NA")
  ) %>% 
  group_by(GOid) %>% 
  summarise(
    ensembl_id = str_c(value, collapse = ", "),
    external_gene_name = str_c(external_gene_name, collapse = ", ")
  ) %>% 
  mutate(
    external_gene_name = str_replace_all(external_gene_name, ", NA", "")
  ) %>% 
  left_join(allRes, by = c("GOid" = "GO.ID")) %>% 
  arrange(., weight) %>% 
  relocate(external_gene_name, .after = Term) %>% 
  relocate(ensembl_id, .after = last_col())

write.table(GOtable, file = paste0(PATH.OUT, STAGE, "_", JAW,"_GOid_and_external_gene_names.txt"), quote = FALSE, row.names = FALSE, sep = "\t")

write_csv(GOtable, file = paste0(PATH.OUT, STAGE, "_", JAW,"_GOid_and_external_gene_names.csv"), quote_escape = "double")




# external_name %>% 
#   filter(ensembl_gene_id == "ENSONIG00000008854")

# For the methods that account for the GO topology like elim and weight, the problem of multiple
# testing is even more complicated. Here one computes the p-value of a GO term conditioned on the
# neighbouring terms. The tests are therefore not independent and the multiple testing theory does not
# directly apply. We like to interpret the p-values returned by these methods as corrected or not affected
# by multiple testing.










# Molecular function
# GOdata_MF <- new("topGOdata", ontology = "MF", allGenes = geneList, annot = annFUN.gene2GO, gene2GO = geneID2GO)
# test.stat <- new("classicCount", testStatistic = GOFisherTest, name = "Fisher test")
# resultFisher <- getSigGroups(GOdata_MF, test.stat)
# test.stat <- new("classicScore", testStatistic = GOKSTest, name = "KS tests")
# resultKS <- getSigGroups(GOdata_MF, test.stat)
# test.stat <- new("weightCount", testStatistic = GOFisherTest, name = "Fisher test", sigRatio = "ratio")
# resultWeight <- getSigGroups(GOdata_MF, test.stat)
# resultFis <- runTest(GOdata_MF, algorithm = "classic", statistic = "fisher")
# 
# allRes_MF <- GenTable(GOdata_MF, classic = resultFis, KS = resultKS, weight = resultWeight,
#                    orderBy = "weight", ranksOf = "classic", topNodes = 20)
# write.table(allRes_MF, file = paste0(PATH.OUT, STAGE,"_", JAW, "_GO_MF.txt"), quote = FALSE, row.names = FALSE, sep = "\t")



# Cellular component
# GOdata_CC <- new("topGOdata", ontology = "CC", allGenes = geneList,annot = annFUN.gene2GO, gene2GO = geneID2GO)
# test.stat <- new("weightCount", testStatistic = GOFisherTest, name = "Fisher test", sigRatio = "ratio")
# resultWeight <- getSigGroups(GOdata_CC,test.stat)
# allRes_CC<-GenTable(GOdata_CC, weight=resultWeight, orderBy="weight",topNodes = 500)
# write.table(allRes_CC, file="plsig_CC.txt", quote=FALSE, row.names=FALSE, sep="\t")