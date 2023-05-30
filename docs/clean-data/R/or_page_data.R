#### Covid Dashboard ####
# Title: US Page Data
# Date: May 30, 2023
# Input: or_totals data 
# Output: or_page_data.csv
# Description: This file loads in
# the or totals data and outputs 
# the "Most", "Least", "Highest 
# Percentage", and "Least Percentage" 
# for cases and deaths in the US. 
here::i_am("clean-data/R/or_page_data.R")

#### Load Packages #### 
# tidyverse: A collection of data-related packages.
base::library(tidyverse)

#### US Page Data Function ####
or_page_data <- function(or_totals){
  # Arrange Data
  # by case
  arr_totals_c <- or_totals %>%
    group_by(county) %>%
    dplyr::arrange(dplyr::desc(total_cases))
  # by case %
  arr_totals_p <- or_totals %>%
    group_by(county) %>%
    dplyr::arrange(dplyr::desc(total_cases_perc))
  # by deaths
  arr_totals_d <- or_totals %>%
    group_by(county) %>%
    dplyr::arrange(dplyr::desc(total_deaths))
  # by deaths %
  arr_totals_dp <- or_totals %>%
    group_by(county) %>%
    dplyr::arrange(dplyr::desc(total_deaths_perc))
  
  # Page 1: Cases 
  most_c <- arr_totals_c[[1,1]]
  most_c_val <- base::formatC(
    arr_totals_c[[1,2]],
    format = "d",
    big.mark = ",")
  
  least_c <- arr_totals_c[[36,1]]
  least_c_val <- base::formatC(
    arr_totals_c[[36,2]],
    format = "d",
    big.mark = ",")
  
  most_p <- arr_totals_p[[1,1]]
  most_p_val <- base::round(
    arr_totals_p[[1,3]]*100,
    digits = 2)
  
  least_p <- arr_totals_p[[36,1]]
  least_p_val <- base::round(
    arr_totals_p[[36,3]]*100,
    digits = 2)
  
  # Page 2: Deaths
  most_d <- arr_totals_d[[1,1]]
  most_d_val <- base::formatC(
    arr_totals_d[[1,4]],
    format = "d",
    big.mark = ",")
  
  least_d <- arr_totals_d[[36,1]]
  least_d_val <- base::formatC(
    arr_totals_d[[36,4]],
    format = "d",
    big.mark = ",")
  
  most_dp <- arr_totals_dp[[1,1]]
  most_dp_val <- base::round(
    arr_totals_dp[[1,5]]*100,
    digits = 2)
  
  least_dp <- arr_totals_dp[[36,1]]
  least_dp_val <- base::round(
    arr_totals_dp[[36,5]]*100,
    digits = 2)
  
  # US Page Data
  or_page_data <- base::data.frame(
    state = c(most_c, least_c, most_p, least_p, 
              most_d, least_d, most_dp, least_dp),
    val = c(most_c_val, least_c_val, most_p_val, least_p_val, 
            most_d_val, least_d_val, most_dp_val, least_dp_val))
  
  # Save Data
  utils::write.csv(or_page_data, "clean-data/or_page_data.csv")
  return(or_page_data)
}