# =================================================
# 04_visualization.R
# Purpose: Data Visualization for BigMart Sales
# =================================================


library(tidyverse)
library(here)
library(ggplot2)
library(scales)
library(ggthemes)
library(extrafont)

fonts()

# 1. Loading Cleaned and Processed Data
data <- read_csv(here("data", "cleaned", "bigmart_cleaned.csv"))

multi_analysis <- read_csv(here("data", "processed", "multi_analysis.csv"))
sales_by_category <- read_csv(here("data", "processed", "sales_by_category.csv"))
sales_by_fat <- read_csv(here("data", "processed", "sales_by_fat.csv"))
sales_by_location <- read_csv(here("data", "processed", "sales_by_location.csv"))
sales_by_outlet <- read_csv(here("data", "processed", "sales_by_outlet.csv"))

# -----------------------------------------
# 2. Distribution & Data Understanding
# -----------------------------------------

# Distribution of Sales (Refined)
data %>%
  ggplot(aes(x = item_outlet_sales)) +
  geom_histogram(fill = "#8A226AFF", bins = 50) + 
  labs(
    title = "Sales Distribution",
    subtitle = "Majority of Products cluster in lower sales range, with a few high-performing outliers",
    x = "Item Outlet Sales",
    y = "Number of Products",
  ) + 
  theme_fivethirtyeight() +
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(face = "bold", size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/sales_distribution.png", width = 8, height = 5)

# -------------------------------
# 3. Feature Relationships
# -------------------------------

# 1. Sales vs MRP
data %>%
  ggplot(aes(x = item_mrp, y = item_outlet_sales)) +
  geom_point(alpha = 0.5, color = "#F9C932FF") + 
  geom_smooth(method = "lm", color = "#8A226AFF") + 
  labs(
    title = "Sales vs MRP",
    subtitle = "Higher item price points indicate positive correlation with total outlet revenue",
    x = "Item MRP",
    y = "Outlet Sales"
  ) +
  theme_fivethirtyeight() +
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(face = "bold", size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/sales_vs_mrp.png", width = 8, height = 5)

# 2. Visibility vs Sales
data %>%
  ggplot(aes(x = item_visibility, y = item_outlet_sales)) +
  geom_point(alpha = 0.3, color = "#F98C0AFF") + 
  geom_smooth(method = "lm", color = "#BA3655FF") +
  labs(
    title = "Visibility vs Sales",
    subtitle = "High visibility items do not consistently outperform low visibility ones",
    x = "Visibility",
    y = "Outlet Sales"
  ) + 
  theme_fivethirtyeight() +
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(face = "bold", size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/visibility_vs_sales.png", width = 8, height = 5)

# 3. Outlet Age vs Outlet Sales
data %>%
  ggplot(aes(x = factor(outlet_age), y = item_outlet_sales)) +
  geom_boxplot(fill = "#C44E52FF", alpha = 0.9) +
  labs(
    title = "Outlet Age vs Outlet Sales",
    subtitle = "Sales variability remains similar across outlet ages",
    x = "Outlet Age",
    y = "Outlet Sales"
  ) +
  theme_fivethirtyeight() + 
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(face = "bold", size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/outlet_age_vs_outlet_sales2.png", width = 8, height = 5)

# -------------------------------
# 4. Business Insights
# -------------------------------

# 1. Sales by Outlet Type
sales_by_outlet %>%
  ggplot(aes(x = reorder(outlet_type, total_sales), y = total_sales)) + 
  geom_col(fill = "#F98C0AFF") + 
  scale_y_continuous(labels = scales::comma) + 
  labs(
    title = "Total Sales by Outlet Type",
    subtitle = "Supermarket Type 1 generates the most revenue, significantly outperforming other outlets",
    x = "Outlet Type",
    y = "Outlet Sales"
  ) + 
  theme_fivethirtyeight() + 
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/sales_by_outlet_type.png", width = 10, height = 7.5)

# 2. Sales by Location Tier
sales_by_location %>%
  ggplot(aes(x = outlet_location_type, y = total_sales)) + 
  geom_col(fill = "#57106EFF") + 
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Sales by Location Type",
    subtitle = "Tier 3 locations appears to generate highest sales, suggesting a strong market presence in suburban or rural zones",
    x = "Location Type",
    y = "Total Sales"
  ) + 
  theme_fivethirtyeight() + 
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(),
    plot.margin = margin(10, 30, 10, 10)
  )

ggsave("visualizations/total_sales_by_location_tier.png", width = 11, height = 8)

# 3. Sales by Category
sales_by_category %>%
  ggplot(aes(x = reorder(item_type, total_sales), y = total_sales)) + 
  geom_col(fill = "#BA3655FF") + 
  scale_y_continuous(labels = scales::comma) +
  coord_flip() +
  labs(
    title = "Sales by Category",
    subtitle = "Fruits & Vegetables and Snack Foods dominate total sales contribution",
    x = "Item Type",
    y = "Total Sales"
  ) + 
  theme_fivethirtyeight() + 
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text()
  )

ggsave("visualizations/sales_by_category.png", width = 8, height = 5)

# 4. Sales by Fat Content
sales_by_fat %>%
  ggplot(aes(x = item_fat_content, y = total_sales)) + 
  geom_col(fill = "#8A226AFF") + 
  scale_y_continuous(labels = scales::comma) + 
  coord_flip() + 
  labs(
    title = "Sales by Fat Content",
    subtitle = "Low-fat products account for a larger portion of total sales compared to regular-fat alternatives",
    x = "Fat",
    y = "Sales"
  ) + 
  theme_fivethirtyeight() + 
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size =14),
    axis.text = element_text()
  )

ggsave("visualizations/sales_by_fat_content.png", width = 10, height = 7.5)


# ============================================
# End of Script
# ============================================