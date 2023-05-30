#### Covid Dashboard ####
# Title: US Total Death Percent Map
# Date: May 30, 2023
# Input: us_totals_join.csv
# Output: Map of US Total Death Percent
# Description: This file creates 
# a map of US Total Death Percent.
here::i_am("fig-functions/us_death_perc_map.R")

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
us_death_perc_map <- function(){
  vis <- us_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      long,
      lat, 
      group = group,
      # fill = total cases perc
      fill = total_deaths_perc,
      text = paste("State:", state, 
                   "\nTotal Deaths:",
                   base::formatC(
                     total_deaths,
                     format = "d",
                     big.mark = ","),
                   "\nPercent of Population: ",
                   base::round(
                     total_deaths_perc*100,
                     digits=2), "%")
    )) + 
    ggplot2::geom_polygon(color = "grey") +
    ggplot2::coord_quickmap() +
    # labs
    ggplot2::labs(
      title = "Percent of State Population Affected") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colors = hcl.colors(5),
      name = "Percent of Population",
      breaks = c(.002, .0025, .003, .0035, .004, .0045),
      labels = c("2%", "2.5%", "3%", "3.5%", "4%", "4.5%")
    )
  vis <- sty_map(vis)
  return(vis)
}