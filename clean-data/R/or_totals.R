#### Covid Dashboard ####
# Title: OR Totals
# Date: May 30, 2023
# Input: or_join, or_data_dates
# Output: or_totals.csv
# Description: This file reads in 
# the or join and data dates data, 
# calculates totals columns, and 
# saves data as .csv file.
here::i_am("clean-data/R/or_totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Totals Data ####
or_totals <- function(or_join, or_data_dates){
  or_totals <- or_join %>%
    dplyr::filter(date == or_data_dates[[2,1]]) %>%
    dplyr::group_by(county) %>%
    dplyr::reframe(
      total_cases = base::sum(cases),
      total_cases_perc = total_cases/population,
      total_deaths = base::sum(deaths),
      total_deaths_perc = total_deaths/population,
      population = population) 
  # Save Data 
  utils::write.csv(or_totals, "clean-data/or_totals.csv")
  return(or_totals)
}