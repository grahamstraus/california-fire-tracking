library(targets)
source("functions.R")
options(tidyverse.quiet = TRUE)
list(
  tar_target(
    years,
    command = years<-c(2010:2021)
  ),
  tar_target(
    clean_data,
    command = scrape_clean_fire_data(years)
  ),
  tar_target(
    write_csv_files,
    command = for(i in c(1:length(clean_data))){
      write_csv(clean_data[[i]] %>% unnest(Counties),
                file = sprintf("../Data/fire_track_%i.csv", years[i]))
    }
  )
)


## For making master
library(data.table)  
files <- list.files(path = "../Data",pattern = ".csv")
setwd("/Users/gpstraus/Dropbox/Summer 1 Projects/california-fire-tracking/Data")
All <- lapply(files,function(i){
  read_csv(i)
}) %>% bind_rows()
write_csv(All, "Master_CA_Tracking.csv")
