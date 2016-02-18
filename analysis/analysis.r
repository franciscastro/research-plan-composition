#' ---
#' title: "CS2102 Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "18 February, 2016"
#' ---

##################################################
# Notes: Pre-load the following packages
library(tidyr)
library(dplyr)
library(ggplot2)
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
# str(stud_data)
# summary(stud_data)

##################################################


# EXTRACT RELATED DATA POINTS AND VARIABLES
##################################################

# Data frame with username, course_grade, jp_score, and prior_course
stud_jp_prior <- stud_data[,c("username", "course_grade", "jp_score", "prior_course")]
summary(stud_jp_prior)

# Generate data frame of prior_courses and their frequency counts
prior_course_freqs <- count_(stud_data, "prior_course", sort = TRUE)  # Get a table of counts of each prior_course
prior_course_freqs <- as.data.frame(prior_course_freqs)  # Convert table to data frame
colnames(prior_course_freqs)[2] <- "frequency"  # Rename column "n" to "frequency"
summary(prior_course_freqs)

# Generate data frame from stud_jp_prior with prior_course == "CS1101-none"
cs1101_prior <- stud_jp_prior[stud_jp_prior$prior_course == "CS1101-none",]
summary(cs1101_prior)

# Generate data frame of prior_course and frequency count containing "1102"
prior_1102_freqs <- prior_course_freqs[grep(pattern = "1102", prior_course_freqs$prior_course),]
summary(prior_1102_freqs)

# Generate data frame from stud_jp_prior with prior_course containing "1102"
cs1102_prior <- stud_jp_prior[grep(pattern = "1102", stud_jp_prior$prior_course),]
summary(cs1102_prior)

# Generate data frame from cs1101_prior with course_grade == "A", "B", "C"
cs1101_prior_A <- cs1101_prior[cs1101_prior$course_grade == "A",]
cs1101_prior_B <- cs1101_prior[cs1101_prior$course_grade == "B",]
cs1101_prior_C <- cs1101_prior[cs1101_prior$course_grade == "C",]
summary(cs1101_prior_A)
summary(cs1101_prior_B)
summary(cs1101_prior_C)

# Generate data frame from cs1102_prior with course_grade == "A", "B"
cs1102_prior_A <- cs1102_prior[cs1102_prior$course_grade == "A",]
cs1102_prior_B <- cs1102_prior[cs1102_prior$course_grade == "B",]
summary(cs1102_prior_A)
summary(cs1102_prior_B)

##################################################


# RANDOM SAMPLING FROM DATA FRAMES
##################################################

# Sample 10 students (with 1101 prior) from each grade
# sample_cs1101_A <- sample_n(cs1101_prior_A, 10)
# sample_cs1101_B <- sample_n(cs1101_prior_B, 10)
# sample_cs1101_C <- sample_n(cs1101_prior_C, 10)

# Store sampled students to CSV files
# write.csv(sample_cs1101_A, "sample-cs1101-A.csv", row.names = FALSE)
# write.csv(sample_cs1101_B, "sample-cs1101-B.csv", row.names = FALSE)
# write.csv(sample_cs1101_C, "sample-cs1101-C.csv", row.names = FALSE)

# Sample 10 students (with 1102 prior) from each grade
# sample_cs1102_A <- sample_n(cs1102_prior_A, 10)
# sample_cs1102_B <- sample_n(cs1102_prior_B, 10)

# Store sampled students to CSV files
# write.csv(sample_cs1102_A, "sample-cs1102-A.csv", row.names = FALSE)
# write.csv(sample_cs1102_B, "sample-cs1102-B.csv", row.names = FALSE)

##################################################