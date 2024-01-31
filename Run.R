# Notes:
# what is an mds plot?

# To do:
# Deconvolution
# use machine learning models
    ## can also try to predict stage
    # use another database to validate
# build a network
#Shiny dashboard
#Deep learning


###ADD CODE TO RUN ALL ANALYSES### 

#Check for tcga_skcm_data.RDS; if present do not run script 01

TCGA_data_path = "data/tcga_skcm_data.RDS"

if (file.exists(TCGA_data_path)) {
  print("TCGA data present. Proceeding without downloading.")
} else {
  print("TCGA data not found. Proceeding to download data.")
  source("code/01_Download_TCGA_Data.qmd")
}

#There is a problem running rmd/qmd files with source. Need to fix. 