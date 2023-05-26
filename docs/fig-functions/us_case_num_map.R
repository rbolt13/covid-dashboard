#### Covid Dashboard ####
# Title: Figure Functions  
# - US Total Case Number Map
# Date: May 25, 2023
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
    # plot theme
    ggplot2::theme_minimal() +
    # labs
    ggplot2::labs(
      title = "Total Covid Cases By State",
      x = "",
      y = ""
    ) +
    # Subtitle and Footnote
    annotate(
      "text", x = -100, y = 60, 
      label = "Discover the distribution of Covid-19 cases across different states with this interactive map.\n Simply hover over the map and utilize the crosshairs to draw a box around an area of interest to zoom in\n and examine the data at a closer level. To zoom out, double click on the map.") +
    annotate(
      "text", x = -100, y = 15, 
      label = "Graph by Randi Bolt\n Data from the NYT and Tidycensus Package\n Data Period: Jan 21, 2020 - March 23, 2023.") +
    # Legend
    ggplot2::scale_fill_gradientn(
      colours = hcl.colors(5),
      name = "Total Number of Cases",
      breaks = c(3000000, 6000000, 9000000, 12000000),
      labels = c("3,000,000", "6,000,000", "9,000,000", "12,000,000")) +
  # theme
    theme(
      text = element_text(size = 16, family = "Times"),
      plot.title = element_text(
        hjust = .5,
        face = "bold"),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_rect(fill = "white"),
      panel.grid.major = element_line(color = "white")
      )
    return(vis)
}