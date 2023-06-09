#### Covid Dashboard ####
# Title: US Totals
# Date: May 30, 2023
# Input: us_join, us_data_dates
# Output: us_totals.csv
# Description: This file reads in 
# the us join and data dates data, 
# calculates totals columns, and 
# saves data as .csv file.
here::i_am("clean-data/R/us_totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Data ####
us_totals <- function(us_join, us_data_dates){
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