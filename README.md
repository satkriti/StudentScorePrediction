# StudentScorePrediction
Prediction of student's score based on number of hours studied

This is a supervised learning model created to predict percentage of students based on their respective studied hours.

First I look for data types and empty values using -> str(dataset_name) and apply function.
After learning that there are no empty values and only continuous data is present, I find out the resultant variable and the independent variables.
Here, there are just two features present, so, Scores is the dependent variable and Hours is the independent variable.
(Since hours define how the student would score in the exam)

Then we look for outliers using ggplot (library - ggplot2)
boxplot - used for outliers 

code: ggplot(data = s_data, aes(x = Scores, y = Hours)) + geom_boxplot()#no outliers

scatterplot - used to verify if it is a linear regression

code: ggplot(data = s_data, aes(x = Scores, y = Hours)) + geom_point() #yes it is

This is a supervised learning model, output is known. 
So, we can split the data based on resultant variable (Scores) into two set - using SplitRatio (from caTools package):
1. training set - named as trainingdata, where higher ratio of the data goes
2. test set - named as testingdata, where lower ratio of the split data goes

code: 

sample = sample.split(s_data$Scores, SplitRatio = 0.70)

trainingdata = subset(s_data, sample == 'TRUE')

testingdata = subset(s_data, sample =='FALSE')

I have used linear regression to create the model using syntax -  lm(DV~IV, data = yourtrainingdatasetName)

code: percentageModel = lm(Scores~Hours , data = trainingdata)

Then, I've predicted the model using test set
code: predictedScore = predict(percentageModel, testingdata_new)

Now I've added this predictedScore value in Testingdata
code: testingdata$PredScores = predictedScore

Now it's cruicial that we validate our models.
I have tested my models using MAE(Mean Absolute Error) and MAPE(Mean Absolute Percentage Error)

Lower the MAE, the better is the model. My MAE score = 4.5
MAPE less than .05 - acceptably accurate.  (.10 < MAPE < .25 indicates low, but acceptable accuracy. MAPE>.25 is unacceptable) My MAPE = 0.08

code: 

MAE(predictedScore, testingdata$Scores) 

MAPE(predictedScore, testingdata$Scores)

#I have used filter function(part of dplyr package) to find out the predicted score if student studies for 9.2 hours

code: a = filter(testingdata, Hours == 9.2 )$PredScores


The code is build in R, the data used is saved as a csv file named 'studentscore.csv'.


