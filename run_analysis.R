# Clear Workspace
rm(list = ls())
library(plyr)

# Assume the files from this link are saved in the working directory https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.

# Read in test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read in train data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read in labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Join test and traning data sets
featuresData <- rbind(testX, trainX)
activityData <- rbind(testY, trainY)
subjectData <- rbind(testSubject, trainSubject)

# Set the names of the variables
names(featuresData) <- features$V2
names(activityData) <- "activity"
names(subjectData) <- "subject"

# Join all the data together to create a single data set
dat <- cbind(featuresData, activityData, subjectData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
requiredCols <- c(grep("mean|std", names(dat), ignore.case = TRUE), 562, 563)
subDat <- dat[, requiredCols]

# 3. Uses descriptive activity names to name the activities in the data set
subDat$activity <- with(activityLabels,
                        V2[match(subDat$activity, V1)])

# 4. Appropriately labels the data set with descriptive variable names
names(subDat)<-gsub("^t", "Time", names(subDat))
names(subDat)<-gsub("^f", "Frequency", names(subDat))
names(subDat)<-gsub("Acc", "Accelerometer", names(subDat))
names(subDat)<-gsub("Gyro", "Gyroscope", names(subDat))
names(subDat)<-gsub("Mag", "Magnitude", names(subDat))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidyData <- aggregate(. ~subject + activity, subDat, mean)
write.table(tidyData, file = "tidydata.txt", row.name=FALSE)
