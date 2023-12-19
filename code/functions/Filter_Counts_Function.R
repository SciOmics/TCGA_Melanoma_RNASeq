

filter_counts = function(x, count_threshold) {
    counts = x$counts
    to_filter_out = which(rowSums(counts) < count_threshold)
    print(paste0(length(to_filter_out), " rows were filtered."))
    filtered_x = x[-to_filter_out,]
    return(filtered_x)
}

