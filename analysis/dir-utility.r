#' ---
#' title: "Directory creation utility script"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "15 March 2016"
#' ---


# NOTES
#==================================================
#
# This script is used to create directories for each
# sub-sample generated in data-setup.r and data-sample.r
# 
# Run data-setup.r prior to running this script.
#
#==================================================


# Set directory paths for each sample group
#==================================================

dir_1101_A <- "C:/Git Repositories/files/sampled/1101-a"
dir_1101_B <- "C:/Git Repositories/files/sampled/1101-b"
dir_1101_C <- "C:/Git Repositories/files/sampled/1101-c"
dir_1102_A <- "C:/Git Repositories/files/sampled/1102-a"
dir_1102_B <- "C:/Git Repositories/files/sampled/1102-b"

#==================================================


# Read files (csv files have been pre-generated)
#==================================================

data_1101a <- read.csv("sample-cs1101-A.csv")
data_1101b <- read.csv("sample-cs1101-B.csv")
data_1101c <- read.csv("sample-cs1101-C.csv")
data_1102a <- read.csv("sample-cs1102-A.csv")
data_1102b <- read.csv("sample-cs1102-B.csv")

#==================================================


# Fetch directory names (usernames) from data frames
#==================================================

data_1101a <- data_1101a$username
data_1101b <- data_1101b$username
data_1101c <- data_1101c$username
data_1102a <- data_1102a$username
data_1102b <- data_1102b$username

#==================================================


# Create directories for each sample group
#==================================================

create_dirs <- function(maindir, subdir) {
  dir.create(file.path(maindir, subdir))
}

sapply(data_1101a, create_dirs, maindir = dir_1101_A)
sapply(data_1101b, create_dirs, maindir = dir_1101_B)
sapply(data_1101c, create_dirs, maindir = dir_1101_C)
sapply(data_1102a, create_dirs, maindir = dir_1102_A)
sapply(data_1102b, create_dirs, maindir = dir_1102_B)

#==================================================

