#### Covid Dashboard ####
# Title: Style Map Function 
# Date: May 26, 2023
# Description: This file takes
# in a ggplot map, and styles 
# it. 
here::i_am("fig-functions/sty_map.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Style Map Function ####
sty_map <- function(map){
  sty_map <- map + 
    # plot theme
    ggplot2::theme_minimal() +
    # Subtitle and Footnote
    annotate(
      "text", x = -100, y = 60, 
      label = "Discover the distribution of Covid-19 across different states with this interactive map.\n Simply hover over the map and utilize the crosshairs to draw a box around an area of interest to zoom in\n and examine the data at a closer level. To zoom out, double click on the map.") +
    annotate(
      "text", x = -100, y = 15, 
      label = "Graph by Randi Bolt\n Data from the NYT and Tidycensus Package\n Data Period: Jan 21, 2020 - March 23, 2023.") +
    # labs
    labs(x = "", y = "") +
    # theme
    theme(
      text = element_text(size = 16, family = "Times"),
      plot.title = element_text(
        hjust = .5,
        face = "bold"),
      # Hide Lat and Long Lines and Ticks
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_rect(fill = "white"),
      panel.grid.major = element_line(color = "white")
    ) 
  return(sty_map)
}
