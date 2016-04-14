#' ---
#' title: "CS[2102/19] Preference Analysis"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "06 April 2016"
#' ---


#==================================================
# NOTES AND DEPENDENCIES
#==================================================

# This script is for plotting the survey responses of students. 

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
setwd(working_dir); getwd()

# Set file names
file_name1 <- "preference-ranking-cs19-edit.csv"
file_name2 <- "preference-ranking-cs2102.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
pref_data1 <- read.csv(file_name1)
pref_data2 <- read.csv(file_name2)

# Convert column types as needed
pref_data1$id <- as.character(pref_data1$id)
pref_data1$study_id <- as.character(pref_data1$study_id)
pref_data1$efficiency <- as.factor(pref_data1$efficiency)
pref_data1$structure <- as.factor(pref_data1$structure)
pref_data1$aesthetics <- as.factor(pref_data1$aesthetics)
pref_data1$affective <- as.factor(pref_data1$affective)
pref_data1$purple <- as.factor(pref_data1$purple)
pref_data1$maintainability <- as.factor(pref_data1$maintainability)
pref_data1$pink <- as.factor(pref_data1$pink)

pref_data2$id <- as.character(pref_data2$id)
pref_data2$study_id <- as.character(pref_data2$study_id)
pref_data2$efficiency <- as.factor(pref_data2$efficiency)
pref_data2$structure <- as.factor(pref_data2$structure)
pref_data2$aesthetics <- as.factor(pref_data2$aesthetics)
pref_data2$affective <- as.factor(pref_data2$affective)
pref_data2$purple <- as.factor(pref_data2$purple)
pref_data2$maintainability <- as.factor(pref_data2$maintainability)
pref_data2$pink <- as.factor(pref_data2$pink)

# Get data information
# str(pref_data1) ; summary(pref_data1)
# str(pref_data2) ; summary(pref_data2)


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# RAINFALL: CS19

# Create data frame for problem = rainfall
rainfall <- pref_data1[pref_data1$problem == "rainfall",]

# Create data frame with occurrence counts of each metric and '0' metric counts
rainfall_count <- setDT(data.frame(colSums(!is.na(rainfall))), keep.rownames = TRUE)[]
setnames(rainfall_count, colnames(rainfall_count), c("metric", "count"))
rainfall_count <- rainfall_count[5:11,]
rainfall_count <- rbind(rainfall_count, 
                        data.frame(metric = "none", count = sum(rainfall[,"metric_count"] == 0)))


# SHOPPING DISCOUNT: CS19

# Create data frame for problem = shopdisc
shopdisc <- pref_data1[pref_data1$problem == "shopdisc",]

# Create data frame with occurrence counts of each metric and '0' metric counts
shopdisc_count <- setDT(data.frame(colSums(!is.na(shopdisc))), keep.rownames = TRUE)[]
setnames(shopdisc_count, colnames(shopdisc_count), c("metric", "count"))
shopdisc_count <- shopdisc_count[5:11,]
shopdisc_count <- rbind(shopdisc_count, 
                        data.frame(metric = "none", count = sum(shopdisc[,"metric_count"] == 0)))


# EARTHQUAKE: CS19

# Create data frame for problem = earthquake
earthquake1 <- pref_data1[pref_data1$problem == "earthquake",]

# Create data frame with occurrence counts of each metric and '0' metric counts
earthquake_count1 <- setDT(data.frame(colSums(!is.na(earthquake1))), keep.rownames = TRUE)[]
setnames(earthquake_count1, colnames(earthquake_count1), c("metric", "count"))
earthquake_count1 <- earthquake_count1[5:11,]
earthquake_count1 <- rbind(earthquake_count1, 
                        data.frame(metric = "none", count = sum(earthquake1[,"metric_count"] == 0)))


# RAINFALL-EARTHQUAKE: CS19

# Create data frame combining metric counts for rainfall & earthquake
rainfall_equake <- rainfall[,c("id", "problem", "metric_count")]
setnames(rainfall_equake, c("metric_count"), c("rfall_count"))
rainfall_equake$quake_count <- earthquake1$metric_count[match(rainfall_equake$id, earthquake1$id)]
rainfall_equake$change <- ifelse(rainfall_equake$rfall_count < rainfall_equake$quake_count, "increase", 
                                 ifelse(rainfall_equake$rfall_count == rainfall_equake$quake_count, 
                                        "same", "decrease"))

# Create data frame with counts of 'change' column
rainfall_equake_count <- data.frame(count(rainfall_equake, change))
setnames(rainfall_equake_count, c("n"), c("count"))

# Create data frame from rainfall_equake with change == 'same', 'increase', 'decrease'
rfall_equake_same <- rainfall_equake[rainfall_equake$change == "same",]
rfall_equake_incr <- rainfall_equake[rainfall_equake$change == "increase",]
rfall_equake_decr <- rainfall_equake[rainfall_equake$change == "decrease",]


# SHOPDISC-EARTHQUAKE: CS19

# Create data frame combining metric counts for rainfall & earthquake
shopdisc_equake <- shopdisc[,c("id", "problem", "metric_count")]
setnames(shopdisc_equake, c("metric_count"), c("shopdisc_count"))
shopdisc_equake$quake_count <- earthquake1$metric_count[match(shopdisc_equake$id, earthquake1$id)]
shopdisc_equake$change <- ifelse(shopdisc_equake$shopdisc_count < shopdisc_equake$quake_count, "increase", 
                                 ifelse(shopdisc_equake$shopdisc_count == shopdisc_equake$quake_count, 
                                        "same", "decrease"))

# Create data frame with counts of 'change' column
shopdisc_equake_count <- data.frame(count(shopdisc_equake, change))
setnames(shopdisc_equake_count, c("n"), c("count"))

# Create data frame from shopdisc_equake with change == 'same', 'increase', 'decrease'
shopdisc_equake_same <- shopdisc_equake[shopdisc_equake$change == "same",]
shopdisc_equake_incr <- shopdisc_equake[shopdisc_equake$change == "increase",]
shopdisc_equake_decr <- shopdisc_equake[shopdisc_equake$change == "decrease",]


# EARTHQUAKE: CS2102

# Create data frame for problem = earthquake
earthquake2 <- pref_data2[pref_data2$problem == "earthquake",]

# Create data frame with occurrence counts of each metric and '0' metric counts
earthquake_count2 <- setDT(data.frame(colSums(!is.na(earthquake2))), keep.rownames = TRUE)[]
setnames(earthquake_count2, colnames(earthquake_count2), c("metric", "count"))
earthquake_count2 <- earthquake_count2[5:11,]
earthquake_count2 <- rbind(earthquake_count2, 
                        data.frame(metric = "none", count = sum(earthquake2[,"metric_count"] == 0)))


#==================================================
# GRAPHS: COUNT NUMBER OF STUDENTS FOR EACH METRIC
#==================================================

# RAINFALL: CS19

# Graph number of students for each metric
g_rainfall <- ggplot(data = rainfall_count, aes(x = metric, y = count))
g_rainfall + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("CS19: Rainfall Metric Counts") +
  theme(legend.position = "right",
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


# SHOPPING DISCOUNT: CS19

# Graph number of students for each metric
g_shopdisc <- ggplot(data = shopdisc_count, aes(x = metric, y = count))
g_shopdisc + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("CS19: Shopping Discount Metric Counts") +
  theme(legend.position = "right",
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


# EARTHQUAKE: CS19

# Graph number of students for each metric
g_earthquake1 <- ggplot(data = earthquake_count1, aes(x = metric, y = count))
g_earthquake1 + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("CS19: Earthquake Metric Counts") +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) + 
  scale_y_continuous(limits = c(0,75))


# EARTHQUAKE: CS2102

# Graph number of students for each metric
g_earthquake2 <- ggplot(data = earthquake_count2, aes(x = metric, y = count))
g_earthquake2 + geom_bar(aes(fill = metric), stat = "identity") +
  ggtitle("CS2102: Earthquake Metric Counts") +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) + 
  scale_y_continuous(limits = c(0,75))


# RAINFALL-EARTHQUAKE CHANGE: CS19

# Graph change in metrics, pre to post
g_rfall_change <- ggplot(data = rainfall_equake_count, aes(x = change, y = count))
g_rfall_change + geom_bar(aes(fill = change), stat = "identity") +
  ggtitle("CS19: Rainfall-Earthquake Metric Changes") +
  theme(legend.position = "right") +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


# SHOPDISC-EARTHQUAKE CHANGE: CS19

# Graph change in metrics, pre to post
g_shopdisc_change <- ggplot(data = shopdisc_equake_count, aes(x = change, y = count))
g_shopdisc_change + geom_bar(aes(fill = change), stat = "identity") +
  ggtitle("CS19: ShopDisc-Earthquake Metric Changes") +
  theme(legend.position = "right") +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  scale_y_continuous(limits = c(0,75))


#==================================================
# FILE WRITING FOR ADDITIONAL ANALYSIS
#==================================================

# RAINFALL-EARTHQUAKE: CS19

# # Get entries from earthquake1 and rainfall for csv writing
# rfall_same1 <- earthquake1[match(rfall_equake_same$id, earthquake1$id),]
# rfall_same2 <- rainfall[match(rfall_equake_same$id, rainfall$id),]
# rfall_incr1 <- earthquake1[match(rfall_equake_incr$id, earthquake1$id),]
# rfall_incr2 <- rainfall[match(rfall_equake_incr$id, rainfall$id),]
# rfall_decr1 <- earthquake1[match(rfall_equake_decr$id, earthquake1$id),]
# rfall_decr2 <- rainfall[match(rfall_equake_decr$id, rainfall$id),]
# 
# # Write to csv for analysis
# write.csv(rfall_same1, file.path(working_dir, "rfall_same1.csv"), row.names = FALSE)
# write.csv(rfall_same2, file.path(working_dir, "rfall_same2.csv"), row.names = FALSE)
# write.csv(rfall_incr1, file.path(working_dir, "rfall_incr1.csv"), row.names = FALSE)
# write.csv(rfall_incr2, file.path(working_dir, "rfall_incr2.csv"), row.names = FALSE)
# write.csv(rfall_decr1, file.path(working_dir, "rfall_decr1.csv"), row.names = FALSE)
# write.csv(rfall_decr2, file.path(working_dir, "rfall_decr2.csv"), row.names = FALSE)

# SHOPDISC-EARTHQUAKE: CS19

# Get entries from earthquake1 and shopdisc for csv writing
shopdisc_same1 <- earthquake1[match(shopdisc_equake_same$id, earthquake1$id),]
shopdisc_same2 <- shopdisc[match(shopdisc_equake_same$id, shopdisc$id),]
shopdisc_incr1 <- earthquake1[match(shopdisc_equake_incr$id, earthquake1$id),]
shopdisc_incr2 <- shopdisc[match(shopdisc_equake_incr$id, shopdisc$id),]
shopdisc_decr1 <- earthquake1[match(shopdisc_equake_decr$id, earthquake1$id),]
shopdisc_decr2 <- shopdisc[match(shopdisc_equake_decr$id, shopdisc$id),]

# Write to csv for analysis
write.csv(shopdisc_same1, file.path(working_dir, "shopdisc_same1.csv"), row.names = FALSE)
write.csv(shopdisc_same2, file.path(working_dir, "shopdisc_same2.csv"), row.names = FALSE)
write.csv(shopdisc_incr1, file.path(working_dir, "shopdisc_incr1.csv"), row.names = FALSE)
write.csv(shopdisc_incr2, file.path(working_dir, "shopdisc_incr2.csv"), row.names = FALSE)
write.csv(shopdisc_decr1, file.path(working_dir, "shopdisc_decr1.csv"), row.names = FALSE)
write.csv(shopdisc_decr2, file.path(working_dir, "shopdisc_decr2.csv"), row.names = FALSE)

