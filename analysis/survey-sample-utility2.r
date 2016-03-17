#' ---
#' title: "CS19 Survey sampling script"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "15 March 2016"
#' ---


# NOTES
#==================================================

# This utility script is for:
# 1. Splitting the full survey by programming problem
# 2. Extracting the sampled users from one of the split surveys

# Pre-load the following packages:
library(tidyr)
library(dplyr)

#==================================================


# GLOBALS SETUP
#==================================================

# Set working directory
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names and directories (UPDATE AS NEEDED)
survey_source <- "brown-cleaned-survey-pretest.csv"

# For posttest
# survey_split_filenames <- c("survey-bmi.csv",
#                             "survey-dsmooth.csv",
#                             "survey-fwords.csv",
#                             "survey-quake.csv")
# survey_split_dest_files <- file.path(working_dir, survey_split_filenames)

# For pretest
survey_split_filenames <- c("survey-rainfall.csv",
                            "survey-ltriples.csv",
                            "survey-shopdisc.csv")
survey_split_dest_files <- file.path(working_dir, survey_split_filenames)

#==================================================


# SPLIT FULL SURVEY FILE BY PROBLEM (POSTTEST)
#==================================================
# 
# # Read survey file
# survey_data <- read.csv(survey_source)
# str(survey_data)
# 
# # Rename dataframe column names
# colnames(survey_data) <- c("username", 
#                            "rank_bmi1", "rank_bmi2", "explain_bmi", "plan_bmi1", "plan_bmi2",
#                            "rank_dsmooth1", "rank_dsmooth2", "explain_dsmooth", "plan_dsmooth1", "plan_dsmooth2",
#                            "rank_fwords1", "rank_fwords2", "explain_fwords", "plan_fwords1", "plan_fwords2",
#                            "rank_quake1", "rank_quake2", "explain_quake", "plan_quake1", "plan_quake2")
# str(survey_data)
# 
# # Extract survey entries for BMI problem
# survey_bmi <- survey_data[,c("username", "rank_bmi1", "rank_bmi2", "explain_bmi", "plan_bmi1", "plan_bmi2")]
# str(survey_bmi)
# 
# # Extract survey entries for Data Smooth problem
# survey_dsmooth <- survey_data[,c("username", "rank_dsmooth1", "rank_dsmooth2", "explain_dsmooth", "plan_dsmooth1", "plan_dsmooth2")]
# str(survey_dsmooth)
# 
# # Extract survey entries for Most Frequent Words problem
# survey_fwords <- survey_data[,c("username", "rank_fwords1", "rank_fwords2", "explain_fwords", "plan_fwords1", "plan_fwords2")]
# str(survey_fwords)
# 
# # Extract survey entries for Earthquake problem
# survey_quake <- survey_data[,c("username", "rank_quake1", "rank_quake2", "explain_quake", "plan_quake1", "plan_quake2")]
# str(survey_quake)
# 
# # Write problem surveys to CSV files (UNCOMMENT TO REWRITE FILES)
# write.csv(survey_bmi, survey_split_dest_files[1], row.names = FALSE)
# write.csv(survey_dsmooth, survey_split_dest_files[2], row.names = FALSE)
# write.csv(survey_fwords, survey_split_dest_files[3], row.names = FALSE)
# write.csv(survey_quake, survey_split_dest_files[4], row.names = FALSE)

#==================================================


# EXTRACT STUDENT SAMPLE ENTRIES FROM EARTHQUAKE PROBLEM
#==================================================

# Read file for getting sample students
# coding_data <- read.csv(source_sample_names)

# Convert column types as needed
# coding_data$Course <- as.factor(coding_data$Course)
# coding_data$ID <- as.character(coding_data$ID)
# coding_data$SolutionID <- as.factor(coding_data$SolutionID)
# coding_data$Helpers <- as.character(coding_data$Helpers)
# coding_data$Notes <- as.character(coding_data$Notes)

# Get data information
# str(coding_data)

# Extract sampled users (Select only SolutionID == 1 to avoid duplicates)
# sampled_ids <- coding_data[coding_data$SolutionID == "1","ID"]

# Extract entries from survey
# sampled_survey <- survey_quake[survey_quake$username %in% sampled_ids,]

# Write to file
# write.csv(sampled_survey, file.path(survey_dest, "sampled-survey.csv"), row.names = FALSE)

#==================================================


# SPLIT FULL SURVEY FILE BY PROBLEM (PRETEST)
#==================================================

# Read survey file
survey_data <- read.csv(survey_source)
str(survey_data)

# Rename dataframe column names
colnames(survey_data) <- c("username", 
                           "rank_rainfall1", "rank_rainfall2", "rank_rainfall3", "explain_rainfall",
                           "rank_ltriples1", "rank_ltriples2", "rank_ltriples3", "explain_ltriples",
                           "rank_shopdisc1", "rank_shopdisc2", "explain_shopdisc")
str(survey_data)

# Extract survey entries for Rainfall problem
survey_rainfall <- survey_data[,c("username", "rank_rainfall1", "rank_rainfall2", "rank_rainfall3", "explain_rainfall")]
str(survey_rainfall)

# Extract survey entries for Length of Triples problem
survey_ltriples <- survey_data[,c("username", "rank_ltriples1", "rank_ltriples2", "rank_ltriples3", "explain_ltriples")]
str(survey_ltriples)

# Extract survey entries for Shopping Discount problem
survey_shopdisc <- survey_data[,c("username", "rank_shopdisc1", "rank_shopdisc2", "explain_shopdisc")]
str(survey_shopdisc)

# Write problem surveys to CSV files (UNCOMMENT TO REWRITE FILES)
write.csv(survey_rainfall, survey_split_dest_files[1], row.names = FALSE)
write.csv(survey_ltriples, survey_split_dest_files[2], row.names = FALSE)
write.csv(survey_shopdisc, survey_split_dest_files[3], row.names = FALSE)

#==================================================