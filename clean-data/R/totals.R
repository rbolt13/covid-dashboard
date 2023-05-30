#### Covid Dashboard ####
# Title: Clean Data  - US Totals
# Date: May 30, 2023
# Description: This file reads in 
# the us_join.csv and us_data_dates.csv
# data sets in the `clean-data` folder 
# and calculates totals columns. 
here::i_am("clean-data/R/totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Function ####
totals <- function(id_join, id_data_dates, id_region, 
                   region, id){
  # add region column so we can group by region
  id_join$region <- id_join[,2]
  # totals data
  totals <- id_join %>%
    dplyr::filter(date == id_data_dates[[2,1]]) %>%
    dplyr::group_by(region) %>%
    dplyr::reframe(
      total_cases = base::sum(cases),
      total_cases_perc = total_cases/population,
      total_deaths = base::sum(deaths),
      total_deaths_perc = total_deaths/population,
      population = population) 
  # Assign Similar Case Structure for join
  totals$region <- stringr::str_to_title(totals$region)
  id_region$region <- stringr::str_to_title(id_region$region)
  # Join totals and map data
  totals_join <- totals %>%
    dplyr::full_join(id_region %>%
                       dplyr::select(long, lat, group, region),
                     by = c("region" = "region")) %>%
    dplyr::filter(!is.na(date), !is.na(lat), !is.na(long)) %>%
    arrange(region)
  # Update region name
  base::colnames(totals)[2] <- region
  base::colnames(totals_join)[2] <- region
  # Save Data
  utils::write.csv(totals, paste0("clean-data/",id,"_totals.csv"))
  utils::write.csv(totals_join, paste0("clean-data/",id,"_totals_join.csv"))
  return(totals)
}