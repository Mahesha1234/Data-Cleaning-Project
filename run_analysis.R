
#getwd()
## to run set your own working directory
##setwd("C:\\Users\\Mahesha\\Desktop\\Desktop\\Data_Science\\Courseera\\Data-Cleaning\\Project")
getwd()

##Dataset name
Dataset <- "getdata_UCI_HAR_Dataset.zip"

## Download and unzip the dataset:
if (!file.exists(Dataset)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, Dataset)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(Dataset) 
}

##  Load activity labels data
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels
activityLabels[,2] <- as.character(activityLabels[,2])
activityLabels[,2]

## Load features data
features <- read.table("UCI HAR Dataset/features.txt")
features 
features[,2] <- as.character(features[,2])
features[,2]

# Extract only mean and standard deviation data
featuresmeanstd <- grep(".*mean.*|.*std.*", features[,2])
featuresmeanstd
featuresmeanstd.names <- features[featuresmeanstd,2]
featuresmeanstd.names
featuresmeanstd.names <- gsub('-mean', 'Mean', featuresmeanstd.names)
featuresmeanstd.names <- gsub('-std', 'Std', featuresmeanstd.names)
featuresmeanstd.names
featuresmeanstd.names <- gsub('[-()]', '', featuresmeanstd.names)
featuresmeanstd.names

# Load train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresmeanstd]
train
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainActivities
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainSubjects
train <- cbind(trainSubjects, trainActivities, train)
train

## Load Test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresmeanstd]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)
test

# merge datasets
FullData <- rbind(train, test)

# add labels
colnames(FullData) <- c("subject", "activity", featuresmeanstd.names)
names(FullData)

# turn activities & subjects into factors
FullData$activity <- factor(FullData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
FullData$subject <- as.factor(FullData$subject)

# melt the data
library(reshape2)
FullData.melted <- melt(FullData, id = c("subject", "activity"))
FullData.melted
# mean
FullData.mean <- dcast(FullData.melted, subject + activity ~ variable, mean)
FullData.mean
#write
write.table(FullData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
