# Load libraries
library(readr)
library(dplyr)
library(knitr)
library(kableExtra)

# Step 1: Load your CSV file
salinity_data <- read_csv("Raw Salinity Data.csv")

# Step 2: Clean column names for easier internal handling
salinity_data <- salinity_data %>%
  rename(
    Treatment = `Treatment`,
    Salinity_Start = `Salinity (Start)`,
    Salinity_End = `Salinity (End)`
  )

# Step 3: Display formatted table with original column names for output
salinity_data %>%
  rename(
    `Salinity (Start)` = Salinity_Start,
    `Salinity (End)` = Salinity_End
  ) %>%
  kbl(caption = "Start and End Salinity by Treatment",
      digits = 1,
      align = "lcc") %>%
  kable_styling(full_width = FALSE,
                bootstrap_options = c("striped", "hover", "condensed"))

