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

**Table 1. Summary of the number of sample from different tissue sites.**

There shouldn't be "Primary" samples from non-cutaneous tissues. These are mislabeled and will be removed. 
  
  
  
| Stage | Primary Sample Count | Metastatic Sample Count |
| --- | --- | --- |
| 0 | 0 | 7 |
| 1 | 1 | 29 |
| 1A | 0 | 18 |
| 1B | 1 | 28 |
| 2 | 4 | 26 |
| 2A | 4 | 14 |
| 2B | 9 | 19 |
| 2C | 49 | 15 |
| 3 | 2 | 39 |
| 3A | 1 | 15 |
| 3B | 12 | 35 |
| 3C | 12 | 55 |
| 4 | 3 | 21 |

**Table 2. Summary of the number of samples from disease stages.**

There shouldn't be metastatic samples labeled Stage 0 or stage 1, and probably not stage 2 either. This is concerning. I could eliminate early stage samples, but this would substaintally lower our sample size. I'll leave these samples in for now and see how they related to other samples in a PCA. 
  
  

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plots.png?raw=true)  

**Figure 1. PCA plots of normalized expression**

There is some seperation of primary vs. metastatic samples in PC1 and PC2. This is driven in part by the lymph node metastatic samples, but the metastatic cutaneous samples also seem to seperate. Let's plot just the cutaneous samples.

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plot_cutaneous.png?raw=true)  

**Figure 2. PCA plot filtered to only cutanous samples**

There does indeed appear to be some seperating along PC1 and PC2, a maybe a bit in PC3. 


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_plot_stage.png?raw=true)  

**Figure 3. Survival by disease stage.**



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

