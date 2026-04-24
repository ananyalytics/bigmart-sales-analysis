# ============================================
# 01_data_loading.R
# Purpose: Load Bigmart Sales Data
# ============================================


library(tidyverse)
library(here)
library(janitor)

# 1. Reading Data
train_path <- here("data", "raw", "Train.csv")

# 2. Loading the CSV
train <- read_csv(train_path)

# 3. Cleaning Column Names
train <- clean_names(train)

# 4. Basic Data Inspection 
cat("===== SUMMARY =====")
summary(train)

cat("===== STRUCTURE ======")
glimpse(train)

cat("===== DIMENSIONS ======")
dim(train)

# 5. Checking Missing Values
colSums(is.na(train))

# 6. Data Overview 
head(train)


# ============================================
# End of Script
# ============================================