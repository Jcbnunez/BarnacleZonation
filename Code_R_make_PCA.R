library(vroom)
library(tidyverse)
library(magrittr)
library(FactoMineR)
library(factoextra)

# Load LD thin program 
source("~/data/S_balanoides_genomics_resources/Misc_resources/ThinLDinR_SNPtable.R")


#load data
allele_freqs <- vroom("~/data/S_balanoides_genomics_resources/Analyses/Zonation_Paper/10.Allele_Frequencies/SCGP_Sb3.1.noindels.NoSigt.AlleleFrequency.LD500.txt")
 
freqs = c("HIHH_p","FIHH_p","HIHC_p","FIHC_p","HILH_p","FILH_p","HILC_p","FILC_p","RICLN_p","RICHS_p","RIDHS_p","RIDLN_p","GBHS_p","GBLN_p","NRHS_p","NRLN_p","YVHS_p","YVLN_p","ICE_p","UKW_p","NOR_p","CAN_p")
habi = c("ME","ME","ME","ME","ME","ME","ME","ME","RI","RI","RI","RI","NOR","NOR","NOR","NOR","SVE","SVE","ICE","UK","NOR","CAN")

allele_freqs[,freqs] %>% .[complete.cases(.),] %>% t %>% as.data.frame() %>% PCA(graph = F, scale.unit = TRUE) -> PCA_dat

PCA_dat$ind$coord %>% as.data.frame() -> PCA_coord

pop_colors = c("maroon1","mediumseagreen","dodgerblue1","purple","gold1","firebrick","springgreen")

PCA_coord %>% ggplot(aes(x=Dim.1, y=Dim.2, fill = as.factor(habi))) + geom_jitter(size =5, shape = 21) + scale_fill_manual(values = pop_colors) + theme_bw() -> all_pops_pca12
ggsave("all_pops_pca12.pdf",all_pops_pca12, width = 5, height = 4)

PCA_coord %>% ggplot(aes(x=Dim.2, y=Dim.3, fill = as.factor(habi))) + geom_jitter(size =5, shape = 21) + scale_fill_manual(values = pop_colors)+ theme_bw() -> all_pops_pca23
ggsave("all_pops_pca23.pdf",all_pops_pca23, width = 5, height = 4)

PCA_dat %>% fviz_screeplot() -> all_pops_scree
ggsave("all_pops_scree.pdf",all_pops_scree, width = 4, height = 4)

q("no")