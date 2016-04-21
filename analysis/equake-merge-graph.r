#' ---
#' title: "Earthquake/DataSmooth Structure Analysis with Merged Graphs"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "19 April 2016"
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
library(grid)


#==================================================
# GLOBALS SETUP
#==================================================

# Set working directory
working_dir <- "C:/Git Repositories/files"
setwd(working_dir)#; getwd()

# Set file names
quake2102 <- "coding-2102-earthquake.csv"
quake19 <- "coding-19-earthquake.csv"

dsmooth2102 <- "coding-2102-datasmooth.csv"
dsmooth19 <- "coding-19-datasmooth.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read files
equake_data2102 <- read.csv(quake2102)
equake_data19 <- read.csv(quake19)
dsmooth_data2102 <- read.csv(dsmooth2102)
dsmooth_data19 <- read.csv(dsmooth19)

# Convert column types as needed: 2102 data
equake_data2102$School      <- as.factor(equake_data2102$School)
equake_data2102$Course      <- as.factor(equake_data2102$Course)
equake_data2102$StudyID     <- as.character(equake_data2102$StudyID)
equake_data2102$Lang        <- as.factor(equake_data2102$Lang)
equake_data2102$Problem     <- as.factor(equake_data2102$Problem)
equake_data2102$Subgroup    <- as.factor(equake_data2102$Subgroup)
equake_data2102$SolutionID  <- as.factor(equake_data2102$SolutionID)
equake_data2102$Bin         <- as.factor(equake_data2102$Bin)
equake_data2102$Structure   <- as.factor(equake_data2102$Structure)
equake_data2102$Helpers     <- as.character(equake_data2102$Helpers)
equake_data2102$Builtins    <- as.character(equake_data2102$Builtins)
equake_data2102$Notes       <- as.character(equake_data2102$Notes)

dsmooth_data2102$School      <- as.factor(dsmooth_data2102$School)
dsmooth_data2102$Course      <- as.factor(dsmooth_data2102$Course)
dsmooth_data2102$StudyID     <- as.character(dsmooth_data2102$StudyID)
dsmooth_data2102$Lang        <- as.factor(dsmooth_data2102$Lang)
dsmooth_data2102$Problem     <- as.factor(dsmooth_data2102$Problem)
dsmooth_data2102$Subgroup    <- as.factor(dsmooth_data2102$Subgroup)
dsmooth_data2102$SolutionID  <- as.factor(dsmooth_data2102$SolutionID)
dsmooth_data2102$Bin         <- as.factor(dsmooth_data2102$Bin)
dsmooth_data2102$Structure   <- as.factor(dsmooth_data2102$Structure)
dsmooth_data2102$Helpers     <- as.character(dsmooth_data2102$Helpers)
dsmooth_data2102$Builtins    <- as.character(dsmooth_data2102$Builtins)
dsmooth_data2102$Notes       <- as.character(dsmooth_data2102$Notes)

# Convert column types as needed: 19 data
equake_data19$School      <- as.factor(equake_data19$School)
equake_data19$Course      <- as.factor(equake_data19$Course)
equake_data19$StudyID     <- as.character(equake_data19$StudyID)
equake_data19$Lang        <- as.factor(equake_data19$Lang)
equake_data19$Problem     <- as.factor(equake_data19$Problem)
equake_data19$Subgroup    <- as.factor(equake_data19$Subgroup)
equake_data19$SolutionID  <- as.factor(equake_data19$SolutionID)
equake_data19$Bin         <- as.factor(equake_data19$Bin)
equake_data19$Structure   <- as.factor(equake_data19$Structure)
equake_data19$Helpers     <- as.character(equake_data19$Helpers)
equake_data19$Builtins    <- as.character(equake_data19$Builtins)
equake_data19$Notes       <- as.character(equake_data19$Notes)

dsmooth_data19$School      <- as.factor(dsmooth_data19$School)
dsmooth_data19$Course      <- as.factor(dsmooth_data19$Course)
dsmooth_data19$StudyID     <- as.character(dsmooth_data19$StudyID)
dsmooth_data19$Lang        <- as.factor(dsmooth_data19$Lang)
dsmooth_data19$Problem     <- as.factor(dsmooth_data19$Problem)
dsmooth_data19$Subgroup    <- as.factor(dsmooth_data19$Subgroup)
dsmooth_data19$SolutionID  <- as.factor(dsmooth_data19$SolutionID)
dsmooth_data19$Bin         <- as.factor(dsmooth_data19$Bin)
dsmooth_data19$Structure   <- as.factor(dsmooth_data19$Structure)
dsmooth_data19$Helpers     <- as.character(dsmooth_data19$Helpers)
dsmooth_data19$Builtins    <- as.character(dsmooth_data19$Builtins)
dsmooth_data19$Notes       <- as.character(dsmooth_data19$Notes)
dsmooth_data19$Correctness <- NULL

# Combine 2102 and 19 datasets and add a column for determining the population (1101, 1102, 19)
equake_data <- rbind(equake_data2102, equake_data19)
equake_data$StudyGroup <- ifelse(grepl("1101", equake_data$Subgroup), "1101",
                                 ifelse(grepl("1102", equake_data$Subgroup), "1102", "19"))
dsmooth_data <- rbind(dsmooth_data2102, dsmooth_data19)
dsmooth_data$StudyGroup <- ifelse(grepl("1101", dsmooth_data$Subgroup), "1101",
                                 ifelse(grepl("1102", dsmooth_data$Subgroup), "1102", "19"))

# Set n-values for each StudyGroup (use either equake_data or dsmooth_data)
n_1101  <- nrow(equake_data[equake_data$StudyGroup == "1101",])
n_1102  <- nrow(equake_data[equake_data$StudyGroup == "1102",])
n_19    <- nrow(equake_data[equake_data$StudyGroup == "19",])


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame with occurrence counts of structures for each bin
equake_bin_group_count <- data.frame(count(equake_data, Bin, StudyGroup))
setnames(equake_bin_group_count, c("n"), c("Counts"))
equake_bin_group_count$Percentage <- round(ifelse(equake_bin_group_count$StudyGroup == "1101", ((equake_bin_group_count$Counts / n_1101) * 100),
                                     ifelse(equake_bin_group_count$StudyGroup == "1102", ((equake_bin_group_count$Counts / n_1102) * 100),
                                            ((equake_bin_group_count$Counts / n_19) * 100))),2)
dsmooth_bin_group_count <- data.frame(count(dsmooth_data, Bin, StudyGroup))
setnames(dsmooth_bin_group_count, c("n"), c("Counts"))
dsmooth_bin_group_count$Percentage <- round(ifelse(dsmooth_bin_group_count$StudyGroup == "1101", ((dsmooth_bin_group_count$Counts / n_1101) * 100),
                                                  ifelse(dsmooth_bin_group_count$StudyGroup == "1102", ((dsmooth_bin_group_count$Counts / n_1102) * 100),
                                                         ((dsmooth_bin_group_count$Counts / n_19) * 100))),2)

# Add 0-values to Bin-StudyGroup combinations that have 0 occurences
equake_bin_group_count <- equake_bin_group_count %>% expand(Bin, StudyGroup) %>% left_join(equake_bin_group_count)
equake_bin_group_count <- replace_na(equake_bin_group_count, replace=list(Counts = 0, Percentage = 0))

dsmooth_bin_group_count <- dsmooth_bin_group_count %>% expand(Bin, StudyGroup) %>% left_join(dsmooth_bin_group_count)
dsmooth_bin_group_count <- replace_na(dsmooth_bin_group_count, replace=list(Counts = 0, Percentage = 0))


#==================================================
# GRAPHS
# ==================================================

# ALL STUDYGROUP OCCURRENCES PER BIN OVER ALL SOLUTIONS

# EARTHQUAKE
ggplot(data=equake_bin_group_count, aes(x=Bin, y=Percentage, fill=StudyGroup)) + 
  coord_flip() +
  geom_bar(stat='identity', position='dodge', colour="black") + 
  geom_text(aes(label=paste(Percentage, "%")), 
            hjust=-0.2, 
            position=position_dodge(0.95), 
            size=3.5, 
            colour='deepskyblue4', 
            fontface='bold') +
  scale_y_continuous(limits=c(0,70), expand=c(0,0))+ 
  theme(legend.position=c(0.8,0.3), 
        legend.background=element_rect(size=0.5, linetype='solid', colour ='darkblue'), 
        axis.line=element_line(colour="black"), 
        panel.grid.major = element_blank(), 
        axis.ticks.x=element_blank(),
        axis.text.y = element_text(size=12)) +
  labs(fill='Study Group', x='\nPlan', y='\n% of Solutions in each Plan Type') + 
  scale_fill_manual(labels=c("CrsBnvc", "CrsBexp", "CrsA"), values=c("black", "white", "#56B4E9"))

# DATASMOOTH
ggplot(data=dsmooth_bin_group_count, aes(x=Bin, y=Percentage, fill=StudyGroup)) + 
  coord_flip() +
  geom_bar(stat='identity', position='dodge', colour="black") + 
  geom_text(aes(label=paste(Percentage, "%")), 
            hjust=-0.2, 
            position=position_dodge(0.95), 
            size=3.5, 
            colour='deepskyblue4', 
            fontface='bold') +
  scale_y_continuous(limits=c(0,70), expand=c(0,0))+ 
  theme(legend.position=c(0.8,0.3), 
        legend.background=element_rect(size=0.5, linetype='solid', colour ='darkblue'), 
        axis.line=element_line(colour="black"), 
        panel.grid.major = element_blank(), 
        axis.ticks.x=element_blank(),
        axis.text.y=element_text(size=12)) +
  labs(fill='Study Group', x='\nPlan', y='\n% of Solutions in each Plan Type') + 
  scale_fill_manual(labels=c("CrsBnvc", "CrsBexp", "CrsA"), values=c("black", "white", "#56B4E9"))


