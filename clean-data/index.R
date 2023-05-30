#### Covid Dashboard ####
# Title: Clean Data
# Date: May 26, 2023
# Input: 'raw-data'
# Output: 'clean-data'
# Description: This file loads in the `raw-data`, and takes
# the data sets through cleaning functions that clean and 
# save the data as .csv files in the `clean-data` folder.
# To Do: Make one functions for join, totals, totals-join, 
# page_data, and page_totals. 
here::i_am("clean-data/index.R")

#### Load Data ####
# read_csv(): read in csv file. 
us_covid <- readr::read_csv("raw-data/us_covid.csv")
us_pop <- readr::read_csv("raw-data/us_pop.csv")
us_state <- readr::read_csv("raw-data/us_states.csv")
or_covid <- readr::read_csv("raw-data/or_covid.csv")
or_pop <- readr::read_csv("raw-data/or_pop.csv")
or_counties <- readr::read_csv("raw-data/or_counties.csv")

#### Load Functions ####
# source(): reads in data from file. 
base::source("clean-data/R/us_join.R")
base::source("clean-data/R/or_join.R")
base::source("clean-data/R/data_dates.R")
base::source("clean-data/R/us_totals.R")
base::source("clean-data/R/or_totals.R")
base::source("clean-data/R/us_totals_join.R")
base::source("clean-data/R/or_totals_join.R")
base::source("clean-data/R/us_page_data.R")
base::source("clean-data/R/or_page_data.R")

#### Data Cleaning Functions ####
# Join Data 
us_join <- us_join(us_covid, us_pop)
or_join <- or_join(or_covid, or_pop)
# Dates Data 
us_data_dates <- data_dates(us_join, c("us"))
or_data_dates <- data_dates(or_join, c("or"))
# Totals Data
us_totals <- us_totals(us_join, us_data_dates)
or_totals <- or_totals(or_join, or_data_dates)
# Totals Join Data
us_totals_join <- us_totals_join(us_totals, us_states)
or_totals_join <- or_totals_join(or_totals, or_counties)
# Page Data 
us_page_data <- us_page_data(us_totals)
or_page_data <- or_page_data(or_totals)
