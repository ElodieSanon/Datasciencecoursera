## Purpose
This project demonstrates the ability to collect, work with,
and clean a dataset from wearable computing accelerometers
(Samsung Galaxy S smartphone).

## Repository Contents

| File | Description |
|-----------------|--------------------------------------------------|
| run_analysis.R | Main R script performing all 5 analysis steps |
| tidy_data.txt | Final tidy dataset (180 rows x 68 columns) |
| CodeBook.md | Description of variables and transformations |
| README.md | This file |

## How to Run

1. Install dplyr package:
install.packages("dplyr")

2. Run the script:
source("run_analysis.R")

The script automatically downloads the data.
It produces tidy_data.txt in the working directory.

## Script Steps

Step 1 - Merges train and test datasets (10,299 observations)
Step 2 - Extracts mean() and std() columns (66 variables)
Step 3 - Replaces activity codes with descriptive names
Step 4 - Labels variables with descriptive names
Step 5 - Creates tidy dataset with average per subject and activity
Result: 180 rows x 68 columns

## How to Read the Final Dataset

data <- read.table("tidy_data.txt", header = TRUE)
View(data)
