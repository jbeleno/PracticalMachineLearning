# Set the variable y to be a factor variable in both the training and test set.
# Then set the seed to 33833. Fit (1) a random forest predictor relating the 
# factor variable y to the remaining variables and (2) a boosted predictor 
# using the "gbm" method. Fit these both with the train() command in the 
# caret package.
# What are the accuracies for the two approaches on the test data set? 
# What is the accuracy among the test set samples where the two methods agree?
question1 <- function() {
    library(ElemStatLearn)
    library(caret)
    data(vowel.train)
    data(vowel.test)
    
    set.seed(33833)
    
    vowel.train$y <- as.factor(vowel.train$y)
    vowel.test$y <- as.factor(vowel.test$y)
    
    modelrf <- train(y ~ ., data = vowel.train, method = "rf")
    modelgbm <- train(y ~ ., data = vowel.train, method = "gbm")
    
    predictionRf <- predict(modelrf, newdata = vowel.test)
    predictionGbm <- predict(modelgbm, newdata = vowel.test)
    predDF <- data.frame(predictionRf, predictionGbm, y = vowel.test$y)
    
    confusionMatrix(predictionRf, vowel.test$y)$overall[1]
    confusionMatrix(predictionGbm, vowel.test$y)$overall[1]
    
    combPred <- sum(predictionRf[predDF$predictionRf == predDF$predictionGbm] == 
                        predDF$y[predDF$predictionRf == predDF$predictionGbm]) / 
                        sum(predDF$predictionRf == predDF$predictionGbm)
    
    # combModel <- train(y ~ ., method="gam", data = predDF)
    # combPred <- round(predict(combModel, predDF))
    
    # errores <- c(sqrt(mean((predictionRf - vowel.test$y)^2)),
    #             sqrt(mean((predictionGbm - vowel.test$y)^2)),
    #             sqrt(mean((combPred - vowel.test$y)^2)))
    
    # errores
}

# Set the seed to 62433 and predict diagnosis with all the other variables 
# using a random forest ("rf"), boosted trees ("gbm") and linear discriminant 
# analysis ("lda") model. Stack the predictions together using random forests 
# ("rf"). What is the resulting accuracy on the test set? Is it better or 
# worse than each of the individual predictions?
question2 <- function() {
    library(caret)
    
    library(gbm)
    
    set.seed(3433)
    
    library(AppliedPredictiveModeling)
    
    data(AlzheimerDisease)
    
    adData = data.frame(diagnosis,predictors)
    
    inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
    
    training = adData[ inTrain,]
    
    testing = adData[-inTrain,]
    
    set.seed(62433)
    
    modelRf <- train(diagnosis ~ ., data = training, method = "rf")
    modelGbm <- train(diagnosis ~ ., data = training, method = "gbm")
    modelLda <- train(diagnosis ~ ., data = training, method = "lda")
    
    predictionRf <- predict(modelRf, newdata = testing)
    predictionGbm <- predict(modelGbm, newdata = testing)
    predictionLda <- predict(modelLda, newdata = testing)
    
    confusionMatrix(predictionRf, testing$diagnosis)$overall[1]
    confusionMatrix(predictionGbm, testing$diagnosis)$overall[1]
    confusionMatrix(predictionLda, testing$diagnosis)$overall[1]
    
    predDF <- data.frame(predictionRf, predictionGbm, predictionLda, diagnosis = testing$diagnosis)
    modelComb <- train(diagnosis~., data=predDF, method="rf")
    predictionComb <- predict(modelComb, testing)
    confusionMatrix(predictionComb, testing$diagnosis)$overall[1]
}

# Set the seed to 233 and fit a lasso model to predict Compressive Strength. 
# Which variable is the last coefficient to be set to zero as the penalty increases? 
# (Hint: it may be useful to look up ?plot.enet).
question3 <- function() {
    set.seed(3523)
    
    library(AppliedPredictiveModeling)
    
    data(concrete)
    
    inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
    
    training = concrete[ inTrain,]
    
    testing = concrete[-inTrain,]
    
    set.seed(233)
    
    model <- train(CompressiveStrength ~ ., data = training, method = "lasso")
    plot.enet(model$finalModel,xvar="penalty", use.color=TRUE)
}

# Fit a model using the bats() function in the forecast package to the training 
# time series. Then forecast this model for the remaining time points. For how 
# many of the testing points is the true value within the 95% prediction 
# interval bounds?
question4 <- function() {
    library(lubridate) # For year() function below
    
    dat = read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"))
    
    training = dat[year(dat$date) < 2012,]
    
    testing = dat[(year(dat$date)) > 2011,]
    
    tstrain = ts(training$visitsTumblr)
    
    library(forecast)
    nTestinRows <- nrow(testing)
    model <- bats(tstrain)
    fcast <- forecast(model, level = 95, nTestinRows)
    
    result <- sum(fcast$lower < testing$visitsTumblr & testing$visitsTumblr < fcast$upper)/nTestinRows
    
}

# Set the seed to 325 and fit a support vector machine using the e1071 package to 
# predict Compressive Strength using the default settings. Predict on the testing 
# set. What is the RMSE?
question5 <- function() {
    library(caret)
    library("e1071")
    set.seed(3523)
    
    library(AppliedPredictiveModeling)
    
    data(concrete)
    
    inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
    
    training = concrete[ inTrain,]
    
    testing = concrete[-inTrain,]
    
    set.seed(325)
    model <- svm(CompressiveStrength ~ ., data = training)
    predictionSvm <- predict(model, testing)
    rmse <- sqrt(mean((predictionSvm - testing$CompressiveStrength)^2))
    rmse
}
