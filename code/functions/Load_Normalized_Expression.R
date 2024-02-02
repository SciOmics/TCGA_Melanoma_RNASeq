
load_normalized_expression = function(path){
  temp = as.data.frame(data.table::fread(path))
  rownames(temp) = temp$V1
  temp = temp[,2:ncol(temp)]
  return(temp)
}
