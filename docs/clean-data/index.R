#### Covid Dashboard ####
# Title: Clean Data - Index
# Date: May 26, 2023
# Description: This file loads in the `raw-data`.
# Then takes them through cleaning functions that 
# save the clean data as .csv files in the 
# `clean-data` folder.
# Input: 'raw-data'
#   - us_covid , us_pop, us_states
#   - or_covid, or_pop, or_counties
# Output: 'clean-data'
#   - us_join, us_dates, 
#   - us_totals, us_totals_join, 
#   - us_page_data, us_page_totals
#   - or_join, or_data_dates, 
#   - or_totals, or_totals_join, 
#   - or_page_data, or_page_totals
# Note: 
#   - "id" is used to identify US or OR. 
#   - "region" is used to identify state or county.
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
base::source("clean-data/R/us_totals_join.R")
base::source("clean-data/R/us_page_data.R")

#### Join Data ####
# Input: id_covid, id_pop
# Output: id_join 
# Description: Joins covid and population data sets. 
us_join <- us_join(us_covid, us_pop)
or_join <- or_join(or_covid, or_pop)

#### Dates Data ####
# Input: id_join , "id"
# Output: dates_data
# Description: Extracts the first and last data of data 
# from the data set and creates a dates data frame. 
us_data_dates <- data_dates(us_join, c("us"))
or_data_dates <- data_dates(or_join, c("or"))

#### Totals Data #### 
# Input: id_join, id_date_data
# Output: id_totals, id_totals_join
# Description: Arranges the join data by the 
# most recent date of data, calculates totals,  
# and saved as .csv file in the clean-data folder. 
us_totals <- us_totals(us_join, us_data_dates)

#### Totals Join Data ####
# Input: id_totals, id_region 
# Output: id_totals_join
# Description: Joins the totals data with the region data. 
us_totals_join <- us_totals_join(us_totals, us_states)

#### Page Data ####
# Input: id_totals
# Output: id_page_data
# Description: Calculates totals seen on dashboard pages. 
us_page_data <- us_page_data(us_totals)
