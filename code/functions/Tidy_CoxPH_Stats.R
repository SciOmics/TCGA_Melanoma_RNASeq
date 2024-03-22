
#extract stats from a coxph result#

coxph_tidy_stats = function(coxph_results){
  
  #run summary
  coxph_results = summary(coxph_results)
  
  #extract statistics
  coxph_results = coxph_results$conf.int |> 
    as.data.frame() |> 
    cbind(coxph_results$coefficients) 
  
  #create column with variable name
  coxph_results$variable = rownames(coxph_results)
  
  #better column names
  colnames(coxph_results) = c("hazard_ratio", "hazard_ratio_inverse", "lower_95_CI", "upper_95_CI", "coefficient", "HR_duplicate", "standard_error", "wald_statistic", "pval", "variable_name")
  
  #add inverse confidence intervals
  coxph_results = coxph_results |> 
    mutate(lower_95_CI_inverse = 1/lower_95_CI,
           upper_95_CI_inverse = 1/upper_95_CI)
  
  #get rid of duplicates and reorder
  coxph_results = coxph_results[c("variable_name", "coefficient", "standard_error", "hazard_ratio", "hazard_ratio_inverse", "lower_95_CI", "lower_95_CI_inverse", "upper_95_CI", "upper_95_CI_inverse", "wald_statistic", "pval")]
  
  rownames(coxph_results) = NULL
  
  return(coxph_results)
  
}
