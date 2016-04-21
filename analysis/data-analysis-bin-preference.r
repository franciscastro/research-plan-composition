#' ---
#' title: "Bin Preference Analysis"
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
file_name1 <- "brown-structs-rank.csv"
adding_file <- "coding-19-adding.csv"

# file_name1 <- "wpi-structs-rank.csv"
# rfall_file <- "coding-2102-rainfall.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file: 2102/19 Earthquake/DataSmooth
coding_data1 <- read.csv(file_name1)

# Convert column types as needed
coding_data1$StudyID <- as.character(coding_data1$StudyID)
coding_data1$Subgroup <- as.factor(coding_data1$Subgroup)
coding_data1$Problem <- as.factor(coding_data1$Problem)
coding_data1$Bin1 <- as.factor(coding_data1$Bin1)
coding_data1$Structure1 <- as.factor(coding_data1$Structure1)
coding_data1$Bin2 <- as.factor(coding_data1$Bin2)
coding_data1$Structure2 <- as.factor(coding_data1$Structure2)
coding_data1$Sol1Rank <- as.factor(coding_data1$Sol1Rank)
coding_data1$Sol2Rank <- as.factor(coding_data1$Sol2Rank)
coding_data1$Preference <- as.factor(coding_data1$Preference)

# Read file: Adding Machine
adding_data <- read.csv(adding_file)

# Convert column types as needed
adding_data$School <- as.factor(adding_data$School)
adding_data$Course <- as.factor(adding_data$Course)
adding_data$StudyID <- as.character(adding_data$StudyID)
adding_data$Lang <- as.factor(adding_data$Lang)
adding_data$Problem <- as.factor(adding_data$Problem)
adding_data$Subgroup <- as.factor(adding_data$Subgroup)
adding_data$SolutionID <- as.factor(adding_data$SolutionID)
adding_data$Bin <- as.factor(adding_data$Bin)
adding_data$Structure <- as.factor(adding_data$Structure)
adding_data$Helpers <- as.character(adding_data$Helpers)
adding_data$Notes <- as.character(adding_data$Notes)

# Read file: Rainfall
# rfall_data <- read.csv(rfall_file)

# Convert column types as needed
# rfall_data$School <- as.factor(rfall_data$School)
# rfall_data$Course <- as.factor(rfall_data$Course)
# rfall_data$StudyID <- as.character(rfall_data$StudyID)
# rfall_data$Lang <- as.factor(rfall_data$Lang)
# rfall_data$Problem <- as.factor(rfall_data$Problem)
# rfall_data$Subgroup <- as.factor(rfall_data$Subgroup)
# rfall_data$SolutionID <- as.factor(rfall_data$SolutionID)
# rfall_data$Structure <- as.factor(rfall_data$Structure)
# rfall_data$Helpers <- as.character(rfall_data$Helpers)
# rfall_data$Notes <- as.character(rfall_data$Notes)

# Get data information
# str(coding_data1); summary(coding_data1)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# EARTHQUAKE

# Create data frame for earthquake data
equake <- coding_data1[coding_data1$Problem == "earthquake",]

# Create data frame with occurrence counts of structures for earthquake
equake_preference_count1 <- data.frame(count(equake, Preference))
setnames(equake_preference_count1, c("n"), c("Counts"))

# EARTHQUAKE-ADDING MACHINE (19)

# Create data frame combining equake with corresponding adding-machine solution in each student row entry
equake_combined <- equake[,colnames(equake)]
equake_combined$AddingBin <- adding_data[equake_combined$StudyID == adding_data$StudyID, c("Bin")]
equake_combined$AddingStruct <- adding_data[equake_combined$StudyID == adding_data$StudyID, c("Structure")]

# Create data frame with occurrence counts of adding-machine structures for earthquake
equake_combined_count1 <- data.frame(count(equake_combined, Preference, AddingBin))
setnames(equake_combined_count1, c("n"), c("Counts"))

# EARTHQUAKE-RAINFALL (2102)
# 
# # Create data frame combining equake with corresponding rainfall solution in each student row entry
# equake_combined <- equake[,colnames(equake)]
# equake_combined$RfallStruct <- rfall_data[equake_combined$StudyID == rfall_data$StudyID, c("Structure")]
# 
# # Create data frame with occurrence counts of rainfall structures for earthquake
# equake_combined_count1 <- data.frame(count(equake_combined, Preference, RfallStruct))
# setnames(equake_combined_count1, c("n"), c("Counts"))


# DATASMOOTH

# Create data frame for datasmooth data
# dsmooth <- coding_data1[coding_data1$Problem == "datasmooth",]

# Create data frame with occurrence counts of structures for dsmooth
# dsmooth_preference_count1 <- data.frame(count(dsmooth, Preference))
# setnames(dsmooth_preference_count1, c("n"), c("Counts"))

# DATASMOOTH-ADDING MACHINE (19)
 
# # Create data frame combining datasmooth with corresponding adding-machine solution in each student row entry
# dsmooth_combined <- dsmooth[,colnames(dsmooth)]
# dsmooth_combined$AddingBin <- adding_data[dsmooth_combined$StudyID == adding_data$StudyID, c("Bin")]
# dsmooth_combined$AddingStruct <- adding_data[dsmooth_combined$StudyID == adding_data$StudyID, c("Structure")]
# 
# # Create data frame with occurrence counts of adding-machine structures for dsmooth
# dsmooth_combined_count1 <- data.frame(count(dsmooth_combined, Preference, AddingBin))
# setnames(dsmooth_combined_count1, c("n"), c("Counts"))

# DATASMOOTH-RAINFALL (2102)

# Create data frame combining equake with corresponding rainfall solution in each student row entry
# dsmooth_combined <- dsmooth[,colnames(dsmooth)]
# dsmooth_combined$RfallStruct <- rfall_data[dsmooth_combined$StudyID == rfall_data$StudyID, c("Structure")]

# Create data frame with occurrence counts of rainfall structures for earthquake
# dsmooth_combined_count1 <- data.frame(count(dsmooth_combined, Preference, RfallStruct))
# setnames(dsmooth_combined_count1, c("n"), c("Counts"))


#==================================================
# GRAPHS
#==================================================

# # EARTHQUAKE PREFERENCES: CS19
# 
# Graph counts per bin preference
# g_equake_prefs1 <- ggplot(data=equake_preference_count1, aes(x=Preference, y=Counts))
# g_equake_prefs1 + geom_bar(aes(fill=Preference), stat = "identity") +
#   ggtitle("CS19: Earthquake Preferences") +
#   theme(legend.position="none", axis.text.x=element_text(size=8)) +
#   geom_text(aes(label=Counts), vjust=1.5, color="white") +
#   labs(x="\nEarthquake Bins")

# EARTHQUAKE PREFERENCES: CS2102

# Graph counts per bin preference
# g_equake_prefs1 <- ggplot(data=equake_preference_count1, aes(x=Preference, y=Counts))
# g_equake_prefs1 + geom_bar(aes(fill=Preference), stat = "identity") +
#   ggtitle("CS2102: Earthquake Preferences") +
#   theme(legend.position="none", axis.text.x=element_text(size=8)) +
#   geom_text(aes(label=Counts), vjust=1.5, color="white") + 
#   labs(x="\nEarthquake Bins")


# DATASMOOTH PREFERENCES: CS19

# Graph counts per bin preference
# g_dsmooth_prefs1 <- ggplot(data=dsmooth_preference_count1, aes(x=Preference, y=Counts))
# g_dsmooth_prefs1 + geom_bar(aes(fill=Preference), stat = "identity") +
#   ggtitle("CS19: DataSmooth Preferences") +
#   theme(legend.position="none", axis.text.x=element_text(size=8)) +
#   geom_text(aes(label=Counts), vjust=1.5, color="white") +
#   labs(x="\nDataSmooth Bins")

# DATASMOOTH PREFERENCES: CS2102

# Graph counts per bin preference
# g_dsmooth_prefs1 <- ggplot(data=dsmooth_preference_count1, aes(x=Preference, y=Counts))
# g_dsmooth_prefs1 + geom_bar(aes(fill=Preference), stat = "identity") +
#   ggtitle("CS2102: DataSmooth Preferences") +
#   theme(legend.position="none", axis.text.x=element_text(size=8)) +
#   geom_text(aes(label=Counts), vjust=1.5, color="white") +
#   labs(x="\nDataSmooth Bins")


# EARTHQUAKE-ADDING MACHINE: CS19

# Compute midpoints of bars, for each structure in each bin; store in variable pos
equake_adding_midpoint1 <- group_by(equake_combined_count1, Preference) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))
# 
# Graph adding-machine counts per earthquake bin
g_equake_adding <- ggplot(data=equake_adding_midpoint1, aes(x=Preference, y=Counts))
g_equake_adding + geom_bar(aes(fill=AddingBin), stat = "identity") +
  # ggtitle("CS19: Earthquake - Adding Machine") +
  coord_flip() +
  theme(legend.position=c(0.75,0.3), 
        legend.background=element_rect(size=0.5, linetype='solid', colour ='darkblue'),
        axis.text.x=element_text(size=8),
        axis.ticks.x=element_blank(),
        panel.grid.major = element_blank(),
        axis.text.y = element_text(size=12)) +
  geom_text(aes(label=Counts, y=pos), color="white", fontface='bold') +
  labs(fill="Adding Machine Structure", x="\nEarthquake Structure Preference", y='\nNumber of Students') + 
  scale_y_continuous(limits=c(0,10.5), expand=c(0,0), breaks = c(0,2,4,6,8,10)) + 
  scale_fill_manual(values=c("darkgray", "yellow", "cyan", 'black'))

# EARTHQUAKE-RAINFALL: CS2102

# Compute midpoints of bars, for each structure in each bin; store in variable pos
# equake_rfall_midpoint1 <- group_by(equake_combined_count1, Preference) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph rainfall counts per earthquake bin
# g_equake_rfall <- ggplot(data=equake_rfall_midpoint1, aes(x=Preference, y=Counts))
# g_equake_rfall + geom_bar(aes(fill=RfallStruct), stat = "identity") +
#   ggtitle("CS2102: Earthquake - Rainfall") +
#   theme(legend.position="right", axis.text.x=element_text(size=8, angle = 45, hjust = 1, vjust = 1)) +
#   geom_text(aes(label=Counts, y=pos), color="white") +
#   labs(fill="Rainfall Bins", x="\nEarthquake Bin Preference")


# DATASMOOTH-ADDING MACHINE: CS19

# # Compute midpoints of bars, for each structure in each bin; store in variable pos
# dsmooth_adding_midpoint1 <- group_by(dsmooth_combined_count1, Preference) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))
# 
# # Graph adding-machine counts per datasmooth bin
# g_dsmooth_adding <- ggplot(data=dsmooth_adding_midpoint1, aes(x=Preference, y=Counts))
# g_dsmooth_adding + geom_bar(aes(fill=AddingBin), stat = "identity") +
#   ggtitle("CS19: DataSmooth - Adding Machine") +
#   theme(legend.position="bottom", axis.text.x=element_text(size=8)) +
#   geom_text(aes(label=Counts, y=pos), color="white") + 
#   labs(fill="Adding Machine Bins", x="\nDataSmooth Bin Preference")


# DATASMOOTH-RAINFALL: CS2102

# Compute midpoints of bars, for each structure in each bin; store in variable pos
# dsmooth_rfall_midpoint1 <- group_by(dsmooth_combined_count1, Preference) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph rainfall counts per datasmooth bin
# g_dsmooth_rfall <- ggplot(data=dsmooth_rfall_midpoint1, aes(x=Preference, y=Counts))
# g_dsmooth_rfall + geom_bar(aes(fill=RfallStruct), stat = "identity") +
#   ggtitle("CS2102: DataSmooth - Rainfall") +
#   theme(legend.position="right", axis.text.x=element_text(size=8, angle = 45, hjust = 1, vjust = 1)) +
#   geom_text(aes(label=Counts, y=pos), color="white") +
#   labs(fill="Rainfall Bins", x="\nDataSmooth Bin Preference")

