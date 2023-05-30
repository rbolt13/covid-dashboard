#### Covid Dashboard ####
# Title: Us Page Totals
# Date: May 30, 2023
# Input: 
# Output: 
# Description: 
here::i_am("clean-data/R/us_page_totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Row Total Values ####
us_total_cases <- sum(us_totals$total_cases)
us_cases_perc <- base::round(
  (us_total_cases / sum(us_totals$population))*100,
  digits = 2)
us_total_deaths <- sum(us_totals$total_deaths)
us_deaths_perc <- base::round(
  (us_total_deaths / sum(us_totals$population))*100,
  digits = 2)

#### US Page Totals Data ####
us_page_totals <- base::data.frame(
  cases = c(us_total_cases, us_cases_perc),
  deaths = c(us_total_deaths, us_deaths_perc))

#### Save Data ####
utils::write.csv(us_page_totals, "clean-data/us_page_totals.csv")
