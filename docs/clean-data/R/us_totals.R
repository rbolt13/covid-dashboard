#### Covid Dashboard ####
# Title: Clean Data  - US Totals
# Date: May 30, 2023
# Description: This file reads in 
# the us_join.csv and us_data_dates.csv
# data sets in the `clean-data` folder 
# and calculates totals columns. 
here::i_am("clean-data/R/us_totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Data ####
us_totals <- function(us_join, us_data_dates, us_states){
  us_totals <- us_join %>%
    dplyr::filter(date == us_data_dates[[2,2]]) %>%
    dplyr::group_by(state) %>%
    dplyr::reframe(
      total_cases = base::sum(cases),
      total_cases_perc = total_cases/population,
      total_deaths = base::sum(deaths),
      total_deaths_perc = total_deaths/population,
      population = population) 
  # Save Data 
  utils::write.csv(us_totals, "clean-data/us_totals.csv")
return(us_totals)
}