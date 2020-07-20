# R script to tidy up the data in the Decathlon Data file

# load libraries
library(tidyverse)
library(here)

# load in data set
dec_data <- read_rds(here("raw_data/decathlon.rds"))

# check the size of the data frame and the column classes
dim(dec_data)
sapply(dec_data, class)

# rename column rows
dec_data <- dec_data %>%
  rename(run_100m = `100m`,
         long_jump = Long.jump,
         shot_put = Shot.put,
         high_jump = High.jump,
         hurdles_110m = `110m.hurdle`,
         discus = Discus,
         pole_vault = Pole.vault,
         javeline = Javeline,
         run_1500m = `1500m`,
         rank = Rank,
         points = Points,
         competition = Competition)

# remove row names and make them a column
dec_data <- rownames_to_column(dec_data, "athlete_name")

# export data set to csv for analysis
write_csv(dec_data, here("clean_data/decathlon_data_clean.csv"))
