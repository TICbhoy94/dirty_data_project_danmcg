# R script written to tidy the sea birds data set

# load libraries
library(tidyverse)
library(here)
library(readxl)

# load data set
names_sheets <- excel_sheets(here("raw_data/seabirds.xls"))
names_sheets


# iterate through all the tabs of the spreadsheet and store them in a list 
all_tabs <- list()
for(this_sheet in names_sheets){
  all_tabs[[this_sheet]] <- read_excel(here("raw_data/seabirds.xls"), sheet = this_sheet)
}

# assign each sheet to a different data_frame (these may be useful for future analysis)
ship_data <- all_tabs[["Ship data by record ID"]]
bird_data <- all_tabs[["Bird data by record ID"]]
ship_codes <- all_tabs[["Ship data codes"]]
bird_codes <- all_tabs[["Bird data codes"]]


# Combine ship and bird data and keep only the data we're interested in
combined_df <- left_join(bird_data, ship_data, by = "RECORD ID") %>%
  select("RECORD ID",
         species_common_name = "Species common name (taxon [AGE / SEX / PLUMAGE PHASE])", 
         species_scientific_name = "Species  scientific name (taxon [AGE /SEX /  PLUMAGE PHASE])",
         "COUNT",
         "LAT",
         "LONG")


# export clean data to a csv file
write_csv(combined_df, here("clean_data/seabird_data_clean.csv"))



