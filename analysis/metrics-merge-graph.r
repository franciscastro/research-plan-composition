#' ---
#' title: "Metrics Cited Analysis with Merged Graphs"
#' author: "Francisco Castro (fgcastro@wpi.edu)"
#' date: "20 April 2016"
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
setwd(working_dir)#; getwd()

# Set file names
metrics19 <- "metrics-cited-cs19.csv"
metrics2102 <- "metrics-cited-cs2102.csv"


#==================================================
# MASTER DATA SETUP
#==================================================

# Read file
metrics_data19 <- read.csv(metrics19)
metrics_data2102 <- read.csv(metrics2102)

# Convert column types as needed: 19 data
metrics_data19$id         <- as.character(metrics_data19$id)
metrics_data19$study_id   <- as.character(metrics_data19$study_id)
metrics_data19$efficiency <- as.factor(metrics_data19$efficiency)
metrics_data19$structure  <- as.factor(metrics_data19$structure)
metrics_data19$aesthetics <- as.factor(metrics_data19$aesthetics)
metrics_data19$affective  <- as.factor(metrics_data19$affective)
metrics_data19$purple     <- NULL
metrics_data19$maintainability <- as.factor(metrics_data19$maintainability)
metrics_data19$pink       <- NULL

# Convert column types as needed: 2102 data
metrics_data2102$id         <- as.character(metrics_data2102$id)
metrics_data2102$study_id   <- as.character(metrics_data2102$study_id)
metrics_data2102$efficiency <- as.factor(metrics_data2102$efficiency)
metrics_data2102$structure  <- as.factor(metrics_data2102$structure)
metrics_data2102$aesthetics <- as.factor(metrics_data2102$aesthetics)
metrics_data2102$affective  <- as.factor(metrics_data2102$affective)
metrics_data2102$purple     <- NULL
metrics_data2102$maintainability <- as.factor(metrics_data2102$maintainability)
metrics_data2102$pink       <- NULL

# Set n-values for each StudyGroup (use either RAINFALL, SHOPPING, OR EARTHQUAKE)
n_19  <- nrow(metrics_data19[metrics_data19$problem == "rainfall",])


#==================================================
# EXTRACT RELATED DATA POINTS
#==================================================

# Create data frame for problem = rainfall
rainfall19 <- metrics_data19[metrics_data19$problem == "rainfall",]

# Create data frame with occurrence counts of each metric and '0' metric counts
rainfall19_count <- setDF(setDT(data.frame(colSums(!is.na(rainfall19))), keep.rownames = TRUE)[])
setnames(rainfall19_count, colnames(rainfall19_count), c("metric", "count"))
rainfall19_count <- rainfall19_count[5:10,]
rainfall19_count <- rbind(rainfall19_count, data.frame(metric = "none", count = sum(rainfall19[,"metric_count"] == 0)))
rainfall19_count$problem <- c("rainfall")
rainfall19_count <- rainfall19_count[,c(1,3,2)]


# Create data frame for problem = shopdisc
shopdisc19 <- metrics_data19[metrics_data19$problem == "shopdisc",]

# Create data frame with occurrence counts of each metric and '0' metric counts
shopdisc19_count <- setDF(setDT(data.frame(colSums(!is.na(shopdisc19))), keep.rownames = TRUE)[])
setnames(shopdisc19_count, colnames(shopdisc19_count), c("metric", "count"))
shopdisc19_count <- shopdisc19_count[5:10,]
shopdisc19_count <- rbind(shopdisc19_count, data.frame(metric = "none", count = sum(shopdisc19[,"metric_count"] == 0)))
shopdisc19_count$problem <- c("shopdisc")
shopdisc19_count <- shopdisc19_count[,c(1,3,2)]


# Create data frame for problem = earthquake
earthquake19 <- metrics_data19[metrics_data19$problem == "earthquake",]

# Create data frame with occurrence counts of each metric and '0' metric counts
earthquake19_count <- setDF(setDT(data.frame(colSums(!is.na(earthquake19))), keep.rownames = TRUE)[])
setnames(earthquake19_count, colnames(earthquake19_count), c("metric", "count"))
earthquake19_count <- earthquake19_count[5:10,]
earthquake19_count <- rbind(earthquake19_count, data.frame(metric = "none", count = sum(earthquake19[,"metric_count"] == 0)))
earthquake19_count$problem <- c("earthquake")
earthquake19_count <- earthquake19_count[,c(1,3,2)]


# Combine all count data frames
metrics19_count <- rbind(rainfall19_count, shopdisc19_count, earthquake19_count)
metrics19_count$percentage <- round(((metrics19_count$count / n_19) * 100),2)

# Remove metric_count rows
metrics19_count <- metrics19_count[!(metrics19_count$metric == "metric_count"),]

# Remove affective rows
metrics19_count <- metrics19_count[!(metrics19_count$metric == "affective"),]

#==================================================
# GRAPHS
# ==================================================

# Graph number of students for each metric
ggplot(data=metrics19_count, aes(x=metric, y=percentage, fill=problem)) + 
  coord_flip() + 
  geom_bar(stat='identity', position='dodge', colour="black") + 
  geom_text(aes(label=paste(percentage, "%")), 
            hjust=-0.2, 
            position=position_dodge(0.95), 
            size=3.5, 
            colour='deepskyblue4', 
            fontface='bold') +
  scale_y_continuous(limits=c(0,110), expand=c(0,0))+ 
  theme(legend.position=c(0.8,0.8), 
        legend.background=element_rect(size=0.5, linetype='solid', colour ='darkblue'), 
        axis.line=element_line(colour="black"), 
        panel.grid.major = element_blank(), 
        axis.ticks.x=element_blank(),
        axis.text = element_text(size=12),
        axis.title=element_text(size=14,face="bold")) +
  labs(fill='Problem', x='Criteria\n', y='\n% of Students Identifying each Criteria') + 
  scale_fill_manual(labels=c("Earthquake", "Rainfall", "Shopping Cart"), 
                    values=c("black", "white", "#56B4E9"), 
                    guide=guide_legend(reverse=TRUE))




