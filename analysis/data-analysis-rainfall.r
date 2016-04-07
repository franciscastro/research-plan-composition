#' ---
#' title: "CS2102 Rainfall Structure Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "06 April 2016"
#' ---


#==================================================
# NOTES AND DEPENDENCIES
#==================================================

# This script is for plotting the code structure counts of students. 

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
setwd(working_dir)#; getwd()

# Set file names
file_name1 <- "coding-2102-rainfall.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
coding_data1 <- read.csv(file_name1)

# Convert column types as needed
coding_data1$School <- as.factor(coding_data1$School)
coding_data1$Course <- as.factor(coding_data1$Course)
coding_data1$StudyID <- as.character(coding_data1$StudyID)
coding_data1$Lang <- as.factor(coding_data1$Lang)
coding_data1$Problem <- as.factor(coding_data1$Problem)
coding_data1$Subgroup <- as.factor(coding_data1$Subgroup)
coding_data1$SolutionID <- as.factor(coding_data1$SolutionID)
coding_data1$Structure <- as.factor(coding_data1$Structure)
coding_data1$Helpers <- as.character(coding_data1$Helpers)
coding_data1$Notes <- as.character(coding_data1$Notes)

# Get data information
# str(coding_data1); summary(coding_data1)
# str(coding_data2); summary(coding_data2)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame with just the needed columns
clean_data1 <- coding_data1[, c("StudyID", "Subgroup", "SolutionID", "Structure")]

# Create data frame with occurrence counts of structures for each subgroup
subgroup_structs_count1 <- data.frame(count(clean_data1, Subgroup, Structure))
setnames(subgroup_structs_count1, c("n"), c("Counts"))


#==================================================
# GRAPHS
#==================================================

# RAINFALL: CS2102

# Graph all structures, grouped by subgroup
g_subgroup1 <- ggplot(data=subgroup_structs_count1, aes(x=Subgroup, y=Counts))
g_subgroup1 + geom_bar(aes(fill=Structure), stat = "identity") +
  ggtitle("CS2102: Rainfall Structures") +
  theme(legend.position = "bottom") +
  geom_text(aes(label=Counts), vjust=1.5, color="white") 
