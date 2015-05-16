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

# Initialize: we just don't know. 
test$Survived <- NA

# Combine data sets.
combined <- rbind(train, test)

### FEATURE ENGINEERING ON COMBINED DATA FRAME

# Extract titles
combined$Name <- as.character(combined$Name)
combined$Title <- sapply(combined$Name, FUN=function(x) {strsplit(x,split='[,.]')[[1]][2]})
combined$Title <- sub(' ','',combined$Title)

# Group rare titles together
combined$Title[combined$Title %in% c('Capt','Col','Don','Major','Sir')] <- 'Sir'
combined$Title[combined$Title %in% c('Lady','Dona','the Countess')] <- 'Lady'
combined$Title[combined$Title %in% c('Mme','Mrs')] <- 'Mrs'
combined$Title[combined$Title %in% c('Ms','Miss','Mlle')] <- 'Miss'
combined$Title[combined$Title %in% c('Master','Jonkheer')] <- 'Master'

# Turn title into a factor
combined$Title <- factor(combined$Title)

### RE-BREAK DATA INTO TEST VS TRAIN
train <- combined[1 : train_n,]
test <- combined[(train_n + 1):(train_n + test_n),]

# Let's make a decision tree.

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title, data = train, method = "class")

# Let's use the decision tree.

test$Survived <- predict(fit, test, type="class")

### Create CSV to submit
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "submission.csv", row.names = FALSE)