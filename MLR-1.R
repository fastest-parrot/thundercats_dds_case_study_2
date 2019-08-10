
#Create a Task. Make a Learner. Train Them.

install.packages("mlr")
install.packages("mlbench")

library(mlr)
library(mlbench)

attrition_data = read.csv('../skennedy/thundercats_dds_case_study_2/atttrition.csv')


data(attrition_data, package="mlbench")

head(attrition_data)

#need to specify target variable for supervised learning
#for classification, the column has to be a factor
regr.task = makeRegrTask(id = "attrition", data = attrition_data, target = "Attrition")

#basic info of a task
getTaskDesc(regr.task)

### List everything in mlr --> classification in this case
lrns = listLearners()
head(lrns[c("class", "package")])

### Get the number of observations
n = getTaskSize(regr.task)

### Use 1/3 of the observations for training
#train.set = sample(n, size = n/3)
#train.set

#use every second observation for testing and for training 

train.set = seq(1, n, by = 2)
test.set = seq(2, n, by = 2)

#train the learner
mod = train("regr.lm", regr.task, subset = train.set)
mod

#predict on the test set
task.pred = predict(mod, task=regr.task, subset = test.set)
task.pred

#access the prediction
head(as.data.frame(task.pred))

head(getPredictionTruth(task.pred))

head(getPredictionResponse(task.pred))

