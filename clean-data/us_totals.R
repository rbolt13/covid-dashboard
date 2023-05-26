#### Covid Dashboard ####
# Title: Clean Data  - US Totals
# Date: May 25, 2023
# Description: This file reads in 
# the us_join.csv and us_data_dates.csv
# data sets in the `clean-data` folder 
# and calculates totals columns. 
here::i_am("clean-data/us_totals.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_join <- readr::read_csv("clean-data/us_join.csv")
us_data_dates <- readr::read_csv("clean-data/us_data_dates.csv")
us_states <- readr::read_csv("raw-data/us_states.csv")

#### Totals Data ####
us_totals <- us_join %>%
  dplyr::filter(date == us_data_dates[[2,2]]) %>%
  dplyr::group_by(state) %>%
  dplyr::reframe(
    total_cases = base::sum(cases),
    total_cases_perc = total_cases/population,
    total_deaths = base::sum(deaths),
    total_deaths_perc = total_deaths/population,
    population = population) 

#### Assign Similar Case Structure for Join ####
us_totals$state <- stringr::str_to_title(us_totals$state)
us_states$state <- stringr::str_to_title(us_states$region)

#### Join Totals Data with US Map Data ####
us_totals_join <- us_totals %>%
  dplyr::full_join(us_states %>%
                     dplyr::select(long, lat, group, state),
                   by = c("state" = "state")) %>%
  dplyr::filter(!is.na(date), !is.na(lat), !is.na(long)) %>%
  arrange(state)

#### Save Data ####
utils::write.csv(us_totals, "clean-data/us_totals.csv")
utils::write.csv(us_totals_join, "clean-data/us_totals_join.csv")