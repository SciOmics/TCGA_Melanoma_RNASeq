**Under Construction**

This repo is to demo analysis approaches for bulk RNA-seq data using data from TCGA Skin Cutaneous Melanoma (SKCM) dataset.

Goals: 
1) Contrast primary vs metastatic samples. 
2) Determine variables (observed and latent) impacting overall survival in patients.
3) Build a predictive model to distinguish between primary and metastatic samples. 

Approaches:
1) Differential expression analysis.
2) Epithelial–Mesenchymal gene signature scoring.
3) Weighted gene coexpression network analysis (WGCNA)
4) Deconvolution of cell types.
___


![alt text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/DAG.png?raw=true)  

**Figure 1. Directed acyclic graph of hypothesized variables impacting patient overall survival**
I'll use this model to investigate overall survival in patients. Disease stage, patient sex, and patient age are present in the sample metadata, so that will be straight forward to look at. While the metadata contains lists of treatment info, these are uninformative, so I'll have to ignore this for the purposes of this analysis. Infiltrate of different immune cell populations, cancer associated fibroblasts (CAFs), and epithelial–mesenchymal status are latent variables that I'll derive these from the RNA expression data. 

___

...I will start by getting a general feel for the data...

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

___
  
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

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_sex.png?raw=true)  

**Figure 2. Overall survival by patient sex.** 
There is no observed difference in overall survival between male and female patients. My hypothesis was wrong. There was a hypothesis that there would be differences in immunotherapy efficacy between male and female patients, but evidence suggests that this is not the case (see [Wallis CJD et al. JAMA Oncol. 2019](https://jamanetwork.com/journals/jamaoncology/fullarticle/2719757)). Regardless, the samples in this dataset are from patients diagnosised at latest 2012, before checkpoint immunotherapy approvals in metastatic melanoma. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_age.png?raw=true)  

**Figure 3. Overall survival by patient age.**
Patients who are older have decreased overall survival probability. The top plot shows shows patient age as a continuous variable vs. the date of last followup from the index date. Be careful in interpretting this plot given that many of these data are censored (black dots). A Cox regression shows a significant relationship between overall survival and patient age. The bottom plot is a different visualization of these data, showing surival curves based on binned ages. 


___

...next I will normalize the RNA-seq data and do some exploratory analysis...

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plots.png?raw=true)  

**Figure 2. PCA plots of normalized expression**
There is some seperation of primary vs. metastatic samples in PC1 and PC2. This is driven in part by the lymph node metastatic samples, but the metastatic cutaneous samples also seem to seperate. Let's plot just the cutaneous samples.

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plot_cutaneous.png?raw=true)  

**Figure 3. PCA plot filtered to only cutaneous samples**
There does indeed appear to be some seperating along PC1 and PC2, and maybe a bit in PC3. 

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_plot_stage.png?raw=true)  

**Figure 3. Overall survival by disease stage.**
Survival probability gets shorter as disease stage increases. This is what I would expect, but it is a good sanity check of the data. 

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/volcano_plot.png?raw=true)  

**Figure 4. Volcano plot: primary vs. metastatic samples.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/GSEA.png?raw=true)  

**Figure 5. Gene set enrichment analysis: primary vs. metastatic samples.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/Epi_Mes_scores.png?raw=true)  

**Figure 6. Epithelial–Mesenchymal scores.** Samples were scored using epithelial and mesenchymal gene signatures from [Tan TZ, et al. EMBO Mol Med. 2014.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4287932/) (cleaned csv version available in the references folder) by GSEA, ssGSEA, and SingScore. ssGSEA and Singscore produced highly similar results, with metastatic samples predominately being low in epithelial scores. GSVA scoring produced a wider spread in the epithelial scores of metastatic samples. Likewise, primary samples scored low in the mesenchymal signature for ssGSEA and SingScore, but GSVA again had a wide spread. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/singscore_primary_met.png?raw=true)  

**Figure 7. Epithelial–Mesenchymal scores of primary vs. metastatic samples.** Singscore was used to generate a combined epithelial and mesenchymal gene signature score. Filtering down to only cutaneous samples, metastatic samples had a higher score (i.e. more mesenchymal-like) relative to primary samples. 

___

**Figure 8. Overall survival by epithelial–mesenchymal score.**

-median division, gmm division
-all samples, cutaneous only, late stage only

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_primary_vs_met.png?raw=true)  

**Figure X.***

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_survival.png?raw=true)  

**Figure X.***

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolutions_other_cell_types.png?raw=true)  

**Figure X.***

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_forest_plot.png?raw=true)  

**Figure X.***

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/module_deconvolution_correlations_examples.png?raw=true)  

**Figure X.***


___
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/cell_types_in_WGCNA_modules.png?raw=true) 

**Figure x. Enrichment for cell type gene signatures  in WGCNA modules**

___
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/module_deconvolution_correlations.png?raw=true)  

**Correlations between deconvolution cell frequencies and WGCNA module eigen values.**

___
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/yellow_module_survival.png?raw=true) 

**Unadjusted survival curves for WGCNA yellow module eigen values.**

___
  

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/boostedtree_ROC.png?raw=true)  

**Figure X.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/NN_ROC.png?raw=true)  

**Figure X.**

___



