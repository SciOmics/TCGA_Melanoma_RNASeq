**Under Construction**

This repo is to demo analysis of bulk RNA-seq data using data from TCGA Skin Cutaneous Melanoma (SKCM) dataset.

___

Goal: Determine variables impacting overall survival in melanoma patients. 

Methods:
1) Differential expression analysis.
2) Gene signature scoring.
3) Weighted gene coexpression network analysis (WGCNA).
4) Deconvolution of cell types.
5) Machine learning and deep learning models.
___


![alt text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/DAG.png?raw=true)  

**Figure 1. Directed acyclic graph of hypothesized variables impacting patient overall survival**
I'll use this model to investigate overall survival in patients. Disease stage, patient sex, patient age, and sample tissue source are present in the sample metadata, so that will be straight forward to look at. While the metadata contains lists of treatment info, these are uninformative, so I'll have to ignore this for the purposes of this analysis. Infiltrate of different immune cell populations, cancer associated fibroblasts (CAFs), epithelial–mesenchymal status, cancer antigen expression, and sample purity are latent variables that I will derive  from the RNA expression data. 

___

...I will start by getting a general feel for the data...

___

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
There shouldn't be "Primary" samples from non-cutaneous tissues.  

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
There shouldn't be metastatic samples labeled Stage 0 or stage 1, and probably not stage 2 either. This is concerning.

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_sex.png?raw=true)  

**Figure 2. Overall survival by patient sex.** 
There is no observed difference in overall survival between male and female patients. My hypothesis was wrong. There was a hypothesis that there would be differences in immunotherapy efficacy between male and female patients, but evidence suggests that this is not the case (see [Wallis CJD et al. JAMA Oncol. 2019](https://jamanetwork.com/journals/jamaoncology/fullarticle/2719757)). Regardless, the samples in this dataset are from patients diagnosised at latest 2012, before checkpoint immunotherapy approvals in metastatic melanoma. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_age.png?raw=true)  

**Figure 3. Overall survival by patient age.**
Patients who are older have decreased overall survival probability. The top plot shows shows patient age as a continuous variable vs. the date of last followup from the index date. Be careful in interpretting this plot given that many of these data are censored (black dots). A Cox regression shows a stastically significant relationship between overall survival and patient age (95% CI of hazard ratio: 1.011 to 1.031). Keep in mind, the hazard ratio is per each additional year of age. The bottom plot is a different visualization of these data, showing surival curves based on binned ages. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_plot_stage.png?raw=true)  

**Figure 4. Overall survival by disease stage.**
Survival probability gets shorter as disease stage increases. This is what I would expect, but it is a good sanity check of the data. 

___


...next I will normalize the RNA-seq data and do some exploratory analysis...

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plots.png?raw=true)  

**Figure 5. PCA plots of normalized expression**
There is some seperation of primary vs. metastatic samples in PC1 and PC2. This is driven in part by the lymph node metastatic samples, but the metastatic cutaneous samples also seem to seperate. Let's plot just the cutaneous samples.

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_plot_cutaneous.png?raw=true)  

**Figure 6. PCA plot filtered to only cutaneous samples**
There does indeed appear to be some seperating along PC1 and PC2, and maybe a bit in PC3. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/pca_primary_mets.png?raw=true)  

**Figure 7. Comparing primary and metastatic sample principal components.**
It is more clear what principal compenents have separation between primary vs metastatic samples if we look at PCs individually. There does appear to be varying magnitudes of separation up to PC6. 

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/volcano_plot.png?raw=true)  

**Figure 8. Volcano plot: primary vs. metastatic samples.**
Genes to the left side of the plot are increased in expression in primary samples, while those on the right are increased in metastatic samples.

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/gene_expression_plots.png?raw=true)  

**Figure 9. Gene expression: primary vs. metastatic samples.**
KRT6B = Keratin 6B
C7: Complement component 7 

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/GSEA.png?raw=true)  

**Figure 10. Gene set enrichment analysis: primary vs. metastatic samples.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/Epi_Mes_scores.png?raw=true)  

**Figure 11. Epithelial–Mesenchymal scores.** 
Samples were scored using epithelial and mesenchymal gene signatures from [Tan TZ, et al. EMBO Mol Med. 2014.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4287932/) (cleaned csv version available in the references folder) by GSEA, ssGSEA, and SingScore. ssGSEA and Singscore produced highly similar results, with metastatic samples predominately being low in epithelial scores. GSVA scoring produced a wider spread in the epithelial scores of metastatic samples. Likewise, primary samples scored low in the mesenchymal signature for ssGSEA and SingScore, but GSVA again had a wide spread. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/singscore_primary_met.png?raw=true)  

**Figure 7. Epithelial–Mesenchymal scores of primary vs. metastatic samples.** Singscore was used to generate a combined epithelial and mesenchymal gene signature score. Filtering down to only cutaneous samples, metastatic samples had a higher score (i.e. more mesenchymal-like) relative to primary samples. 

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_singscore.png?raw=true)  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/survival_by_singscore_gmm.png?raw=true)  

**Figure 8. Overall survival by epithelial–mesenchymal score.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/wgcna_forest_primary_vs_met.png?raw=true)  

**Figure X. .**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/wgcna_primary_vs_met.png?raw=true)  

**Figure X. .**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/wgcna_pathways_primary_vs_met.png?raw=true)  

**Figure X. .**

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/wgcna_forest_plot.png?raw=true)  

**Figure X. Hazard ratios of overall survival based on WGCNA module eigenvalues.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/hub_genes_survival.png?raw=true)  

**Figure X. Overall survival based on WGCNA module hub genes.**
___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/wgcna_pathways.png?raw=true)  

**Figure X. Pathway enrichment in WGCNA modules.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/cell_types_in_WGCNA_modules.png?raw=true) 

**Figure X. Enrichment for cell type gene signatures in WGCNA modules**

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolutions_other_cell_types.png?raw=true)  

**Figure X. Comparisons of deconvolution algorithms.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_primary_vs_met.png?raw=true)  

**Figure X. Comparison of cell type deconvolutions between primary and metastatic samples.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_survival.png?raw=true)  

**Figure X. Kaplan Meier plots of overall survival based on cell type deconvolutions**

___


![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/module_deconvolution_correlations_examples.png?raw=true)  

**Figure X. WGCNA module eigenvalues correlations with cell type deconvolutions.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/module_deconvolution_correlations.png?raw=true)  

**Figure X. Correlations between deconvolution cell frequencies and WGCNA module eigen values.**

___
  
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/deconvolution_forest_plot.png?raw=true)  

**Figure X. Hazard ratios of overall survival based on cell type deconvolutions.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/boostedtree_ROC.png?raw=true)  

**Figure X. Receiver operating characteristic (ROC) curve for predicting metastatic vs. primary samples by a boosted tree model.**

___

![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/plots/NN_ROC.png?raw=true)  

**Figure X. Receiver operating characteristic (ROC) curve for predicting metastatic vs. primary samples by a fully connected neural network model.**

___


**Survival Models**

| Independent Variable of Interest | Variable(s) to Adjust for |
| --- | --- | 
| Patient Age | None |
| Patient Sex | None |
| Disease Stage | None |
| Immune Infiltrate | Disease Stage |
| Epithelial-Mesenchymal Score | CAF Infiltration, Sample Purity |

