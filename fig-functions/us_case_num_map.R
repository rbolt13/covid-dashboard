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
      fill = total_cases)) + 
    ggplot2::geom_polygon(color = "grey") +
    ggplot2::coord_quickmap() + 
    # plot theme
    ggplot2::theme_minimal() +
    # labs
    ggplot2::labs(
      title = "Total Number of Cases by State",
      subtitle = "This map shows the total number of covid cases by state.",
      caption = "Graph by Randi Bolt | Data from NYT and Tidycensus | Period 2020 - 2023.",
      x = "",
      y = ""
    ) +
    # theme
    theme(
      text = element_text(size = 16, family = "Times")) 
    return(vis)
}