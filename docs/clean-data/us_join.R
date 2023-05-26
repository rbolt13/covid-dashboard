#### Covid Dashboard ####
# Title: Clean Data  - US Join
# Date: May 25, 2023
# Description: This file loads in
# the raw us data sets and joins them.
here::i_am("clean-data/us_join.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_covid <- readr::read_csv("raw-data/us_covid.csv")
us_pop <- readr::read_csv("raw-data/us_pop.csv")

#### Join Covid and Population Data ####
us_join <- us_covid %>%
  dplyr::select(date, state, cases, deaths) %>%
  dplyr::full_join(us_pop %>%
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

#### Save Data #### 
utils::write.csv(us_join, "clean-data/us_join.csv")