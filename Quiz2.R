# Which of the following commands will create non-overlapping training and test 
# sets with about 50% of the observations assigned to each?
question1 <- function() {
    library(AppliedPredictiveModeling)
    data(AlzheimerDisease)
    
    adData = data.frame(diagnosis,predictors)
    trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
    training = adData[trainIndex,]
    testing = adData[-trainIndex,]
}

# Make a plot of the outcome (CompressiveStrength) versus the index of the 
# samples. Color by each of the variables in the data set (you may find the 
# cut2() function in the Hmisc package useful for turning continuous 
# covariates into factors). What do you notice in these plots?
question2 <- function() {
    library(AppliedPredictiveModeling)
    data(concrete)
    library(caret)
    set.seed(1000)
    inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
    training = mixtures[ inTrain,]
    testing = mixtures[-inTrain,]
    
    dim(training) # 774 9
    summary(training)
    
    library(Hmisc)
    covariates <- colnames(training)
    covariates <- covariates[covariates != "CompressiveStrength"]
    
    cut <- cut2(training[,covariates[1]])
    labelx <- paste0("index, colour=",covariates[1])
    plot(training$CompressiveStrength, pch=19, col=cut, xlab=labelx, ylab="CompressiveStrength")
}

# Make a histogram and confirm the SuperPlasticizer variable is skewed. 
# Normally you might use the log transform to try to make the data more 
# symmetric. Why would that be a poor choice for this variable?
# This data is highly skewed, hence, it is hard to try to neutralize it.
question3 <- function() {
    library(AppliedPredictiveModeling)
    data(concrete)
    library(caret)
    set.seed(1000)
    inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
    training = mixtures[ inTrain,]
    testing = mixtures[-inTrain,]
    
    hist(training[, "Superplasticizer"])
}

# Find all the predictor variables in the training set that begin with IL. 
# Perform principal components on these variables with the preProcess() 
# function from the caret package. Calculate the number of principal components 
# needed to capture 90% of the variance. How many are there?
question4 <- function() {
    library(caret)
    library(AppliedPredictiveModeling)
    set.seed(3433)
    data(AlzheimerDisease)
    adData = data.frame(diagnosis,predictors)
    inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
    training = adData[ inTrain,]
    testing = adData[-inTrain,]
    
    IlColNames = grep("^IL", colnames(training), value=TRUE,ignore.case=TRUE)
    preProc <- preProcess(training[,IlColNames], method="pca", thresh=0.9)
    preProc # 9
}

# Create a training data set consisting of only the predictors with variable 
# names beginning with IL and the diagnosis. Build two predictive models, 
# one using the predictors as they are and one using PCA with principal 
# components explaining 80% of the variance in the predictors. Use method="glm" 
# in the train function.
question5 <- function() {
    library(caret)
    library(AppliedPredictiveModeling)
    set.seed(3433)
    data(AlzheimerDisease)
    adData = data.frame(diagnosis,predictors)
    inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
    training = adData[ inTrain,]
    testing = adData[-inTrain,]
    
    IlColNames = grep("^IL", colnames(training), value=TRUE,ignore.case=TRUE)
    trainingIl <- data.frame(training[,IlColNames], training$diagnosis)
    testingIl <- data.frame(testing[, IlColNames], testing$diagnosis)
    
    ctrl <- trainControl(preProcOptions = list(thresh = 0.8))
    modelPcaFit <- train(training.diagnosis ~ ., method="glm", preProcess="pca", trControl= ctrl, data = trainingIl)
    confusionMatrix(testingIl$testing.diagnosis, predict(modelPcaFit, testingIl))
    # PCA: Accuracy: 71.95%
    
    modelFit <- train(training.diagnosis ~ ., method="glm", data = trainingIl)
    confusionMatrix(testingIl$testing.diagnosis, predict(modelFit, testingIl))
    # Without PCA: 64.63%
}
