# 14 May 2015
# Titanic: Getting Started with R
# Inspired by Trevor Stephens

# Read in data sets
train <- read.csv("train.csv")
test <- read.csv("test.csv")

# Define n (number of observations)
train_n <- length(train$PassengerId)
test_n <- length(test$PassengerId)

# Initialize: everyone dies. 
test$Survived <- rep(0, test_n)


### Create CSV to submit
submit <- data.frame(PassengerId = test$PassengerId, Survied = test$Survived)
write.csv(submit, file = "submission.csv", row.names = FALSE)