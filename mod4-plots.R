# read in the data
er_data <- read.csv("er_patients.csv")
str(er_data)

# Create a box plot of BP
BP <- er_data$BP
boxplot(BP)
title("Distribution of BP for ER Patients")
boxplot(er_data$Freq)
title("Visit Frequency of ER Patients")
# Histogram of MD ratings
first <- er_data$First
second <- er_data$Second
decision <- er_data$FinalDecision
xmin <- min(first, second, decision)
xmax <- max(first, second, decision)

# Set up a side-by-side layout
par(mfrow = c(1,3))
# First Histogram
hist(first, main = "Histogram 1",  xlab = "Value", ylab = "Frequency", 
     col = "powderblue")

# Create the second histogram
hist(second, main = "Histogram 2", main = "External", xlab = "Value", ylab = "Frequency",
     col = "pink")
# Create the third histogram
hist(decision, main = "Histogram 2", main = "ER Dept Head", xlab = "Value", ylab = "Frequency",
     col = "grey", )
