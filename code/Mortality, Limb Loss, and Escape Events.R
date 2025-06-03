# Load required libraries
library(readr)
library(dplyr)
library(knitr)
library(kableExtra)

# Step 1: Read your CSV file
event_data <- read_csv("Mortality, Limb Loss, and Escape Events.csv")  # update if your filename differs

# Step 2: Create a clean formatted table
event_data %>%
  kbl(
    caption = "Summary of Mortality, Limb Loss, and Escape Events by Treatment",
    align = "lccc",
    digits = 0
  ) %>%
  kable_styling(
    full_width = FALSE,
    bootstrap_options = c("striped", "hover", "condensed")
  )
