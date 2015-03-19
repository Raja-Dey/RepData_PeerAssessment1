# Source of data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Q1. Merges the training and the test sets to create one data set.
# Please change the path if required to access the file
Xtrain <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/train/X_train.txt")
Xtest <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/test/X_test.txt")
X <- rbind(Xtrain, Xtest)  ## X is data
Strain <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/train/subject_train.txt")
Stest <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/test/subject_test.txt")
S <- rbind(Strain, Stest)  ## S is subject
Ytrain <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/train/y_train.txt")
Ytest <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/test/y_test.txt")
Y <- rbind(Ytrain, Ytest)  ## Y is label

# Q2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Please change the path if required to access the file
Features <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/features.txt")
MeanStd <- grep("-(mean|std)\\(\\)", Features[, 2])
X <- X[, MeanStd]
names(X) <- Features[MeanStd, 2]
names(X) <- gsub("\\(\\)", "", names(X))
names(X) <- tolower(names(X))

# Q3. Uses descriptive activity names to name the activities in the data set.
# Please change the path if required to access the file
activities <- read.table("./module3-Get-Clean/UCI-HAR-Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# Q4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"  # correct column name
all_cleanData <- cbind(S, Y, X) # bind all data in a single data set

# Q5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidy_data <- ddply(all_cleanData, .(subject, activity), function(x) colMeans(x[, 3:68]))
write.table(tidy_data, "./module3-Get-Clean/tidy_data.txt", row.name=FALSE)
