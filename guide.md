# R Beginner Project: Exploring the Palmer Penguins Dataset

## Project Goal

Practice the complete data analysis workflow in R:

1. Load data
2. Explore data
3. Clean data
4. Answer questions
5. Create visualizations
6. Summarize findings

---

# Setup

## Install Required Packages

```r
install.packages("tidyverse")
install.packages("palmerpenguins")
```

## Load Packages

```r
library(tidyverse)
library(palmerpenguins)
```

## Load the Dataset

```r
penguins
```

Explore the dataset:

```r
head(penguins)
str(penguins)
summary(penguins)
```

---

# Research Questions

Imagine you are a researcher studying penguin populations.

Your task is to answer the following questions.

---

## Question 1: Which Species Is the Heaviest?

Calculate the average body mass for each species.

### Skills Practiced

* `group_by()`
* `summarise()`
* `mean()`

### Example Starting Point

```r
penguins %>%
  group_by(species) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE))
```

---

## Question 2: Do Males Weigh More Than Females?

Calculate average body mass by sex.

### Things to Consider

* Handle missing values.
* Compare average weights between groups.

### Example Starting Point

```r
penguins %>%
  group_by(sex) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE))
```

---

## Question 3: Which Island Has the Largest Penguins?

Calculate average body mass by island.

### Example Starting Point

```r
penguins %>%
  group_by(island) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = TRUE))
```

---

# Data Quality Investigation

## Check for Missing Values

Determine how many missing values exist in the dataset.

```r
sum(is.na(penguins))
```

## Find Missing Values by Column

```r
colSums(is.na(penguins))
```

### Questions

* Which columns contain missing values?
* How might missing values affect your analysis?

---

# Visualizations

Create the following plots using `ggplot2`.

---

## Plot 1: Bar Chart

Average body mass by species.

### Goal

Compare species averages visually.

---

## Plot 2: Box Plot

Body mass distribution by species.

### Goal

Understand variation and identify outliers.

---

## Plot 3: Scatter Plot

Bill length versus body mass.

Color points by species.

### Goal

Investigate whether larger bills are associated with heavier penguins.

---

# Stretch Goals

Complete these after finishing the main analysis.

---

## Stretch Goal 1: Find the Largest Penguin

Locate the penguin with the greatest body mass.

```r
which.max(penguins$body_mass_g)
```

Display the entire row containing that penguin.

---

## Stretch Goal 2: Create a New Variable

Convert body mass from grams to kilograms.

```r
penguins$body_mass_kg <- penguins$body_mass_g / 1000
```

Repeat some analyses using kilograms.

---

## Stretch Goal 3: Save a Plot

Export one of your visualizations.

```r
ggsave("penguin_plot.png")
```

Verify the file is saved in your working directory.

---

# Final Report

Create a short written summary of your findings.

Example structure:

```text
Penguin Analysis

Dataset contains X penguins.

The heaviest species was ______.

Male/Female penguins were heavier on average.

The island with the heaviest penguins was ______.

A scatterplot suggested that ______.
```

---

# Success Criteria

By the end of this project, you should be comfortable with:

* Loading datasets
* Exploring data structures
* Handling missing values
* Filtering and grouping data
* Calculating summary statistics
* Creating visualizations with ggplot2
* Writing a short analytical report

---

# Optional Next Steps

After completing this project:

1. Try a messier real-world dataset.
2. Learn data cleaning with `dplyr`.
3. Explore datasets from Kaggle.
4. Try a weekly data challenge from TidyTuesday.
5. Build a small dashboard using Shiny.
