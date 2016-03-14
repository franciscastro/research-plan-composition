#' ---
#' title: "Setup for CS2102 Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "14 March 2016"
#' ---


# NOTES
#==================================================

# Pre-load the following packages:
library(tidyr)
library(dplyr)
library(ggplot2)

#==================================================


# GLOBALS SETUP
#==================================================

# Set working directory for file manipulation
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names
file_name <- "combined.csv"

#==================================================


# DATA SETUP
#==================================================

# Read file
coding_data <- read.csv(file_name)

# Convert columns from factor to character
coding_data$Course <- as.factor(coding_data$Course)
coding_data$ID <- as.character(coding_data$ID)
coding_data$SolutionID <- as.factor(coding_data$SolutionID)
coding_data$Helpers <- as.character(coding_data$Helpers)
coding_data$Notes <- as.character(coding_data$Notes)

# Get data information
str(coding_data)
# summary(coding_data)

#==================================================


# EXTRACT RELATED DATA POINTS AND VARIABLES
#==================================================

# Data frame with SolutionID = 1, excluding columns: School, Course, Lang, Problem, Helpers, Notes
data_id_1 <- coding_data[coding_data$SolutionID == "1",
                         c("ID", "Subgroup", "SolutionID", "Structure")]
str(data_id_1)
summary(data_id_1)

# Data frame with SolutionID = 2, excluding columns: School, Course, Lang, Problem, Helpers, Notes
data_id_2 <- coding_data[coding_data$SolutionID == "2",
                         c("ID", "Subgroup", "SolutionID", "Structure")]
str(data_id_2)
summary(data_id_2)

#==================================================


# PLOT STRUCTURE COUNTS
#==================================================

# For data_id_1
count(data_id_1, Structure, sort = TRUE)

g1 <- ggplot(data = data_id_1, 
            aes(x = Structure,
                fill = Structure))

g1 + geom_bar(position = "dodge") +
  coord_flip() + 
  ggtitle("Counts: Solution 1") +
  theme(legend.position = "none")

# For data_id_2
count(data_id_2, Structure, sort = TRUE)

g2 <- ggplot(data = data_id_2, 
             aes(x = Structure,
                 fill = Structure))

g2 + geom_bar(position = "dodge") +
  coord_flip() + 
  ggtitle("Counts: Solution 2") +
  theme(legend.position = "none")

#==================================================

