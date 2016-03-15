#' ---
#' title: "Setup for CS2102 Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "15 March 2016"
#' ---


# NOTES
#==================================================

# This script is used to extract users for study that meet
# the criteria for sampling.

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
file_name <- "wpi-id-key.csv"

#==================================================


# DATA SETUP
#==================================================

# Read file
stud_data <- read.csv(file_name)

# Rename dataframe column names
colnames(stud_data) <- c("username", "study_id", "course_grade", "jp_score", "prior_course")

# Convert username from factor to character
stud_data$username <- as.character(stud_data$username)

# Get data information
# str(stud_data)
# summary(stud_data)

#==================================================


# EXTRACT RELATED DATA POINTS AND VARIABLES
#==================================================

# Create data frame with username, course_grade, jp_score, and prior_course
stud_jp_prior <- stud_data[,c("username", "course_grade", "jp_score", "prior_course")]
summary(stud_jp_prior)

# Create data frame of prior_courses and their frequency counts
prior_course_freqs <- count_(stud_data, "prior_course", sort = TRUE)  # Get a table of counts of each prior_course
prior_course_freqs <- as.data.frame(prior_course_freqs)  # Convert table to data frame
colnames(prior_course_freqs)[2] <- "frequency"  # Rename column "n" to "frequency"
summary(prior_course_freqs)

# Create data frame from stud_jp_prior with prior_course == "CS1101-none"
cs1101_prior <- stud_jp_prior[stud_jp_prior$prior_course == "CS1101-none",]
summary(cs1101_prior)

# Create data frame of prior_course and frequency count containing "1102"
prior_1102_freqs <- prior_course_freqs[grep(pattern = "1102", prior_course_freqs$prior_course),]
summary(prior_1102_freqs)

# Create data frame from stud_jp_prior with prior_course containing "1102"
cs1102_prior <- stud_jp_prior[grep(pattern = "1102", stud_jp_prior$prior_course),]
summary(cs1102_prior)

# Create data frame from cs1101_prior with course_grade == "A", "B", "C"
cs1101_prior_A <- cs1101_prior[cs1101_prior$course_grade == "A",]
cs1101_prior_B <- cs1101_prior[cs1101_prior$course_grade == "B",]
cs1101_prior_C <- cs1101_prior[cs1101_prior$course_grade == "C",]
summary(cs1101_prior_A)
summary(cs1101_prior_B)
summary(cs1101_prior_C)

# Create data frame from cs1102_prior with course_grade == "A", "B"
cs1102_prior_A <- cs1102_prior[cs1102_prior$course_grade == "A",]
cs1102_prior_B <- cs1102_prior[cs1102_prior$course_grade == "B",]
summary(cs1102_prior_A)
summary(cs1102_prior_B)

#==================================================

