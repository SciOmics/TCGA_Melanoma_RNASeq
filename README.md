This repo is to demo analysis approaches for bulk RNA-seq data. 
\
**Under Construction**

Bulk RNA-seq data from TCGA Skin Cutaneous Melanoma (SKCM) dataset was downloaded.

| Sample Origin | Tissue | Sample Count |
| --- | --- | --- |
| Metastatic | CNS | 5 |
| Metastatic | Cutaneous | 98 |
| Metastatic | Lymph Node | 196 |
| Metastatic | Mucosal | 3 |
| Metastatic | Organ | 19 |
| Primary | Cutaneous | 96 |
| Primary | Lymph Node | 1 |
| Primary | Mucosal | 1 |

**Table 1. Summary of samples.**

There shouldn't be "Primary" samples from non-cutaneous tissues. These are mislabeled and will be removed. 


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plots.png?raw=true)  

**Figure 1. PCA plots of normalized expression**





![alt text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/DAG.png?raw=true)  
**Directed acyclic graph of hypothesized variables impacting patient overall survival**
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/cell_types_in_WGCNA_modules.png?raw=true)  
**Enrichment for cell type gene signatures  in WGCNA modules**
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/module_deconvolution_correlations.png?raw=true)  
**Correlations between deconvolution cell frequencies and WGCNA module eigen values.**
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/yellow_module_survival.png?raw=true)  
**Unadjusted survival curves for WGCNA yellow module eigen values.**
  


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/boostedtree_ROC.png?raw=true)  

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/NN_ROC.png?raw=true)  

