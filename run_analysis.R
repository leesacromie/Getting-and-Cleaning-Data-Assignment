## This script will read in the required files from the downloaded folder UCI
## HAR Dataset.Once read the files will be clean and display as requested in the
## Getting and Cleaning Data Assignment. The accompanying read me and code book
## will explain the steps taken to clean and present the data.

library(dplyr)

## Reading in 8 files required to clean the UCI HAR Dataset
testdata<- read.table("X_test.txt")
traindata<-read.table("X_train.txt")
features<- read.table("features.txt")
activity<- read.table("activity_labels.txt")
testsubjectid<- read.table("subject_test.txt")
trainsubjectid<- read.table("subject_train.txt")
testactivity<- read.table("y_test.txt")
trainactivity<- read.table("y_train.txt")

## Part 1 of the assignment combine test and training data 
alldata<- rbind(testdata, traindata)

## Assigning the features to for measure variables to the column names,
## removing punctuation and upper case.
features[,2]<-tolower(features[,2])
colnames(alldata) <- features[,2]
colnames(alldata) <- gsub("[[:punct:][:blank:]]", "", names(alldata))

## Part 2 Extracting only measurements for with mean and std only
## this variable is called meanstddata.

meanstddata<-alldata[, grepl("mean|std", colnames(alldata))]
meanstddata<-meanstddata[, !grepl("jerk|^f|mag|angle", colnames(meanstddata))]

## Add subject Id for each observation to the meanstddata

allsubjects<-rbind(testsubjectid, trainsubjectid)
colnames(allsubjects)<-"subjectid"
meanstddata<-cbind(allsubjects, meanstddata)

## Part 3 Combine all activity into one dataset and labels them with the
## activity table. The labels have been made lower case and "_" removed.

allactivities<-rbind(testactivity, trainactivity)
colnames(allactivities)<-"activity"
colnames(activity)<-c("code","activity")
meanstddata<-cbind(allactivities, meanstddata)
meanstddata<-merge(activity, meanstddata, by.x="code", by.y="activity",all=TRUE)
meanstddata[,2]<-tolower(meanstddata[,2])
meanstddata[,2]<- gsub("_", "", meanstddata[,2])
meanstddata<-select(meanstddata, !code)

## Part 4 descriptive names have been given to all variable as data has been
## added as the read files have been manipulated

## Part 5 This groups by acticity and then subject and then find the mean for
## all measurements savinf this as .csv file called finaldataset.

meanbyactivitysubject<-meanstddata %>% 
  group_by(activity,subjectid) %>% 
    summarise_all(mean)

write.table(meanbyactivitysubject, "finaldataset.txt")
