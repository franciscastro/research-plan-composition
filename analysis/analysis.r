##################################################
# Author: Francisco Castro (fgcastro@wpi.edu)
# Last modified: 17 February 2016

# Notes: Pre-load the following packages
# library(tidyr)
# library(dplyr)
# library(ggplot2)
##################################################


# GLOBALS SETUP
##################################################

# Set working directory for file manipulation
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names
file_name <- "wpi-id-key.csv"

##################################################


# DATA SETUP
##################################################

# Read file
stud_data <- read.csv(file_name)

# Rename dataframe column names
colnames(stud_data) <- c("username", "study_id", "course_grade", "jp_score", "prior_course")

# Convert username from factor to character
stud_data$username <- as.character(stud_data$username)

# Get data information
str(stud_data)
summary(stud_data)

##################################################


# EXTRACT RELATED DATA POINTS AND VARIABLES
##################################################

# Data frame with username and prior_course
stud_prior_course <- stud_data[,c("username", "prior_course")]

# Generate data frame of prior_course and its frequency count
prior_course_freqs <- count_(stud_data, "prior_course", sort = TRUE)
prior_course_freqs <- as.data.frame(prior_course_freqs)
colnames(prior_course_freqs)[2] <- "frequency"

# Data frame with username and prior_course

##################################################

