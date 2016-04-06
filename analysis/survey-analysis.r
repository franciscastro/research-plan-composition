#' ---
#' title: "CS[2102/19] Preference Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "05 April 2016"
#' ---


#==================================================
# NOTES AND DEPENDENCIES
#==================================================

# This script is for plotting the survey responses of students. 

# Pre-load the following packages:
library(tidyr)
library(dplyr)
library(ggplot2)
library(data.table)
library(gridExtra)


#==================================================
# GLOBALS SETUP
#==================================================

# Set working directory
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names
file_name1 <- "preference-ranking-cs19.csv"
file_name2 <- "preference-ranking-cs2102.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
pref_data1 <- read.csv(file_name1)
pref_data2 <- read.csv(file_name2)

# Convert column types as needed
pref_data1$id <- as.character(pref_data1$id)
pref_data1$study_id <- as.character(pref_data1$study_id)
pref_data1$efficiency <- as.factor(pref_data1$efficiency)
pref_data1$structure <- as.factor(pref_data1$structure)
pref_data1$aesthetics <- as.factor(pref_data1$aesthetics)
pref_data1$affective <- as.factor(pref_data1$affective)
pref_data1$purple <- as.factor(pref_data1$purple)
pref_data1$maintainability <- as.factor(pref_data1$maintainability)
pref_data1$pink <- as.factor(pref_data1$pink)

pref_data2$id <- as.character(pref_data2$id)
pref_data2$study_id <- as.character(pref_data2$study_id)
pref_data2$efficiency <- as.factor(pref_data2$efficiency)
pref_data2$structure <- as.factor(pref_data2$structure)
pref_data2$aesthetics <- as.factor(pref_data2$aesthetics)
pref_data2$affective <- as.factor(pref_data2$affective)
pref_data2$purple <- as.factor(pref_data2$purple)
pref_data2$maintainability <- as.factor(pref_data2$maintainability)
pref_data2$pink <- as.factor(pref_data2$pink)

# Get data information
# str(pref_data1) ; summary(pref_data1)
# str(pref_data2) ; summary(pref_data2)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# RAINFALL: CS19

# Create data frame for problem = rainfall
rainfall <- pref_data1[pref_data1$problem == "rainfall",]

# Create data frame with occurrence counts of each metric
rainfall_count <- setDT(data.frame(colSums(rainfall == 1, na.rm = TRUE)), keep.rownames = TRUE)[]
setnames(rainfall_count, colnames(rainfall_count), c("metric", "count"))
rainfall_count <- rainfall_count[5:11,]


# SHOPPING DISCOUNT: CS19

# Create data frame for problem = shopdisc
shopdisc <- pref_data1[pref_data1$problem == "shopdisc",]

# Create data frame with occurrence counts of each metric
shopdisc_count <- setDT(data.frame(colSums(shopdisc == 1, na.rm = TRUE)), keep.rownames = TRUE)[]
setnames(shopdisc_count, colnames(shopdisc_count), c("metric", "count"))
shopdisc_count <- shopdisc_count[5:11,]


# EARTHQUAKE: CS19

# Create data frame for problem = earthquake
earthquake1 <- pref_data1[pref_data1$problem == "earthquake",]

# Create data frame with occurrence counts of each metric
earthquake_count1 <- setDT(data.frame(colSums(earthquake1 == 1, na.rm = TRUE)), keep.rownames = TRUE)[]
setnames(earthquake_count1, colnames(earthquake_count1), c("metric", "count"))
earthquake_count1 <- earthquake_count1[5:11,]


# EARTHQUAKE: CS2102

# Create data frame for problem = earthquake
earthquake2 <- pref_data2[pref_data2$problem == "earthquake",]

# Create data frame with occurrence counts of each metric
earthquake_count2 <- setDT(data.frame(colSums(earthquake2 == 1, na.rm = TRUE)), keep.rownames = TRUE)[]
setnames(earthquake_count2, colnames(earthquake_count2), c("metric", "count"))
earthquake_count2 <- earthquake_count2[5:11,]


#==================================================
# GRAPHS: COUNT NUMBER OF STUDENTS FOR EACH METRIC
#==================================================

# RAINFALL: CS19

# Graph number of students for each metric
g_rainfall <- ggplot(data = rainfall_count, aes(x = metric, y = count))
g_rainfall + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("Rainfall: Metric Counts") +
  theme(legend.position = "right",
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


# SHOPPING DISCOUNT: CS19

# Graph number of students for each metric
g_shopdisc <- ggplot(data = shopdisc_count, aes(x = metric, y = count))
g_shopdisc + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("Shopping Discount: Metric Counts") +
  theme(legend.position = "right",
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


# EARTHQUAKE: CS19

# Graph number of students for each metric
g_earthquake1 <- ggplot(data = earthquake_count1, aes(x = metric, y = count))
g_earthquake1 + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("Earthquake1: Metric Counts") +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) + 
  scale_y_continuous(limits = c(0,75))


# EARTHQUAKE: CS2102

# Graph number of students for each metric
g_earthquake2 <- ggplot(data = earthquake_count2, aes(x = metric, y = count))
g_earthquake2 + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("Earthquake2: Metric Counts") +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) + 
  scale_y_continuous(limits = c(0,75))

