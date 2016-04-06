#' ---
#' title: "CS2102 Structure Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "05 April 2016"
#' ---


#==================================================
# NOTES AND DEPENDENCIES
#==================================================

# This script is for plotting the code structure counts of students. 

# Pre-load the following packages:
library(tidyr)
library(dplyr)
library(ggplot2)
library(data.table)
library(gridExtra)


#==================================================
# GLOBALS SETUP
#==================================================

# Set working directory
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)#; getwd()

# Set file names
file_name <- "data.csv"


#==================================================
# MASTER DATA SETUP
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
# str(coding_data); summary(coding_data)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame for SolutionID = 1
data_id_1 <- coding_data[coding_data$SolutionID == "1", 
                         c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]

# Create data frame for SolutionID = 2
data_id_2 <- coding_data[coding_data$SolutionID == "2", 
                         c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]

# Create data frame for plotting over all solutions created
all_solns <- coding_data[,c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]

# Create data frame that counts occurrences of structures for each bin
all_solns_count <- data.frame(count(all_solns, Bin, Structure))
setnames(all_solns_count, c("n"), c("Counts"))

# Create data frame containing Bins and Structures for each solution for each student
bin_structs <- data_id_1[,c("StudyID", "Subgroup", "Bin", "Structure")]
setnames(bin_structs, c("Bin", "Structure"), c("Bin1", "Structure1"))
bin_structs$Bin2 <- data_id_2[bin_structs$StudyID == data_id_2$StudyID, c("Bin")]
bin_structs$Structure2 <- data_id_2[bin_structs$StudyID == data_id_2$StudyID, c("Structure")]

# Create data frame containing students who has same Bin1 and Bin2
same_bins <- bin_structs[bin_structs$Bin1 == bin_structs$Bin2,]

# Create data frame that counts occurrences of structures for each bin
same_bins_count <- data.frame(count(same_bins, Bin1))
setnames(same_bins_count, c("n"), c("Counts"))

# Create data frame containing students who has different Bin1 and Bin2
diff_bins <- bin_structs[bin_structs$Bin1 != bin_structs$Bin2,]

# Create data frame with at least one of the solutions as SingleTraverse
diff_bins_singletrav <- diff_bins[diff_bins$Bin1 == "SingleTraverse" | 
                                    diff_bins$Bin2 == "SingleTraverse",]

# Swap the values so that all SingleTraverse-s are under Bin1, switch corresponding Structure-s
diff_bins_singletrav[diff_bins_singletrav$Bin2 == "SingleTraverse", 
                     c("Bin1","Structure1","Bin2","Structure2")] <- 
  diff_bins_singletrav[diff_bins_singletrav$Bin2 == "SingleTraverse", 
                       c("Bin2","Structure2","Bin1","Structure1")]

# Create data frame that counts occurrences of bins for SingleTrav
diff_bins_singletrav_count <- data.frame(count(diff_bins_singletrav, Bin2))
setnames(diff_bins_singletrav_count, c("n"), c("Counts"))

# Create data frame with all other solutions that didn't use SingleTraverse
diff_bins_other <- diff_bins[diff_bins$Bin1 != "SingleTraverse" & 
                               diff_bins$Bin2 != "SingleTraverse",]


#==================================================
# GRAPHS
#==================================================

# COUNT ALL STRUCTURE OCCURRENCES PER BIN OVER ALL SOLUTIONS
# Note: Stacked bar visualization for each code structure bin

# Compute midpoints of bars, for each structure in each bin; store in variable pos
all_solns_midpoint <- group_by(all_solns_count, Bin) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph all structures, grouped by bin
g_all_solns <- ggplot(data = all_solns_midpoint,
                      aes(x = Bin, y = Counts))

g_all_solns + geom_bar(aes(fill = Structure), stat = "identity") + 
  coord_flip() +
  ggtitle("All solutions") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts, y = pos), color = "white") 

#=====

# COUNT STUDENTS WITH SAME BINS FOR BOTH SOLUTIONS

same_bins_midpoint <- group_by(same_bins_count, Bin1) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph number of students who has same bin in both solutions
g_same_bins <- ggplot(data = same_bins_midpoint,
                      aes(x = Bin1, y = Counts))

g_same_bins + geom_bar(aes(fill = Bin1), stat = "identity") + 
  ggtitle("Students with same bins for solutions 1, 2") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts, y = pos), color = "white")

#=====

# COUNT STUDENTS WITH DIFFERENT BINS, BUT ONE IN SINGLETRAVERSE BIN

diff_bins_singletrav_midpoint <- group_by(diff_bins_singletrav_count, Bin2) %>% 
  mutate(pos = cumsum(Counts) - (0.5 * Counts))

g_diff_bins_singletrav <- ggplot(data = diff_bins_singletrav_midpoint, 
                                 aes(x = Bin2, y = Counts))

g_diff_bins_singletrav + geom_bar(aes(fill = Bin2), stat = "identity") + 
  ggtitle("Students with SingleTraverse as one of the solutions") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts, y = pos), color = "white")

#=====

# COUNT STUDENTS WHO DID NOT DO SINGLETRAVERSE

g_diff_bins_other <- tableGrob(diff_bins_other)
grid.arrange(g_diff_bins_other)

#==================================================

