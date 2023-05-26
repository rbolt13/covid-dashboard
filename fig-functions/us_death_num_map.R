#### Covid Dashboard ####
# Title: Figure Functions  
# - US Total Deaths Number Map
# Date: May 26, 2023
# Description: This file loads in
# the us_totals_join.csv data from 
# the `clean-data` file, and creates 
# a map of US Total Death Numbers.
here::i_am("fig-functions/us_death_num_map.R")

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
us_death_num_map <- function(){
  vis <- us_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      long,
      lat, 
      group = group,
      # fill = total deaths
      fill = total_deaths,
      text = paste("State:", state, 
                   "\nTotal Deathss:",
                   base::formatC(
                     total_deaths,
                     format = "d",
                     big.mark = ","),
                   "\nPercent of Population: ",
                   base::round(
                     total_deaths_perc*100,
                     digits=2), "%"
      )
    )) + 
    ggplot2::geom_polygon(color = "grey") +
    ggplot2::coord_quickmap() + 
    # labs
    ggplot2::labs(
      title = "Total Covid Fatalities By State") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colours = hcl.colors(5),
      name = "Total Number of Deaths",
      breaks = c(25000, 50000, 75000, 100000),
      labels = c("25,000", "50,000", "75,000", "100,000")) 
  vis <- sty_map(vis)
  return(vis)
}