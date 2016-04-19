#' ---
#' title: "CS2102/19 Earthquake Structure Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "18 April 2016"
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
file_name1 <- "coding-2102-earthquake.csv"
# file_name2 <- "coding-19-earthquake.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
coding_data1 <- read.csv(file_name1)
# coding_data1 <- read.csv(file_name2)

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
coding_data1$Builtins <- as.character(coding_data1$Builtins)
coding_data1$Notes <- as.character(coding_data1$Notes)

# Get data information
# str(coding_data1); summary(coding_data1)
# str(coding_data2); summary(coding_data2)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# EARTHQUAKE: CS2102

# Create data frame with just the needed columns
clean_data1 <- coding_data1[, c("StudyID", "Subgroup", "SolutionID", "Bin", "Structure")]

# Create separate data frames for each of SolutionID = 1 and SolutionID = 2
sol_id1 <- clean_data1[clean_data1$SolutionID == "1",]
sol_id2 <- clean_data1[clean_data1$SolutionID == "2",]

# Create data frame with occurrence counts of structures for each bin
bin_structs_count1 <- data.frame(count(clean_data1, Bin, Structure))
setnames(bin_structs_count1, c("n"), c("Counts"))

# Create data frame combining solutions 1 & 2 bins and structures in each student row entry
combined_sols1 <- sol_id1[,c("StudyID", "Subgroup", "Bin", "Structure")]
setnames(combined_sols1, c("Bin", "Structure"), c("Bin1", "Structure1"))
combined_sols1$Bin2 <- sol_id2[combined_sols1$StudyID == sol_id2$StudyID, c("Bin")]
combined_sols1$Structure2 <- sol_id2[combined_sols1$StudyID == sol_id2$StudyID, c("Structure")]

# Create data frame containing students who has same Bin1 and Bin2
same_bins1 <- combined_sols1[combined_sols1$Bin1 == combined_sols1$Bin2,]

# Create data frame that counts occurrences of structures for each bin
same_bins_count1 <- data.frame(count(same_bins1, Bin1))
setnames(same_bins_count1, c("n"), c("Counts"))

# Create data frame containing students who has different Bin1 and Bin2
diff_bins1 <- combined_sols1[combined_sols1$Bin1 != combined_sols1$Bin2,]

# Create data frame containing students who has an AllTogether solution for Bin1 and Bin2
# NOTE: AllTogether is either SingleTraverse or NestedTraverse
allin1trav_both1 <- diff_bins1[(diff_bins1$Bin1 == "SingleTraverse" | diff_bins1$Bin1 == "NestedTraverse") &
                            (diff_bins1$Bin2 == "SingleTraverse" | diff_bins1$Bin2 == "NestedTraverse"),]

# Modify diff_bins1 so that it removes all rows with AllTogether solutions for both Bin1 and Bin2
diff_bins1 <- setdiff(diff_bins1, allin1trav_both1)

# Create data frame with at least one of the solutions as an AllTogether
diff_bins_allin1trav1 <- diff_bins1[diff_bins1$Bin1 == "SingleTraverse" | diff_bins1$Bin1 == "NestedTraverse" |
                                      diff_bins1$Bin2 == "SingleTraverse" | diff_bins1$Bin2 == "NestedTraverse",]

# Swap the values so that all Single/NestedTraverse-s are under Bin1, swap corresponding Structures
diff_bins_allin1trav1[diff_bins_allin1trav1$Bin2 == "SingleTraverse" | diff_bins_allin1trav1$Bin2 == "NestedTraverse", 
                      c("Bin1","Structure1","Bin2","Structure2")] <-
  diff_bins_allin1trav1[diff_bins_allin1trav1$Bin2 == "SingleTraverse" | diff_bins_allin1trav1$Bin2 == "NestedTraverse"
                        , c("Bin2","Structure2","Bin1","Structure1")]

diff_bins_allin1trav_count1 <- data.frame(count(diff_bins_allin1trav1, Bin1, Bin2))
setnames(diff_bins_allin1trav_count1, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in SingleTraverse
diff_bins_singltrav1 <- diff_bins_allin1trav1[diff_bins_allin1trav1$Bin1 == "SingleTraverse",]

# Create data frame that counts occurrences of other bins for students with one SingleTrav
diff_bins_singltrav_count1 <- data.frame(count(diff_bins_singltrav1, Bin2))
setnames(diff_bins_singltrav_count1, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in NestedTraverse
diff_bins_nstdtrav1 <- diff_bins_allin1trav1[diff_bins_allin1trav1$Bin1 == "NestedTraverse",]

# Create data frame that counts occurrences of other bins for students with one NestedTrav
diff_bins_nstdtrav_count1 <- data.frame(count(diff_bins_nstdtrav1, Bin2))
setnames(diff_bins_nstdtrav_count1, c("n"), c("Counts"))

# Create data frame with all other solutions that didn't use SingleTraverse or NestedTraverse
diff_bins_other1 <- diff_bins1[diff_bins1$Bin1 != "SingleTraverse" & diff_bins1$Bin2 != "SingleTraverse" &
                                 diff_bins1$Bin1 != "NestedTraverse" & diff_bins1$Bin2 != "NestedTraverse",]


# FOR CS2102: 1102 BACKGROUND

# Create data frame of students with 1102 background
studs_1102 <- clean_data1[clean_data1$Subgroup == "1102-a" | clean_data1$Subgroup == "1102-b",]

# Create data frame with occurrence counts of structures for each bin for students with 1102 background
bin_structs1102_count <- data.frame(count(studs_1102, Bin, Structure))
setnames(bin_structs1102_count, c("n"), c("Counts"))

# Create separate data frames for each of SolutionID = 1 and SolutionID = 2
sol_id1_1102 <- studs_1102[studs_1102$SolutionID == "1",]
sol_id2_1102 <- studs_1102[studs_1102$SolutionID == "2",]

# Create data frame combining solutions 1 & 2 bins and structures in each student row entry
combined_1102 <- sol_id1_1102[,c("StudyID", "Subgroup", "Bin", "Structure")]
setnames(combined_1102, c("Bin", "Structure"), c("Bin1", "Structure1"))
combined_1102$Bin2 <- sol_id2_1102[combined_1102$StudyID == sol_id2_1102$StudyID, c("Bin")]
combined_1102$Structure2 <- sol_id2_1102[combined_1102$StudyID == sol_id2_1102$StudyID, c("Structure")]

# Create data frame containing students who has same Bin1 and Bin2
same_bins1102 <- combined_1102[combined_1102$Bin1 == combined_1102$Bin2,]

# Create data frame that counts occurrences of structures for each bin
same_bins_count1102 <- data.frame(count(same_bins1102, Bin1))
setnames(same_bins_count1102, c("n"), c("Counts"))

# Create data frame containing students who has different Bin1 and Bin2
diff_bins1102 <- combined_1102[combined_1102$Bin1 != combined_1102$Bin2,]

# Create data frame containing students who has an AllTogether solution for Bin1 and Bin2
# NOTE: AllTogether is either SingleTraverse or NestedTraverse
allin1trav_both1102 <- diff_bins1102[(diff_bins1102$Bin1 == "SingleTraverse" | diff_bins1102$Bin1 == "NestedTraverse") &
                                 (diff_bins1102$Bin2 == "SingleTraverse" | diff_bins1102$Bin2 == "NestedTraverse"),]

# Modify diff_bins1 so that it removes all rows with AllTogether solutions for both Bin1 and Bin2
diff_bins1102 <- setdiff(diff_bins1102, allin1trav_both1102)

# Create data frame with at least one of the solutions as an AllTogether
diff_bins_allin1trav1102 <- diff_bins1102[diff_bins1102$Bin1 == "SingleTraverse" | diff_bins1102$Bin1 == "NestedTraverse" |
                                      diff_bins1102$Bin2 == "SingleTraverse" | diff_bins1102$Bin2 == "NestedTraverse",]

# Swap the values so that all Single/NestedTraverse-s are under Bin1, swap corresponding Structures
diff_bins_allin1trav1102[diff_bins_allin1trav1102$Bin2 == "SingleTraverse" | diff_bins_allin1trav1102$Bin2 == "NestedTraverse", 
                      c("Bin1","Structure1","Bin2","Structure2")] <-
  diff_bins_allin1trav1102[diff_bins_allin1trav1102$Bin2 == "SingleTraverse" | diff_bins_allin1trav1102$Bin2 == "NestedTraverse",
                         c("Bin2","Structure2","Bin1","Structure1")]

diff_bins_allin1trav_count1102 <- data.frame(count(diff_bins_allin1trav1102, Bin1, Bin2))
setnames(diff_bins_allin1trav_count1102, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in SingleTraverse
diff_bins_singltrav1102 <- diff_bins_allin1trav1102[diff_bins_allin1trav1102$Bin1 == "SingleTraverse",]

# Create data frame that counts occurrences of other bins for students with one SingleTrav
diff_bins_singltrav_count1102 <- data.frame(count(diff_bins_singltrav1102, Bin2))
setnames(diff_bins_singltrav_count1102, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in NestedTraverse
diff_bins_nstdtrav1102 <- diff_bins_allin1trav1102[diff_bins_allin1trav1102$Bin1 == "NestedTraverse",]

# Create data frame that counts occurrences of other bins for students with one NestedTrav
diff_bins_nstdtrav_count1102 <- data.frame(count(diff_bins_nstdtrav1102, Bin2))
setnames(diff_bins_nstdtrav_count1102, c("n"), c("Counts"))

# Create data frame with all other solutions that didn't use SingleTraverse or NestedTraverse
diff_bins_other1102 <- diff_bins1102[diff_bins1102$Bin1 != "SingleTraverse" & diff_bins1102$Bin2 != "SingleTraverse" &
                                 diff_bins1102$Bin1 != "NestedTraverse" & diff_bins1102$Bin2 != "NestedTraverse",]


# FOR CS2102: 1101 BACKGROUND

# Create data frame of students with 1101 background
studs_1101 <- clean_data1[clean_data1$Subgroup == "1101-a" | 
                            clean_data1$Subgroup == "1101-b" | 
                            clean_data1$Subgroup == "1101-c",]

# Create data frame with occurrence counts of structures for each bin for students with 1101 background
bin_structs1101_count <- data.frame(count(studs_1101, Bin, Structure))
setnames(bin_structs1101_count, c("n"), c("Counts"))

# Create separate data frames for each of SolutionID = 1 and SolutionID = 2
sol_id1_1101 <- studs_1101[studs_1101$SolutionID == "1",]
sol_id2_1101 <- studs_1101[studs_1101$SolutionID == "2",]

# Create data frame combining solutions 1 & 2 bins and structures in each student row entry
combined_1101 <- sol_id1_1101[,c("StudyID", "Subgroup", "Bin", "Structure")]
setnames(combined_1101, c("Bin", "Structure"), c("Bin1", "Structure1"))
combined_1101$Bin2 <- sol_id2_1101[combined_1101$StudyID == sol_id2_1101$StudyID, c("Bin")]
combined_1101$Structure2 <- sol_id2_1101[combined_1101$StudyID == sol_id2_1101$StudyID, c("Structure")]

# Create data frame containing students who has same Bin1 and Bin2
same_bins1101 <- combined_1101[combined_1101$Bin1 == combined_1101$Bin2,]

# Create data frame that counts occurrences of structures for each bin
same_bins_count1101 <- data.frame(count(same_bins1101, Bin1))
setnames(same_bins_count1101, c("n"), c("Counts"))

# Create data frame containing students who has different Bin1 and Bin2
diff_bins1101 <- combined_1101[combined_1101$Bin1 != combined_1101$Bin2,]

# Create data frame containing students who has an AllTogether solution for Bin1 and Bin2
# NOTE: AllTogether is either SingleTraverse or NestedTraverse
allin1trav_both1101 <- diff_bins1101[(diff_bins1101$Bin1 == "SingleTraverse" | diff_bins1101$Bin1 == "NestedTraverse") &
                                       (diff_bins1101$Bin2 == "SingleTraverse" | diff_bins1101$Bin2 == "NestedTraverse"),]

# Modify diff_bins1 so that it removes all rows with AllTogether solutions for both Bin1 and Bin2
diff_bins1101 <- setdiff(diff_bins1101, allin1trav_both1101)

# Create data frame with at least one of the solutions as an AllTogether
diff_bins_allin1trav1101 <- diff_bins1101[diff_bins1101$Bin1 == "SingleTraverse" | diff_bins1101$Bin1 == "NestedTraverse" |
                                            diff_bins1101$Bin2 == "SingleTraverse" | diff_bins1101$Bin2 == "NestedTraverse",]

# Swap the values so that all Single/NestedTraverse-s are under Bin1, swap corresponding Structures
diff_bins_allin1trav1101[diff_bins_allin1trav1101$Bin2 == "SingleTraverse" | diff_bins_allin1trav1101$Bin2 == "NestedTraverse", 
                         c("Bin1","Structure1","Bin2","Structure2")] <-
  diff_bins_allin1trav1101[diff_bins_allin1trav1101$Bin2 == "SingleTraverse" | diff_bins_allin1trav1101$Bin2 == "NestedTraverse",
                           c("Bin2","Structure2","Bin1","Structure1")]

diff_bins_allin1trav_count1101 <- data.frame(count(diff_bins_allin1trav1101, Bin1, Bin2))
setnames(diff_bins_allin1trav_count1101, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in SingleTraverse
diff_bins_singltrav1101 <- diff_bins_allin1trav1101[diff_bins_allin1trav1101$Bin1 == "SingleTraverse",]

# Create data frame that counts occurrences of other bins for students with one SingleTrav
diff_bins_singltrav_count1101 <- data.frame(count(diff_bins_singltrav1101, Bin2))
setnames(diff_bins_singltrav_count1101, c("n"), c("Counts"))

# Create data frame from diff_bins_allin1trav1 that has Bin1 in NestedTraverse
diff_bins_nstdtrav1101 <- diff_bins_allin1trav1101[diff_bins_allin1trav1101$Bin1 == "NestedTraverse",]

# Create data frame that counts occurrences of other bins for students with one NestedTrav
diff_bins_nstdtrav_count1101 <- data.frame(count(diff_bins_nstdtrav1101, Bin2))
setnames(diff_bins_nstdtrav_count1101, c("n"), c("Counts"))

# Create data frame with all other solutions that didn't use SingleTraverse or NestedTraverse
diff_bins_other1101 <- diff_bins1101[diff_bins1101$Bin1 != "SingleTraverse" & diff_bins1101$Bin2 != "SingleTraverse" &
                                       diff_bins1101$Bin1 != "NestedTraverse" & diff_bins1101$Bin2 != "NestedTraverse",]

#==================================================
# GRAPHS
#==================================================

# EARTHQUAKE: CS2102

# ALL STRUCTURE OCCURRENCES PER BIN OVER ALL SOLUTIONS
# Note: Stacked bar visualization for each code structure bin

# Compute midpoints of bars, for each structure in each bin; store in variable pos
bin_structs_midpoint1 <- group_by(bin_structs_count1, Bin) %>% mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph all structures, grouped by bin
g_all_solns1 <- ggplot(data = bin_structs_midpoint1, aes(x = Bin, y = Counts))
g_all_solns1 + geom_bar(aes(fill = Structure), stat = "identity") +
  coord_flip() +
  ggtitle("CS2102: All solutions") +
  # ggtitle("CS19: All solutions") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts, y = pos), color = "white")


# STUDENTS WITH SAME BINS FOR BOTH SOLUTIONS

g_same_bins1 <- ggplot(data = same_bins_count1, aes(x = Bin1, y = Counts))
g_same_bins1 + geom_bar(aes(fill = Bin1), stat = "identity") +
  ggtitle("CS2102: Students with same bins for solutions 1, 2") +
  # ggtitle("CS19: Students with same bins for solutions 1, 2") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts), vjust = -0.5) +
  scale_y_continuous(limits = c(0,15))


# STUDENTS WITH DIFFERENT BINS, BUT ONE IN SINGLETRAVERSE/NESTEDTRAVERSE BIN

g_diff_bins_allin1trav1 <- ggplot(data = diff_bins_allin1trav_count1, aes(x = Bin2, y = Counts))
g_diff_bins_allin1trav1 + geom_bar(aes(fill = Bin2), stat = "identity") + 
  ggtitle("CS2102: Students with [Single/Nested]Traverse as one of the solutions") +
  # ggtitle("CS19: Students with [Single/Nested]Traverse as one of the solutions") + 
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts), vjust = -0.5) + 
  scale_y_continuous(limits = c(0,15)) +
  facet_grid(Bin1 ~ .)


# STUDENTS WITH DIFFERENT SOLUTIONS BUT BOTH IN ALLTOGETHER

g_allin1trav_both1 <- tableGrob(allin1trav_both1)
grob_title <- textGrob("Students with different solutions but both in AllTogether")
grid.arrange(grob_title, g_allin1trav_both1)


# STUDENTS WHO DID NOT DO SINGLETRAVERSE OR NESTED TRAVERSE

g_diff_bins_other1 <- tableGrob(diff_bins_other1)
grob_title <- textGrob("Students who did not do SingleTraverse or NestedTraverse")
grid.arrange(grob_title, g_diff_bins_other1)


# FOR STUDENTS WITH 1102 BACKGROUND

# Compute midpoints of bars, for each structure in each bin; store in variable pos
bin_structs1102_midpoint <- group_by(bin_structs1102_count, Bin) %>%
  mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph all structures, grouped by bin
g_all_solns1102 <- ggplot(data = bin_structs1102_midpoint, aes(x = Bin, y = Counts))
g_all_solns1102 + geom_bar(aes(fill = Structure), stat = "identity") +
  coord_flip() +
  ggtitle("CS2102: All solutions from students with 1102 background") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts, y = pos), color = "white")

# 1102 STUDENTS WITH SAME BINS FOR BOTH SOLUTIONS
g_same_bins1102 <- ggplot(data = same_bins_count1102, aes(x = Bin1, y = Counts))
g_same_bins1102 + geom_bar(aes(fill = Bin1), stat = "identity") +
  ggtitle("CS2102: 1102 Students with same bins for solutions 1, 2") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts), vjust = -0.5) +
  scale_y_continuous(limits = c(0,15))

# 1102 STUDENTS WITH DIFFERENT BINS, BUT ONE IN SINGLETRAVERSE/NESTEDTRAVERSE BIN
g_diff_bins_allin1trav1102 <- ggplot(data = diff_bins_allin1trav_count1102, aes(x = Bin2, y = Counts))
g_diff_bins_allin1trav1102 + geom_bar(aes(fill = Bin2), stat = "identity") + 
  ggtitle("CS2102: 1102 Students with [Single/Nested]Traverse as one of the solutions") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts), vjust = -0.5) + 
  scale_y_continuous(limits = c(0,15)) +
  facet_grid(Bin1 ~ .)

# 1102 STUDENTS WITH DIFFERENT SOLUTIONS BUT BOTH IN ALLTOGETHER
# g_allin1trav_both1102 <- tableGrob(allin1trav_both1102)
# grob_title <- textGrob("1102 Students with different solutions but both in AllTogether")
# grid.arrange(grob_title, g_allin1trav_both1102)

# 1102 STUDENTS WHO DID NOT DO SINGLETRAVERSE OR NESTED TRAVERSE
g_diff_bins_other1102 <- tableGrob(diff_bins_other1102)
grob_title <- textGrob("1102 Students who did not do SingleTraverse or NestedTraverse")
grid.arrange(grob_title, g_diff_bins_other1102)


# FOR STUDENTS WITH 1101 BACKGROUND

# Compute midpoints of bars, for each structure in each bin; store in variable pos
bin_structs1101_midpoint <- group_by(bin_structs1101_count, Bin) %>%
  mutate(pos = cumsum(Counts) - (0.5 * Counts))

# Graph all structures, grouped by bin
g_all_solns1101 <- ggplot(data = bin_structs1101_midpoint, aes(x = Bin, y = Counts))
g_all_solns1101 + geom_bar(aes(fill = Structure), stat = "identity") +
  coord_flip() +
  ggtitle("CS2102: All solutions from students with 1101 background") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts, y = pos), color = "white")

# 1101 STUDENTS WITH SAME BINS FOR BOTH SOLUTIONS
g_same_bins1101 <- ggplot(data = same_bins_count1101, aes(x = Bin1, y = Counts))
g_same_bins1101 + geom_bar(aes(fill = Bin1), stat = "identity") +
  ggtitle("CS2102: 1101 Students with same bins for solutions 1, 2") +
  theme(legend.position = "bottom") +
  geom_text(aes(label = Counts), vjust = -0.5) +
  scale_y_continuous(limits = c(0,15))

# 1101 STUDENTS WITH DIFFERENT BINS, BUT ONE IN SINGLETRAVERSE/NESTEDTRAVERSE BIN
g_diff_bins_allin1trav1101 <- ggplot(data = diff_bins_allin1trav_count1101, aes(x = Bin2, y = Counts))
g_diff_bins_allin1trav1101 + geom_bar(aes(fill = Bin2), stat = "identity") + 
  ggtitle("CS2102: 1101 Students with [Single/Nested]Traverse as one of the solutions") +
  theme(legend.position = "bottom") + 
  geom_text(aes(label = Counts), vjust = -0.5) + 
  scale_y_continuous(limits = c(0,15)) +
  facet_grid(Bin1 ~ .)

# 1101 STUDENTS WITH DIFFERENT SOLUTIONS BUT BOTH IN ALLTOGETHER
g_allin1trav_both1101 <- tableGrob(allin1trav_both1101)
grob_title <- textGrob("1101 Students with different solutions but both in AllTogether")
grid.arrange(grob_title, g_allin1trav_both1101)

# 1101 STUDENTS WHO DID NOT DO SINGLETRAVERSE OR NESTED TRAVERSE
g_diff_bins_other1101 <- tableGrob(diff_bins_other1101)
grob_title <- textGrob("1101 Students who did not do SingleTraverse or NestedTraverse")
grid.arrange(grob_title, g_diff_bins_other1101)

