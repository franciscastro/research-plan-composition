
# CHECK SIGNIFICANCE OF PARSING USE

coding_data1 <- read.csv("coding-19-adding.csv")
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

parse19 <- coding_data1[,c("StudyID", "Structure")]
parse19$Structure <- ifelse(grepl("Parse", parse19$Structure), "1", "0")
parse19$Structure <- as.factor(parse19$Structure)
parse19$Earthquake <- c(1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1)
parse19$Earthquake <- as.factor(parse19$Earthquake)
setnames(parse19, c("Structure"), c("Adding"))

# Generate contingency table
cont_table <- table(parse19[, c("Adding", "Earthquake")])
# tbl <- table(parse19$Adding, parse19$Earthquake)
print(cont_table)

# McNemar test
mcnemar.test(cont_table)





# METRICS TEST

# metrics_data19 <- read.csv("metrics-cited-cs19.csv")
# # Convert column types as needed: 19 data
# metrics_data19$id         <- as.character(metrics_data19$id)
# metrics_data19$study_id   <- as.character(metrics_data19$study_id)
# metrics_data19$efficiency <- as.integer(metrics_data19$efficiency)
# metrics_data19$structure  <- as.factor(metrics_data19$structure)
# metrics_data19$aesthetics <- as.factor(metrics_data19$aesthetics)
# metrics_data19$affective  <- as.factor(metrics_data19$affective)
# metrics_data19$purple     <- NULL
# metrics_data19$maintainability <- as.integer(metrics_data19$maintainability)
# metrics_data19$pink       <- NULL
# 
# rainfall19 <- metrics_data19[metrics_data19$problem == "rainfall", c("id","efficiency","maintainability")]
# rainfall19[is.na(rainfall19)] <- 0; rainfall19 <- rainfall19[order(rainfall19$id),]
# 
# shopdisc19 <- metrics_data19[metrics_data19$problem == "shopdisc", c("id","efficiency","maintainability")]
# shopdisc19[is.na(shopdisc19)] <- 0; shopdisc19 <- shopdisc19[order(shopdisc19$id),]
# 
# earthquake19 <- metrics_data19[metrics_data19$problem == "earthquake", c("id","efficiency","maintainability")]
# earthquake19[is.na(earthquake19)] <- 0; earthquake19 <- earthquake19[order(earthquake19$id),]


# CHECK SIGNIFICANCE OF DROP IN EFFICIENCY

# efficiency19 <- rainfall19[,c("id","efficiency")]
# efficiency19$efficiency <- ifelse(rainfall19$efficiency == shopdisc19$efficiency, rainfall19$efficiency,
#                                 ifelse(rainfall19$efficiency == 1 | shopdisc19$efficiency == 1, 1, 0))
# efficiency19$Post <- earthquake19$efficiency
# setnames(efficiency19, c("efficiency"), c("Pre"))
# cont_table_eff <- table(efficiency19[, c("Pre", "Post")])
# 
# print(cont_table_eff)
# mcnemar.test(cont_table_eff)


# CHECK SIGNIFICANCE OF GROWTH IN MAINTAINABILITY

# maintainability19 <- rainfall19[,c("id","maintainability")]
# maintainability19$maintainability <- ifelse(rainfall19$maintainability == shopdisc19$maintainability, rainfall19$maintainability,
#                                   ifelse(rainfall19$maintainability == 1 | shopdisc19$maintainability == 1, 1, 0))
# maintainability19$Post <- earthquake19$maintainability
# setnames(maintainability19, c("maintainability"), c("Pre"))
# cont_table_main <- table(maintainability19[, c("Pre", "Post")])
# 
# print(cont_table_main)
# mcnemar.test(cont_table_main)

