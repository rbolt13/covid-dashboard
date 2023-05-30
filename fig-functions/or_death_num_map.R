#### Covid Dashboard ####
# Title: OR Total Deaths Number Map
# Date: May 26, 2023
# Input: or_totals_join.csv
# Output: Map of OR Death Totals
# Description: This file creates 
# a map of OR Total Death Numbers.
here::i_am("fig-functions/or_death_num_map.R")

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
or_death_num_map <- function(){
  vis <- or_totals_join %>%
    ggplot2::ggplot(ggplot2::aes(
      lon,
      lat, 
      group = group,
      # fill = total deaths
      fill = total_deaths,
      text = paste("County:", county, 
                   "\nTotal Deaths:",
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
      title = "Total Covid Fatalities By County") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colours = hcl.colors(5),
      name = "Total Number of Deaths",
      breaks = c(300, 600, 900, 1200),
      labels = c("300", "600", "900", "1,200")) 
  vis <- or_sty_map(vis)
  return(vis)
}