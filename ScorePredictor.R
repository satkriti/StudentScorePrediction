#Q1: Problem statement: PREDICT PERCENTAGE BASED ON STUDY HOURS
#Q2: WHAT IS PREDICTED SCORE IF STUDENT STUDIES 9.25 HOURS PER DAY

s_data = read.csv("studentscore.csv")
#EDA: 

dim(s_data)
head(s_data)
str(s_data)
#no missing vals
apply(s_data, 2, function(x) sum(is.na(x)))

summary(s_data)

#understanding:score is the DV/RV and hours is independent
library(ggplot2)
ggplot(data = s_data, aes(x = Scores, y = Hours)) + geom_boxplot() #no outliers

#can we build a Linear Reg model?
ggplot(data = s_data, aes(x = Scores, y = Hours)) + geom_point() #yes we can

library(caTools)
sample = sample.split(s_data$Scores, SplitRatio = 0.70)

trainingdata = subset(s_data, sample == 'TRUE')
testingdata = subset(s_data, sample =='FALSE')


#now that data is divided, we will create a model
library(MLmetrics)
percentageModel = lm(Scores~. , data = trainingdata)
summary(percentageModel)

#predict this model using testset
#before that remove dependent variable from test set
testingdata_new = testingdata[-2]

#now testing
predictedScore = predict(percentageModel, testingdata_new)
checkTable = cbind(Actual = testingdata$Scores, Predicted = predictedScore)

#add this predictedScore value in Testingdata
testingdata$PredScores = predictedScore


#Evaluating the model through MAE and MAPE
MAE(predictedScore, testingdata$Scores) 
MAPE(predictedScore, testingdata$Scores) 

#ANSWER 1 : predicted percentage based on hours = PredScore column in testingdata

#ANSWER FOR Q2: WHAT IS PREDICTED SCORE IF STUDENT STUDIES 9.25 HOURS PER DAY
library(dplyr)
a = filter(testingdata, Hours == 9.2 )$PredScores
a #so when hours = 9.2, predicted score = 91.61

