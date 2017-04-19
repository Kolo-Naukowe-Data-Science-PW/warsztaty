#Warsztaty caret

install.packages("caret")
install.packages("e1071")
install.packages("data.table")
install.packages('glmnet')
install.packages('Matrix')
install.packages('leaps')
install.packages('mda')
install.packages('plyr')
library(caret)
library(e1071)
library(data.table)
library(glmnet)
library(Matrix)
library(leaps)
library(mda)
library(plyr)
###Preprocessing

data(cars)
cars<-data.table(cars)

#near zero variance
data(cars)
cars<-data.table(cars)
cars[,AUTO:=1]
nzv <- nearZeroVar(cars, saveMetrics= TRUE)
cars[121,AUTO:=0]
nzv <- nearZeroVar(cars, saveMetrics= TRUE)
cars[,AUTO:=NULL]



#correlations

descrCor <-  cor(cars)
summary(descrCor[upper.tri(descrCor)])
colscor<-findCorrelation(descrCor, cutoff = .75)
cars <- cars[,-colscor,with = FALSE]
descrCor2 <- cor(cars)
summary(descrCor2[upper.tri(descrCor2)])

#linear dependencies
data(cars)
cars<-data.table(cars)
comboInfo <- findLinearCombos(cars)

#centering, scaling
cars_train<-cars[1:floor(nrow(cars)*2/3)]
cars_test<-cars[floor(nrow(cars)*2/3+1):nrow(cars)]
preProcValues<-preProcess(cars_train[,list(Price)], method = c("center", "scale"))
predict(preProcValues, cars_train)
predict(preProcValues, cars_test)
preProcValues<-preProcess(cars_test[,list(Price)], method = c("range"))
qq<-predict(preProcValues, cars_train)
ll<-predict(preProcValues, cars_test)
#transforming variables
preProcValues<-preProcess(cars[,-(1:2),with = FALSE], method = c("pca"))
predict(preProcValues, cars)
preProcValues<-preProcess(cars[,list(Price)], method = c("BoxCox"))
predict(preProcValues, cars)

#nzv once more
cars[,AUTA:=1]
cars
preProcValues<-preProcess(cars, method = c("nzv"))
predict(preProcValues, cars)

cars[,AUTA:=NULL]

# Zad 1 na danych cox2 zrobic preprocessing

data(cox2)
coxik<-data.table(cox2Descr)
cox2Class
coxik[,ACTIVITY:=cox2Class]

##Splitting
set.seed(123)
trainIndex <- createDataPartition(cars$Price, p = .8, 
                                  list = FALSE, 
                                  times = 1)
head(trainIndex)


cars_train <- cars[ trainIndex,]
cars_test  <- cars[-trainIndex,]


#in time series
createTimeSlices(c(1:20),initialWindow = 5, horizon = 3,fixedWindow = TRUE)


#Zad2. podzielic zbior coxik na czesc treningowa i testowa

##Modelling

data(cars)
cars<-data.table(cars)

#first model

fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)


Fit1 <- train(Price ~ ., data = cars_train, 
                 method = "glmnet", 
                 trControl = fitControl)
Fit1

plot(Fit1)  
plot(Fit1, metric = "Rsquared")

Fit2 <- train(Price ~ ., data = cars_train, 
                    method = "leapSeq", 
                    trControl = fitControl)
Fit2


glmnetGrid <-  expand.grid(lambda = c(0,10,100),alpha=c(0,0.5,1))
Fit3 <- train(Price ~ ., data = cars_train, 
              method = "glmnet", 
              trControl = fitControl,
              tuneGrid = glmnetGrid)
Fit3



whichbest <- tolerance(Fit1$results, metric = "RMSE", maximize = FALSE) 
Fit3$results[whichbest,]

Fit3$finalModel$tuneValue

Fit4 <- train(Price ~ ., data = cars_train, 
              method = "glmnet", 
              trControl = fitControl,
              tuneGrid = glmnetGrid,
              metric = 'Rsquared')
Fit4$finalModel$tuneValue

#predictions
pred<-predict(Fit3, newdata = cars_test)

fitControl <- trainControl(method = "none")
Fit5 <- train(Price ~ ., data = cars_train, 
              method = "glmnet", 
              trControl = fitControl)
Fit5$finalModel$tuneValue
#https://topepo.github.io/caret/train-models-by-tag.html
#measures regression and classification
postResample(pred = pred, obs = cars_test$Price)
#measures classification probs

#twoClassSummary(test_set, lev = levels(test_set$obs))
#mnLogLoss(test_set, lev = levels(test_set$obs))


#variable importance

kk <- varImp(Fit3, scale = FALSE)
kk 

#LIFT Curves


set.seed(2)
lift_training <- twoClassSim(1000)
lift_testing  <- twoClassSim(1000)

ctrl <- trainControl(method = "cv", classProbs = TRUE,
                     summaryFunction = twoClassSummary)

set.seed(1045)
fda_lift <- train(Class ~ ., data = lift_training,
                  method = "fda", metric = "ROC",
                  tuneLength = 20,
                  trControl = ctrl)
set.seed(1045)
lda_lift <- train(Class ~ ., data = lift_training,
                  method = "lda", metric = "ROC",
                  trControl = ctrl)



## Generate the test set results
lift_results <- data.frame(Class = lift_testing$Class)
lift_results$FDA <- predict(fda_lift, lift_testing, type = "prob")[,"Class1"]
lift_results$LDA <- predict(lda_lift, lift_testing, type = "prob")[,"Class1"]

head(lift_results)


lift_obj <- lift(Class ~ FDA + LDA, data = lift_results)
plot(lift_obj, values = 60, auto.key = list(columns = 2,
                                            lines = TRUE,
                                            points = FALSE))


#Zad3 zrobic dobra klasyfikacje u coxik (podzial zbioru 2:1) miara dobroci AUC, narysowac krzywa LIFT.