This repo is to demo analysis approaches for bulk RNA-seq data. 
\
**Under Construction**
\

\
![alt text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/DAG.png?raw=true)
**Directed acyclic graph of hypothesized variables impacting patient overall survival**
\
\
Factors that are hypothesized to impact survival:
\
-Treatement(s) received: unfortunately, the data contain non-informative information about treatment, so this variable will be omitted. Howver, any treatment received prior to ~2011 would likley have been ineffective in affecting survival. We could filter the data to only cases prior to then. 
\
-Immune Infiltrate: as these data are from bulk RNA-seq, we'll need to use deconvolution techniques to get estimates of frequencies of immune infiltrate. Alternatively, we could use cell signature scoring methods (e.g. xCell). 
\
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/cell_types_in_WGCNA_modules.png?raw=true)\
**Enrichment for cell type gene signatures  in WGCNA modules**
\
\
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/module_deconvolution_correlations.png?raw=true)\
**Correlations between deconvolution cell frequencies and WGCNA module eigen values.**
\
\
![alt_text](https://github.com/SciOmics/TCGA_Melanoma_RNASeq/blob/main/outputs/yellow_module_survival.png?raw=true)\
**Unadjusted survival curves for WGCNA yellow module eigen values.**
\
\
