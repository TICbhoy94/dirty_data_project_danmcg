# R script to tidy the task 4 data on halloween candy

# load libraries
library(tidyverse)
library(here)
library(readxl)

# load in data sets
candy_2015 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2015.xlsx"), range = cell_cols(2:99))
candy_2016 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2016.xlsx"),range = cell_cols(2:109))
candy_2017 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2017.xlsx"), range = cell_cols(2:112))


# objective is to get the data into the same format before combining

#2017

# rename 2017 column names
candy_2017 <- rename(candy_2017,  "     Q01_going_out" = "Q1: GOING OUT?",
                     "     Q02_gender" = "Q2: GENDER",
                     "     Q03_age" = "Q3: AGE",
                     "     Q04_country" = "Q4: COUNTRY",
                     "     Q05_state_province_county" = "Q5: STATE, PROVINCE, COUNTY, ETC",
                     "     Q07_joy_other" = "Q7: JOY OTHER",
                     "     Q08_despair_other" = "Q8: DESPAIR OTHER",
                     "     Q09_other_comments" = "Q9: OTHER COMMENTS")

# align titles
names(candy_2017) <- substring(names(candy_2017), 6)


# drop any columns that are not candy
invalid_candy <- c("Bonkers (the board game)", # not candy
                                            "Broken glow stick", # not candy
                                            "Candy that is clearly just the stuff given out for free at restaurants", # not anything really
                                            "Cash, or other forms of legal tender", # not caandy
                                            "Chardonnay", # wine so definately not candy
                                            "Creepy Religious comics/Chick Tracts", # not candy
                                            "Dental paraphenalia", # defo not candy
                                            "Generic Brand Acetaminophen", # not candy!!
                                            "Glow sticks" , # not candy
                                            "Gum from baseball cards", # not specific enough
                                            "Healthy Fruit", # not candy
                                            "Hugs (actual physical hugs)", # lovely but not candy
                                            "Jolly Rancher (bad flavor)", # not specific enough
                                            "Jolly Ranchers (good flavor)", # not specific enough
                                            "Senior Mints", # not a real candy
                                            "Kale smoothie", # not candy
                                            "Licorice (not black)", # doesn't exist
                                            "Maynards", # not specific enough (brand not a product)
                                            "Blue M&M's", # not a product
                                            "Red M&M's", # not a product 
                                            "Green Party M&M's", # not a product
                                            "Independent M&M's", # not a product
                                            "Abstained from M&M'ing.", # not a product
                                            "Minibags of chips", # not candy
                                            "Mint Juleps", # cocktail so not a candy 
                                            "Pencils", # not candy
                                            "Real Housewives of Orange County Season 9 Blue-Ray", # not candy
                                            "Reggie Jackson Bar", # discontinued in the 80s
                                            "Sandwich-sized bags filled with BooBerry Crunch", # not candy
                                            "Spotted Dick", # traditional english dessert, not candy
                                            "Vials of pure high fructose corn syrup, for main-lining into your vein", # don't even know tbh
                                            "Vicodin", # defo not candy
                                            "White Bread", # not candy
                                            "Whole Wheat anything", # not candy
                                            "Any full-sized candy bar" # was originally left in but skews all results
                                            )

candy_2017 <- candy_2017[ , !(names(candy_2017) %in% invalid_candy)]

# rename candy bars to suitable names where applicable
candy_2017 <- rename(candy_2017, "Mary Janes" = "Anonymous brown globs that come in black and orange wrappers\t(a.k.a. Mary Janes)",
                     "Bonkers" = "Bonkers (the candy)", 
                     "Chick-o-Sticks" = "Chick-o-Sticks (we don’t know what that is)",
                     "Gummy Bears" = "Gummy Bears straight up",
                     "JoyJoy" = "JoyJoy (Mit Iodine!)", 
                     "Sweetums" = "Sweetums (a friend to diabetes)",  
                     "Sourpatch Kids" = "Sourpatch Kids (i.e. abominations of nature)",
                     "Licorice" =  "Licorice (yes black)" , 
                     "Circus Peanuts" = "Those odd marshmallow circus peanut things",
                     "Tolberone Products" = "Tolberone something or other" )

# create a date columm in case we want to compare year
candy_2017 <- candy_2017 %>%
  mutate(Q10_year = 2017)
                     

# 2016
names(candy_2016)

# rename 2016 column names
candy_2016 <- rename(candy_2016,  "[Q01_going_out]" = "Are you going actually going trick or treating yourself?",
                     "[Q02_gender]" = "Your gender:",
                     "[Q03_age]" = "How old are you?",
                     "[Q04_country]" = "Which country do you live in?",
                     "[Q05_state_province_county]" = "Which state, province, county do you live in?",
                     "[Q07_joy_other]" = "Please list any items not included above that give you JOY.",
                     "[Q08_despair_other]" = "Please list any items not included above that give you DESPAIR.",
                     "[Q09_other_comments]" = "Please leave any witty, snarky or thoughtful remarks or comments regarding your choices.")

# remove square brackets
names(candy_2016) <- gsub("\\[*\\]*", "", names(candy_2016))
# 2015 has 5630 responsies, 2016 has 1259, 2017 has 2460


# remove invalid candy names

# Mary Janes already appears so we will drop that column 
invalid_candy <- c(invalid_candy, "Mary Janes", # already in list
                   "Person of Interest Season 3 DVD Box Set (not including Disc 4 with hilarious outtakes)", # not candy
                   "Third Party M&M's") # not obvious which flavour these are
candy_2016 <- candy_2016[ , !(names(candy_2016) %in% invalid_candy)]

# rename candy bars to suitable names where applicable
candy_2016 <- rename(candy_2016,"Mary Janes" = "Anonymous brown globs that come in black and orange wrappers", 
                     "Bonkers" = "Bonkers (the candy)", 
                     "Chick-o-Sticks" = "Chick-o-Sticks (we don’t know what that is)",
                     "Gummy Bears" = "Gummy Bears straight up",
                     "JoyJoy" = "JoyJoy (Mit Iodine!)", 
                     "Sweetums" = "Sweetums (a friend to diabetes)",  
                     "Sourpatch Kids" = "Sourpatch Kids (i.e. abominations of nature)",
                     "Licorice" =  "Licorice (yes black)" , 
                     "Circus Peanuts" = "Those odd marshmallow circus peanut things",
                     "Tolberone Products" = "Tolberone something or other" )


# create a date columm in case we want to compare year
candy_2016 <- candy_2016 %>%
  mutate(Q10_year = 2016)


# 2015
names(candy_2015)

candy_2015 <- rename(candy_2015,  "[Q01_going_out]" = "Are you going actually going trick or treating yourself?",
                    "[Q03_age]" = "How old are you?", 
                    "[Q07_joy_other]" = "Please list any items not included above that give you JOY." ,
                    "[Q08_despair_other]" = "Please list any items not included above that give you DESPAIR." ,
                    "[Q09_other_comments]" = "Please leave any remarks or comments regarding your choices.")

names(candy_2015) <- gsub("\\[*\\]*", "", names(candy_2015))

# add any additional invalid candy to existing list then remove
invalid_candy <- c(invalid_candy, "Peterson Brand Sidewalk Chalk", # not candy
                   "Mint Leaves", # not candy
                   "Peanut Butter Jars", # not candy
                   "Lapel Pins", # not candy
                   "Brach products (not including candy corn)" # too generic
                   )
candy_2015 <- candy_2015[ , !(names(candy_2015) %in% invalid_candy)]

candy_2015 <- rename(candy_2015,"Mary Janes" = "Anonymous brown globs that come in black and orange wrappers", 
                     "Chick-o-Sticks" = "Chick-o-Sticks (we don’t know what that is)",
                     "Gummy Bears" = "Gummy Bears straight up",
                     "JoyJoy" = "JoyJoy (Mit Iodine)" , 
                     "Circus Peanuts" = "Those odd marshmallow circus peanut things",
                     "Tolberone Products" = "Tolberone something or other",
                     "Box'o'Raisins" = "Box’o’ Raisins",
                     "Hershey's Kisses"  = "Hershey’s Kissables",
                     "Hershey's Dark Chocolate" = "Dark Chocolate Hershey",
                     "Reese's Pieces" = "Peanut Butter Bars") # assumption here that Reeses Pieces are these bar 


# create a date columm in case we want to compare year
candy_2015 <- candy_2015 %>%
  mutate(Q10_year = 2015)


# check if all the names of the columns match
matching_cols <- intersect(colnames(candy_2017), colnames(candy_2015))

candy_2015[, !(names(candy_2015) %in% matching_cols)]
candy_2017[, !(names(candy_2017) %in% matching_cols)]


all_columns <- c(colnames(candy_2017), colnames(candy_2016), colnames(candy_2015)) %>%
  unique()


# add any missing columns to our tables

missing_cols <- setdiff(all_columns, names(candy_2017))
candy_2017[missing_cols] <- NA
missing_cols <- setdiff(all_columns, names(candy_2016))
candy_2016[missing_cols] <- NA
missing_cols <- setdiff(all_columns, names(candy_2015))
candy_2015[missing_cols] <- NA

# combine our tables

halloween_candy_df <- rbind(candy_2015, candy_2016, candy_2017)

# make the table in long format

halloween_candy_df <- pivot_longer(halloween_candy_df, cols = !starts_with("Q"), names_to = "Q06_candy_name", values_to = "Q06_response")

# order columns alphabetically
halloween_candy_df <- halloween_candy_df[,order(colnames(halloween_candy_df))]

# confirm column classes
sapply(halloween_candy_df, class)

# now we can finally clean our data entries

# 1st lets check if all Q6 responses are either JOY or DESPAIR or MEH

halloween_candy_df$Q06_response <- str_to_upper(halloween_candy_df$Q06_response) # capatalise everthing

halloween_candy_df %>%
  group_by(Q06_response) %>%
  summarise(COUNT = n())

# all responsies are in the exceptable form

# lets check Q1

halloween_candy_df %>%
  group_by(Q01_going_out) %>%
  summarise(COUNT = n())
 
# all acceptable

# lets check Q2

halloween_candy_df %>%
  group_by(Q02_gender) %>%
  summarise(COUNT = n())

# all acceptable

# lets fix Q3

halloween_candy_df$Q03_age <- gsub("[^[:digit:]., ]","", halloween_candy_df$Q03_age) # remove all characters
halloween_candy_df$Q03_age <- as.numeric(halloween_candy_df$Q03_age) # change all remaining ones to the correct format
halloween_candy_df$Q03_age <- round(halloween_candy_df$Q03_age) # round up
halloween_candy_df <-  halloween_candy_df %>%
  mutate(Q03_age = ifelse(Q03_age > 100 
                             | Q03_age < 1, NA, Q03_age)) # filter out ages between 0 and 100 (sorry older people)

# lets fix Q4

# title all countries
halloween_candy_df$Q04_country <- str_to_title(halloween_candy_df$Q04_country)

# change invalid entries to NA
invalid_countries <- c("Atlantis", # unlikely 
                       "Canae", # not a country, city somewhere
                       "Cascadia", # region of North America that is made up of parts of Canada and the US
                       "Denial", # not a country
                       "Earth", # not a country
                       "Europe", # not a country
                       "God's Country", # could be anywhere
                       "I Don't Know Anymore", # not a country
                       "N. America", # not a country
                       "Narnia", # not a country 
                       "Somewhere", # not a country 
                       "The Republic Of Cascadia", # not a country
                       "There Isn't One For Old Men",
                       "A Tropical Island South Of The Equator", # not specific,
                       "Fear And Loathing", # not a country
                       "See Above", # not a country
                       "One Of The Best Ones", # not a country
                       "Insanity Lately", # not a country
                        "Neverland" #not a country
                       )

# if you're too stupid to put something even remotely connected to a country, I'm sorry, you're out!
halloween_candy_df<- halloween_candy_df[!halloween_candy_df$Q04_country  %in% invalid_countries, ]

# get rid of entries with digits
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[0-9]", halloween_candy_df$Q04_country), NA)

# get rid of any entry with only one character entry
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("^[?a-zA-Z0-9]$",halloween_candy_df$Q04_country), NA)

# change all vaiartions of USA to America (need to exclude the UAE)
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("^[TtUu][a-zA-MO-Z\\. ]*[Ss][a-zA-Z\\.!? ]*[Aa]*$",halloween_candy_df$Q04_country),"America") # this will pick up the majority
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[ .?A']*[Mm][ue][r][i]*[c][a]$",halloween_candy_df$Q04_country),"America")
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[Uu][Ss][Aa]",halloween_candy_df$Q04_country),"America")
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[Mu][uU][Rr]{2}",halloween_candy_df$Q04_country),"America")
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[E][u][a]",halloween_candy_df$Q04_country),"America")

# get the UK in a union again
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("^[Uu][a-zA-Z\\. ]*[Kkd]",halloween_candy_df$Q04_country),"UK")
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("^[Ee][n][gd][l][a]*",halloween_candy_df$Q04_country),"UK")
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("^[Sc]([c][o][t])",halloween_candy_df$Q04_country),"UK")
#halloween_candy_df$Q4_country <- replace(halloween_candy_df$Q4_country,grep("Ud",halloween_candy_df$Q4_country),"UK") # assuming this was meant to say UK


# get Canada's house in order
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[C][a][n]",halloween_candy_df$Q04_country),"Canada")

# sort out The Netherlands
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[Nn][Ee][Tt][Hh][Ee]",halloween_candy_df$Q04_country),"The Netherlands")


# fix Spain
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[Ee][Ss][Pp][Aa]",halloween_candy_df$Q04_country),"Spain")

# fix the states!
halloween_candy_df <-  halloween_candy_df %>%
  mutate(Q04_country = ifelse(Q04_country == "California" 
                             | Q04_country == "New York"
                             | Q04_country == "Pittsburgh" 
                             | Q04_country == "New Jersey" 
                             | Q04_country == "Alaska"
                             | Q04_country == "North Carolina",
                             "America", Q04_country))
         
# recaptalise UAE
halloween_candy_df$Q04_country <- replace(halloween_candy_df$Q04_country,grep("[U][a][e]",halloween_candy_df$Q04_country),"UAE")

# sory by year so 2017, the most complete data set, is the reference data
halloween_candy_df <- halloween_candy_df %>%
  arrange(desc(halloween_candy_df$Q10_year))

# export clean data to csv file
write_csv(halloween_candy_df, here("clean_data/halloween_candy_clean.csv"))
