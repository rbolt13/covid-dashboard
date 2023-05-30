#### Covid Dashboard ####
# Title: Clean Data  - OR Join
# Date: May 26, 2023
# Description: This file loads in
# the raw or data sets and joins them.
here::i_am("clean-data/or_join.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Join Covid and Population Data ####
or_join <- function(data1, data2){
  # Remove so join can matche county names.
  data2$county <- base::gsub(
    " County, Oregon", "", data2$county)
  # join
  or_join <- data1 %>%
    dplyr::select(date, state, county, cases, deaths) %>%
    dplyr::full_join(data2 %>% 
        dplyr::select(county, population),
        by = c("county" = "county")) %>%
    dplyr::reframe(
      date = date,
      county = county,
      population = population,
      cases = cases,
      cases_per_pop = cases/population,
      deaths = deaths,
      deaths_per_pop = deaths/population)
  # save data
  utils::write.csv(or_join, "clean-data/or_join.csv")
  return(or_join)
}