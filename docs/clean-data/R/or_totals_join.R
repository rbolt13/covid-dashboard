#### Covid Dashboard ####
# Title: OR Totals Join 
# Date: May 30, 2023
# Input: or_totals, or_counties
# Output: or_totals_join
# Description: This file reads in 
# the or join and states data, joins
# them, and saves as .csv file. 
here::i_am("clean-data/R/or_totals_join.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Data ####
or_totals_join <- function(or_totals, or_counties){
  # Assign Similar Case Structure for Join 
  or_totals$county <- stringr::str_to_title(or_totals$county)
  or_counties$county <- stringr::str_to_title(or_counties$county)
  
  # Join Totals Data with US Map Data 
  or_totals_join <- or_totals %>%
    dplyr::full_join(or_counties %>%
                       dplyr::select(lon, lat, group, county),
                     by = c("county" = "county"),
                     multiple = "all") %>%
    dplyr::filter(!is.na(lat), !is.na(lon)) %>%
    dplyr::arrange(county)
  
  # Save Data 
  utils::write.csv(or_totals_join, "clean-data/or_totals_join.csv")
  return(or_totals_join)
}