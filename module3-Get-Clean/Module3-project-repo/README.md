## Getting and Cleaning Data - Project

### Introduction

The purpose of this project is to demonstrate the ability to collect, work 
with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This assignment will be graded by peers on a series of yes/no questions related to the project. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R has five sections that answer the following five different questions.

    Q1. Merges the training and the test sets to create one data set.
    Q2. Extracts only the measurements on the mean and standard deviation for each measurement.
    Q3. Uses descriptive activity names to name the activities in the data set.
    Q4. Appropriately labels the data set with descriptive activity names.
    Q5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

Download the zip file and unzip to get a folder 'UCI HAR Dataset'. Please read the'README.txt' file to get detailed description of the content of this folder.


### Please do the following change before to run the script run_analysis.R 

Change the path for the following files to access from your working directory:
X_train.txt, X_test.txt, Y_train.txt, Y_test.txt, subject_train.txt, subject_test.txt, features.txt, activity_labels.txt


### Grading

This assignment will be graded via peer assessment.
