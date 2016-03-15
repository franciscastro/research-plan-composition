#' ---
#' title: "Survey sampling script"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "14 March 2016"
#' ---


# NOTES
#==================================================

# Pre-load the following packages:
library(tidyr)
library(dplyr)

#==================================================


# GLOBALS SETUP
#==================================================

# Set working directory for file manipulation
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names and directories
file_name <- "clean-survey.csv"
sampled_name <- "combined.csv"

survey_dest <- "C:/Git Repositories/files/data-coding/split-surveys"
survey_filenames <- c("survey_bmi.csv",
                      "survey_dsmooth.csv",
                      "survey_fwords.csv",
                      "survey_quake.csv")
survey_dest_files <- file.path(survey_dest, survey_filenames)

#==================================================


# GET STUDENTS FROM SURVEY FILE FOR EACH PROBLEM
#==================================================

# Read file
survey_data <- read.csv(file_name)
str(survey_data)

# Rename dataframe column names
colnames(survey_data) <- c("username", 
                           "problem_bmi", "rank_bmi1", "rank_bmi2", "explain_bmi", "plan_bmi1", "plan_bmi2", "help_bmi",
                           "problem_dsmooth", "rank_dsmooth1", "rank_dsmooth2", "explain_dsmooth", "plan_dsmooth1", "plan_dsmooth2", "help_dsmooth",
                           "problem_fwords", "rank_fwords1", "rank_fwords2", "explain_fwords", "plan_fwords1", "plan_fwords2", "help_fwords",
                           "problem_quake", "rank_quake1", "rank_quake2", "explain_quake", "plan_quake1", "plan_quake2", "help_quake")
str(survey_data)

# Entries for BMI problem
survey_bmi <- survey_data[,c("username", "problem_bmi", "rank_bmi1", "rank_bmi2", "explain_bmi", "plan_bmi1", "plan_bmi2", "help_bmi")]
str(survey_bmi)

# Entries for Data Smooth problem
survey_dsmooth <- survey_data[,c("username", "problem_dsmooth", "rank_dsmooth1", "rank_dsmooth2", "explain_dsmooth", "plan_dsmooth1", "plan_dsmooth2", "help_dsmooth")]
str(survey_dsmooth)

# Entries for Most Frequent Words problem
survey_fwords <- survey_data[,c("username", "problem_fwords", "rank_fwords1", "rank_fwords2", "explain_fwords", "plan_fwords1", "plan_fwords2", "help_fwords")]
str(survey_fwords)

# Entries for Earthquake problem
survey_quake <- survey_data[,c("username", "problem_quake", "rank_quake1", "rank_quake2", "explain_quake", "plan_quake1", "plan_quake2", "help_quake")]
str(survey_quake)

# Write sampled students to CSV files (UNCOMMENT TO REWRITE FILES)
# write.csv(survey_bmi, survey_dest_files[1], row.names = FALSE)
# write.csv(survey_dsmooth, survey_dest_files[2], row.names = FALSE)
# write.csv(survey_fwords, survey_dest_files[3], row.names = FALSE)
# write.csv(survey_quake, survey_dest_files[4], row.names = FALSE)

#==================================================


# EXTRACT STUDENT ENTRIES FROM EARTHQUAKE PROBLEM
#==================================================

# Read file
coding_data <- read.csv(sampled_name)

# Convert columns from factor to character
coding_data$Course <- as.factor(coding_data$Course)
coding_data$ID <- as.character(coding_data$ID)
coding_data$SolutionID <- as.factor(coding_data$SolutionID)
coding_data$Helpers <- as.character(coding_data$Helpers)
coding_data$Notes <- as.character(coding_data$Notes)

# Get data information
str(coding_data)

# Extract sampled users
sampled_ids <- coding_data[coding_data$SolutionID == "1","ID"]

# Extract entries from survey
sampled_survey <- survey_quake[survey_quake$username %in% sampled_ids,]

# Write to file
# write.csv(sampled_survey, file.path(survey_dest, "sampled-survey.csv"), row.names = FALSE)

#==================================================