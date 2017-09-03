# Getting the data
training_data_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
raw_df <- read.csv(training_data_url, header=T, sep = ",", na.strings = c("", "NA"))
# dim(raw_df) 160 variables

# Feature selection

# Removing variables with too much NA
na_threshold = 0.2
accepted_size <- nrow(raw_df)*na_threshold
na_values_per_column <- colSums(is.na(raw_df))
tidy_df <- raw_df[, na_values_per_column < accepted_size] 
# dim(tidy_df) 60 variables

library(plyr)
count(training$classe) # The possibles values for the outcome variable is "almost" equally distributed 

library(caret)

# Spliting the data in training and testing set
set.seed(0328)
inTrain = createDataPartition(tidy_df$classe, p = 3/4)[[1]]
training = tidy_df[ inTrain,]
testing = tidy_df[-inTrain,]

# Defining a general train control
tc <- trainControl(method = "cv", number = 5)

# Random Forest
model <- train(classe ~ .,data=training,method="rf",trControl= tc)

# Prediction
predictionRf <- predict(model, newdata = testing)

# Estimated accuracy out of the sample
confusionMatrix(predictionRf, testing$classe)$overall[1]

# Getting validation data
validation_data_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
columns <- colnames(tidy_df)
columns <- columns[columns != "classe"]
raw_validation <- read.csv(validation_data_url, header=T, sep = ",", na.strings = c("", "NA"))
validation <- raw_validation[, columns]

# Predict validation dataset

predictionRfValidation <- predict(model, newdata = validation)



