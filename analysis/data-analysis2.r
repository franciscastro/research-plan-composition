#' ---
#' title: "CS2102 Structure Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "26 March 2016"
#' ---


# NOTES
#==================================================

# This script is for plotting the code structure counts of each user. 
# This uses a stacked bar visualization for each code structure bin.

# Pre-load the following packages:
library(tidyr)
library(dplyr)
library(ggplot2)

#==================================================


# GLOBALS SETUP
#==================================================

# Set working directory
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)
getwd()

# Set file names
file_name <- "data.csv"

#==================================================


# DATA SETUP
#==================================================

# Read file
coding_data <- read.csv(file_name)

# Convert column types as needed
coding_data$StudyID <- as.character(coding_data$StudyID)
coding_data$Subgroup <- as.factor(coding_data$Subgroup)
coding_data$SolutionID <- as.factor(coding_data$SolutionID)
coding_data$Bin <- as.factor(coding_data$Bin)
coding_data$Structure <- as.factor(coding_data$Structure)
coding_data$Helpers <- as.character(coding_data$Helpers)
coding_data$Builtins <- as.character(coding_data$Builtins)
coding_data$Notes <- as.character(coding_data$Notes)

# Get data information
# str(coding_data)
# summary(coding_data)

#==================================================


# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame with SolutionID = 1,
# Exclude columns: Lang, Problem, Helpers, Builtins, Notes
data_id_1 <- coding_data[coding_data$SolutionID == "1", 
                         c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]
# str(data_id_1)
# summary(data_id_1)

# Create data frame with SolutionID = 2,
# Exclude columns: Lang, Problem, Helpers, Builtins, Notes
data_id_2 <- coding_data[coding_data$SolutionID == "2", 
                         c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]
# str(data_id_2)
# summary(data_id_2)

# Create data frame for plotting over all solutions created
# Exclude columns: Lang, Problem, Helpers, Builtins, Notes
all_solns <- coding_data[,c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]

# Create data frame that counts occurrences of structures for each bin
all_solns_count <- count(all_solns, Bin, Structure)
all_solns_count <- data.frame(all_solns_count)

#==================================================


# PLOT STRUCTURE COUNTS
#==================================================

# For data_id_1
# count(data_id_1, Bin, sort = TRUE)
# 
# g1 <- ggplot(data = data_id_1,
#              aes(x = Bin,
#                  fill = Structure))
# 
# g1 + geom_bar() +
#   coord_flip() +
#   ggtitle("Counts: Solution 1") +
#   theme(legend.position = "bottom")


# Counts per bin over all solutions
# count(all_solns, Bin, sort = TRUE)
# 
# g2 <- ggplot(data = all_solns,
#              aes(x = Bin,
#                  fill = Structure))
# 
# g2 + geom_bar() +
#   coord_flip() +
#   ggtitle("All solutions") +
#   theme(legend.position = "none")

# a <- ddply(all_solns_count, "Bin", mutate, label_y = cumsum(n) - 0.5 * n)

a <- group_by(all_solns_count, Bin) %>% mutate(pos = cumsum(n) - (0.5 * n))
print(a)

g3 <- ggplot(data = a,
             aes(x = Bin, y = n))

g3 + geom_bar(aes(fill = Structure), stat = "identity") +
  coord_flip() +
  ggtitle("All solutions") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = n, y = pos), color = "white")  
  



#==================================================

