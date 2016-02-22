#' ---
#' title: "Report extraction"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "22 February 2016"
#' ---

# NOTES
#==================================================
#
# This utility script is for extracting the reports
# needed based on the sampled populations.
#
#==================================================


# Set directory paths and file names
#==================================================

samples_source <- "C:/Git Repositories/files/updated-samples"
samples_files <- c("sample-cs1101-A.csv", 
                   "sample-cs1101-B.csv", 
                   "sample-cs1101-C.csv", 
                   "sample-cs1102-A.csv", 
                   "sample-cs1102-B.csv")

report_dest <- "C:/Git Repositories/files/sampled-reports"
report_source <- "C:/Git Repositories/files/reports"
report_dest_dirs <- c("cs1101-a-report", 
                      "cs1101-b-report", 
                      "cs1101-c-report", 
                      "cs1102-a-report", 
                      "cs1102-b-report")
report_dest_dirs <- file.path(report_dest, report_dest_dirs)

#==================================================


# Read files (csv files have been pre-generated)
#==================================================

# Read CSVs
cs1101a <- read.csv(file.path(samples_source,samples_files[1]))
cs1101b <- read.csv(file.path(samples_source,samples_files[2]))
cs1101c <- read.csv(file.path(samples_source,samples_files[3]))
cs1102a <- read.csv(file.path(samples_source,samples_files[4]))
cs1102b <- read.csv(file.path(samples_source,samples_files[5]))

# Convert username from factor to character
cs1101a$username <- as.character(cs1101a$username)
cs1101b$username <- as.character(cs1101b$username)
cs1101c$username <- as.character(cs1101c$username)
cs1102a$username <- as.character(cs1102a$username)
cs1102b$username <- as.character(cs1102b$username)

#==================================================


# Extract and generate file names (usernames)
#==================================================

# List of vectors; each vector contains usernames
# Usernames will be used to compare which report to copy
file_names <- list(cs1101a$username,
                   cs1101b$username,
                   cs1101c$username,
                   cs1102a$username,
                   cs1102b$username)

# Append ".txt" to each username to generate file names
for (i in 1:length(file_names)) {
  file_names[[i]] <- paste0(file_names[[i]],".txt")
} 
rm(i) # Clean-up unneeded variable
print(file_names)

#==================================================


# Find and copy reports
#==================================================

# Go through each vector of file names
for (i in 1:length(file_names)) {
  
  # Create directory for files
  dir.create(report_dest_dirs[i], showWarnings = TRUE)
  
  # Copy existing files to destination directory
  file.copy(# Generate a vector of full path names to existing files
            file.path(report_source,
                      # Extract a vector of files that exist
                      file_names[[i]][file.exists(file.path(report_source,file_names[[i]]))]),
            report_dest_dirs[i])
  
  # Print copied files
  print(list.files(report_dest_dirs[i]))
  
}
rm(i) # Clean-up unneeded variable

#==================================================

