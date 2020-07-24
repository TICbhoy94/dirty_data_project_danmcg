# R script to clean the data set for task 2

# load libraries
library(tidyverse)
library(here)

# load data sets
cake_df <- read_csv(here("raw_data/cake/cake-ingredients-1961.csv"))
cake_abv <- read_csv(here("raw_data/cake/cake_ingredient_code.csv"))


# convert abreviations into full names
cake_abv <- cake_abv %>%
  mutate(ingrediant_unit = paste0(ingredient, " (", measure, ")")) # take the abbrevations table and combine the ingrediant values with the measure

# create a vector of all our abbreviated ingrediants
ingrediant_names <- cake_df %>%
  colnames() %>% 
  tail(-1) # remove 'cake' from this vector

# pivot main data frame into a longer format and make a conenction to our abbreviation table
cake_df <- cake_df %>%
  pivot_longer(cols = ingrediant_names, names_to = "code", values_to = "measure_amount") %>% 
  drop_na()  %>% # drop rows of ingediants that are not used in different recipes
  left_join(cake_abv, by = "code") # join to the abbreviations table
 
# remove redundant columns
cake_df <- cake_df %>%
  select(cake = Cake, ingrediant_unit, measure_amount)

# export clean data to a csv file
write_csv(cake_df, here("clean_data/cake_ingrediants_clean.csv"))



