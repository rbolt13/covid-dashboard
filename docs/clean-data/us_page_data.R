#### Covid Dashboard ####
# Title: Clean Data  - Page Data
# Date: May 25, 2023
# Description: This file loads in
# the us_totals.csv file and outputs 
# the "Most", "Least", "Highest 
# Percentage", and "Least Percentage" 
# for cases and deaths in the US. 
here::i_am("clean-data/us_page_data.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### Load Data ####
# read_csv(): Reads csv file. 
us_totals <- readr::read_csv("clean-data/us_totals.csv")

#### Row Total Values ####
us_total_cases <- sum(us_totals$total_cases)
us_cases_perc <- base::round(
  (us_total_cases / sum(us_totals$population))*100,
  digits = 2)
us_total_deaths <- sum(us_totals$total_deaths)
us_deaths_perc <- base::round(
  (us_total_deaths / sum(us_totals$population))*100,
  digits = 2)

#### Arrange Data####
# arrange by case
arr_totals_c <- us_totals %>%
  group_by(state) %>%
  dplyr::arrange(dplyr::desc(total_cases))
# arrange by case %
arr_totals_p <- us_totals %>%
  group_by(state) %>%
  dplyr::arrange(dplyr::desc(total_cases_perc))
# arrange by deaths
arr_totals_d <- us_totals %>%
  group_by(state) %>%
  dplyr::arrange(dplyr::desc(total_deaths))
# arrange by deaths %
arr_totals_dp <- us_totals %>%
  group_by(state) %>%
  dplyr::arrange(dplyr::desc(total_deaths_perc))

#### Page 1: Cases ####
most_c <- arr_totals_c[[1,2]]
most_c_val <- base::formatC(
  arr_totals_c[[1,3]],
  format = "d",
  big.mark = ",")

least_c <- arr_totals_c[[52,2]]
least_c_val <- base::formatC(
  arr_totals_c[[52,3]],
  format = "d",
  big.mark = ",")

most_p <- arr_totals_p[[1,2]]
most_p_val <- base::round(
  arr_totals_p[[1,4]]*100,
  digits = 2)

least_p <- arr_totals_p[[52,2]]
least_p_val <- base::round(
  arr_totals_p[[52,4]]*100,
  digits = 2)

#### Page 2: Deaths ####
most_d <- arr_totals_d[[1,2]]
most_d_val <- base::formatC(
  arr_totals_d[[1,3]],
  format = "d",
  big.mark = ",")

least_d <- arr_totals_d[[52,2]]
least_d_val <- base::formatC(
  arr_totals_d[[52,3]],
  format = "d",
  big.mark = ",")

most_dp <- arr_totals_dp[[1,2]]
most_dp_val <- base::round(
  arr_totals_dp[[1,4]]*100,
  digits = 2)

least_dp <- arr_totals_dp[[52,2]]
least_dp_val <- base::round(
  arr_totals_dp[[52,4]]*100,
  digits = 2)

#### US Page Data ####
us_page_data <- base::data.frame(
  state = c(most_c, least_c, most_p, least_p, 
            most_d, least_d, most_dp, least_dp),
  val = c(most_c_val, least_c_val, most_p_val, least_p_val, 
          most_d_val, least_d_val, most_dp_val, least_dp_val))

#### US Page Totals Data ####
us_page_totals <- base::data.frame(
  cases = c(us_total_cases, us_cases_perc),
  deaths = c(us_total_deaths, us_deaths_perc))

#### Save Data ####
utils::write.csv(us_page_data, "clean-data/us_page_data.csv")
utils::write.csv(us_page_totals, "clean-data/us_page_totals.csv")
