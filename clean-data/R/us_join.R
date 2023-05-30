#### Covid Dashboard ####
# Title: Clean Data  - US Join
# Date: May 25, 2023
# Description: This file loads in
# the raw us data sets and joins them.
here::i_am("clean-data/R/us_join.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Join Covid and Population Data ####
us_join <- function(data1, data2){
  us_join <- data1 %>%
    dplyr::select(date, state, cases, deaths) %>%
    dplyr::full_join(
      data2 %>%
        dplyr::select(state, population),
      by = c("state" = "state")) %>%
    dplyr::reframe(
      date = date,
      state = state,
      population = population,
      cases = cases,
      cases_per_pop = cases/population,
      deaths = deaths,
      deaths_per_pop = deaths/population) %>%
    dplyr::filter(!is.na(population))
  # save data
  utils::write.csv(us_join, "clean-data/us_join.csv")
  return(us_join)
}