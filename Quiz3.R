question1 <- function() {
    library(AppliedPredictiveModeling)
    data(segmentationOriginal)
    library(caret)
    
    # I'm assuming a partition 70% for training and 30% for testing
    trainIndex = createDataPartition(segmentationOriginal$Case, p = 0.70,list=FALSE)
    training <- segmentationOriginal[trainIndex,]
    testing <- segmentationOriginal[-trainIndex,]
    
    set.seed(125)
    
    modFit <- train(Case ~ ., method = "rpart", data = training)
    
    library(rattle)
    fancyRpartPlot(modFit$finalModel)
}

# If K is small in a K-fold cross validation is the bias in the estimate of 
# out-of-sample (test set) accuracy smaller or bigger? If K is small is the 
# variance in the estimate of out-of-sample (test set) accuracy smaller or 
# bigger. Is K large or small in leave one out cross validation?
# Answer: The bias is smaller and the variance is bigger. Under leave one 
# out cross validation K is equal to one.

# These data contain information on 572 different Italian olive oils from 
# multiple regions in Italy. Fit a classification tree where Area is the 
# outcome variable. Then predict the value of area for the following data 
# frame using the tree command with all defaults
# What is the resulting prediction? Is the resulting prediction strange? 
# Why or why not?
question3 <- funtion() {
    library(pgmm)
    data(olive)
    library(caret)
    
    olive = olive[,-1]
    
    newdata = as.data.frame(t(colMeans(olive)))
    
    # I'm assuming a partition 70% for training and 30% for testing
    trainIndex = createDataPartition(olive$Area, p = 0.70,list=FALSE)
    training <- olive[trainIndex,]
    testing <- olive[-trainIndex,]
    
    modFit <- train(Area ~ ., method = "rpart", data = training)
    
    predict(modFit, newdata = newdata)
    
    # 2.783. It is strange because Area should be a qualitative variable 
    # - but tree is reporting the average value of Area as a numeric 
    # variable in the leaf predicted for newdata
}

# Then set the seed to 13234 and fit a logistic regression model 
# (method="glm", be sure to specify family="binomial") with Coronary Heart
# Disease (chd) as the outcome and age at onset, current alcohol consumption, 
# obesity levels, cumulative tabacco, type-A behavior, and low density 
# lipoprotein cholesterol as predictors. Calculate the misclassification rate 
# for your model using this function and a prediction on the "response" scale:
# What is the misclassification rate on the training set? What is the 
# misclassification rate on the test set?
question4 <- function() {
    library(caret)
    library(ElemStatLearn)
    data(SAheart)
    set.seed(8484)
    train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
    trainSA = SAheart[train,]
    testSA = SAheart[-train,]
    
    set.seed(13234)
    
    modFit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, method="glm", family="binomial", data = trainSA)
    prediction <- predict(modFit, newdata = testSA)
    values <- testSA$chd
    
    trainPrediction <- predict(modFit, newdata = trainSA)
    trainValues <- trainSA$chd
    
    missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
    
    missClass(trainValues, trainPrediction) # 0.2727273
    missClass(values, prediction) # 0.3116883
}

question5 <- function() {
    library(ElemStatLearn)
    data(vowel.train)
    data(vowel.test)
    library(randomForest)
    
    vowel.test$y <- as.factor(vowel.test$y)
    vowel.train$y <- as.factor(vowel.train$y)
    
    set.seed(33833)
    
    model <- randomForest(y ~ ., data = vowel.train)
    varImp(model)
}
