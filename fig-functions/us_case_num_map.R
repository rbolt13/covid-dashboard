#### Covid Dashboard ####
# Title: Figure Functions  
# - US Total Case Number Map
# Date: May 26, 2023
# Description: This file loads in
# the us_totals_join.csv data from 
# the `clean-data` file, and creates 
# a map of US Total Case Numbers.
here::i_am("fig-functions/us_case_num_map.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_totals_join <- readr::read_csv("clean-data/us_totals_join.csv")

#### Load Functions ####
# sty_map(): Stylizes Map 
base::source("fig-functions/sty_map.R")

#### Function ####
us_case_num_map <- function(){
  vis <- us_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      long,
      lat, 
      group = group,
      # fill = total cases
      fill = total_cases,
      text = paste("State:", state, 
                   "\nTotal Cases:",
                   base::formatC(
                     total_cases,
                     format = "d",
                     big.mark = ","),
                   "\nPercent of Population: ",
                   base::round(
                     total_cases_perc*100,
                     digits=2), "%"
                   )
      )) + 
    ggplot2::geom_polygon(color = "grey") +
    ggplot2::coord_quickmap() + 
    # labs
    ggplot2::labs(
      title = "Total Covid Cases By State") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colours = hcl.colors(5),
      name = "Total Number of Cases",
      breaks = c(3000000, 6000000, 9000000, 12000000),
      labels = c("3,000,000", "6,000,000", "9,000,000", "12,000,000")) 
  vis <- sty_map(vis)
    return(vis)
}