# ============================================
# 02_data_cleaning.R
# Purpose: Clean Bigmart Sales Data
# ============================================


library(dplyr)
library(lubridate)
library(here)

# 1. Cleaning Missing item_weight
train <- train %>%
  group_by(item_identifier) %>%
  mutate(item_weight = ifelse(is.na(item_weight),
                              mean(item_weight, na.rm = TRUE),
                              item_weight)) %>%
  ungroup()

train$item_weight[is.na(train$item_weight)] <- median(train$item_weight, na.rm = TRUE)

# 2. Cleaning Missing outlet_size
train$outlet_size[is.na(train$outlet_size)] <- "Unknown"

# 3. Fixing item_visibility = 0
train$item_visibility[train$item_visibility == 0] <- NA

train <- train %>%
  group_by(item_identifier) %>%
  mutate(item_visibility = ifelse(is.na(item_visibility),
                                  median(item_visibility, na.rm = TRUE),
                                  item_visibility)) %>%
  ungroup()

train$item_visibility[is.na(train$item_visibility)] <- mean(train$item_visibility, na.rm = TRUE)

# 4. Fixing item_fat_content Inconsistencies
train$item_fat_content <- tolower(train$item_fat_content)

train$item_fat_content <- recode(train$item_fat_content, 
                                 "lf" = "low fat",
                                 "reg" = "regular",
                                 "low fat" = "low fat",
                                 "regular" = "regular")

# 5. Adding New Columns
train$outlet_age <- year(Sys.Date()) - train$outlet_establishment_year
train$price_category <- cut(train$item_mrp,
                            breaks = c(0, 70, 140, 210, Inf),
                            labels = c("Low", "Medium", "High", "Premium"))

# 6. Data Type Conversions
train$item_fat_content <- as.factor(train$item_fat_content)
train$item_type <- as.factor(train$item_type)
train$outlet_size <- as.factor(train$outlet_size)
train$outlet_type <- as.factor(train$outlet_type)
train$outlet_location_type <- as.factor(train$outlet_location_type)

# 7. Saving File
write.csv(train, here("data", "cleaned", "bigmart_cleaned.csv"), row.names = FALSE)


# ============================================
# End of Script
# ============================================