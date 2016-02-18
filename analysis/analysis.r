# Author: Francisco Castro (fgcastro@wpi.edu)
# Last modified: 17 February 2016

# Notes: Pre-load the following packages
# library(tidyr)
# library(dplyr)
# library(ggplot2)

# Set working directory for file manipulation
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()


# Set file names
file_name <- "wpi-id-key.csv"


# Read file
stud_data <- read.csv(file_name)


# Convert username from factor to character
stud_data$Username <- as.character(stud_data$Username)


# Get data information
str(stud_data)
summary(stud_data)

