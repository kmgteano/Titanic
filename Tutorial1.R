# 14 May 2015
# Titanic: Getting Started with R
# Inspired by Trevor Stephens

library(rpart)

# Read in data sets
train <- read.csv("train.csv")
test <- read.csv("test.csv")

# Define n (number of observations)
train_n <- length(train$PassengerId)
test_n <- length(test$PassengerId)

# Initialize: everyone dies. 
test$Survived <- 0

# Let's make a decision tree.

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Let's use the decision tree.

Prediction <- predict(fit, test, type="class")

### Create CSV to submit
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submission.csv", row.names = FALSE)