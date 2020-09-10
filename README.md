# Getting-and-Cleaning-Data-Assignment

## Introduction

This README.md will provide instruction on how the run.anaylsis.R file gets and cleans the data of the HAR UCI Dataset. The initial codebooks and Read me files as well as the data can be found at the following link [HAR UCI.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Step by Step Guide to run_analysis.R

The assignment has the following parts:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps 1 - 11 will explain how these steps have been achieved as well as how to read the resultant dataset from Part 5 into R. Please use the code book called **Assignement Code Book** to understand the labels for the varible as well as the intial supporting data in the HAR UCI Data set.

### Step 1
The first step is reading into R the required files data files. There are 8 in total, some one which will be used to provide descriptive names to variables or hold data observations.
### Step 2
Combines all the observations from both the test and train data observations set, into a object called **alldata**. This has been done using rbind with the test data being loaded first and train data loaded second.
### Step 3
The features data has now been assigned to the column names of the**alldata** object generated above. In this step the tolower and gsub commands have been utilized to remove punctuation and uppercases from**alldata**. 
### Step 4
Now that the names of the columns have been assigned in Step 3. Part 2 of the assingment asks for only the measurements for mean and std be extracted. There are a total of 561 features that have been captured in this dataset. As discussed in the original Readme.text file and features_info file, there are 9 measurements that haven't been calculated or manipulated from the original data. These are **Body Acceleration, Gravity Acceleration and Gryoscope Acceleration** in each of the the 3 axis (x, y and z). As such only the mean and the std of these 9 measurements has been extracted from the data. This has been done using the grepl function, with the resulting dataframe labeled **meanstddata**
### Step 5.
The next step combines all the subjects for test and train into one subject dataframe called **allsubjects** using rbind, with test being loaded first and then train data. The column name is assigned the label **subjectid**. **allsubjects** is combined with **alldata** using cbind, with **subjectid** first and **alldata** second. Now subject id is associated with the observations of features in the **meanstddata** object.
### Step 6.
This step combines the activitiy data for the test and train into one using the rbind with test first and train second. This is assigned to object **allactivities**.
Once the activities have been combined, they are assigned the label **activity**. 
### Step 7.
The activity data has two columns and these are now assigned the names **code** and **activity**
### Step 8.
The **allactiviies** dataframe is them combined using cbind with **meanstddata**, with **allactivities** first and **meanstddata** second.
## Step 9 .
The **activity** object is then merged with **meanstdata** object using the code column and activity columns of **activity** and **meanstddata** respectively. The activitites are made lower case and _ is removed to ensure the activity labels are descriptive, see the code book for more details. This is done using first the tolower function and then the gsub function. The code column is then removed as it is no longer required in the dataframe.

**Parts 1 - 4 of the assignment are now complete**

### Step 10
The groupby function is now used to group by the subject and activity. The summarize all function is then used to find the mean of each of these groups of data and then this is assigned to the object **meanbyactivitysubject**.

**Part 5 of the assignment is now complete**

## Step 11
Lastly the resultant table is written to a text file called **finaldataset.txt** using the write.table function. As per the Getting and Cleaning Data advice in the *"thoughfulbloke Aka David Hood"* which can be found at this [link](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) the data can be read in by typing data <- read.table(file_path, header = TRUE)
View(data)
