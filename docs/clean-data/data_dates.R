#### Covid Dashboard ####
# Title: Clean Data  - Data Dates
# Date: May 25, 2023
# Description: This file loads in
# the joined data sets and save the 
# start and end dates.
here::i_am("clean-data/data_dates.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_join <- readr::read_csv("clean-data/us_join.csv")

#### Arrange Data ####
arr_data <- us_join %>%
  dplyr::arrange(dplyr::desc(date))

#### Save Dates ####
start_date <- arr_data[[1,2]]
end_date <- utils::tail(arr_data$date, n = 1)

#### US Data Dates ####
us_data_dates <- data.frame(date = c(end_date, start_date))

#### Save Data ####
utils::write.csv(us_data_dates, "clean-data/us_data_dates.csv")
