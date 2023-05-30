#### Covid Dashboard ####
# Title: OR Total Case Number Map
# Date: May 26, 2023
# Input: or_totals_join.csv
# Output: Map of US Total Cases 
# Description: This file creates a map of US 
# Total Case Numbers.
here::i_am("fig-functions/or_case_num_map.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
or_totals_join <- readr::read_csv("clean-data/or_totals_join.csv")

#### Load Functions ####
# sty_map(): Stylizes Map 
base::source("fig-functions/or_sty_map.R")

#### Function ####
or_case_num_map <- function(){
  vis <- or_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      lon,
      lat, 
      group = group,
      # fill = total cases
      fill = total_cases,
      text = paste("County:", county, 
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
      title = "Total Covid Cases By County") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colours = hcl.colors(5),
      name = "Total Number of Cases",
      breaks = c(25000, 50000, 75000, 100000),
      labels = c("25,000", "50,000", "75,000", "100,000")) 
  vis <- or_sty_map(vis)
  return(vis)
}