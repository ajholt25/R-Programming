# load packages
require(pryr)
require(ISLR)
require(boot)
library(data.table)
library(plyr)

setwd("/Users/randomfluff/Documents/R-Programming")
# read in data from file
Students <- read.table("mod8Data.txt", header = TRUE, sep = ",")
str(Students)
head(Students)

# add a column mean of grade
Students <- ddply(Students, "Sex", transform, Grade.Average = mean(Grade))
head(Students)

sex = Students$Sex
mean(Students$Sex) # not numeric or logical, cannot take mean

# write results to a file
write.table(Students, "Students_Gendered_Mean")

# subset the data frame for students who have the letter i in their name
i_students <- subset(Students, grepl("[i]", Students$Name, ignore.case = TRUE))

# write the subset to a csv (comma separated) file
write.table(i_students, "i_students_mean", sep = ",")

#### dplyr version ####
students <- Students
students %>%
  group_by(Sex) %>%
  mutate(grade.average = mean(Grade))
students