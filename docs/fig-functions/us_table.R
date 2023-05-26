#### Covid Dashboard ####
# Title: Figure Functions  
# - US Total Case Percent Map
# Date: May 26, 2023
# Description: This functions 
# takes in a data.frame and 
# outputs a table. 
here::i_am("fig-functions/us_table.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_totals <- readr::read_csv("clean-data/us_totals.csv")

#### Table Function ####
us_table <- function(){
  table <- us_totals
  return(us_totals)
}