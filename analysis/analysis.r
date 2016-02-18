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
stud_prior <- stud_data[,c("username", "prior_course")]

# Data frame with username, course_grade, jp_score, and prior_course
stud_jp_prior <- stud_data[,c("username", "course_grade", "jp_score", "prior_course")]

# Generate data frame of prior_courses and their frequency counts
prior_course_freqs <- count_(stud_data, "prior_course", sort = TRUE)  # Get a table of counts of each prior_course
prior_course_freqs <- as.data.frame(prior_course_freqs)  # Convert table to data frame
colnames(prior_course_freqs)[2] <- "frequency"  # Rename column "n" to "frequency"

# Generate data frame from stud_jp_prior with prior_course == "CS1101-none"
cs1101_prior <- stud_jp_prior[stud_jp_prior$prior_course == "CS1101-none",]

# Generate data frame of prior_course and frequency count containing "1102"
prior_1102_freqs <- prior_course_freqs[grep(pattern = "1102", prior_course_freqs$prior_course),]

# Generate data frame from stud_jp_prior with prior_course containing "1102"
cs1102_prior <- stud_jp_prior[grep(pattern = "1102", stud_jp_prior$prior_course),]

# Get data information
str(stud_prior)
str(stud_jp_prior)
str(prior_course_freqs)
str(cs1101_prior)
str(prior_1102_freqs)
str(cs1102_prior)

##################################################

