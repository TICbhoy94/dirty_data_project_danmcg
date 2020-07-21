# R script to tidy the task 4 data on halloween candy

# load libraries
library(tidyverse)
library(here)
library(readxl)

# load in data sets
candy_2015 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2015.xlsx"), range = cell_cols(2:96))
candy_2016 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2016.xlsx"),range = cell_cols(2:109))
candy_2017 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2017.xlsx"), range = cell_cols(2:112))

# objective is to get the data into the same format before combining


