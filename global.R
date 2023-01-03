library(tidyverse)
library(readxl)
library(writexl)

#converting df to OD matrix -----
od_to_mat <- function(df, zone_codes){
  mat <- matrix(data = 0, 
                nrow = length(zone_codes),
                ncol = length(zone_codes),
                dimnames = list(zone_codes, zone_codes))
  df <- df %>% 
    mutate(origin = as.character(origin),
           destination = as.character(destination))

  for(i in 1:dim(df)[[1]]){
    mat[df$origin[i], df$destination[i]] <- mat[df$origin[i], df$destination[i]]+1
  }
  
  return(mat)
}


