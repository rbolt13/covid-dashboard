#### Covid Dashboard ####
# Title: Raw Data - Index
# Date: May 25, 2023
# Description: This file loads in six
# raw data sets used for this dashboard: 
#   - us_covid
#   - us_pop
#   - us_states
#   - or_covid
#   - or_pop
#   - or_counties
# Each data set is saved as a .csv files
# in the 'raw-data' folder. 
here::i_am("raw-data/index.R")

#### Load Packages ####
# tidyverse: A collection of data-related packages.
# tidycensus: Access census data.
base::library(tidyverse)
base::library(tidycensus)

#### Access Tidycensus API ####
readRenviron(".Renviron")
Sys.getenv("CENSUS_API_KEY")

#### Load NYT Data ####
# us_covid: NYT covid data by state.
us_covid <- readr::read_csv(
  'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv')
# counties_covid: NYT covid data by county.
counties_covid <- readr::read_csv(
  'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')
# or_covid: Subset of counties_covid that is just Oregon.
or_covid <- counties_covid %>% dplyr::filter(state == "Oregon")

#### Load Tidycensus Data ####
# us_pop: US population census data.
us_pop <- tidycensus::get_estimates(
  geography = "state", 
  year = 2019, 
  variable =  "POP") %>% 
  dplyr::rename (
    "state" = NAME, 
    "population" = value)
# or_pop: OR population census data. 
or_pop <- tidycensus::get_estimates(
  geography = "county",
  state = "OR",
  year = 2019,
  variable = "POP") %>%
  dplyr::rename (
    "county" = NAME,
    "population" = value)

#### Map Data ####
# us_states: Mapping data for the US. 
us_states <- ggplot2::map_data("state")
# or_counties: Mapping data for OR counties. 
or_counties <- ggplot2::map_data("county", "oregon") %>%
  dplyr::select(lon = long, lat, group, county = subregion)

#### Save Data ####
utils::write.csv(us_covid, "raw-data/us_covid.csv")
utils::write.csv(or_covid, "raw-data/or_covid.csv")
utils::write.csv(us_pop, "raw-data/us_pop.csv")
utils::write.csv(or_pop, "raw-data/or_pop.csv")
utils::write.csv(us_states, "raw-data/us_states.csv")
utils::write.csv(or_counties, "raw-data/or_counties.csv")