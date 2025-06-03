# Load required libraries
library(readr)
library(dplyr)
library(ggplot2)

# Step 1: Load your CSV file
# Make sure your working directory is set correctly; use getwd() if needed
Raw_Crab_Data <- read_csv("Data for Respiration Slope Bar Chart.csv")

# Step 2: Clean up column names (remove spaces and parentheses)
Raw_Crab_Data <- Raw_Crab_Data %>%
  rename(
    CrabID = `Crab ID`,
    Time_min = `Time`,
    RFU_wt = `RFU/weight (g)`
  )

# Step 3: Confirm your groups (especially 9 uncrowded crabs over 2 weeks)
table(Raw_Crab_Data$Treatment)

# Step 4: Calculate slope of RFU_wt vs Time for each crab within week & treatment
slopes <- Raw_Crab_Data %>%
  group_by(Treatment, CrabID, Week) %>%
  summarise(
    slope = coef(lm(RFU_wt ~ Time_min))[2],
    .groups = "drop"
  )

# Step 5: Calculate summary stats per treatment
summary_stats <- slopes %>%
  group_by(Treatment) %>%
  summarise(
    mean_slope = mean(slope),
    sd_slope = sd(slope),
    n = n()
  )

# Step 6: Plot
set.seed(42)  # Lock jitter positions so the dots don't move each time
ggplot() +
  geom_bar(data = summary_stats,
           aes(x = Treatment, y = mean_slope),
           stat = "identity",
           fill = "lightblue",
           alpha = 0.7) +
  geom_errorbar(data = summary_stats,
                aes(x = Treatment,
                    ymin = mean_slope - sd_slope,
                    ymax = mean_slope + sd_slope),
                width = 0.2) +
  geom_jitter(data = slopes,
              aes(x = Treatment, y = slope),
              width = 0.1,
              height = 0.1,
              color = "darkblue",
              size = 2.5) +
  labs(
    title = "Crab Respiration Rates by Treatment",
    y = "Respiration slope (RFU/g/min)"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))
