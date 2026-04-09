# ============================================
# 01_data_loading.R
# Purpose: Load Bigmart Sales Data
# ============================================


# 1. Loading Libraries
library(tidyverse)
library(here)
library(janitor)

# 2. Reading Data
train_path <- here("data", "raw", "Train.csv")

# 3. Loading the CSV
train <- read_csv(train_path)

# 4. Cleaning Column Names
train <- clean_names(train)

# 5. Basic Data Inspection 
cat("===== SUMMARY =====")
summary(train)

cat("===== STRUCTURE ======")
glimpse(train)

cat("===== DIMENSIONS ======")
dim(train)

# 6. Checking Missing Values
colSums(is.na(train))

# 7. Data Overview 
head(train)


# ============================================
# End of Script
# ============================================