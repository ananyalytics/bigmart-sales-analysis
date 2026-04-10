# ============================================
# 03_eda.R
# Purpose: Exploratory Data Analysis
# ============================================


library(here)
library(tidyverse)

# 1. Reading Cleaned Data
data_path <- here("data", "cleaned", "bigmart_cleaned.csv")

# 2. Loading the CSV
data <- read_csv(data_path)


# -------------------------------
# 3. Univariate Analysis
# -------------------------------
cat("\t===== \tDistribution of Sales\t =====\t")
summary(data$item_outlet_sales)

hist(data$item_outlet_sales,
     main = "Sales Distrubtion",
     xlab = "Item Outlet Size",
     breaks = 50)


# -------------------------------
# 4. Bivariate Analysis
# -------------------------------

# Sales by Outlet Type
sales_by_outlet <- data %>%
  group_by(outlet_type) %>%
  summarise(avg_sales = mean(item_outlet_sales),
            total_sales = sum(item_outlet_sales)) %>%
  ungroup()

# Sales by Location Type
sales_by_location <- data %>%
  group_by(outlet_location_type) %>%
  summarise(avg_sales = mean(item_outlet_sales),
            total_sales = sum(item_outlet_sales)) %>%
  ungroup()

# Sales by Item Type
sales_by_category <- data %>%
  group_by(item_type) %>%
  summarise(avg_sales = mean(item_outlet_sales),
            total_sales = sum(item_outlet_sales)) %>%
  ungroup()

# Sales by Fat Content
sales_by_fat <- data %>%
  group_by(item_fat_content) %>%
  summarise(avg_sales = mean(item_outlet_sales),
            total_sales = sum(item_outlet_sales))


# -------------------------------
# 5. Multivariate Analysis
# -------------------------------

# Sales by Outlet & Location Type
multi_analysis <- data %>%
  group_by(outlet_type, outlet_location_type) %>%
  summarise(avg_sales = mean(item_outlet_sales),
            total_Sales = sum(item_outlet_sales)) %>%
  ungroup()

# Outlet Age vs Sales
cor(data$outlet_age, data$item_outlet_sales)


# 6. Exporting Results
write_csv(sales_by_outlet, here("data", "processed", "sales_by_outlet.csv"))
write_csv(sales_by_location, here("data", "processed", "sales_by_location.csv"))
write_csv(sales_by_category, here("data", "processed", "sales_by_category.csv"))
write_csv(sales_by_fat, here("data", "processed", "sales_by_fat.csv"))
write_csv(multi_analysis, here("data", "processed", "multi_analysis.csv"))


# ============================================
# End of Script
# ============================================