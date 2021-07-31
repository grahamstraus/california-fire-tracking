library(targets)
source("functions.R")
options(tidyverse.quiet = TRUE)
list(
  tar_target(
    years,
    command = years<-c(2010:2020)
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

