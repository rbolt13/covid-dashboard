#### Covid Dashboard ####
# Title: OR Total Case Percent Map
# Date: May 30, 2023
# Input: or_totals.join.csv
# Output: Map of OR Cases Percent
# Description: This file creates 
# a map of OR Total Case Percent.
here::i_am("fig-functions/or_case_perc_map.R")

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
or_case_perc_map <- function(){
  vis <- or_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      lon,
      lat, 
      group = group,
      # fill = total cases perc
      fill = total_cases_perc,
      text = paste("County:", county, 
                   "\nTotal Cases:",
                   base::formatC(
                     total_cases,
                     format = "d",
                     big.mark = ","),
                   "\nPercent of Population: ",
                   base::round(
                     total_cases_perc*100,
                     digits=2), "%")
    )) + 
    ggplot2::geom_polygon(color = "grey") +
    ggplot2::coord_quickmap() +
    # labs
    ggplot2::labs(
      title = "Percent of County Population Affected") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colors = hcl.colors(5),
      name = "Percent of Population",
      breaks = c(0.15, 0.20, 0.25),
      labels = c("15%%", "20%", "25%")
    )
  vis <- or_sty_map(vis)
  return(vis)
}