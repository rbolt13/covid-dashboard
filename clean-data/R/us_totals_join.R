#### Covid Dashboard ####
# Title: Clean Data  - US Totals Join 
# Date: May 30, 2023
# Description: This file reads in 
# the us_join.csv and us_states.csv
# and joins them.  
here::i_am("clean-data/R/us_totals_join.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Data ####
# Input: us_totals, us_states 
# Output: us_totals_join
# Description: Joins the totals data with the region data. 
us_totals_join <- function(us_totals, us_states){
  # Assign Similar Case Structure for Join 
  us_totals$state <- stringr::str_to_title(us_totals$state)
  us_states$state <- stringr::str_to_title(us_states$region)
  
  # Join Totals Data with US Map Data 
  us_totals_join <- us_totals %>%
    dplyr::full_join(us_states %>%
                       dplyr::select(long, lat, group, state),
                     by = c("state" = "state"),
                     multiple = "all") %>%
    dplyr::filter(!is.na(lat), !is.na(long)) %>%
    dplyr::arrange(state)
  
  # Save Data 
  utils::write.csv(us_totals_join, "clean-data/us_totals_join.csv")
  return(us_totals_join)
}