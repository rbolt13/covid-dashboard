#### Covid Dashboard ####
# Title: Data Dates
# Date: May 26, 2023
# Input: id_join, c("id")
# Output: id_data_dates.csv
# Description: This function loads in
# the joined data sets and an id, extracts 
# the start and end dates as a data frame, and
# then it saves that df as a .csv file in the 
# 'clean-data' folder.
# Note: 
#   - "id" is used to identify US or OR. 
here::i_am("clean-data/R/data_dates.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Data Dates Function ####
data_dates <- function(id_join, id){
  # arrange data by date
  arr_data <- id_join %>%
    dplyr::arrange(dplyr::desc(date))
  # save dates
  end_date <- arr_data[[1,1]]
  start_date <- utils::tail(arr_data$date, n = 1)
  # create data frame
  data_dates <- data.frame(date = c(start_date, end_date))
  # save data
  utils::write.csv(data_dates, paste0("clean-data/",id,"_data_dates.csv"))
  return(data_dates)
}