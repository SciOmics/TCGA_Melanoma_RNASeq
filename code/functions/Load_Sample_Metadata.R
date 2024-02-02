
load_sample_metadata = function(path){
  temp = as.data.frame(data.table::fread(path))
  temp = temp[,2:ncol(temp)]
  rownames(temp) = temp$sample_id
  return(temp)
}

