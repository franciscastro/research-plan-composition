#' ---
#' title: "CS19 Adding Machine Structure Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "14 April 2016"
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
file_name1 <- "coding-19-adding.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
coding_data1 <- read.csv(file_name1)

# Convert column types as needed
coding_data1$School <- as.factor(coding_data1$School)
coding_data1$Course <- as.factor(coding_data1$Course)
coding_data1$StudyID <- as.character(coding_data1$StudyID)
coding_data1$Lang <- as.factor(coding_data1$Lang)
coding_data1$Problem <- as.factor(coding_data1$Problem)
coding_data1$Subgroup <- as.factor(coding_data1$Subgroup)
coding_data1$SolutionID <- as.factor(coding_data1$SolutionID)
coding_data1$Bin <- as.factor(coding_data1$Bin)
coding_data1$Structure <- as.factor(coding_data1$Structure)
coding_data1$Helpers <- as.character(coding_data1$Helpers)
coding_data1$Notes <- as.character(coding_data1$Notes)

# Get data information
# str(coding_data1); summary(coding_data1)
# str(coding_data2); summary(coding_data2)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame with just the needed columns
clean_data1 <- coding_data1[, c("StudyID", "Subgroup", "Bin", "SolutionID", "Structure")]

# Create data frame with occurrence counts of structures for each bin
bin_struct_count1 <- data.frame(count(clean_data1, Bin, Structure))
setnames(bin_struct_count1, c("n"), c("Counts"))

# Create data frame with occurrence counts for each bin
bin_count <- data.frame(count(clean_data1, Bin))
setnames(bin_count, c("n"), c("Counts"))

# Replace 'SingleLoop' and 'NestedLoop' factors for uniformity
levels(bin_count$Bin)[levels(bin_count$Bin) == "SingleLoop"] <- "SingleTraversal"
levels(bin_count$Bin)[levels(bin_count$Bin) == "NestedLoop"] <- "NestedTraversal"


#==================================================
# GRAPHS
#==================================================

# ADDING MACHINE: CS19

# Compute midpoints of bars, for each subgroup in each structure; store in variable pos
bin_struct_midpoint1 <- group_by(bin_struct_count1, Bin) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph all subgroups, grouped by structure
g_bin_struct1 <- ggplot(data=bin_struct_midpoint1, aes(x=Bin, y=Counts))
g_bin_struct1 + geom_bar(aes(fill=Structure), stat = "identity") +
  ggtitle("CS19: Adding Machine Structures") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts, y = pos), color="white")

# Graph number of occurrence per bin
ggplot(data=bin_count, aes(x=Bin, y=Counts)) + 
  geom_bar(aes(fill=Bin), stat='identity') +
  coord_flip() + 
  theme(legend.position='none', 
        axis.ticks.x=element_blank(), 
        panel.grid.major = element_blank(), 
        axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"), 
        aspect.ratio=0.4) +
  geom_text(aes(label=Counts), hjust=1.5, color='white', fontface='bold', size=5) +
  scale_y_continuous(limits=c(0,10.5), expand=c(0,0), breaks = c(0,2,4,6,8,10)) + 
  labs(x='Plan\n', y='\nNumber of Students in each Plan Type')

