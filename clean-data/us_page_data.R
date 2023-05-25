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

sec_most_c <- arr_totals_c[[2,2]]
sec_most_c_val <- base::formatC(
  arr_totals_c[[2,3]],
  format = "d",
  big.mark = ",")

least_c <- arr_totals_c[[52,2]]
least_c_val <- base::formatC(
  arr_totals_c[[52,3]],
  format = "d",
  big.mark = ",")

sec_least_c <- arr_totals_c[[51,2]]
sec_least_c_val <- base::formatC(
  arr_totals_c[[51,3]],
  format = "d",
  big.mark = ",")

most_p <- arr_totals_p[[1,2]]
most_p_val <- base::round(
  arr_totals_p[[1,4]]*100,
  digits = 2)

sec_most_p <- arr_totals_p[[2,2]]
sec_most_p_val <- base::round(
  arr_totals_p[[2,4]]*100,
  digits = 2)

least_p <- arr_totals_p[[52,2]]
least_p_val <- base::round(
  arr_totals_p[[52,4]]*100,
  digits = 2)

sec_least_p <- arr_totals_p[[51,2]]
sec_least_p_val <- base::round(
  arr_totals_p[[51,4]]*100,
  digits = 2)

#### Page 2: Deaths ####
most_d <- arr_totals_d[[1,2]]
most_d_val <- base::formatC(
  arr_totals_d[[1,3]],
  format = "d",
  big.mark = ",")

sec_most_d <- arr_totals_d[[2,2]]
sec_most_d_val <- base::formatC(
  arr_totals_d[[2,3]],
  format = "d",
  big.mark = ",")

least_d <- arr_totals_d[[52,2]]
least_d_val <- base::formatC(
  arr_totals_d[[52,3]],
  format = "d",
  big.mark = ",")

sec_least_d <- arr_totals_d[[51,2]]
sec_least_d_val <- base::formatC(
  arr_totals_d[[51,3]],
  format = "d",
  big.mark = ",")

most_dp <- arr_totals_dp[[1,2]]
most_dp_val <- base::round(
  arr_totals_dp[[1,4]]*100,
  digits = 2)

sec_most_dp <- arr_totals_dp[[2,2]]
sec_most_dp_val <- base::round(
  arr_totals_dp[[2,4]]*100,
  digits = 2)

least_dp <- arr_totals_dp[[52,2]]
least_dp_val <- base::round(
  arr_totals_dp[[52,4]]*100,
  digits = 2)

sec_least_dp <- arr_totals_dp[[51,2]]
sec_least_dp_val <- base::round(
  arr_totals_dp[[51,4]]*100,
  digits = 2)

#### US Page Data ####
us_page_data <- base::data.frame(
  state = c(most_c, sec_most_c, least_c, sec_least_c,
            most_p, sec_most_p, least_p, sec_least_p,
            most_d, sec_most_d, least_d, sec_least_d,
            most_dp, sec_most_dp, least_dp, sec_least_dp),
  val = c(most_c_val, sec_most_c_val, least_c_val, sec_least_c_val,
          most_p_val, sec_most_p_val, least_p_val, sec_least_p_val,
          most_d_val, sec_most_d_val, least_d_val, sec_least_d_val,
          most_dp_val, sec_most_dp_val, least_dp_val, sec_least_dp_val)
)

#### Save Data ####
utils::write.csv(us_page_data, "clean-data/us_page_data.csv")